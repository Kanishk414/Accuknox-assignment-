# Base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV SRVPORT=4499
#sometimes it is not catching path of cowsay so explicitly added .
ENV PATH=$PATH:/usr/games

# here it main installation packages are fortune-mod fortunes-min cowsay .
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        netcat-openbsd \
        cowsay \
        fortune-mod \
        fortunes-min \
        perl \
        locales && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*


# Setting up our  working directory
WORKDIR /app

# Copying our  script
COPY wisecow.sh /app/wisecow.sh

#giving permission to the file to run 
RUN chmod +x /app/wisecow.sh

# Expose port
EXPOSE 4499

# Run the app
CMD ["/app/wisecow.sh"]
