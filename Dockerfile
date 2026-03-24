# Minimal Ubuntu image
FROM ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /minecraft

# Copy your server.jar
COPY server.jar /minecraft/server.jar

# Expose default Minecraft port
EXPOSE 25565

# Automatically accept EULA and set online-mode=false
RUN echo "eula=true" > eula.txt && \
    echo "online-mode=false" >> server.properties || true

# Start server
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "nogui"]
