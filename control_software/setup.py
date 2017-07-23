from distutils.core import setup
import glob

setup(name='hera_corr_f',
      version='0.0.1',
      description='Python libraries and scripts to control the HERA correlator F-Engines',
      author='Jack Hickish',
      author_email='jackh@berkeley.edu',
      url='https://github.com/jack-h/herafengine',
      provides=['hera_corr_f'],
      packages=['hera_corr_f'],
      package_dir={'hera_corr_f' : 'src'},
      scripts=glob.glob('scripts/*'),
      )

