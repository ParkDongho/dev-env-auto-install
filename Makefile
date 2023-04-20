OSNAME = ubuntu
OSVER = 20

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

rhel-8: default chisel chipyard astronvim

aws-fpga-ami: default
	echo "not supported yet"
	
ubuntu-onpremise: default

###################
default: ## Install the default packages
	./code/default/default-$(OSNAME)-$(OSVER).sh

###################
chisel: java11 coursier sbt diagrammer verilator

java11:
	./code/java/java11-$(OSNAME)-$(OSVER)-latest.sh

coursier:
	./code/coursier/coursier-$(OSNAME)-$(OSVER)-latest.sh

sbt: coursier
	./code/sbt/sbt-$(OSNAME)-$(OSVER)-latest.sh

diagrammer:
	./code/diagrammer/diagrammer-$(OSNAME)-$(OSVER)-latest.sh

verilator:
	./code/verilator/verilator-$(OSNAME)-$(OSVER)-latest.sh

####################

nvim: ## Install neovim
	./code/nvim/nvim-$(OSNAME)-$(OSVER)-latest.sh

rust: ## Install rust
	./code/rust/rust-$(OSNAME)-$(OSVER)-latest.sh

astronvim: nvim rust ## Install AstroNvim
	./code/astronvim/astronvim-$(OSNAME)-$(OSVER)-latest.sh
	



####################
conda-install: ## Install conda
	./code/conda/conda-$(OSNAME)-$(OSVER)-latest.sh

conda-setup: conda-install ## Setup conda
	./code/conda/conda-setup-$(OSNAME)-$(OSVER)-latest.sh

chipyard: conda-install conda-setup verilator ## Install Chipyard
	./code/chipyard/chipyard-$(OSNAME)-$(OSVER)-latest.sh
	
	
###################

gui:  ## Install the GUI on a CLI-only system
	./code/gui/gui-rhel-8.sh

ssh:  ## Install and enable the SSH service
	./code/default/ssh.sh
	
xrdp: ## Install and enable the xrdp service
	./code/default/xrdp.sh

bash: ## Select the desired shell (bash, zsh)
	./code/shell/bash-rhel-8-latest.sh

zsh:  ## Select the desired shell (bash, zsh)
	./code/shell/zsh-rhel-8-latest.sh



