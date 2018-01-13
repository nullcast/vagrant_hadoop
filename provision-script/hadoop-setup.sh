# etc/hadoop/slaves
cat << 'EOF' > $HADOOP_HOME/etc/hadoop/slaves
node1
node2
EOF
cat $HADOOP_HOME/etc/hadoop/slaves

# etc/hadoop/core-site.xml
cat << 'EOF' > /tmp/core-site.xml.property
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://master:9000</value>
  </property>
EOF
sed -i -e '
  /^<configuration>$/r /tmp/core-site.xml.property
  /^$/d
' $HADOOP_HOME/etc/hadoop/core-site.xml
tail -n 6 $HADOOP_HOME/etc/hadoop/core-site.xml

# etc/hadoop/hdfs-site.xml
cat << 'EOF' > /tmp/hdfs-site.xml.property
  <property>
    <name>dfs.replication</name>
    <value>2</value>
  </property>
  <property>
    <name>dfs.namenode.secondary.http-address</name>
    <value>master:50090</value>
  </property>
EOF
sed -i -e '
  /^<configuration>$/r /tmp/hdfs-site.xml.property
  /^$/d
' $HADOOP_HOME/etc/hadoop/hdfs-site.xml
tail -n 6 $HADOOP_HOME/etc/hadoop/hdfs-site.xml

# etc/hadoop/mapred-site.xml
cp $HADOOP_HOME/etc/hadoop/mapred-site.xml{.template,}
cat << 'EOF' > /tmp/mapred-site.xml.property
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
EOF
sed -i -e '
  /^<configuration>$/r /tmp/mapred-site.xml.property
  /^$/d
' $HADOOP_HOME/etc/hadoop/mapred-site.xml
tail -n 6 $HADOOP_HOME/etc/hadoop/mapred-site.xml

# etc/hadoop/yarn-site.xml
cat << 'EOF' > /tmp/yarn-site.xml.property
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>master</value>
  </property>
EOF
sed -i -e '
  /^<configuration>$/r /tmp/yarn-site.xml.property
  /^$/d
' $HADOOP_HOME/etc/hadoop/yarn-site.xml
tail -n 11 $HADOOP_HOME/etc/hadoop/yarn-site.xml

rm -R /tmp/*