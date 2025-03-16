FROM ubuntu:24.04

# update
RUN apt-get -y update && apt-get install -y \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libglib2.0-0 \
    sudo \
    wget \
    vim
RUN apt update && apt install -y gcc -y
#install anaconda3
WORKDIR /opt
# download anaconda package and install anaconda
# archive -> https://repo.anaconda.com/archive/
RUN wget https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-aarch64.sh && \
    sh /opt/Anaconda3-2024.06-1-Linux-aarch64.sh -b -p /opt/anaconda3 && \
    rm -f Anaconda3-2024.06-1-Linux-aarch64.sh
# set path
ENV PATH /opt/anaconda3/bin:$PATH

# update pip and install packages
RUN pip install --upgrade pip && \
    pip install opencv-python && \
    pip install nibabel
RUN pip install psycopg2-binary
RUN conda install -c conda-forge pytorch -y
RUN conda install -c conda-forge librosa -y
RUN conda install onnxruntime -y
RUN conda install -c conda-forge soundfile -y
RUN conda install -c conda-forge pydub -y
RUN pip install audiostretchy
RUN pip install basicsr
RUN pip install facexlib
RUN pip install gfpgan
RUN pip install scenedetect
RUN pip install deepface
RUN pip install googletrans==4.0.0-rc1
RUN pip install httpx --upgrade
RUN pip install TTS
WORKDIR /
RUN mkdir /work
WORKDIR /work

# execute jupyterlab as a default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]