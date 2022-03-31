FROM python:3.6.10-stretch
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-dev build-essential libgl1-mesa-glx libsm6 libxext6 libglib2.0-0 libglib2.0-dev

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb http://download.mono-project.com/repo/debian stretch/snapshots/5.20 main" > /etc/apt/sources.list.d/mono-official.list \
  && apt-get update \
  && apt-get install -y clang \
  && apt-get install -y mono-devel=5.20\* \
  && rm -rf /var/lib/apt/lists/* /tmp/*

RUN mkdir /app
WORKDIR /app
COPY . /app/

RUN pip3 install --upgrade pip
RUN pip3 install -U setuptools
RUN pip3 install -U wheel
RUN pip3 install -U pycparser
RUN pip3 install pythonnet==2.4.0
RUN pip3 install -r requirements.txt
CMD ["python3", "app.py"]
EXPOSE 5000