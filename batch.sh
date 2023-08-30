#!/bin/bash

export platform=windows
languages=(
    'bash'
    'c'
    'c-sharp'
    'clojure'
    'cmake'
    'cpp'
    'css'
    'scss'
    'dockerfile'
    'elisp'
    'elixir'
    'glsl'
    'go'
    'go-mod'
    'heex'
    'html'
    'janet-simple'
    'java'
    'javascript'
    'json'
    'julia'
    'lua'
    'make'
    'markdown'
    'org'
    'perl'
    'proto'
    'python'
    'ruby'
    'rust'
    'scala'
    'surface'
    'sql'
    'toml'
    'tsx'
    'typescript'
    'verilog'
    'vhdl'
    'wgsl'
    'yaml'
    'dart'
    'souffle'
    'kotlin'
)

for language in "${languages[@]}"
do
    ./build.sh $language
done

zip -r "libs-${platform}-x64.zip" dist
