.PHONY: build_book
build_book: build_docker_image
	docker run -it -v $(PWD):/opt/repo mondoblack /bin/bash -c "cd /opt/repo && make build_pdf"

.PHONY: release
release: build_docker_image
	docker run -it -v $(PWD):/opt/repo mondoblack /bin/bash -c "cd /opt/repo && make release_book"

.PHONY: build_docker_image
build_docker_image:
	docker build -t mondoblack -f Dockerfile .

.PHONY: build_pdf
build_pdf: clean
	pdflatex "\def\isprintbook{1} \input{mondoblack.tex}"

.PHONY: clean
clean:
	rm -f mondoblack.blg
	rm -f mondoblack.bbl
	rm -f mondoblack.aux
	rm -f mondoblack-document.aux
	rm -f mondoblack.out
	rm -f mondoblack-document.out
	rm -f mondoblack.toc
	rm -f mondoblack.run.xml
	rm -f mondoblack.bcf
	rm -f mondoblack.pdf
	rm -f mondoblack.log
	rm -f mondoblack.mobi
	rm -f mondoblack.4ct
	rm -f mondoblack.4tc
	rm -f mondoblack.dvi
	rm -f mondoblack.epub
	rm -f mondoblack.css
	rm -f mondoblack.fdb_latexmk
	rm -f mondoblack.fls
	rm -f mondoblack.idv
	rm -f mondoblack.lg
	rm -f mondoblack.ncx
	rm -f mondoblack.tmp
	rm -f mondoblack.xref
	rm -f mondoblack*.svg
	rm -f mondoblack*.html
	rm -f mondoblack*.xhtml
	rm -rf mondoblack-epub/
	rm -rf mondoblack-epub3/
	rm -rf mondoblack-mobi/
	rm -rf mondoblack-azw3/
	rm -rf mondoblack.azw3
	rm -f *.pdf
	rm -f output.log
	rm -f content.opf
	find . -name "*.xbb" | xargs rm -f
	rm -rf release/

.PHONY: release_book
release_book: clean make_release_dir build_ebook build_pdf
	cp mondoblack.pdf release/mondoblack.pdf
	cp mondoblack-mobi/mondoblack.mobi release/mondoblack.mobi
	cp mondoblack-epub/mondoblack.epub release/mondoblack.epub
	cp mondoblack-azw3/mondoblack.azw3 release/mondoblack.azw3

.PHONY: make_release_dir
make_release_dir:
	mkdir -p release

.PHONY: build_ebook
build_ebook: make_release_dir
	find . -name "*.jpg" | xargs ebb -x
	find . -name "*.png" | xargs ebb -x
	tex4ebook -c tex4ebook.cfg -f epub mondoblack.tex
	tex4ebook -c tex4ebook.cfg -f mobi mondoblack.tex
	tex4ebook -c tex4ebook.cfg -f azw3 mondoblack.tex
