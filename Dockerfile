FROM index.docker.io/continuumio/anaconda3

MAINTAINER peterz3g <peterz3g@163.com>

#for the docker src dir, copy to images
RUN mkdir -p /dsrc
WORKDIR /dsrc
COPY . /dsrc/

#enable cron, and take a example task
COPY cron_jobs.txt /var/spool/cron/crontabs/root


# install nginx  E: dpkg was interrupted, you must manually run 'dpkg --configure -a' to correct the problem. 
# pip install --no-cache-dir -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
# pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pandas 

# https://mirror.tuna.tsinghua.edu.cn/help/anaconda/
# conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
# conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
# conda config --set show_channel_urls yes

RUN apt-get update && \
apt-get install -y cron && \
apt-get install -y vim && \
apt-get install -y telnet && \
apt-get install -y netstat && \
apt-get install -y gcc && \
apt-get install -y build-essential && \
chmod +x /dsrc/entrypoint.sh && \
chmod 0600 /var/spool/cron/crontabs/root && \
pip install --upgrade pip && \
pip install --upgrade setuptools && \
pip install -r /dsrc/requirements.txt && \
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
service cron restart && \
echo "#add by zhangyang"  >> /etc/profile && \
echo "export LANG=C.UTF-8"  >> /etc/profile && \
mkdir /root/.jupyter && \
apt-get clean && \
apt-get autoclean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
ls


#enable notebook port
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
EXPOSE 7001
ENTRYPOINT ["/bin/bash", "/dsrc/entrypoint.sh"]

