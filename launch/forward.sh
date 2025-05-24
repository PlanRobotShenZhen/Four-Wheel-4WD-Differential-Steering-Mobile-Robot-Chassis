#!/bin/bash

# 检查参数
if [ $# -ne 1 ]; then
  echo "Usage: $0 <linear_speed>"
  exit 1
fi

# 停止机器人（清零指令）
rostopic pub -1 /cmd_vel geometry_msgs/Twist -- '[0.0, 0.0, 0.0]' '[0.0, 0.0, 0.0]' >/dev/null

# 持续发布前进指令（Ctrl+C 时自动停止）
echo "Moving FORWARD with speed: $1"
trap 'rostopic pub -1 /cmd_vel geometry_msgs/Twist -- "[0.0, 0.0, 0.0]" "[0.0, 0.0, 0.0]" >/dev/null' INT
rostopic pub -r 10 /cmd_vel geometry_msgs/Twist -- "[$1, 0.0, 0.0]" "[0.0, 0.0, 0.0]"