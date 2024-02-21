#!/bin/bash

sudo apt update
sudo apt-get install bash-completion -y
type _init_completion
source /usr/share/bash-completion/bash_completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
exec bash


# krew install
set -x 
cd "$(mktemp -d)" && OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
KREW="krew-${OS}_${ARCH}"
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
tar zxvf "${KREW}.tar.gz"
./"${KREW}" install krew

cat <<EOF | tee -a ~/.bashrc

########### Krew Setting ###################
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
EOF
source ~/.bashrc

kubectl krew install ctx
kubectl krew install ns
kubectl krew install neat

mkdir -p ~/plugins && cd ~/plugins
git clone https://github.com/jonmosco/kube-ps1.git
chmod +x ./kube-ps1/kube-ps1.sh

cat <<EOF | tee -a ~/.bashrc

############# kube-ps1 SETTING   ##################
source $HOME/plugins/kube-ps1/kube-ps1.sh
PS1='[\u@\h \W \$(kube_ps1)]\\$ '
KUBE_PS1_SYMBOL_ENABLE=true
EOF

source ~/.bashrc
