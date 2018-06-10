
run:
	py -3 -m mkdocs gh-deploy
	git add .
	git commit -m "update master"
	git push origin master
