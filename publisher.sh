VERSION="0.1"
AUTHOR="Hervé Beraud"

function git_merge() {
    git checkout master
    git merge --no-ff development
    read -p "master commit message" mastermessage
    git commit -am "$mastermessage"
    git push origin master
}

function git_tag() {
    read -p "version" version
    git tag -a $version
    git push --follow-tags
}

function manage_git() {
    git_merge
    git_tag
}

function clean_wheel() {
    if [ -d "$DIRECTORY" ]; then
        echo -e "remove old packaging versions"
        rm -rf dist/*
    fi
}

function manage_python_package() {
    clean_wheel    
    python setup.py bdist_wheel
    twine upload dist/*
}

function run() {
    manage_git
    manage_python_package
}

run
