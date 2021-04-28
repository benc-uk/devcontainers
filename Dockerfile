ARG BASE
FROM $BASE

# Need to support both root and non-root, to use as a devcontainer and with 'act'
ARG user=vscode
ARG userhome=/home/vscode
USER $user
ENV HOME $userhome

# Path update needed as many installers go to $HOME/.local/bin
RUN mkdir -p $HOME/.local/bin
ENV PATH $HOME/.local/bin:$HOME/.npm-global/bin:$PATH
WORKDIR $HOME
COPY scripts/install.sh .
RUN ./install.sh && rm install.sh

ENTRYPOINT [ "zsh" ]