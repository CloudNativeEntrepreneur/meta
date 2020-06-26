git config --global core.ignorecase false

if [ -x "$(command -v node)" ]; then
        echo "nodejs installed"
else
    echo "WARNING: Missing tool - node"
fi;
if [ -x "$(command -v n)" ]; then
        echo "n installed"
else
    echo "WARNING: Missing tool - n"
fi;
if [ -x "$(command -v meta)" ]; then
        echo "meta installed"
else
    echo "WARNING: Missing tool - meta"
fi;
if [ -x "$(command -v loop)" ]; then
        echo "loop installed"
else
    echo "WARNING: Missing tool - loop"
fi;
if [ -x "$(command -v gcloud)" ]; then
        echo "gcloud installed"
else
    echo "WARNING: Missing tool - gcloud"
fi;
if [ -x "$(command -v jx)" ]; then
        echo "jx installed"
else
    echo "WARNING: Missing tool - jx"
fi;
if [ -x "$(command -v kubectl)" ]; then
        echo "kubectl installed"
else
    echo "WARNING: Missing tool - kubectl"
fi;
if [ -x "$(command -v safe)" ]; then
        echo "safe installed"
else
    echo "WARNING: Missing tool - safe"
fi;
if [ -x "$(command -v envsubst)" ]; then
        echo "gettext installed"
else
    echo "WARNING: Missing tool - envsubst (gettext)"
fi;
if [ -x "$(command -v docker)" ]; then
        echo "docker installed"
else
    echo "WARNING: Missing tool - docker"
fi;
if [ -x "$(command -v docker-compose)" ]; then
        echo "docker-compose installed"
else
    echo "WARNING: Missing tool - docker-compose"
fi;

# test path inclusions
if [[ "$PATH" =~ "$HOME/.jx/bin" ]]; then
    echo "jx referenced in \$PATH"
else
    echo "$HOME/.jx/bin is not listed in your path file. Please add 'export PATH=\$HOME/.jx/bin:\$PATH' to your ~/.zshrc and source. Then re-run 'make install-tools'"
fi%   