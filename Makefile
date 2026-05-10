BEAMER := main
LATEXMK := latexmk
LATEXMK_FLAGS := -xelatex -synctex=1 -quiet -interaction=nonstopmode -file-line-error -halt-on-error -shell-escape

.PHONY: all clean help

all:
	@rm -f error.log
	@TEXINPUTS=style:$(TEXINPUTS) $(LATEXMK) $(LATEXMK_FLAGS) $(BEAMER) || { \
		cp $(BEAMER).log error.log 2>/dev/null || true; \
		$(MAKE) --no-print-directory clean; \
		echo "Error! Please check error.log for more details."; \
		exit 1; \
	}
	@$(MAKE) --no-print-directory clean
	@echo "Done."

clean:
	@$(LATEXMK) -quiet -c $(BEAMER) 2>/dev/null || true
	@rm -f \
		$(BEAMER).bbl \
		$(BEAMER).bcf \
		$(BEAMER).blg \
		$(BEAMER).nav \
		$(BEAMER).run.xml \
		$(BEAMER).snm \
		$(BEAMER).vrb \
		$(BEAMER).synctex.gz \
		$(BEAMER).xdv

help:
	@echo "Usage: make [options]"
	@echo
	@echo "Options:"
	@echo "  all      Use xelatex to compile the LaTeX document."
	@echo "  clean    Clean temporary files."
	@echo "  help     Show this help message."
	@echo
	@echo "Note: make without any option is equivalent to make all."
