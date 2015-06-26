# My personal VIM configuration

This is my personal version contolled VIM configuration

## How to Set up

1. remove old configuration

    Windows:
    ```bat
    rd /s /q %ProgramFiles(x86)%\vim\vimfiles
    del %ProgramFiles(x86)%\vim\_viminfo
    del %ProgramFiles(x86)%\vim\_vimrc
    ```
    
    Linux:
    ```bash
    rm -rf ~/.vim
    rm ~/.viminfo
    rm ~/.vimrc
    ```
    
2. check out the git repository

        git clone https://github.com/andi-blafasl/vim.git .vim

3. update submodules

        git submodule update --init --recursive

4. create symlinks in home directory

    Windows:
    ```bat
    mklink /d vimfiles .vim
    mklink _vimrc .vim\.vimrc
    mklink .vimrc .vim\.vimrc
    ```
    
    Linux:
    ```sh
    ln -s .vim/.virmc .vimrc
    ```
    
## Keep submodules up to date
