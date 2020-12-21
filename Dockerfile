FROM ubuntu:20.04
ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y bash zsh wget curl gcc make cmake golang python3 python3-dev nodejs npm openjdk-11-jre-headless maven vim tmux git ctags && \
    git clone https://github.com/my-dotfile/my-tmux ~/.my-tmux && ~/.my-tmux/install.sh && \
    git clone https://github.com/my-dotfile/my-vim ~/.my-vim && ~/.my-vim/install.sh && \
    mkdir ~/.my-zsh && \
    wget -O ~/.my-zsh/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && \
    chmod +x ~/.my-zsh/install.sh && ~/.my-zsh/install.sh && \
    echo 'set encoding=utf-8' >> ~/.vimrc.local && \
    go env -w GOPROXY=https://goproxy.io,direct GO111MODULE=on && \
    vim -c 'GoInstallBinaries' -c 'q!' && \
    ~/.vim/bundle/YouCompleteMe/install.py --all && \
    rm -rf ~/go/pkg ~/.cache /tmp/* && \
    find . -name '.git' -type d | xargs rm -rf && \
    chsh -s /usr/bin/zsh

WORKDIR /workdir/

ENTRYPOINT [ "/usr/bin/tmux" ]
