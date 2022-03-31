FROM python:3.9-slim

RUN apt update && \
    apt install --no-install-recommends -y build-essential software-properties-common libgl1-mesa-glx libsm6 libxext6 libglib2.0-0 && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt install --no-install-recommends -y python3.9 python3-pip python3-setuptools python3-distutils && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app
COPY . /app/

RUN python3.9 -m pip install --upgrade pip && \
    python3.9 -m pip install --no-cache-dir -r requirements.txt
CMD ["python3", "app.py"]
EXPOSE 5000