# Minimal Ubuntu image
FROM ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Java and wget (needed for Playit)
RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /minecraft

# Copy Minecraft server jar
COPY server.jar /minecraft/server.jar

# Expose Minecraft default port
EXPOSE 25565

# Accept EULA and set online-mode=false
RUN echo "eula=true" > eula.txt && \
    echo "online-mode=false" >> server.properties || true

# Start Playit tunnel and Minecraft server
CMD ./playit-linux-amd64 & \
    java -Xmx5G -Xms5G -jar server.jar nogui
