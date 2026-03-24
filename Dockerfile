# Minimal Ubuntu image
FROM ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Java only
RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /minecraft

# Copy server.jar from build context
COPY server.jar /minecraft/server.jar

# Expose Minecraft port
EXPOSE 25565

# Start the server
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "nogui"]
