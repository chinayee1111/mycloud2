FROM ubuntu:22.04
ENV qqy="-qq -y -o=Dpkg::Use-Pty=0"
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get $qqy update > /dev/null \
    && apt-get $qqy install ca-certificates curl wget gnupg lsb-release > /dev/null \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
         | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get $qqy update > /dev/null \
    && apt-get $qqy install docker-ce docker-ce-cli containerd.io docker-compose-plugin > /dev/null \
    && apt-get $qqy install openjdk-18-jdk-headless > /dev/null \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*
RUN DEBIAN_FRONTEND=noninteractive apt install qemu-kvm *zenhei* xz-utils dbus-x11 curl firefox-esr gnome-system-monitor mate-system-monitor  git xfce4 xfce4-terminal tightvncserver wget   -y
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN curl -LO https://proot.gitlab.io/proot/bin/proot
RUN chmod 755 proot
RUN mv proot /bin
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir  $HOME/.vnc
RUN echo 'luo' | vncpasswd -f > $HOME/.vnc/passwd
RUN chmod 600 $HOME/.vnc/passwd
RUN echo 'whoami ' >>/luo.sh
RUN echo 'cd ' >>/luo.sh
RUN echo "su -l -c  'vncserver :2000 -geometry 1280x800' "  >>/luo.sh
RUN echo 'cd /noVNC-1.2.0' >>/luo.sh
RUN echo './utils/launch.sh  --vnc localhost:7900 --listen 8900 ' >>/luo.sh
RUN chmod 755 /luo.sh
EXPOSE 8900
CMD  /luo.sh
