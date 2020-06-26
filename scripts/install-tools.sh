git config --global core.ignorecase false

if [ -x "$(command -v brew)" ]; then
        echo "homebrew installed"
else
    mkdir ~/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/homebrew
fi;
if [ -x "$(command -v node)" ]; then
        echo "nodejs installed"
else
    brew install nodejs
fi;
if [ -x "$(command -v n)" ]; then
        echo "n installed"
else
    npm i -g n &&
    n latest
fi;
if [ -x "$(command -v meta)" ]; then
        echo "meta installed"
else
    npm i -g meta
fi;
if [ -x "$(command -v loop)" ]; then
        echo "loop installed"
else
    npm i -g loop
fi;
if [ -x "$(command -v gcloud)" ]; then
        echo "gcloud installed"
else
    curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-298.0.0-darwin-x86_64.tar.gz --output ~/Downloads/google-cloud-sdk-298.0.0-darwin-x86_64.tar.gz
    mkdir ~/Downloads/google-cloud-sdk
    tar -xvzf ~/Downloads/google-cloud-sdk-298.0.0-darwin-x86_64.tar.gz --directory ~/Downloads/google-cloud-sdk
    sh ~/Downloads/google-cloud-sdk/install.sh
fi;
if [ -x "$(command -v jx)" ]; then
        echo "jx installed"
else
    brew tap jenkins-x/jx
    brew install jx
fi;
if [ -x "$(command -v kubectl)" ]; then
        echo "kubectl installed"
else
    brew install kubectl
fi;
if [ -x "$(command -v kubectx)" ]; then
        echo "kubectx installed"
else
    brew install kubectx
fi;
if [ -x "$(command -v safe)" ]; then
        echo "safe installed"
else
    brew tap starkandwayne/cf
    brew install starkandwayne/cf/safe
fi;
if [ -x "$(command -v sops)" ]; then
        echo "sops installed"
else
    brew install sops
fi;
if [ -x "$(command -v envsubst)" ]; then
        echo "gettext installed"
else
    brew install gettext
    brew link --force gettext
fi;
if [ -x "$(command -v docker)" ]; then
        echo "gettext installed"
else
    brew tap caskroom/cask
    brew cask install docker
fi;

# test path inclusions
if [[ "$PATH" =~ "$HOME/.jx/bin" ]]; then
    echo "jx referenced in \$PATH"
else
    echo "$HOME/.jx/bin is not listed in your path file. Please add 'export PATH=\$HOME/.jx/bin:\$PATH' to your ~/.zshrc and source. Then re-run 'make install-tools'"
fi