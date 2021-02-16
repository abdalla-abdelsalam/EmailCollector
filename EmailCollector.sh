#!/bin/bash
path=$(pwd)
rm -rf development.txt
touch development.txt
while read repo_link
do   
   git clone $repo_link
   repo_link=(`echo $repo_link | tr '/' ' '`)
   AppPath=$path/${repo_link[3]}
   cd $AppPath
   git log > logs.txt
   while read line
   do
      if [[ $line = "Author: "* && ! $(grep -i "$line" "../development.txt") ]]
       then
         echo $line >>"../development.txt"
      fi
   done <logs.txt
   rm -rf $AppPath  
   cd $path 
    

done < ./links.txt