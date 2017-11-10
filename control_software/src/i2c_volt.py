import time,numpy as np,logging,struct

logging.getLogger(__name__).addHandler(logging.NullHandler())

class LTC2990():
	""" Quad I2C Voltage, Current and Temperature Monitor """

	DICT = dict()

	DICT[0x00] = {	'VCCREADY' : 0b1 << 6,
			'V4READY' : 0b1 << 5,
			'V3READY' : 0b1 << 4,
			'V2READY' : 0b1 << 3,
			'V1READY' : 0b1 << 2,
			'TINTREADY' : 0b1 << 1,
			'BUSY' : 0b1 << 0, }
	DICT[0x01] = {	'TEMPERATUREFORMAT' : 0b1 << 7,
			'REPEATSINGLE' : 0b1 << 6,
			'MODE1' : 0b11 << 3,
			'MODE0' : 0b111 << 0, }
	DICT[0x02] = {	'TRIGGER' : 0b11111111 << 0,}

	DICT[0x04] = {	'TINTMSB' : 0b11111111 << 0,}
	DICT[0x05] = {	'TINTLSB' : 0b11111111 << 0,}
	DICT[0x06] = {	'V1MSB' : 0b11111111 << 0,}
	DICT[0x07] = {	'V1LSB' : 0b11111111 << 0,}
	DICT[0x08] = {	'V2MSB' : 0b11111111 << 0,}
	DICT[0x09] = {	'V2LSB' : 0b11111111 << 0,}
	DICT[0x0a] = {	'V3MSB' : 0b11111111 << 0,}
	DICT[0x0b] = {	'V3LSB' : 0b11111111 << 0,}
	DICT[0x0c] = {	'V4MSB' : 0b11111111 << 0,}
	DICT[0x0d] = {	'V4LSB' : 0b11111111 << 0,}
	DICT[0x0e] = {	'VCCMSB' : 0b11111111 << 0,}
	DICT[0x0f] = {	'VCCLSB' : 0b11111111 << 0,}


	MSB = dict()
	MSB['TEMP'] = {	'DV' : 0B1 << 7,
			'SS' : 0B1 << 6,
			'SO' : 0B1 << 5,
			'DATA' : 0b111111 << 0,
			}
	MSB['VOLT'] = {	'DV' : 0B1 << 7,
			'DATA' : 0b1111111 << 0,
			}

	MODE0={	0:['v1',	'v2',		'tr2',		'tr2'],
		1:['v1-v2',	'v1-v2',	'tr2',		'tr2'],
		2:['v1-v2',	'v1-v2',	'v3',		'v4'],
		3:['tr1',	'tr1',		'v3',		'v4'],
		4:['tr1',	'tr1',		'v3-v4',	'v3-v4'],
		5:['tr1',	'tr1',		'tr2',		'tr2'],
		6:['v1-v2',	'v1-v2',	'v3-v4',	'v3-v4'],
		7:['v1',	'v2',		'v3',		'v4'], }

	CDIFFERENTIAL = 19.42e-6
	CSINGLEENDED = 305.18e-6
	VCCBIAS = 2.5
	TEMPFACTOR = 16.0

	fmt = 0	# celsius -> 0, kelvin -> 1
	repeat = 1 # repeat -> 0, single -> 1
	mode1 = 0b11 # mode1 -> mode[4:3], 0b11 for all measurements per mode[2:0]
	mode0 = 0b0 # mode0 -> mode[2:0], 0b0 for V1, V2, TR2

	def __init__(self, itf, addr=0x4f):
		self.itf=itf
		self.addr=addr

	def init(self,fmt='celsius',repeat=False,mode1=3,mode0=7):

		if fmt not in ['celsius','kelvin']:
			raise ValueError("Invalid parameter")
		if repeat not in [False,True]:
			raise ValueError("Invalid parameter")
		if mode1 not in range(4):
			raise ValueError("Invalid parameter")
		if mode0 not in range(8):
			raise ValueError("Invalid parameter")

		self.fmt = 0 if fmt == 'celsius' else 1
		self.repeat = 0 if repeat == 1 else 1
		self.mode1 = mode1
		self.mode0 = mode0

		rid, mask = self._getMask(self.DICT, 'TEMPERATUREFORMAT')
		val = self._set(0x0, self.fmt, mask)
		rid, mask = self._getMask(self.DICT, 'REPEATSINGLE')
		val = self._set(val, self.repeat, mask)
		rid, mask = self._getMask(self.DICT, 'MODE1')
		val = self._set(val, self.mode1, mask)
		rid, mask = self._getMask(self.DICT, 'MODE0')
		val = self._set(val, self.mode0, mask)

		self.write(rid, val)

	def _set(self, d1, d2, mask=None):
		# Update some bits of d1 with d2, while keep other bits unchanged
		if mask:
			d1 = d1 & ~mask
			d2 = d2 * (mask & -mask)
		return d1 | d2

	def _get(self, data, mask):
		data = data & mask
		return data / (mask & -mask)

	def _getMask(self, dicts, name):
		for rid in dicts:
			if name in dicts[rid]:
				return rid, dicts[rid][name]
		return None,None

	def write(self,reg=None,data=None):
		self.itf.write(self.addr,reg,data)

	def read(self,reg=None,length=1):
		return self.itf.read(self.addr,reg,length)

	def readTemp(self):
		name='TINT'

		self.setWord('TRIGGER',0xff)
		while not self.getWord(name+'READY'):
			time.sleep(0.01)
		msb = self.getWord(name+'MSB')
		lsb = self.getWord(name+'LSB')

		data = dict()
		data['DV'] = self._get(msb,self.MSB['TEMP']['DV'])
		data['SS'] = self._get(msb,self.MSB['TEMP']['SS'])
		data['SO'] = self._get(msb,self.MSB['TEMP']['SO'])
		value = self._get(msb,self.MSB['TEMP']['DATA']) << 8 | lsb
		data['DATA'] = value / self.TEMPFACTOR

		return data

	def readVolt(self,name):
		name = name.lower()
		if name not in self.MODE0[self.mode0]+['vcc']:
			raise ValueError("Invalid parameter")

		if name != 'vcc':
			regs = ['V1', 'V2', 'V3', 'V4']
			reg = regs[self.MODE0[self.mode0].index(name)]
		else:
			reg = 'VCC'

		self.setWord('TRIGGER',0xff)
		while not self.getWord(reg+'READY'):
			time.sleep(0.01)
		msb = self.getWord(reg+'MSB')
		lsb = self.getWord(reg+'LSB')

		value = self._get(msb,self.MSB['VOLT']['DATA']) << 8 | lsb
		value = value & 0x7fff | value & 0x4000 << 1
		value = struct.unpack('>h',struct.pack('>H',value))[0]

		if name in ['vcc']:
			data = value * self.CSINGLEENDED + self.VCCBIAS
		elif name in ['v1-v2','v3-v4']:
			data = value * self.CDIFFERENTIAL
		elif name in ['v1','v2','v3','v4']:
			data = value * self.CSINGLEENDED

		return data

	def getStatus(self,name=None):

		if name not in self.DICT[0].keys() + [None]:
			raise ValueError("Invalid parameter")

		data = self.read(0x0)

		if name == None:
			return dict([(n,self._get(data,m)) for (n,m) in self.DICT[0x0].items()])
		else:
			return self._get(data,self.DICT[0x0][name])

	def getRegister(self,rid=None):
		if rid==None:
			return dict([(regId,self.getRegister(regId)) for regId in self.DICT])
		elif rid in self.DICT:
			rval = self.read(rid)
			return {name: self._get(rval,mask) for name, mask in self.DICT[rid].items()}
		else:
			raise ValueError("Invalid parameter")

	def getWord(self,name):
		rid, mask = self._getMask(self.DICT, name)
		return self._get(self.read(rid),mask)
		
	def setWord(self,name,value):
		rid, mask = self._getMask(self.DICT, name)
		if mask == 0xff:
			data = self._set(0x0,value,mask)
			self.write(rid,data)
		else:
			data = self.read(rid)
			data = self._set(data,value,mask)
			self.write(rid,data)
