#!/bin/bash
sudo apt install -y inkscape texlive-full emacs graphviz
WORKING_DIRECTORY=$(pwd)
ln -sf $WORKING_DIRECTORY/general $WORKING_DIRECTORY/projektantrag/
ln -sf $WORKING_DIRECTORY/general $WORKING_DIRECTORY/projekthandbuch/
