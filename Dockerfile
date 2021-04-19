FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y cups wget

COPY linux-brprinter-installer-2.2.2-2 /root/linux-brprinter-installer-2.2.2-2

RUN printf 'y\ny\ny\nn\nn\nn\nn\n' | bash /root/linux-brprinter-installer-2.2.2-2 MFC-J5910DW

CMD [ "bash"]