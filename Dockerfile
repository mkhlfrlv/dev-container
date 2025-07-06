FROM ubuntu:24.04

RUN apt update && \
    apt install -y openssh-server python3-pip sudo

RUN useradd -m -s /bin/bash dev && \
    echo "dev:dev" | chpasswd && \
    usermod -aG sudo dev && \
    mkdir -p /home/dev/app && \
    chown dev:dev /home/dev/app

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

RUN ssh-keygen -A

RUN mkdir -p /run/sshd

COPY start.sh /start.sh
RUN chmod +x /start.sh
RUN echo '[ -f /etc/k8s-env ] && export $(cat /etc/k8s-env | xargs)' > /home/dev/.bashrc

EXPOSE 22

CMD ["/start.sh"]
