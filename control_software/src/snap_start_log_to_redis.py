import datetime
import redis


def send_log_to_redis(logfile):
    snap_log = SnapLog(logfile)
    snap_log.load()
    snap_log.split()
    snap_log.redis()


class SnapLog:
    log_designators = ['INFO', 'WARNING', 'ERROR']

    def __init__(self, fname):
        self.fname = fname

    def load(self):
        self.log = {}
        for ld in self.log_designators:
            self.log[ld] = {}
        dtime = None
        with open(self.fname, 'r') as fp:
            for line in fp:
                for this_des in self.log:
                    if this_des in line:
                        break
                else:
                    continue
                hostnames = []
                for node in range(30):
                    for loc in range(4):
                        hostname = "heraNode{}Snap{}".format(node, loc)
                        if hostname in line:
                            hostnames.append(hostname)
                if not len(hostnames):
                    if 'Sync passed' in line:
                        hostnames = ['Sync passed']
                    elif 'Initialization complete' in line:
                        hostnames = ['Initialization complete']
                for this_hostname in hostnames:
                    self.log[this_des].setdefault(this_hostname, {})
                    try:
                        dtime = datetime.datetime.strptime(line[:19], "%Y-%m-%d %H:%M:%S")
                        ms = float(line.split('-')[2].split(',')[-1])
                        dtime += datetime.timedelta(milliseconds=ms)
                    except ValueError:
                        if dtime is None:
                            continue
                        else:
                            dtime = dtime
                    if dtime in self.log[this_des][this_hostname]:
                        dtime += datetime.timedelta(microseconds=1.0)
                    self.log[this_des][this_hostname][dtime] = line.strip()

    def split(self):
        self.working = []
        self.unconfig = []
        self.maxout = []
        self.commfail = set()
        self.log_time_start, self.log_time_stop = None, None

        if 'Sync passed' in self.log['INFO']:
            self.log_time_start = sorted(self.log['INFO']['Sync passed'].keys())[-1]
        if 'Initialization complete' in self.log['INFO']:
            self.log_time_stop = sorted(self.log['INFO']['Initialization complete'].keys())[-1]
        if self.log_time_start is None or self.log_time_stop is None:
            return

        ts = {}
        for ld in self.log.keys():
            for th in self.log[ld].keys():
                for dt in self.log[ld][th].keys():
                    if dt >= self.log_time_start and dt <= self.log_time_stop:
                        this_line = self.log[ld][th][dt]
                        while dt in ts:
                            dt += datetime.timedelta(microseconds=1.0)
                        ts.setdefault(th, {})
                        ts[th][dt] = this_line
        for hostname in ts.keys():
            is_working = False
            for dt in sorted(ts[hostname]):
                line = ts[hostname][dt]
                is_working = False
                if 'Arming sync' in line:
                    is_working = True
                elif 'Not enabling eths on unconfiged hosts:' in line:
                    self.unconfig.append(hostname)
                elif 'Max enabled reached: not enabling' in line:
                    self.maxout.append(hostname)
                elif 'Comms failed on' in line:
                    self.commfail.add(hostname)
            if is_working:
                self.working.append(hostname)

    def redis(self):
        connection_pool = redis.ConnectionPool(host='redishost', decode_responses=True)
        r = redis.StrictRedis(connection_pool=connection_pool)
        try:
            log_time_start = self.log_time_start.strftime('%Y-%m-%dT%H:%M:%S.%f')
        except AttributeError:
            log_time_start = 'Not found'
        try:
            log_time_stop = self.log_time_stop.strftime('%Y-%m-%dT%H:%M:%S.%f')
        except AttributeError:
            log_time_start = 'Not found'
        stat = {'timestamp': datetime.datetime.now().strftime('%Y-%m-%dT%H:%M:%S'),
                'log_time_start': log_time_start,
                'log_time_stop': log_time_stop,
                'working': ','.join(self.working),
                'unconfig': ','.join(self.unconfig),
                'maxout': ','.join(self.maxout),
                'commfail': ','.join(self.commfail)}
        r.hmset('snap_log', stat)
