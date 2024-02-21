#!/bin/bash
wget https://github.com/derailed/k9s/releases/download/v0.26.7/k9s_Linux_x86_64.tar.gz
tar zxvf k9s_Linux_x86_64.tar.gz
rm k9s_Linux_x86_64.tar.gz
sudo mv k9s /usr/local/bin/k9s
rm LICENSE README.md
