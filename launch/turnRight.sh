#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <angular_speed>"
  exit 1
fi

rostopic pub -1 /cmd_vel geometry_msgs/Twist -- '[0.0, 0.0, 0.0]' '[0.0, 0.0, 0.0]' >/dev/null

echo "Turning RIGHT with angular speed: $1"
trap 'rostopic pub -1 /cmd_vel geometry_msgs/Twist -- "[0.0, 0.0, 0.0]" "[0.0, 0.0, 0.0]" >/dev/null' INT
rostopic pub -r 10 /cmd_vel geometry_msgs/Twist -- "[0.0, 0.0, 0.0]" "[0.0, 0.0, -$1]"