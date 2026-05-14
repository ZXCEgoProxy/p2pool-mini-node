FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y wget curl bzip2 tar

# Download and extract Monero CLI
RUN wget https://downloads.getmonero.org/cli/monero-linux-x64-v0.18.5.0.tar.bz2 && \
    tar -xjf monero-linux-x64-v0.18.5.0.tar.bz2 && \
    mv monero-x86_64-linux-gnu-v0.18.5.0 /monero && \
    rm monero-linux-x64-v0.18.5.0.tar.bz2

# Download and extract P2Pool
RUN wget https://github.com/SChernykh/p2pool/releases/download/v4.15/p2pool-v4.15-linux-x64.tar.gz && \
    tar -xzf p2pool-v4.15-linux-x64.tar.gz && \
    mv p2pool-v4.15-linux-x64 /p2pool && \
    rm p2pool-v4.15-linux-x64.tar.gz

# Expose necessary ports
EXPOSE 18080 37888 3333

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set working directory
WORKDIR /

# Run the start script
CMD ["/start.sh"]