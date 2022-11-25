#!/bin/bash

export platform=windows
languages=(
    'c'
    'cpp'
    'css'
    'c-sharp'
    'go'
    'html'
    'javascript'
    'json'
    'python'
    'rust'
    'typescript'
    'elixir'
    'heex'
)

for language in "${languages[@]}"
do
    ./build.sh $language
done

zip -r "libs-${platform}-x64.zip" dist
