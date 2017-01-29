FROM alpine
MAINTAINER ant <git@manchestermonkey.co.uk>

ENV TFMVER 0.8.5
ENV HOME=/home/cloud

ADD https://releases.hashicorp.com/terraform/${TFMVER}/terraform_${TFMVER}_linux_amd64.zip /tmp/
ADD https://github.com/realestate-com-au/bash-my-aws/archive/master.tar.gz /tmp/

RUN apk --no-cache add util-linux bash python3 curl make less groff git vim &&\
    pip3 install --upgrade pip awscli boto3 boto &&\
    unzip -d /bin/ /tmp/terraform_${TFMVER}_linux_amd64.zip &&\
    tar -zxf /tmp/master.tar.gz -C /home/cloud/ && mv /home/cloud/bash-my-aws-master /home/cloud/bma &&\
    echo -ne "for I in /home/cloud/bma/lib/*-functions; do source \$I; done\n source /home/cloud/bma/bash_completion.sh\n\n PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$ '\n\n clear \n echo '\nTerraform version: ${TFMVER}\n AWS-CLI Version: $(aws --version)\n\n' " > /home/cloud/.bashrc &&\
  rm -f /tmp/* &&\
  adduser cloud -Du 1000 -h /home/cloud && mkdir /home/cloud/project && chown -Rf cloud: /home/cloud 

USER cloud

WORKDIR /home/cloud

ENTRYPOINT ["/bin/bash"]
