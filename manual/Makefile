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
# Revision 1.3  2001/09/01 00:20:09  mones
# Deleted my stupid revision comment. I shouldn't play with cvs late night...
#
# Revision 1.2  2001/09/01 00:11:12  mones
# added Spanish to list of generated languages
#
# Revision 1.1  2001/08/29 21:31:27  fbarriere
# Created.
#
######################################################################

SGML_TOOL     := /usr/bin/sgml2html
SGML_TOOL_OPT :=
#SGML_TOOL_OPT := --imagebuttons

#
#  Defines the list of languages to process.
#
LANGS         := en fr es

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

#
#  Edits under this point are not recommended.
# ####################################################

ROOT_DIR      := $(shell pwd)

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
		$(MAKE) -f $(ROOT_DIR)/Makefile -C $(HTML_DIR)/$$LANG1 LANG1=$$LANG1 ROOT_DIR=$(ROOT_DIR) user_guide.html;\
	done;

#
#  Targets: the final one(s), generate the HTML(s).
#

user_guide.html: user_guide.sgml
	@ echo "******Starting $(SGML_TOOL)."
	@ $(SGML_TOOL) $(SGML_TOOL_OPT) user_guide.sgml

user_guide.sgml: $(ROOT_DIR)/$(LANG1)/*.sgml
	@ echo "******Building full SGML file."
	@ $(CAT) $(ROOT_DIR)/$(LANG1)/*.sgml > user_guide.sgml


#
#  Usual clean target:
#

clean:
	- $(RM) $(HTML_DIR)
