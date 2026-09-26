# Slim ROS 2 Humble workspace for onboarding exercises 01–07 Phase A.
# Not the sim / autonomy stack — that is docker/dv_pipeline_stack.
#
# Students should not install ROS on the host. Build + run:
#   docker compose -f docker-compose.onboarding.yml up -d --build
#   .\tools\onboarding-ros.ps1

FROM ros:humble-ros-base

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-colcon-common-extensions \
        python3-numpy \
        python3-pytest \
        ros-humble-geometry-msgs \
        ros-humble-rclpy \
        ros-humble-std-msgs \
    && ln -sf /usr/bin/pytest-3 /usr/local/bin/pytest \
    && rm -rf /var/lib/apt/lists/*

# Interactive `docker compose exec … bash` does not re-run ENTRYPOINT.
# Keep the same sourcing in bashrc so a raw exec still has ros2 / colcon.
RUN printf '%s\n' \
        'if [ -f /opt/ros/humble/setup.bash ]; then . /opt/ros/humble/setup.bash; fi' \
        'if [ -f /ws/install/setup.bash ]; then . /ws/install/setup.bash; fi' \
        >> /etc/bash.bashrc

WORKDIR /ws

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Isolated from the sim stack (which uses domain 0 by default).
ENV ROS_DOMAIN_ID=42

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "infinity"]
