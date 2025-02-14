# Base image
FROM python:3.12.9-bullseye

# Expose port 8080
EXPOSE 8080

# Set environment variables
ENV PATH="/root/OpenEFT/nbis/nfseg/bin:/root/OpenEFT/nbis/nfiq/bin:$PATH"

# Update and install required packages, including cmake, X11 development libraries, and openjpeg
RUN apt-get update && apt-get install -y \
    git \
    sudo \
    build-essential \
    cmake \
    libopenjp2-7-dev \
    libgl1-mesa-glx \
    libx11-dev \
    libfuse2 \
    libxext-dev \
    bash

# Clone the OpenEFT repository
RUN git clone https://github.com/kourosh-forti-hands/OpenEFT.git /root/OpenEFT && \
    cd /root/OpenEFT

# Set working directory to the cloned repo
WORKDIR /root/OpenEFT

RUN git checkout vuln-mgmt && git pull

# Run the build_linux.sh script
RUN chmod +x build_linux.sh && bash build_linux.sh

# Set the default command to run the application
#CMD ["python3", "openeft.py"]
ENTRYPOINT ["tail", "-f", "/dev/null"]
