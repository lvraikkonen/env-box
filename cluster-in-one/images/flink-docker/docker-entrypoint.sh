# 指定 Flink 的目录
FLINK_HOME=${FLINK_HOME:-"/opt/flink/bin"}

# 这两个变量分别用于启动 jc 和 tm
JOB_CLUSTER="job-cluster"
TASK_MANAGER="task-manager"

CMD="$1"
shift;

if [ "${CMD}" == "--help" -o "${CMD}" == "-h" ]; then
    echo "Usage: $(basename $0) (${JOB_CLUSTER}|${TASK_MANAGER})"
    exit 0
elif [ "${CMD}" == "${JOB_CLUSTER}" -o "${CMD}" == "${TASK_MANAGER}" ]; then
    echo "Starting the ${CMD}"

    if [ "${CMD}" == "${TASK_MANAGER}" ]; then
        # 启动 taskmanager
        exec $FLINK_HOME/bin/taskmanager.sh start-foreground "$@"
    else
        # 启动 standalone-job
        exec $FLINK_HOME/bin/standalone-job.sh start-foreground "$@"
    fi
fi

exec "$@"