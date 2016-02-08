read -p "Enter commitLabel : " commitLabel
git add --all
git commit -m $commitLabel
git push -u origin master
