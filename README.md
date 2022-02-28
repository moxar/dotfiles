# Dependencies

neovim, git, curl, zsh
```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
apt-get install curl git zsh

postman
```
cd ~/Downloads
wget --content-disposition https://dl.pstmn.io/download/latest/linux
tar -xzf postman-9.14.0-linux-x64.tar.gz
mv Postman ~/.local/.
ln -s ~/.bin/postman ~/.local/Postman/app/postman
```

golang
```
cd ~/Downloads
wget https://go.dev/dl/go1.17.7.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.7.linux-amd64.tar.gz
```

gopls
```
go install golang.org/x/tools/gopls@latest
```

docker
```
cd ~/Downloads
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

kubectl
```
cd ~/Downloads
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo chown root:root kubectl
sudo mv kubectl /user/local/.
```

diff-so-fancy
```
cd ~/Downloads
curl -o ~/.bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
mv diff-so-fancy ~/.bin/.
```

aws-cli
```
cd ~/Downloads
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

nvm
```
cd ~/Downloads
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

ts lsp
```
npm install -g typescript-language-server
```

gql lsp
```
npm install -g graphql-language-service-cli
```
