# HDFSのフォーマット
$HADOOP_HOME/bin/hdfs namenode -format
# HDFSのデーモン起動
$HADOOP_HOME/sbin/start-dfs.sh
jps

# Yarnデーモン起動
$HADOOP_HOME/sbin/start-yarn.sh
jps

# MapReduce のジョブ履歴を管理するサービスを起動
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver
jps
