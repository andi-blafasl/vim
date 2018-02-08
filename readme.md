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

        git clone --recursive https://github.com/andi-blafasl/vim.git .vim

3. create symlinks in home directory

    Windows:
    ```bat
    mklink /d vimfiles .vim
    mklink _vimrc .vim\.vimrc
    mklink .vimrc .vim\.vimrc
    ```
    
    Linux:
    ```sh
    ln -s .vim/.vimrc .vimrc
    ```

## How to fetch updates including Submodules

1. Pull the updated repository
    ```sh
    cd ~/.vim
    git pull
    ```

2. Init and update submodules
    ```sh
    git submodule update --init --recursive
    ```

## Add submodules

Add the Submodule to your git repository
```sh
cd ~/.vim/bundle
git submodule add https://github.com/StanAngeloff/php.vim.git php.vim
```

Commit your changes and push them to your remote

    git add -A
    git commit -m "Submodule php.vim added"
    git push

## Keep submodules up to date

Updating those submodules is super easy.

```sh
git submodule foreach --recursive git checkout master
git submodule foreach --recursive git pull
```

The first line will make sure that all submodules are on the master branch. With the second line, the latest version of each submodule will be pulled.

Now all you need to do is make sure that the latest versions are being added to your project repository:

```sh
git add -A
git commit -m "Submodule xy Update"
git push
```

## Remove a submodule

```sh
git submodule deinit path/to/module # ensure local config cleanup
git rm path/to/module               # clean WD and .gitmodules
```

The first line will remove the submodule from your local config. With the second line, the submodule will be removed from your working directory and the .gitmodules file.

## Adjustment for Screen

For screen to display vim with 256-colors in console you need to set the TERM environment variable in you shell.

1. Enter the following to your .bashrc:
    ```sh
    # enable 256color mode in console for screen and vim
    export TERM=xterm-256color
    ```

2. log off and on again

Further Information see [stackoverflow question 6787734](http://stackoverflow.com/questions/6787734/strange-behavior-of-vim-color-inside-screen-with-256-colors)
