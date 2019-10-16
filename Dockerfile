FROM jenkinsci/jnlp-slave:3.16-1
MAINTAINER songchaots <songchaots@163.com>

ARG DOCKER_VERSION=17.06.2~ce-0~debian
ARG DC_VERSION=1.18.0
ARG KUBECTL_VERSION=v1.16.0

USER root

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    apt-get update && \
    apt-get install -qq -y --no-install-recommends docker-ce=${DOCKER_VERSION} && \
    curl -L https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(KUBECTL_VERSION)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    apt-get clean && \
    echo "-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA0T/zUh64nbKZvy/ETs4oi+0504UroyjzZGUwW/C7atwyWPLx
ueAAE4c/eFbte/+Wv1HkNR4xzm9aIS59mZcLzJKPEO8aMJCIwrjDe9MqYZAFmAzC
qDEkjZ21nUtTGqlK4IkRlvxk/ZD6G5zfoROXCCJeymuZzNMig7lbSq+cGfwBd5Ct
57OFa2NnrOLuOatGltwhH7jQN3t9+7/t/HbaNh63Kul3emjSfp75qTFagu60DIgS
KVLygTnQpFx6z/dO5aHHwJBDyPOQYjhdm9zphcbX2J8Zxq70BqJAFiGCYtMqXWw0
bnGGItLAKcim55svuO0HCOko4SWxLIEcpSlvnQIDAQABAoIBAQC1kVsuH7AsTkRw
jB84DlVKjY8GxmBGFIuVyuP6c1n88JLTcgNkOUV3rHzbi/pIBVCmNIXjvY6URTUc
471in5lCas2vcPn1uASjijU95c65l4HzHOdvkCzaoUVs9mZnFQz+5pEXxWxQRhNw
EGBP4bLFASXlWRa8j1w8loLrvJOkSuDETQt+NepGRyk1OreSAIcDGl4MmJZdnLCH
UWLGyEbtUtWTcnD6akPfKOl31m4fIqnDM0sIYx3/ekD7JzeK/BXbYhPJS7bH5WIS
emr+EQmEVnt5s7Yz2GRepEmR1+LMVq42rk8MstLT8fW8VA0bl07j7qQWjyZopei+
6UIIyKgVAoGBAOhRkgNu07hjRuU4dCumy68i7x2y0oR86QXTiw+EwJjHouZJ8X5m
mMsRj2foIuReLhTeU+kZK0qRItmQJOuLdRSri5Ccowif35G81RlvdbNitr23mCjO
IGCgbjT6TPfoQWe9NkaSxq/v/1Jk+wtSvxxnYvVOgeqZ4w1Fg4tA07ybAoGBAOaU
ZEC/ci+gtGHg5viAURtzJTQMe650lDcknCpTV5p9u2q3F+yheNaSQU5guXEk43Fy
sDfUiazMCw99ctlMNVWF9rmadaRpp5tNbRwGWrm9KWTFeqLgep+FscfDIEVLj2T0
52XLDnd4Ob233bshmG9NI4ULKc3EeXzRrwyJYFwnAoGBAKrDKnxzfhROhNIACQP8
+kKlfvVpd+wClJW/xLuHbLngJBD50RSD/VNmeO57ZwpNX7nfIfZ4laWdwOwCU+D/
BPRIk7GcMQop2X+aOVkU4IMW0BPrW2DDAnGD+v3d7a1bfpfuMHL3eCviUN4Tc6QD
Eo6iP87oAf6bVpVuvx4gbIJ5AoGBANDNIffsJefxXEeiVSZFdK0p2U/H2hyB31IM
Kgq+C/+Pyi75/IVBN97+9HqYZnWKFRi/5cm5Aq9i2sU9McqLE2UN+f3bXJr1Pl0J
gTu2mWPHY3uoxMRICWL5u6MNFOULZp/iksUAW2peidM+dGEoLBTmQrsQ/9shB267
pwvwPz1TAoGANcj+Q5wA8cyIekvWw1D5uvdlTyow7lkW0OHH8KMHxKD45l1szKMg
0j23CetFQ3mOnoMMEWRJ3wshriuQU5XuC0KsHitlAVcJge7csBxoSRKntPudl9KH
2qkEeBExbNM8h1irDdwYPsTLOH3KgxbxIFub728PO9b93zTRhv/TzpY=
-----END RSA PRIVATE KEY-----" > /root/.ssh/id_rsa && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRP/NSHridspm/L8ROziiL7TnThSujKPNkZTBb8Ltq3DJY8vG54AAThz94Vu17/5a/UeQ1HjHOb1ohLn2ZlwvMko8Q7xowkIjCuMN70yphkAWYDMKoMSSNnbWdS1MaqUrgiRGW/GT9kPobnN+hE5cIIl7Ka5nM0yKDuVtKr5wZ/AF3kK3ns4VrY2es4u45q0aW3CEfuNA3e337v+38dto2Hrcq6Xd6aNJ+nvmpMVqC7rQMiBIpUvKBOdCkXHrP907locfAkEPI85BiOF2b3OmFxtfYnxnGrvQGokAWIYJi0ypdbDRucYYi0sApyKbnmy+47QcI6SjhJbEsgRylKW+d root@jnlp" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa
