# /etc/hosts
cat << 'EOF' | sudo tee -a /etc/hosts > /dev/null
192.168.33.10 master
192.168.33.11 node1
192.168.33.12 node2
EOF
tail -n 3 /etc/hosts

# 依存パッケージ
sudo yum -y install epel-release
sudo yum -y install openssh-clients rsync wget java-1.8.0-openjdk-devel sshpass

# .bashrc
cat << 'EOF' >> /home/vagrant/.bashrc
export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
export HADOOP_HOME=/home/vagrant/hadoop-2.8.2
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:$PATH
EOF
cat << 'EOF' >> /root/.bashrc
export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
export HADOOP_HOME=/home/vagrant/hadoop-2.8.2
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:$PATH
EOF
source /home/vagrant/.bashrc

# ssh
cat /vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
mkdir /root/.ssh
cat /vagrant/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
cp /vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
cp /vagrant/.ssh/id_rsa /root/.ssh/id_rsa