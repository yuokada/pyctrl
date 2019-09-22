FROM ubuntu:bionic

RUN apt-get update
RUN apt-get install -y cmake
RUN apt-get install -y gfortran libssl-dev liblapack-dev libopenblas-dev
RUN apt-get install -y python3-setuptools python3-pip
RUN pip3 install pipenv
RUN mkdir -p /opt/app

WORKDIR /opt/app

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8
ENV PIPENV_VENV_IN_PROJECT=true
COPY Pipfile Pipfile.lock ./
RUN pipenv --python 3.6
RUN pipenv install
RUN mkdir -p notebooks
# USER nobody
EXPOSE 8888
ENTRYPOINT ["pipenv", "run"]
# ENTRYPOINT ["pipenv", "run", "jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--notebook-dir", "notebooks"]
CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
# diffutils
# jupyter notebook --no-browser
