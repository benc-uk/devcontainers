# Parameterize base image
ARG baseImage
FROM $baseImage

# Need to support both root and non-root, to use as a devcontainer and with 'act'
ARG user=vscode
ARG userhome=/home/vscode
USER $user
ENV HOME $userhome

# Path update needed as many installers go to $HOME/.local/bin
RUN mkdir -p $HOME/.local/bin
ENV PATH $HOME/.local/bin:$HOME/.npm-global/bin:$PATH
WORKDIR $HOME

# Run the main install script
COPY install.sh .
RUN ./install.sh && rm install.sh

# Set UK London as timezone
ARG timeZone=Europe/London
RUN sudo ln -snf /usr/share/zoneinfo/$timeZone /etc/localtime \
    && echo $timeZone sudo tee /etc/timezone

# It's better than bash
ENTRYPOINT [ "zsh" ]