USER = ramnathv
REPO = swc-nw-dataviz

RMD_FILES  = $(wildcard */*.Rmd)
MD_FILES  = $(patsubst %.Rmd, %.md, $(RMD_FILES))
IPYNB_FILES  = $(patsubst %.Rmd, %.ipynb, $(RMD_FILES))

book: $(MD_FILES)
	gitbook build

serve: $(MD_FILES)
	gitbook serve

publish:
	cd _book && \
	rm -rf .git && \
	git init && \
	git commit --allow-empty -m 'initialize book' && \
	git checkout -b gh-pages && \
	touch .nojekyll && \
	git add . && \
	git commit -am "update book" && \
	git push git@github.com:$(USER)/$(REPO) gh-pages --force


md: $(MD_FILES)

%.md: %.Rmd
	Rscript -e "library(methods);devtools::in_dir(dirname('$^'), knitr::knit(basename('$^')))"



