# Creates a virtual environment and installs 
# all packages required to run hera_corr_f

import pip
import os
import argparse

try:
    import virtualenv
except(ImportError):
    pip.main(['install','virtualenv'])
    import virtualenv

parser = argparse.ArgumentParser(description='Create a virtual environment with all packages requred for hera_corr_f installed.',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument('-git', dest='git', type=str, nargs=2, action='append', 
                    help ='List of git packages and repository pairs')
parser.add_argument('-pip', dest='pip', type=str, nargs='+',
                    help ='List of python pip packages to install')
parser.add_argument('-prot', dest='protocol', type=str, choices=['http','https'], default='https',
                    help ='Change the protocol used to connect to the git repository')

args = parser.parse_args()

# create and activate the virtual env
venv_dir = os.path.join(os.path.expanduser('~'),'.venv')
print('Creating virtual environment in directory %s'%venv_dir)
virtualenv.create_environment(venv_dir)
actfile = os.path.join(venv_dir,'bin','activate_this.py')
execfile(actfile,dict(__file__=actfile))

pip_pkgs = ['ipython','numpy','matplotlib','scipy','pyyaml','redis','crcmod']
if args.pip:
    pip_pkgs = list(set(pip_pkgs+args.pip))

git_pkgs = [['casperfpga','casper-astro'],['tftpy','jack-h']]
if args.git:
    git_pkgs = git_pkgs+args.git

# install pip packages directly using venv as prefix
for pkg in pip_pkgs:
    pip.main(['install','--prefix',venv_dir,pkg])

for pkg,repo in git_pkgs:
    git_url =  'git+'+args.protocol+'://github.com/'+repo+'/'+pkg+'.git'
    pip.main(['install','--prefix',venv_dir,git_url])

print('Finished installing packages. You can activate this environment with \'source ~/.venv/bin/activate\'')
