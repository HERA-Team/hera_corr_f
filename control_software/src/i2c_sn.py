import numpy as np, logging, time, struct

logging.getLogger(__name__).addHandler(logging.NullHandler())

class DS28CM00:
	""" DS28CM00 I2C/SMBus Silicon Serial Number """

	crcPoly = 0b100110001
	crcInitVal = 0

	def __init__(self,itf,addr=0x50):
		self.itf = itf
		self.addr = addr

	def readSN(self):
		data = self.read(0x0,8)
		print data
		_crc = self.crc8(data[0:7],self.crcPoly,self.crcInitVal,False)
		print _crc
		if _crc != data[7]:
			logging.error('Serial number crc8 failed!')
		return data

	def read(self,reg=None,length=1):
		return self.itf.read(self.addr,reg,length)

	def write(self,reg=None,data=None):
		self.itf.write(self.addr,reg,data)

	def crc8(self,data,poly,initVal=0,bigendian=True):

		# For little-endian, reverse the data list
		if not bigendian:
			data = data[::-1]

		crc = initVal

		for d in data:
			crc = crc ^ d
			for j in range(8, 0, -1) :
				if crc & 0x80 :
					crc = (crc << 1) ^ poly
				else :
					crc = crc << 1
		return crc & 0xff

