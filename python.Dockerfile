FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

WORKDIR /tmp

USER root
ENV HOME /root

# Path update needed as many installers go to $HOME/.local/bin
ENV PATH $PATH:$HOME/.local/bin
COPY scripts/install.sh .
RUN chmod +x install.sh && ./install.sh
