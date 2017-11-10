import time,logging,numpy as np,struct

logging.getLogger(__name__).addHandler(logging.NullHandler())

# This library is based on Repo https://github.com/kriswiner/MPU9250

class MPU9250:
	""" 9-axis MotionTracking device that combines a 3-axis gyroscope, 3-axis accelerometer, 3-axis magnetometer and a Digital Motion Processor (DMP) all in a small 3x3x1mm package available as a pin-compatible upgrade from the MPU-6515 
	"""

	DICT = dict()

	# All register names use lower case letter
	# All fields use upper case letter
	DICT[0x00] = {	'XG_ST_DATA' : 0b11111111 << 0,}
	DICT[0x01] = {	'YG_ST_DATA' : 0b11111111 << 0,}
	DICT[0x02] = {	'ZG_ST_DATA' : 0b11111111 << 0,}
	DICT[0x0d] = {	'XA_ST_DATA' : 0b11111111 << 0,}
	DICT[0x0e] = {	'YA_ST_DATA' : 0b11111111 << 0,}
	DICT[0x0f] = {	'ZA_ST_DATA' : 0b11111111 << 0,}
	DICT[0x13] = {	'X_OFFS_USR_H' : 0b11111111 << 0,}
	DICT[0x14] = {	'X_OFFS_USR_L' : 0b11111111 << 0,}
	DICT[0x15] = {	'Y_OFFS_USR_H' : 0b11111111 << 0,}
	DICT[0x16] = {	'Y_OFFS_USR_L' : 0b11111111 << 0,}
	DICT[0x17] = {	'Z_OFFS_USR_H' : 0b11111111 << 0,}
	DICT[0x18] = {	'Z_OFFS_USR_L' : 0b11111111 << 0,}
	DICT[0x19] = {	'SMPLRT_DIV' : 0b11111111 << 0,}
	DICT[0x1a] = {	'config' : 0b11111111 << 0,
			'FIFO_MODE' : 0b1 << 6,
			'EXT_SYNC_SET' : 0b111 << 3,
			'DLPF_CFG' : 0b111 << 0,}
	DICT[0x1b] = {	'gyro_config' : 0b11111111 << 0,
			'XGYRO_CTEN' : 0b1 << 7,
			'YGYRO_CTEN' : 0b1 << 6,
			'ZGYRO_CTEN' : 0b1 << 5,
			'GYRO_FS_SEL' : 0b11 << 3,
			'FCHOICE_B' : 0b11 << 0,}
	DICT[0x1c] = {	'accel_config' : 0xff << 0,
			'AX_ST_EN' : 0b1 << 7,
			'AY_ST_EN' : 0b1 << 6,
			'AZ_ST_EN' : 0b1 << 5,
			'ACCEL_FS_SEL' : 0b11 << 3,}
	DICT[0x1d] = {	'accel_config2' : 0xff << 0,
			'ACCEL_FCHOICE_B' : 0b11 << 2,
			'A_DLPF_CFG' : 0b11 << 0, }
	DICT[0x1e] = {	'LPOSC_CLKSEL' : 0b1111 << 0,}
	DICT[0x1f] = {	'WOM_THRESHOLD' : 0b11111111 << 0,}
	DICT[0x23] = {	'fifo_en' : 0b11111111 << 0,
			'TEMP_FIFO_EN' : 0b1 << 7,
			'GYRO_XOUT' : 0b1 << 6,
			'GYRO_YOUT' : 0b1 << 5,
			'GYRO_ZOUT' : 0b1 << 4,
			'ACCEL' : 0b1 << 3,
			'SLV2' : 0b1 << 2,
			'SLV1' : 0b1 << 1,
			'SLV0' : 0b1 << 0,}
	DICT[0x24] = {	'i2c_mst_ctrl' : 0b11111111 << 0,
			'MULT_MST_EN' : 0b1 << 7,
			'WAIT_FOR_ES' : 0b1 << 6,
			'SLV_3_FIFO_EN' : 0b1 << 5,
			'I2C_MST_P_NSR' : 0b1 << 4,
			'I2C_MST_CLK' : 0b1111 << 0, }
	DICT[0x25] = {	'I2C_SLV0_RNW' : 0b1 << 7,
			'I2C_ID_0' : 0b1111111 << 0, }
	DICT[0x26] = {	'I2C_SLV0_REG' : 0b11111111 << 0,}
	DICT[0x27] = {	'I2C_SLV0_EN' : 0b1 << 7,
			'I2C_SLV0_BYTE_SW' : 0b1 << 6,
			'I2C_SLV0_REG_DIS' : 0b1 << 5,
			'I2C_SLV0_GRP' : 0b1 << 4,
			'I2C_SLV0_LENG' : 0b1111 << 0, }
	DICT[0x28] = {	'I2C_SLV1_RNW' : 0b1 << 7,
			'I2C_ID_1' : 0b1111111 << 0, }
	DICT[0x29] = {	'I2C_SLV1_REG' : 0b11111111 << 0,}
	DICT[0x2a] = {	'I2C_SLV1_EN' : 0b1 << 7,
			'I2C_SLV1_BYTE_SW' : 0b1 << 6,
			'I2C_SLV1_REG_DIS' : 0b1 << 5,
			'I2C_SLV1_GRP' : 0b1 << 4,
			'I2C_SLV1_LENG' : 0b1111 << 0, }
	DICT[0x2b] = {	'I2C_SLV2_RNW' : 0b1 << 7,
			'I2C_ID_2' : 0b1111111 << 0, }
	DICT[0x2c] = {	'I2C_SLV2_REG' : 0b11111111 << 0,}
	DICT[0x2d] = {	'I2C_SLV2_EN' : 0b1 << 7,
			'I2C_SLV2_BYTE_SW' : 0b1 << 6,
			'I2C_SLV2_REG_DIS' : 0b1 << 5,
			'I2C_SLV2_GRP' : 0b1 << 4,
			'I2C_SLV2_LENG' : 0b1111 << 0, }
	DICT[0x2e] = {	'I2C_SLV3_RNW' : 0b1 << 7,
			'I2C_ID_3' : 0b1111111 << 0, }
	DICT[0x2f] = {	'I2C_SLV3_REG' : 0b11111111 << 0,}
	DICT[0x30] = {	'I2C_SLV3_EN' : 0b1 << 7,
			'I2C_SLV3_BYTE_SW' : 0b1 << 6,
			'I2C_SLV3_REG_DIS' : 0b1 << 5,
			'I2C_SLV3_GRP' : 0b1 << 4,
			'I2C_SLV3_LENG' : 0b1111 << 0, }
	DICT[0x31] = {	'I2C_SLV4_RNW' : 0b1 << 7,
			'I2C_ID_4' : 0b1111111 << 0, }
	DICT[0x32] = {	'I2C_SLV3_REG' : 0b11111111 << 0,}
	DICT[0x33] = {	'I2C_SLV4_DO' : 0b11111111 << 0,}
	DICT[0x34] = {	'I2C_SLV4_EN' : 0b1 << 7,
			'SLV4_DONE_INT_EN' : 0b1 << 6,
			'I2C_SLV4_REG_DIS' : 0b1 << 5,
			'I2C_MST_DLY' : 0b1111 << 0, }
	DICT[0x35] = {	'I2C_SLV4_DI' : 0b11111111 << 0,}
	DICT[0x36] = {	'PASS_THROUGH' : 0b1 << 7,
			'I2C_SLV4_DONE' : 0b1 << 6,
			'I2C_LOST_ARB' : 0b1 << 5,
			'I2C_SLV4_NACK' : 0b1 << 4,
			'I2C_SLV3_NACK' : 0b1 << 3,
			'I2C_SLV2_NACK' : 0b1 << 2,
			'I2C_SLV1_NACK' : 0b1 << 1,
			'I2C_SLV0_NACK' : 0b1 << 0,}
	DICT[0x37] = {	'int_pin_cfg' : 0xff << 0,
			'ACTL' : 0b1 << 7,
			'OPEN' : 0b1 << 6,
			'LATCH_INT_EN' : 0b1 << 5,
			'INT_ANYRD_2CLEAR' : 0b1 << 4,
			'ACTL_FSYNC' : 0b1 << 3,
			'FSYNC_INT_MODE_EN' : 0b1 << 2,
			'BYPASS_EN' : 0b1 << 1, }
	DICT[0x38] = {	'int_enable' : 0xff << 0,
			'WOM_EN' : 0b1 << 6,
			'FIFO_OFLOW_EN' : 0b1 << 4,
			'FSYNC_INT_EN' : 0b1 << 3,
			'RAW_RDY_EN' : 0b1 << 0, }
	DICT[0x3a] = {	'INT_STATUS' : 0b11111111 << 0,
			'WOM_INT' : 0b1 << 6,
			'FIFO_OFLOW_INT' : 0b1 << 4,
			'FSYNC_INT' : 0b1 << 3,
			'RAW_DATA_RDY_INT' : 0b1 << 0, }
	DICT[0x3b] = {	'ACCEL_XOUT_H' : 0b11111111 << 0,}
	DICT[0x3c] = {	'ACCEL_XOUT_L' : 0b11111111 << 0,}
	DICT[0x3d] = {	'ACCEL_YOUT_H' : 0b11111111 << 0,}
	DICT[0x3e] = {	'ACCEL_YOUT_L' : 0b11111111 << 0,}
	DICT[0x3f] = {	'ACCEL_ZOUT_H' : 0b11111111 << 0,}
	DICT[0x40] = {	'ACCEL_ZOUT_L' : 0b11111111 << 0,}
	DICT[0x41] = {	'TEMP_OUT_H' : 0b11111111 << 0,}
	DICT[0x42] = {	'TEMP_OUT_L' : 0b11111111 << 0,}
	DICT[0x43] = {	'GYRO_XOUT_H' : 0b11111111 << 0,}
	DICT[0x44] = {	'GYRO_XOUT_L' : 0b11111111 << 0,}
	DICT[0x45] = {	'GYRO_YOUT_H' : 0b11111111 << 0,}
	DICT[0x46] = {	'GYRO_YOUT_L' : 0b11111111 << 0,}
	DICT[0x47] = {	'GYRO_ZOUT_H' : 0b11111111 << 0,}
	DICT[0x48] = {	'GYRO_ZOUT_L' : 0b11111111 << 0,}
	DICT[0x49] = {	'EXT_SENS_DATA_00' : 0b11111111 << 0,}
	DICT[0x4a] = {	'EXT_SENS_DATA_01' : 0b11111111 << 0,}
	DICT[0x4b] = {	'EXT_SENS_DATA_02' : 0b11111111 << 0,}
	DICT[0x4c] = {	'EXT_SENS_DATA_03' : 0b11111111 << 0,}
	DICT[0x4d] = {	'EXT_SENS_DATA_04' : 0b11111111 << 0,}
	DICT[0x4e] = {	'EXT_SENS_DATA_05' : 0b11111111 << 0,}
	DICT[0x4f] = {	'EXT_SENS_DATA_06' : 0b11111111 << 0,}
	DICT[0x50] = {	'EXT_SENS_DATA_07' : 0b11111111 << 0,}
	DICT[0x51] = {	'EXT_SENS_DATA_08' : 0b11111111 << 0,}
	DICT[0x52] = {	'EXT_SENS_DATA_09' : 0b11111111 << 0,}
	DICT[0x53] = {	'EXT_SENS_DATA_10' : 0b11111111 << 0,}
	DICT[0x54] = {	'EXT_SENS_DATA_11' : 0b11111111 << 0,}
	DICT[0x55] = {	'EXT_SENS_DATA_12' : 0b11111111 << 0,}
	DICT[0x56] = {	'EXT_SENS_DATA_13' : 0b11111111 << 0,}
	DICT[0x57] = {	'EXT_SENS_DATA_14' : 0b11111111 << 0,}
	DICT[0x58] = {	'EXT_SENS_DATA_15' : 0b11111111 << 0,}
	DICT[0x59] = {	'EXT_SENS_DATA_16' : 0b11111111 << 0,}
	DICT[0x5a] = {	'EXT_SENS_DATA_17' : 0b11111111 << 0,}
	DICT[0x5b] = {	'EXT_SENS_DATA_18' : 0b11111111 << 0,}
	DICT[0x5c] = {	'EXT_SENS_DATA_19' : 0b11111111 << 0,}
	DICT[0x5d] = {	'EXT_SENS_DATA_20' : 0b11111111 << 0,}
	DICT[0x5e] = {	'EXT_SENS_DATA_21' : 0b11111111 << 0,}
	DICT[0x5f] = {	'EXT_SENS_DATA_22' : 0b11111111 << 0,}
	DICT[0x60] = {	'EXT_SENS_DATA_23' : 0b11111111 << 0,}
	DICT[0x63] = {	'I2C_SLV0_DO' : 0b11111111 << 0,}
	DICT[0x64] = {	'I2C_SLV1_DO' : 0b11111111 << 0,}
	DICT[0x65] = {	'I2C_SLV2_DO' : 0b11111111 << 0,}
	DICT[0x66] = {	'I2C_SLV3_DO' : 0b11111111 << 0,}
	DICT[0x67] = {	'DELAY_ES_SHADOW' : 0b1 << 7,
			'I2C_SLV4_DLY_EN' : 0b1 << 4,
			'I2C_SLV3_DLY_EN' : 0b1 << 3,
			'I2C_SLV2_DLY_EN' : 0b1 << 2,
			'I2C_SLV1_DLY_EN' : 0b1 << 1,
			'I2C_SLV0_DLY_EN' : 0b1 << 0,}
	DICT[0x68] = {	'GYRO_RST' : 0b1 << 2,
			'ACCEL_RST' : 0b1 << 1,
			'TEMP_RST' : 0b1 << 0, }
	DICT[0x69] = {	'ACCEL_INTEL_EN' : 0b1 << 7,
			'ACCEL_INTEL_MODE' : 0b1 << 6, }
	DICT[0x6a] = {	'user_ctrl' : 0b11111111 << 0,
			'FIFO_EN' : 0b1 << 6,
			'I2C_MST_EN' : 0b1 << 5,
			'I2C_IF_DIS' : 0b1 << 4,
			'FIFO_RST' : 0b1 << 2,
			'I2C_MST_RST' : 0b1 << 1,
			'SIG_COND_RST' : 0b1 << 0,}
	DICT[0x6b] = {	'pwr_mgmt_1' : 0b11111111 << 0,
			'H_RESET' : 0b1 << 7,
			'SLEEP' : 0b1 << 6,
			'CYCLE' : 0b1 << 5,
			'GYRO_STANDBY' : 0b1 << 4,
			'PD_PTAT' : 0b1 << 3,
			'CLKSEL' : 0b111 << 0,}
	DICT[0x6c] = {	'pwr_mgmt_2' : 0b11111111 << 0,
			'DIS_XA' : 0b1 << 5,
			'DIS_YA' : 0b1 << 4,
			'DIS_ZA' : 0b1 << 3,
			'DIS_XG' : 0b1 << 2,
			'DIS_YG' : 0b1 << 1,
			'DIS_ZG' : 0b1 << 0,}
	DICT[0x72] = {	'FIFO_CNT_H' : 0b11111 << 0,}
	DICT[0x73] = {	'FIFO_CNT_L' : 0b11111111 << 0,}
	DICT[0x74] = {	'fifo_r_w' : 0b11111111 << 0,
			'D' : 0b11111111 << 0,}
	DICT[0x75] = {	'WHOAMI' : 0b11111111 << 0,}
	DICT[0x77] = {	'XA_OFFS_H' : 0b11111111 << 0,}
	DICT[0x78] = {	'XA_OFFS_L' : 0b1111111 << 1,}
	DICT[0x7a] = {	'YA_OFFS_H' : 0b11111111 << 0,}
	DICT[0x7b] = {	'YA_OFFS_L' : 0b1111111 << 1,}
	DICT[0x7d] = {	'ZA_OFFS_H' : 0b11111111 << 0,}
	DICT[0x7e] = {	'ZA_OFFS_L' : 0b1111111 << 1,}

	WHOAMI=0x71

	GYRO_FULL_SCALE = [250, 500, 1000, 2000]
	GYRO_SCALE = None
	ACCEL_FULL_SCALE = [2,4,8,16]
	ACCEL_SCALE = None

	def __init__(self, itf, addr=0x68):
		self.itf = itf
		self.addr = addr

		if self.whoami() is not self.WHOAMI:
			logging.error("MPU9250 at address {} is not ready!".format(addr))
		# Enable aux i2c - AK8963
		self.setWord('BYPASS_EN',0x1)

	def init(self,gyro=True,accel=True):

		self.reset()

		self.setWord('pwr_mgmt_1',0x00)
		# Wait MEMS oscilator to stablize
		time.sleep(0.1)
		self.setWord('pwr_mgmt_1',0x01)

		# Enable accel and gyro
		rid,mask=self._getMask(self.DICT,'DIS_XA')
		val = self._set(0x0,not accel,mask)
		rid,mask=self._getMask(self.DICT,'DIS_YA')
		val = self._set(val,not accel,mask)
		rid,mask=self._getMask(self.DICT,'DIS_ZA')
		val = self._set(val,not accel,mask)
		rid,mask=self._getMask(self.DICT,'DIS_XG')
		val = self._set(val,not gyro,mask)
		rid,mask=self._getMask(self.DICT,'DIS_YG')
		val = self._set(val,not gyro,mask)
		rid,mask=self._getMask(self.DICT,'DIS_ZG')
		val = self._set(val,not gyro,mask)
		self.setWord('pwr_mgmt_2',val)

		self.setWord('config',0x0)
		self.setWord('SMPLRT_DIV',0x0)
		self.setWord('gyro_config',0X0)
		self.setWord('accel_config',0X0)
		self.setWord('accel_config2',0X0)

		# Enable Aux I2C - AK8963
		self.setWord('int_pin_cfg',0x2)
		# Disable interrupt
		self.setWord('int_enable',0x0)

		self.setGyroScale(250)
		self.setAccelScale(2)


	def whoami(self):
		rid, mask = self._getMask(self.DICT, 'WHOAMI')
		return self.read(rid)

	def read(self,reg,length=1):
		return self.itf.read(self.addr,reg,length)

	def write(self,reg,data):
		self.itf.write(self.addr,reg,data)

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

	def reset(self):
		self.setWord('H_RESET',0x1)
		time.sleep(0.1)

	def setAccelSamplingRate(self,bandwidth=None,delay=None,fs=None):
		vals=[	[1130,	0.75,	4000],
			[460,	1.94,	1000],
			[184,	5.8,	1000],
			[92,	7.8,	1000],
			[41,	11.8,	1000],
			[20,	19.8,	1000],
			[10,	35.7,	1000],
			[5,	66.96,	1000],
			[460,	1.94,	1000],]

		param=[	[0,0],
			[1,0],
			[1,1],
			[1,2],
			[1,3],
			[1,4],
			[1,5],
			[1,6],
			[1,7],]

		r = vals

		if bandwidth != None:
			r = [l for l in vals if bandwidth == l[0]]
			if r == []:
				raise ValueError("Invalid parameter")

		if delay != None:
			r = [l for l in r if delay == l[1]]
			if r == []:
				raise ValueError("Invalid parameter")

		if fs != None:
			r = [l for l in r if fs == l[2]]
			if r == []:
				raise ValueError("Invalid parameter")

		config = param[vals.index(r[0])]

		self.setWord('ACCEL_FCHOICE', config[0])
		self.setWord('A_DLPFCFG', config[1])
		r = r[0]

		logging.info("MPU9250 Accel sampling bandwidth={}, delay={}, fs={}".format(r[0],r[1],r[2]))
		
	def setGyroSamplingRate(self,bandwidth=None,delay=None,fs=None):
		vals=[	[8800,	0.064,	32000],
			[3600,	0.11,	32000],
			[250,	0.97,	8000 ],
			[184,	2.9,	1000 ],
			[92,	3.9,	1000 ],
			[41,	5.9,	1000 ],
			[20,	9.9,	1000 ],
			[10,	17.85,	1000 ],
			[5,	33.48,	1000 ],
			[3600,	0.17,	8000 ],]

		param=[	[0,0],
			[1,0],
			[3,0],
			[3,1],
			[3,2],
			[3,3],
			[3,4],
			[3,5],
			[3,6],
			[3,7],]

		r = vals

		if bandwidth != None:
			r = [l for l in vals if bandwidth == l[0]]
			if r == []:
				raise ValueError("Invalid parameter")

		if delay != None:
			r = [l for l in r if delay == l[1]]
			if r == []:
				raise ValueError("Invalid parameter")

		if fs != None:
			r = [l for l in r if fs == l[2]]
			if r == []:
				raise ValueError("Invalid parameter")

		config = param[vals.index(r[0])]
		r = r[0]

		self.setWord('FCHOICE_B', config[0] ^ 0b11)
		self.setWord('DLPF_CFG', config[1])

		logging.info("MPU9250 Gyro sampling bandwidth={}, delay={}, fs={}".format(r[0],r[1],r[2]))
		
	def setGyroScale(self,scale=250):
		if scale not in self.GYRO_FULL_SCALE:
			raise ValueError("Invalid parameter")
		self.GYRO_SCALE=scale
		self.setWord('GYRO_FS_SEL', self.GYRO_FULL_SCALE.index(scale))
		logging.info("MPU9250 Gyro full scale=+/-{}".format(scale))

	def setAccelScale(self,scale=2):
		if scale not in self.ACCEL_FULL_SCALE:
			raise ValueError("Invalid parameter")
		self.ACCEL_SCALE = scale
		self.setWord('ACCEL_FS_SEL', self.ACCEL_FULL_SCALE.index(scale))
		logging.info("MPU9250 Accel full scale=+/-{}".format(scale))

	def getGyroScale(self):
		if self.GYRO_SCALE not in self.GYRO_FULL_SCALE:
			self.GYRO_SCALE = self.GYRO_FULL_SCALE[self.getWord('GYRO_FS_SEL')]

		return self.GYRO_SCALE

	def getAccelScale(self):
		if self.ACCEL_SCALE not in self.ACCEL_FULL_SCALE:
			self.ACCEL_SCALE = self.ACCEL_FULL_SCALE[self.getWord('ACCEL_FS_SEL')]
		return self.ACCEL_SCALE

	def setFIFO(self,accel=False,temp=False,gyro=False,slv0=False,slv1=False,slv2=False,slv3=False):

		rid, mask = self._getMask(self.DICT, 'fifo_en')
		val = self._set(0x0,	gyro,	self.DICT[rid]['GYRO_XOUT'])
		val = self._set(val,	gyro,	self.DICT[rid]['GYRO_YOUT'])
		val = self._set(val,	gyro,	self.DICT[rid]['GYRO_ZOUT'])
		val = self._set(val,	accel,	self.DICT[rid]['ACCEL'])
		val = self._set(val,	temp,	self.DICT[rid]['TEMP_FIFO_EN'])
		val = self._set(val,	slv0,	self.DICT[rid]['SLV0'])
		val = self._set(val,	slv1,	self.DICT[rid]['SLV1'])
		val = self._set(val,	slv2,	self.DICT[rid]['SLV2'])
		self.write(rid,val)

		#self.setWord('SLV_3_FIFO_EN',slv3)

	def getRegister(self,rid=None):
		if rid==None:
			return dict([(regId,self.getRegister(regId)) for regId in self.DICT])
		elif rid in self.DICT:
			rval = self.read(rid)
			return {name: self._get(rval,mask) for name, mask in self.DICT[rid].items()}
		else:
			raise ValueError("Invalid parameter")

	def readAccel(self,raw=False):

		rid, mask = self._getMask(self.DICT, 'ACCEL_XOUT_H')
		data = np.asarray(self.read(rid,6))
		data = (data[0::2] << 8) | data[1::2]

		if raw==False:
			scale = self.getAccelScale()
			return (scale*2.0)/(1<<16)*data
		else:
			return data

	def readGyro(self,raw=False):
		rid, mask = self._getMask(self.DICT, 'GYRO_XOUT_H')
		data = np.asarray(self.read(rid,6))
		data = (data[0::2] << 8) | data[1::2]
		data = [struct.unpack('>h',struct.pack('>H',d)) for d in data]
		data = np.asarray(data).reshape(-1)
		if raw==False:
			scale = self.getGyroScale()
			return (scale*2.0)/(1<<16)*data
		else:
			return data

	def selftest(self, gyroscale=250,accelscale=2):

		self.setWord('SMPLRT_DIV', 0)
		self.setWord('config', 2)
		self.setWord('gyro_config', 0)
		self.setWord('accel_config2', 2)
		self.setWord('accel_config', 0)

		self.setGyroScale(gyroscale)
		GFS = self.GYRO_FULL_SCALE.index(gyroscale)
		self.setAccelScale(accelscale)
		AFS = self.ACCEL_FULL_SCALE.index(accelscale)

		acc = np.zeros(3)
		gyr = np.zeros(3)
		for i in range(200):
			acc += self.readAccel(True)
			gyr += self.readGyro(True)
		acc /= 200.
		gyr /= 200.

		self.setWord('XGYRO_CTEN', 0x1)
		self.setWord('YGYRO_CTEN', 0x1)
		self.setWord('ZGYRO_CTEN', 0x1)
		self.setWord('AX_ST_EN', 0x1)
		self.setWord('AY_ST_EN', 0x1)
		self.setWord('AZ_ST_EN', 0x1)

		time.sleep(1)
			
		accST = np.zeros(3)
		gyrST = np.zeros(3)
		for i in range(200):
			accST += self.readAccel(True)
			gyrST += self.readGyro(True)
		accST /= 200.
		gyrST /= 200.

		self.setWord('XGYRO_CTEN', 0x0)
		self.setWord('YGYRO_CTEN', 0x0)
		self.setWord('ZGYRO_CTEN', 0x0)
		self.setWord('AX_ST_EN', 0x0)
		self.setWord('AY_ST_EN', 0x0)
		self.setWord('AZ_ST_EN', 0x0)

		rid,mask=self._getMask(self.DICT,'XG_ST_DATA')
		stFactory = np.asarray(self.read(rid,6))
		factoryTrim[0:3] = ((2620/1)<<GFS)*np.power(1.01,stFactory[0:3]-1.0)
		factoryTrim[3:6] = ((2620/1)<<AFS)*np.power(1.01,stFactory[3:6]-1.0)

		gyrerr = ((gyrST - gyr)/factoryTrim[0:3])*100.0-100.0
		accerr = ((accST - acc)/factoryTrim[3:6])*100.0-100.0

		return {'GYRO':gyrerr,'ACCEL':accerr}


	def calibrate(self,WRITE_OFFSET_REG=False):

		self.init(gyro=True,accel=True)
		self.setGyroSamplingRate(bandwidth=184,fs=1000)
		self.setAccelSamplingRate(bandwidth=184,fs=1000)
		self.setWord('SMPLRT_DIV',0x0)
		self.setGyroScale(scale=250)
		self.setAccelScale(scale=2)
		self.setWord('FIFO_RST',0x1)

		self.setFIFO(enable=True,accel=True,gyro=True)
		time.sleep(0.01)
		self.setFIFO(enable=False)

		data = self.readFIFO({'accel':True,'gyro':True})
		return data

#		# Disable FIFO
#		self.setWord('fifo_en',0x0)
#
#		# Select interal clock source
#		self.setWord('CLKSEL',0x0)
#
#		# Disable I2C master control
#		self.setWord('i2c_mst_ctrl',0x0)
#
#		# Reset FIFO and DMP
#		self.setWord('FIFO_RST',0x1)
#		self.setWord('I2C_MST_RST',0x1)
#
#		time.sleep(0.015)
#
#		# Set low-pass filter to 188 Hz
#		self.setWord('DLPF_CFG',0x1)
#
#		# Set sample rate to 1 kHz
#		self.setWord('SMPLRT_DIV',0x0)
#
#		# Set gyro full-scale to 250 degrees per second, maximum sensitivity
#		self.setWord('gyro_config',0x0)
#
#		# Set accelerometer full-scale to 2 g, maximum sensitivity
#		self.setWord('accel_config',0x0)
#
#		gyrosensitivity = 131
#		accelsensitivity = 16384
#
#		# Enable FIFO
#		self.setWord('FIFO_EN',0x1)
#
#		# Enable gyro and accelerometer sensors for FIFO (max size 512 bytes in MPU-9250)
#		# Want to set those bits in one shot, use write function instead of setWord
#		rid, mask = self._getMask(self.DICT, 'GYRO_XOUT')
#		val = self._set(0x0, 0x1, mask)
#		rid, mask = self._getMask(self.DICT, 'GYRO_YOUT')
#		val = self._set(val, 0x1, mask)
#		rid, mask = self._getMask(self.DICT, 'GYRO_ZOUT')
#		val = self._set(val, 0x1, mask)
#		rid, mask = self._getMask(self.DICT, 'ACCEL')
#		val = self._set(val, 0x1, mask)
#		self.write(rid,val)
#
#		# Accumulate 40 samples in 80 milliseconds = 480 bytes
#		time.sleep(0.04)
#
#		# At end of sample accumulation, turn off FIFO sensor read
#		self.setWord('fifo_en',0x0)
#
#		data = self.readFIFO({'ACCEL':True,'GYRO_X':True,'GYRO_Y':True,'GYRO_Z':True})
#
#		accel_bias = data['ACCEL'].sum(axis=0) * 1. / data['ACCEL'].shape[0]
#		gyro_x_bias = data['GYRO_X'].sum(axis=0) * 1. / data['GYRO_X'].shape[0]
#		gyro_y_bias = data['GYRO_Y'].sum(axis=0) * 1. / data['GYRO_Y'].shape[0]
#		gyro_z_bias = data['GYRO_Z'].sum(axis=0) * 1. / data['GYRO_Z'].shape[0]
#

	def readFIFOCount(self):

		rid, mask = self._getMask(self.DICT, 'FIFO_CNT_H')
		data = self.read(rid,2)
		data = (self._get(data[0],mask) << 8) | data[1]
		return data

	def readFIFO(self,types):
		""" read FIFO and sort data into categories according to given types

			E.g.
			readFIFO({'accel':True,'gyro_x':True,'gyro_y':True,'gyro_z':True})
			readFIFO({'accel':True,'gyro':True})
			readFIFO({'accel':True,'slv0':8})

		"""

		TYPES = ['accel','temp','gyro','gyro_x','gyro_y','gyro_z','slv0','slv1','slv2','slv3']

		if not isinstance(types,dict):
			raise ValueError("Invalid parameter")
		if any(key not in TYPES for key in types):
			raise ValueError("Invalid parameter")
		if any(not isinstance(value,int) for value in types.values()):
			raise ValueError("Invalid parameter")
		if any(value > 16 or value < 1 for value in types.values()):
			raise ValueError("Invalid parameter")

		# each
		n = 0

		if 'accel' in types:
			n += 6			# 3 directions, 2 bytes per direction
		if 'temp' in types:
			n += 2			# 2 bytes
		if 'gyro' in types:
			n += 6			# 6 bytes
			types['gyro_x']=True
			types['gyro_y']=True
			types['gyro_z']=True
		else:
			if 'gyro_x' in types:
				n += 2		# 2 bytes
			if 'gyro_y' in types:
				n += 2		# 2 bytes
			if 'gyro_z' in types:
				n += 2		# 2 bytes

		if 'slv0' in types:
			n += types['slv0']
		if 'slv1' in types:
			n += types['slv1']
		if 'slv2' in types:
			n += types['slv2']
		if 'slv3' in types:
			n += types['slv3']

		cnts = self.readFIFOCount()

		# Read FIFO
		rid, mask = self._getMask(self.DICT, 'fifo_r_w')

		data = []
		while cnts >= n:
			data += self.read(rid, n)
			cnts -= n
		data = np.asarray(data).reshape(-1,n)

		# Sort out sensor readings
		results = dict()

		if 'accel' in types:
			results['accel'] = (data[:,0:6:2] << 8) | data[:,1:6:2]
			data = data[:,6:]
		if 'temp' in types:
			results['temp'] = (data[:,0] << 8) | data[:,1]
			data = data[:,2:]
		if all([x in types for x in ['gyro_x','gyro_y','gyro_z']]):
			results['gyro'] = (data[:,0:6:2] << 8) | data[:,1:6:2]
			data = data[:,6:]
		else:
			if 'gyro_x' in types:
				results['gyro_x'] = (data[:,0] << 8) | data[:,1]
				data = data[:,2:]
			if 'gyro_y' in types:
				results['gyro_y'] = (data[:,0] << 8) | data[:,1]
				data = data[:,2:]
			if 'gyro_z' in types:
				results['gyro_z'] = (data[:,0] << 8) | data[:,1]
				data = data[:,2:]
		if 'slv0' in types:
			results['slv0'] = data[:,0:types['slv0']]
			data = data[:,types['slv0']:]
		if 'slv1' in types:
			results['slv1'] = data[:,0:types['slv1']]
			data = data[:,types['slv1']:]
		if 'slv2' in types:
			results['slv2'] = data[:,0:types['slv2']]
			data = data[:,types['slv2']:]
		if 'slv3' in types:
			results['slv3'] = data[:,0:types['slv3']]
			data = data[:,types['slv3']:]

		return results


class AK8963:

	DICT = dict()

	DICT[0x00] = {	'wia':0xff<<0,}
	DICT[0x01] = {	'info':0xff<<0,}
	DICT[0x02] = {	'st1':0xff<<0,
	    	   	'DOR' : 0b1 << 1,
	    	   	'DRDY' : 0b1 << 0, }
	DICT[0x03] = {	'hxl':0xff<<0,}
	DICT[0x04] = {	'hxh':0xff<<0,}
	DICT[0x05] = {	'hyl':0xff<<0,}
	DICT[0x06] = {	'hyh':0xff<<0,}
	DICT[0x07] = {	'hzl':0xff<<0,}
	DICT[0x08] = {	'hzh':0xff<<0,}
	DICT[0x09] = {	'st2':0xff<<0,
	       		'BITM' : 0b1 << 4,
	       		'HOFL' : 0b1 << 3, }
	DICT[0x0a] = {	'cntl1':0xff<<0,
	       		'BIT' : 0b1 << 4,
	       		'MODE' : 0b1111 << 0, }
	DICT[0x0b] = {	'cntl2':0xff<<0,
	       		'SRST' : 0b1 << 0,}
	DICT[0x0c] = {	'astc':0xff<<0,
	       		'SELF' : 0b1 << 6,}
	DICT[0x0d] = {	'ts1':0xff<<0,}
	DICT[0x0e] = {	'ts2':0xff<<0,}
	DICT[0x0f] = {	'i2cdis':0xff<<0,}
	DICT[0x10] = {	'asax':0xff<<0,}
	DICT[0x11] = {	'asay':0xff<<0,}
	DICT[0x12] = {	'asaz':0xff<<0,}

	WHOAMI=0x48
	MPU9250=0x68

	adj=np.asarray([0,0,0])

	def __init__(self, itf, addr=0x0c):
		"""	AK8963 magnetometer

		If integrated with mpu9250, make an instance of mpu9250 and enable aux i2c
		before using AK8963
		"""

		self.itf = itf
		self.addr = addr

		if self.whoami() is not self.WHOAMI:
			logging.error("AK893 at address {} is not ready!".format(addr))

	def init(self):
		self.reset()
		self.adj = self.getAdjustment()
		if self.selftest():
			raise Exception("AK8963 selftest failed!")
		time.sleep(0.01)
		self.setWord('MODE',0b0000)
		time.sleep(0.01)
		time.sleep(0.01)
		self.setWord('BIT',0b1)
		time.sleep(0.01)

	def getAdjustment(self):
		self.setWord('MODE',0b1111)
		x=(self.getWord('asax') - 128.0)/256.0 + 1.0
		y=(self.getWord('asay') - 128.0)/256.0 + 1.0
		z=(self.getWord('asaz') - 128.0)/256.0 + 1.0
		self.setWord('MODE',0b0000)
		time.sleep(0.01)
		return np.asarray([x,y,z])

	def selftest(self):

		bitm = self.getWord('BITM')
		if bitm:
			resolution = 16
		else:
			resolution = 14

		self.setWord('MODE',0b0000)
		self.setWord('SELF',0b1)
		self.setWord('MODE',0b1000)
		while self.getWord('DRDY') != 1:
			pass
		rid, mask = self._getMask(self.DICT,'hxl')
		data = np.asarray(self.read(rid,6))
		data = (data[1::2] << 8) | data[0::2]
		self.setWord('SELF',0b0)
		self.setWord('MODE',0b0000)

		data = signed(data,resolution)
		data = np.multiply(data,self.adj)

		err = 0

		if resolution == 14:
			if data[0] < -50 or data[0] > 50:
				logging.error("X direction selftest out of range!")
				err += 1
			if data[1] < -50 or data[1] > 50:
				logging.error("X direction selftest out of range!")
				err += 1
			if data[2] < -800 or data[2] > 200:
				logging.error("X direction selftest out of range!")
				err += 1
		else:
			if data[0] < -200 or data[0] > 200:
				logging.error("X direction selftest out of range!")
				err += 1
			if data[1] < -200 or data[1] > 200:
				logging.error("X direction selftest out of range!")
				err += 1
			if data[2] < -3200 or data[2] > 800:
				logging.error("X direction selftest out of range!")
				err += 1

		return err

	def whoami(self):
		rid, mask = self._getMask(self.DICT, 'wia')
		return self.read(rid)

	def reset(self):
		self.setWord('cntl2',0x1)
		time.sleep(0.1)

	def read(self,reg,length=1):
		return self.itf.read(self.addr,reg,length)

	def write(self,reg,data):
		self.itf.write(self.addr,reg,data)

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

	def readMag(self):

		bitm = self.getWord('BITM')
		if bitm:
			resolution = 16
		else:
			resolution = 14

		self.setWord('MODE',0b0001)
		while self.getWord('DRDY') != 1:
			pass
		rid, mask = self._getMask(self.DICT,'hxl')
		data = np.asarray(self.read(rid,6))
		data = (data[1::2] << 8) | data[0::2]

		if self.getWord('HOFL'):
			logging.warn('AK8963 overflown!')

		data = signed(data,resolution)

		if resolution==14:
			return data * 0.6
		else:
			return data * 0.15

def signed(data,resolution):
	if isinstance(data,int):
		if data & (0b1<<(resolution-1)) != 0:
			data &= 0xffffffff ^ (0b1<<resolution)-1
		else:
			data &= (0b1<<resolution)-1
		data = struct.unpack('>i',struct.pack('>I',data))
		return data
	elif isinstance(data,list) or isinstance(data,np.ndarray):
		vsigned = np.vectorize(signed)
		data = vsigned16b(data,resolution)
		return data
	else:
		raise ValueError("Invalid parameter")
