# Git常见命令

## git remote

```git
# rename
git remote set-url origin git@xxx.git
# delete
git remote remove origin
# add
git remote add origin yourRemoteUrl
```

## git branch+cheakout

```
=======clear all commit history =======
1.Checkout,build a new branch without parent node
   git checkout --orphan latest_branch

2. Add all the files
   git add -A

3. Commit the changes
   git commit -am "commit message"

4. Delete the branch
   git branch -D master

5.Rename the current branch to master
   git branch -m master

6.Finally, force update your repository
   git push -f origin master
```