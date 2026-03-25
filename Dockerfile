FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /minecraft

COPY server.jar /minecraft/server.jar

EXPOSE 25565

RUN echo "eula=true" > eula.txt && \
    echo "online-mode=false" >> server.properties || true

CMD ./playit-linux-amd64 & \
    java -Xmx6G -Xms6G -jar server.jar nogui
