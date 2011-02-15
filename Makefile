SCRIPT=ftplugin/csv.vim
DOC=doc/ft_csv.txt
PLUGIN=csv
.PHONY : csv.vba


all: $(PLUGIN) $(PLUGIN).vba

clean:
	rm -rf *.vba */*.orig *.~* .VimballRecord doc/tags

dist-clean: clean

vimball: $(PLUGIN).vba install

install:
	vim -N -c 'ru! vimballPlugin.vim' -c':so %' -c':q!' ${PLUGIN}.vba

uninstall:
	vim -N -c 'ru! vimballPlugin.vim' -c':RmVimball ${PLUGIN}.vba'

undo:
	for i in */*.orig; do mv -f "$$i" "$${i%.*}"; done

csv.vba:
	vim -N -c 'ru! vimballPlugin.vim' -c ':let g:vimball_home=getcwd()'  -c ':call append("0", ["ftplugin/csv.vim", "doc/ft_csv.txt", "ftdetect/csv.vim"])' -c '$$d' -c ':%MkVimball! ${PLUGIN}' -c':q!'

csv:
	rm -f ${PLUGIN}.vba
	perl -i.orig -pne 'if (/Version:/) {s/\.(\d)*/sprintf(".%d", 1+$$1)/e}' ${SCRIPT}
	perl -i -pne 'if (/GetLatestVimScripts:/) {s/(\d+)\s+:AutoInstall:/sprintf("%d :AutoInstall:", 1+$$1)/e}' ${SCRIPT}
	perl -i -pne 'if (/Last Change:/) {s/(:\s+).*\n$$/sprintf(": %s", `date -R`)/e}' ${SCRIPT}
	perl -i.orig -pne 'if (/Version:/) {s/\.(\d)+.*\n/sprintf(".%d", 1+$$1)/e}' ${DOC}