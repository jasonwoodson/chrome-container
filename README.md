# chrome-container
Chrome browser container project

    Run the modified podman run command:

bash

podman run -it --rm \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume /dev/shm:/dev/shm \
    --volume /etc/machine-id:/etc/machine-id \
    --volume /run/user/1000:/run/user/1000 \
    --volume /run/dbus:/run/dbus \
    --volume /var/lib/dbus:/var/lib/dbus \
    --volume ./.chrome:/data \
    --env DISPLAY=unix${DISPLAY} \
    --device /dev/dri \
    --device /dev/snd \
    --device /dev/video0 \
    --group-add $(getent group audio | cut -d: -f3) \
    --group-add $(getent group video | cut -d: -f3) \
    --ipc host \
    --security-opt seccomp=unconfined \
    --security-opt apparmor=unconfined \
    chrome
