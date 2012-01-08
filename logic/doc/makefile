PRE=pre
OUTPUT=$(PRE).pdf

all: show

compile: pre
	pdflatex $(PRE).tex 2> output.log

show: compile
	evince $(OUTPUT) 2> output.log

pre:
	pandoc --template beamer.template -i $(PRE).md -o $(PRE).tex
	perl -pe 's/\\section/\\end{frame}\n\\begin{frame}[fragile]\n\\frametitle/' -i $(PRE).tex
	perl -pe 's/\\end{document}/\\end{frame}\n\\end{document}/' -i $(PRE).tex

clean: 
	rm -f pre.tex
	rm -f *.aux
	rm -f *.log
	rm -f *.html
	rm -f *.nav
	rm -f *.out
	rm -f *.snm
	rm -f *.toc
	rm -f *.vrb
	rm -f *.pdf

