FROM amd64/ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

ENV ADMIN_PASSWORD=admin
# ENV PATH $PATH /usr/local/bin

COPY linux-brprinter-installer-2.2.2-2 /root/linux-brprinter-installer-2.2.2-2

RUN apt update && apt upgrade -y && apt install -y cups wget

RUN adduser --home /home/admin --shell /bin/bash --gecos "admin" --disabled-password admin \
    && adduser admin sudo \
    && adduser admin lp \
    && adduser admin lpadmin

RUN echo 'admin ALL=(ALL:ALL) ALL' >> /etc/sudoers

RUN /usr/sbin/cupsd \
    && while [ ! -f  /var/run/cups/cupsd.pid ]; do sleep 1; done \
    && cupsctl --remote-admin --remote-any --share-printers \
    && kill $(cat /var/run/cups/cupsd.pid) \
    && echo "ServerAlias *" >> /etc/cups/cupsd.conf

RUN cp -rp /etc/cups /etc/cups-skel

RUN printf 'y\ny\ny\nn\nn\nn\nn\n' | bash /root/linux-brprinter-installer-2.2.2-2 MFC-J5910DW

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "cupsd", "-f" ]

VOLUME [ "/etc/cups" ]

EXPOSE 631