######################################################################
#  Generate HTML pages from SGML docs.
#  ==================================
#
#  You may need to define (if the default location does not
#  correspond to your installation) the SGML_TOOL variable
#  (using SGML_TOOL=<path-to-sgml2html> on the make command
#  line).
#  The other vars can be left to their default values.
#
######################################################################
# $Log: Makefile,v $
# Revision 1.2  2002/03/12 20:41:44  nikai
# sgml2html language support
#
# Revision 1.1  2001/12/03 21:38:46  fbarriere
# Created, added 'release' target.
#
# Revision 1.1  2001/08/29 21:31:27  fbarriere
# Created.
#
######################################################################
TODAY         := $(shell date "+%d%m%y")

SGML_TOOL     := /usr/bin/sgml2html
SGML_TOOL_OPT := --language=$(LANG1)
#SGML_TOOL_OPT := --imagebuttons

#
#  Defines the list of languages to process.
#
LANGS         := en fr es de

#
#  Where are the HTML pages:
#
HTML_DIR      := HTML

#
#  Some standard shell tools:
#
MKDIR         := mkdir
CAT           := /bin/cat
RM            := /bin/rm -rf
CTAR          := /bin/tar cvfz

#
#  Edits under this point are not recommended.
# ####################################################

ROOT_DIR      := $(shell pwd)
PACKAGE_DIR   := $(ROOT_DIR)/../packages
PACKAGES      := $(addsuffix _$(TODAY).tar.gz,$(addprefix $(PACKAGE_DIR)/faq_, $(LANGS)))

#
#  Top level targets: then per language targets.
#

all:
	@ for LANG1 in $(LANGS);\
	do\
		echo "***Processing: $$LANG1";\
		if [ ! -d $(HTML_DIR) ];\
		then\
			$(MKDIR) $(HTML_DIR);\
		fi;\
		if [ ! -d $(HTML_DIR)/$$LANG1 ];\
		then\
			$(MKDIR) $(HTML_DIR)/$$LANG1;\
		fi;\
		$(MAKE) -f $(ROOT_DIR)/Makefile -C $(HTML_DIR)/$$LANG1 LANG1=$$LANG1 ROOT_DIR=$(ROOT_DIR) sylpheed-faq.html;\
	done;

#
#  Targets: the final one(s), generate the HTML(s).
#

sylpheed-faq.html: $(ROOT_DIR)/$(LANG1)/sylpheed-faq.sgml
	@ echo "******Starting $(SGML_TOOL)."
	@ $(SGML_TOOL) $(SGML_TOOL_OPT) $(ROOT_DIR)/$(LANG1)/sylpheed-faq.sgml

#
#  Generate the release package:
#
release: $(PACKAGES)

$(PACKAGES): $(PACKAGE_DIR)/faq_%_$(TODAY).tar.gz: HTML/%/sylpheed-faq.html
		@ if [ ! -d $(PACKAGE_DIR) ];\
		then\
			echo "***Creating $(PACKAGE_DIR)"; \
			$(MKDIR) $(PACKAGE_DIR);\
		fi;\
		echo "***Packaging: $*"; \
		$(CTAR) $@ HTML/$*/*.html

#
#  Usual clean target:
#

clean:
	- $(RM) $(HTML_DIR)
	- $(RM) $(PACKAGE_DIR)/*
