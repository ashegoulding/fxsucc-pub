cc_pdf = pandoc\
	-s -f markdown_github+yaml_metadata_block+markdown_in_html_blocks+raw_html\
	--highlight-style=tango\
	-V colorlinks=true\
	-V linkcolor=blue\
	-V urlcolor=red\
	-V toccolor=gray
do_iso = mkisofs -quiet -J -udf -allow-limited-size

all: dvd github

output:
	mkdir output

# sudo dnf install pandoc texlive-latex texlive-amsfonts texlive-amsmath\
# texlive-lm texlive-unicode-math texlive-iftex texlive-listings\
# texlive-fancyvrb texlive-topiclongtable texlive-booktabs texlive-pst-graphicx\
# texlive-hyperref texlive-xcolor texlive-ulem texlive-geometry texlive-babel\
# texlive-fontspec texlive-selnolig texlive-gsftopk texlive-framed\
# texlive-footnotehyper
pdf:
	$(cc_pdf) --resource-path=doc -o doc/manual.pdf doc/manual.md

dvd: pdf output
	$(do_iso) -o output/sawmill-mpt_a.iso -V "sawmill-mpt_a" -graft-points\
		dl=dl\
		doc=doc\
		invoices=invoices\
		src=src
	$(do_iso) -o output/sawmill-mpt_b.iso -V "sawmill-mpt_b" vm

github: output
	rsync -a --delete --exclude-from=.exclude_github . output/github

clean:
	rm -rf output
	rm -f doc/manual.pdf
rebuild: clean all
