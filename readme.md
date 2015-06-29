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

## Adjustment for Screen

For screen to display vim with 256-colors in console you need to set the TERM environment variable in you shell.

1. Enter the following to your .bashrc:
    ```sh
    # enable 256color mode in console for screen and vim
    export TERM=xterm-256color
    ```

2. log off and on again

Further Information see [stackoverflow question 6787734](http://stackoverflow.com/questions/6787734/strange-behavior-of-vim-color-inside-screen-with-256-colors)
