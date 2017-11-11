bitwidth = 8;
acc_len = 30000;
runtime = 2.5*acc_len;


vals = randi(2^bitwidth, runtime, 1) - 1;
%vals = zeros(runtime,1);
%vals = mod([0:runtime-1]',2^bitwidth);

din = {};
din.time = [0:runtime-1];
din.signals.values = zeros(runtime,1);
din.signals.dimensions = [1];

new_acc = {};
new_acc.time = [0:runtime-1];
new_acc.signals.values = zeros(runtime,1);
new_acc.signals.dimensions = [1];

for i = [1:runtime]
    if mod(i, acc_len) == 0
        new_acc.signals.values(i) = 1;
        din.signals.values(i+1:runtime) = vals(1:runtime-i);
    end
end

% Configure the simulation time
set_param(bdroot, 'StopTime', num2str(runtime));
sim(bdroot);

% calculate expected output
% After a new_acc, the first addr (=data value) is grabbed
% 2^bitwidth+2+1 clocks later (see model notes)
% We then grab acc_len - 2^bitwidth samples.
% Do the same in software here, separating the even and odd samples
sw_hist0 = zeros(2^bitwidth,1);
sw_hist1 = zeros(2^bitwidth,1);

for i = [0 : acc_len - 2^bitwidth - 1]
    index_offset = i + acc_len + 2^bitwidth + 1;
    if bitand(i, 2)
        %i
        sw_hist0(din.signals.values(index_offset)+1) = sw_hist0(din.signals.values(index_offset)+1) + 1; % keep in mind one-indexed addresses
    end
    if ~bitand(i, 2)
        sw_hist1(din.signals.values(index_offset)+1) = sw_hist1(din.signals.values(index_offset)+1) + 1; % keep in mind one-indexed addresses
    end
end

%for i = [0 : acc_len - 2^bitwidth - 1]
%    index_offset = acc_len + 2^bitwidth + 1;
%    if ~bitand(i, 2)
%        sw_hist1(din.signals.values(i + index_offset)+1) = sw_hist1(din.signals.values(i + index_offset)+1) + 1; % keep in mind one-indexed addresses
%    end
%end

din0 = din0.Data;
en0  = en0.Data;
addr0 = addr0.Data; % remember that these are addresses starting at zero

din1 = din1.Data;
en1  = en1.Data;
addr1 = addr1.Data; % remember that these are addresses starting at zero

% extract the shared bram data
hist0 = zeros(2^bitwidth,1);
for i = [1:runtime]
    if en0(i) == 1
        hist0(addr0(i)+1) = din0(i);
    end
end

hist1 = zeros(2^bitwidth,1);
for i = [1:runtime]
    if en1(i) == 1
        hist1(addr1(i)+1) = din1(i);
    end
end

if sum(hist0 == sw_hist0) == 2^bitwidth
    disp('Even samples PASS testbench')
    even_pass = 1;
else
    disp('Even samples FAIL testbench')
    sum(hist0 == sw_hist0)
    hist0(1:16)
    sw_hist0(1:16)
    even_pass = 0;
end

if sum(hist1 == sw_hist1) == 2^bitwidth
    disp('Odd samples PASS testbench')
    odd_pass = 1;
else
    disp('Odd samples FAIL testbench')
    sum(hist1 == sw_hist1)
    hist1(1:16)
    sw_hist1(1:16)
    odd_pass = 0;
end

if even_pass & odd_pass
    disp('TESTBENCH PASSED');
else
    disp('TESTBENCH FAILED');
end