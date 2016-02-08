echo enter commitLabel:
read commitLabel
git add --all
git commit -m $:commitLabel
git push -u origin master
