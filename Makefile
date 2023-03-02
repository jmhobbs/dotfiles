.PHONY: noop all links software os trust

noop:
	@echo "make [all|links|software|macOS|trust]"
	@echo
	@echo "all      - Install everything, in order"
	@echo "links    - Link all configs"
	@echo "software - Install software and Brewfile"
	@echo "os       - Set OS preferences and config"
	@echo "trust    - Import GPG keys, and other trusty things"

all: links software os trust

links:
	@bash links.sh

software:
	@bash software.sh

os:
	@bash os.sh

trust:
	@bash trust.sh
