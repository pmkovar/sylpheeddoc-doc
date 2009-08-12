######################################################################
#  Generate HTML pages from SGML docs.
#  ==================================
#
#  Edit the setup.mk included file to define your own docbook setup.
#  See the comments in this file for more details...
#
######################################################################
#
#  TARGET_TYPE is used to define the target for the doc to build:
#  either with images, for the web site (TARGET_TYPE=WEB) or without
#  any screenshot (to generate the doc to include in the Sylpheed
#  distribution).
#  TARGET_TYPE can be 'WEB' or any other value (including the null
#  string).
#  The default is 'WEB', so if you do not provide anything on the make
#  command line, the web site version is built.
#
######################################################################
#
#  Building particular type of doc (manual or faq) or building for
#  one language does not require any variable setting (for those who
#  remember the old sgmltools days). Just define what you want to
#  build in the command line of the make. Examples:
#
#  'make manual'           => will make the manual in all languages.
#  'make manual/en'        => Will build the English manual.
#  'make faq/en faq/es'    => Will build the English and Spanish FAQ.
#  'make faq/en manual/en' => Will build the English FAQ and manual.
#
######################################################################
#
# $Log: Makefile,v $
# Revision 1.6  2009/08/12 19:37:33  pknbe
# Makefile: Add the 'faq_chunks.xsl' stylesheet. tools/faq_chunks.xsl: Add chunk stylesheet for FAQ.
#
# Revision 1.6  2009/08/12 17:25:00  pknbe
# Added the 'faq_chunks.xsl' stylesheet
#
# Revision 1.5  2005/06/21 20:29:32  fbarriere
# Changed the Makefile to the new DocBook version of the doc
#
# Revision 1.4  2003/03/12 20:10:26  fbarriere
# Added the use of the zh-sgmltools for the chinese doc.
#
# Revision 1.3  2002/08/27 19:35:36  fbarriere
# Changed FILTER_IMAGE, added the TARGET_TYPE switch, added packages generation part.
#
# Revision 1.2  2002/03/30 21:24:00  fbarriere
# Modified to build the HTML directory locally (when launched from
# a sub-directory), corrected the image filter (this one should
# work in all cases).
#
# Revision 1.1  2002/03/20 21:17:00  fbarriere
# New and unique Makefile for all the docs.
#
######################################################################

#
#  Final result type: WEB (with images and original names),
#  or any other value for a version using the file names
#  that fits the Sylpheed code and without the images.
#
TARGET_TYPE   := WEB

#
#  Derive some settings from the TARGET_TYPE:
#
ifeq ($(TARGET_TYPE), WEB)
	FILTER_IMAGES :=
else
	FILTER_IMAGES := YES_MY_LORD
endif

#
#  Defines the types of doc and languages to process.
#
ALL_TYPES     := faq manual
LANGS         := de en es fr zh_TW.Big5

#
#  Some usual shell commands with some arguments...
#
REMOVE        := /bin/rm -rf 
COPY          := /bin/cp -r 
MAKEDIR       := /bin/mkdir -p 
CAT           := /bin/cat 
TAR_CREATE    := /bin/tar cvfz 

TAR_SUFFIX    := tar.gz

# ####################################################
#  Edits under this point are not recommended.
# ####################################################
#
#  Well, sounds like the voice of the master, in fact,
#  the settings above this line are very specific to
#  your installation/configuration, while the rest
#  of the file contains some variables that are supposed
#  to be defined automatically and typical makefile
#  targets:sources and commands lines...
#  Don't be afraid and feel free to edit anything
#  you want under this line to make it work for you!
# ####################################################

#
#  Some basic settings: the date, some directories
#  and names often used in the target or source
#  parts. Defined here, 'cause it makes changes easier,
#  and allows their definition on the make command line
#  to override the values defined in this file.
#
TODAY         := $(shell date "+%d%m%Y")

HERE          := $(shell pwd)
ROOT_DIR      := $(HERE)
PACKAGE_DIR   := $(ROOT_DIR)/../packages
HTML_DIR      := $(ROOT_DIR)/HTML
SHOTS_DIR     := snapshots

TARGETS       := $(foreach TYPE,$(ALL_TYPES), $(foreach LANG1,$(LANGS),$(HTML_DIR)/$(TYPE)/$(LANG1)/$(TYPE).html))

SCREENSHOTS   := $(addprefix $(HTML_DIR)/,$(shell ls */*/$(SHOTS_DIR)/*png))

#
#  Java and DocBook setup:
#
include $(ROOT_DIR)/setup.mk
#include $(ROOT_DIR)/setup.mk.fc

#
#  XSLT stylesheets:
#
CHUNKS_STYLESHEET := $(ROOT_DIR)/tools/user_guide_chunks.xsl
SINGLE_STYLESHEET := $(ROOT_DIR)/tools/user_guide.xsl
FO_PDF_STYLESHEET := $(ROOT_DIR)/tools/user_guide_fo.xsl
FAQ_CHUNKS_STYLESHEET := $(ROOT_DIR)/tools/faq_chunks.xsl
HTML_STYLESHEET   := sylpheeddoc.css

#
#  Top level targets: then propagate the make for each
#  document type (manual, faq,...), then for each language.
#
.PHONY: $(ALL_TYPES) $(foreach LANG1,$(LANGS), $(foreach TYPE,$(ALL_TYPES),$(TYPE)/$(LANG1)))

all: $(ALL_TYPES)

# Foreach document type: manual, faq:
$(ALL_TYPES):
	@ echo " *** Document: $@"
	@ $(MAKE) $(foreach LANG,$(LANGS),$@/$(LANG))

# Foreach type/language pair:
$(foreach TYPE,$(ALL_TYPES),$(foreach LANG1,$(LANGS),$(TYPE)/$(LANG1))):
	@ echo " ****** Doc/lang: "$@
	@ $(MAKE) $(HTML_DIR)/$@/$(subst /,.html,$(dir $@))

# Foreach HTML output file:
$(TARGETS): $(HTML_DIR)/%.html : %.xml
	@ echo " ********* Creating dir: "$(dir $@)
	@ $(MAKEDIR) $(dir $@)
ifeq ($(TARGET_TYPE), WEB)
	@ echo " ********* Creating dir: "$(dir $@)$(SHOTS_DIR)
	@ $(MAKEDIR) $(dir $@)$(SHOTS_DIR)
	@ $(MAKE) $(addprefix $(HTML_DIR)/,$(shell ls $(dir $<)$(SHOTS_DIR)/*png))
endif
	@ echo " ********* Creating HTML doc."
	@ $(HTML_CMD)

# Foreach PNG screenshot:
$(SCREENSHOTS): $(HTML_DIR)/%.png : %.png
	@ echo " ********* Importing: $<"
	@ $(COPY) $< $@

# ####################################################
#
#  Usual clean target:
#
clean:
	- $(REMOVE) $(HTML_DIR)
	- $(REMOVE) $(PACKAGE_DIR)/*
