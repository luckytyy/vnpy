#!/usr/bin/env bash

python=$1
pypi_index=$2
shift 2

[[ -z $python ]] && python=python3
[[ -z $pypi_index ]] && pypi_index=https://pypi.vnpy.com

$python -m pip install --upgrade pip wheel --index $pypi_index

# 修复函数名：使用下划线替代连字符
function install_ta_lib() {
    export HOMEBREW_NO_AUTO_UPDATE=true
    brew install ta-lib
}

function ta_lib_exists() {
    ta-lib-config --libs > /dev/null 2>&1
}

# 调用修复后的函数名
ta_lib_exists || install_ta_lib

# install ta-lib
$python -m pip install numpy==1.23.1 --index $pypi_index
$python -m pip install ta-lib==0.4.24 --index $pypi_index

# Install Python Modules
$python -m pip install -r requirements.txt --index $pypi_index

# Install VeighNa
$python -m pip install . --index $pypi_index
