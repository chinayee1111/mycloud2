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