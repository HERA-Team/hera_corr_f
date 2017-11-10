import time,logging,numpy as np,struct

logging.getLogger(__name__).addHandler(logging.NullHandler())

class EEP24XX64:
	""" 64 Kbit Electrically Erasable PROM 
	"""
	size = (1<<13)

	def __init__(self, itf, addr=0x51):
		self.itf = itf
		self.addr = addr

	def read(self,reg,length=1):
		if reg < 0 or reg >= self.size or reg + length >= self.size:
			raise ValueError('Invalid parameter')

		regaddrmsb = (reg & 0x1f00) >> 8
		regaddrlsb = reg & 0x00ff
		return self.itf.read(self.addr,[regaddrmsb,regaddrlsb],length)

	def write(self,reg,data):
		if reg < 0 or reg >= self.size or reg + len(data) >= self.size:
			raise ValueError('Invalid parameter')

		while reg & 0xffe0 != (reg + len(data) - 1) & 0xffe0:
			length = (reg | 0x001f) - reg + 1
			regaddrmsb = (reg & 0x1f00) >> 8
			regaddrlsb = reg & 0x00ff
			self.itf.write(self.addr,[regaddrmsb,regaddrlsb],data[0:length])
			data = data[length:]
			reg = (reg&0xffe0) + (0b1<<5)
			time.sleep(0.01)
		if len(data)>0:
			regaddrmsb = (reg & 0x1f00) >> 8
			regaddrlsb = reg & 0x00ff
			self.itf.write(self.addr,[regaddrmsb,regaddrlsb],data)
