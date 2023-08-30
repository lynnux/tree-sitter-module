#!/bin/bash

lang=$1
org="tree-sitter"

case "${lang}" in
    "dockerfile")
        org="camdencheek"
        ;;
    "cmake")
        org="uyha"
        ;;
    "typescript")
        sourcedir="typescript/src"
        ;;
    "tsx")
        repo="tree-sitter-typescript"
        sourcedir="tsx/src"
        ;;
    "elisp")
        org="Wilfred"
        ;;
    "elixir")
        org="elixir-lang"
        ;;
    "heex")
        org="phoenixframework"
        ;;
    "glsl")
        org="theHamsta"
        ;;
    "make")
        org="alemuller"
        ;;
    "markdown")
        org="ikatyang"
        ;;
    "org")
        org="milisims"
        ;;
    "perl")
        org="ganezdragon"
        ;;
    "proto")
        org="mitchellh"
        ;;
    "surface")
        org="connorlay"
        ;;
    "sql")
        org="DerekStride"
        branch="gh-pages"
        ;;
    "toml")
        org="ikatyang"
        ;;
    "vhdl")
        org="alemuller"
        ;;
    "wgsl")
        org="mehmetoguzderin"
        ;;
    "yaml")
        org="ikatyang"
        ;;
    "go-mod")
        org="camdencheek"
        ;;
    "clojure")
        org="dannyfreeman"
        ;;
    "scss")
        org="serenadeai"
        ;;
    "janet-simple")
        org="sogaiu"
        ;;
    "dart")
        org="ast-grep"
        ;;
    "souffle")
        org="chaosite"
        ;;
    "kotlin")
        org="fwcd"
        ;;
    "lua")
        org="MunifTanjim"
        ;;

esac

if [[ "$OSTYPE" =~ ^darwin ]];then
    soext="dylib"
elif [[ "$OSTYPE" =~ ^msys ]];then
    soext="dll"
else
    soext="so"
fi

echo "Building ${lang}"

# Retrieve sources.
git clone "https://github.com/${org}/tree-sitter-${lang}.git" \
    --depth 1 --quiet

if [ "${lang}" == "typescript" ]
then
    lang="typescript/tsx"
fi
cp tree-sitter-lang.in "tree-sitter-${lang}/src"
cp emacs-module.h "tree-sitter-${lang}/src"
cp "tree-sitter-${lang}/grammar.js" "tree-sitter-${lang}/src"
cd "tree-sitter-${lang}/src"

if [ "${lang}" == "typescript/tsx" ]
then
    lang="tsx"
fi

# Build.
cc -c -I. parser.c
# Compile scanner.c.
if test -f scanner.c
then
    cc -fPIC -c -I. scanner.c
fi
# Compile scanner.cc.
if test -f scanner.cc
then
    c++ -fPIC -I. -c scanner.cc
fi
# Link.
if test -f scanner.cc
then
    c++ -fPIC -static -shared *.o -o "libtree-sitter-${lang}.${soext}"
else
    cc -fPIC -static -shared *.o -o "libtree-sitter-${lang}.${soext}"
fi

# Copy out.

if [ "${lang}" == "tsx" ]
then
    cp "libtree-sitter-${lang}.${soext}" ..
    cd ..
fi

mkdir -p ../../dist
cp "libtree-sitter-${lang}.${soext}" ../../dist
cd ../../
if [ "${lang}" == "tsx" ]
then
    rm -rf "tree-sitter-typescript"
else
    rm -rf "tree-sitter-${lang}"
fi

