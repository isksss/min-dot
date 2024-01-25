#!/bin/bash

# fileフォルダにあるファイルのシンボリックリンクをホームディレクトリに作成する
home_dir="$HOME"
script_dir=$(cd $(dirname $0); pwd)

# ファイルのシンボリックリンクを作成する
function create_symlink() {
    local file_name=$1
    local file_path="$script_dir/file/$file_name"
    local link_path="$home_dir/$file_name"

    #シンボリックリンクが存在する場合は削除する
    if [ -L $link_path ]; then
        echo "Remove $link_path"
        rm $link_path
    fi

    # ファイルが存在する場合はバックアップを作成する
    if [ -e $link_path ]; then
        echo "Backup $link_path"
        mv $link_path "$link_path.bak"
    fi

    # シンボリックリンクを作成する
    echo "Create symlink $link_path"
    ln -sf $file_path $link_path
}

# ファイルのシンボリックリンクを作成する
create_symlink ".bashrc"
create_symlink ".vimrc"