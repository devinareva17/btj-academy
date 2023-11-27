FROM ubuntu:18.04
LABEL Name="Devina"

RUN apt-get update
RUN apt-get install vim python -y
ENTRYPOINT ["/bin/bash"]