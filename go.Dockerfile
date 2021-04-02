FROM mcr.microsoft.com/vscode/devcontainers/go:1.16

WORKDIR /tmp

# Path update needed as many installers go to $HOME/.local/bin
ENV PATH $PATH:$HOME/.local/bin
COPY scripts/install.sh .
RUN chmod +x install.sh && ./install.sh
