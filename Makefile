TEX=thesis.tex
TEXMAIN=$(basename $(TEX))
PDF=build/$(subst .tex,.pdf,$(TEX))
LOG=build/$(subst .tex,.log,$(TEX))
SRC=$(shell find src/ -name \"\*.tex\")

default: thesis

thesis: dirs $(src)
	xelatex -file-line-error -output-directory=build --halt-on-error $(TEX)
	cd build; biber thesis
	xelatex -file-line-error -output-directory=build --halt-on-error $(TEX)
	# sh -c ' \
	#   i=2; \
	#   while [ $$i -lt 5 ] && ( \
	#        grep -c "undefined citations" $(LOG) \
	#     || grep -c "undefined references" $(LOG) ); \
	#   do xelatex -file-line-error -output-directory=build --halt-on-error $(TEX); \
	#      i=`expr $$i + 1`; \
	#      done; \
        #   echo "Iterations: $$i"'

dirs:
	mkdir -p build
	cp thesis.bib build/

clean:
	rm -rf build/
