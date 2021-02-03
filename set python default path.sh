python --version
ls /usr/bin/python*
alias python='/usr/bin/python3.8' 
. ~/.bashrc
pip install virtualenv  
virtualenv venv
source venv/bin/activate
python3 -m venv ~/.devops
source ~/.devops/bin/activate