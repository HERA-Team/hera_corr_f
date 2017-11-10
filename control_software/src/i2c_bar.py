import time,numpy as np,logging

class MS5611_01B:

	OSR_PRESS = {	256:0x40,
			512:0x42,
			1024:0x44,
			2048:0x46,
			4096:0x48,}

	OSR_TEMP = {	256:0x50,
			512:0x52,
			1024:0x54,
			2048:0x56,
			4096:0x58,}

	def __init__(self,itf,addr=0x77):
		self.itf = itf
		self.addr = addr
		self.prom = self.readCalibration()

	def init(self):
		self.reset()
		self.prom = self.readCalibration()

	def readCalibration(self):
		data = []
		for i in range(8):
			data += self.read(0xa0|(i<<1),2)
		data = [x<<8|y for x,y in zip(data[0::2],data[1::2])]

		if data[7] & 0xf != self.crc4(data):
			logging.error('Barometer MS5611-01B PROM CRC error!')

		return data

	def crc4(self,data):
		"""	input: 16bit * 8 data list
		"""

		n_rem = 0
		crc_read = data[7] & 0xff
		data[7] = 0xff00 & data[7]

		for i in range(16):
			if i%2:
				n_rem ^= (data[i>>1] & 0xff)
			else:
				n_rem ^= (data[i>>1] >> 8)
			for n_bit in range(8,0,-1):
				if n_rem & 0x8000:
					n_rem = (n_rem << 1) ^ 0x3000
				else:
					n_rem = (n_rem << 1)
		n_rem = (0x000f & (n_rem >> 12))

		data[7] = crc_read | data[7]

		return (n_rem ^ 0x0)

	def readPress(self,osr=4096,compensation=2):
		if compensation not in [0,1,2]:
			raise ValueError("Invalid parameter")
		if osr not in self.OSR_PRESS:
			raise ValueError("Invalid parameter")
		self.write(self.OSR_PRESS[osr])
		time.sleep(0.01)
		data = self.read(0x00,3)
		data = (data[0]<<16)|(data[1]<<8)|data[2]

		temp, dt = self.readTemp(osr)
		temp *= 100
		off = self.prom[2] * 65536 + self.prom[4] * dt / 128 
		sens = self.prom[1] * 32768 + self.prom[3] * dt / 256

		if compensation > 1:
			t2=0
			off2=0
			sens2=0
			if temp < 2000:
				t2 = dt**2/(1<<31)
				off2 = 5 * (temp-2000)**2 / 2
				sens2 = 5 * (temp-2000)**2 / 4
			if temp < -1500:
				off2 = off2 + 7 * (temp+1500)**2
				sens2 = sens2 + 11 * (temp+1500)**2 / 2

			temp=temp-t2
			off=off-off2
			sens=sens-sens2

		if compensation > 0:
			data = (data / (1<<21) * sens - off) / (1<<15)

		if compensation == 0:
			return data,dt,off,sens
		else:
			return data/100.

	def readTemp(self,osr=4096,raw=False):
		if osr not in self.OSR_TEMP:
			raise ValueError("Invalid parameter")
		self.write(self.OSR_TEMP[osr])
		time.sleep(0.5)
		data = self.read(0x00,3)
		data = (data[0]<<16)|(data[1]<<8)|data[2]

		dt = data - self.prom[5] * 256.0

		if raw==False:
			data = 2000 + dt * self.prom[6] / (1<<23)
			data /= 100.

		return data,dt

	def reset(self):
		self.write(0x1e)
		time.sleep(0.1)

	def read(self,reg=None,length=1):
		return self.itf.read(self.addr,reg,length)

	def write(self,reg=None,data=None):
		self.itf.write(self.addr,reg,data)

