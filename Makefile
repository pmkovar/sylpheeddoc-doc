######################################################################
#  Generate HTML pages from SGML docs.
#  ==================================
#
#  You may need to define (if the default location does not
#  correspond to your installation) the SGML_TOOL variable
#  (using SGML_TOOL=<path-to-sgml2html> on the make command
#  line).
#  FILTER_IMAGES must be set to something (anything you want)
#  to generate HTML pages without images. This works only if
#  the images SGML start and end tags are on separate lines
#  and alone on their lines (the filter is a quick and dirty sed).
#  The other vars can be left to their default values.
#
######################################################################
#
#  To only build one type of doc (manual, faq,...) define the
#  ALL_TYPES list. For example: 
#  make ALL_TYPES=manual
#  should only build the HTML pages for the manual.
#  To only build for one language, define the LANGS variable:
#  make LANGS="fr de"
#  should build the french and german docs.
#  Combine the two variables to build one type of doc for
#  selected languages:
#  make ALL_TYPES=faq LANGS=es
#  should only build the spanish faq.
#
######################################################################
# $Log: Makefile,v $
# Revision 1.2  2002/03/30 21:24:00  fbarriere
# Modified to build the HTML directory locally (when launched from
# a sub-directory), corrected the image filter (this one should
# work in all cases).
#
# Revision 1.1  2002/03/20 21:17:00  fbarriere
# New and unique Makefile for all the docs.
#
#
######################################################################

SGML_TOOL     := /usr/bin/sgml2html
SGML_TOOL_OPT := --language=$(LANG1)
#SGML_TOOL_OPT := --imagebuttons

#
#  Remove the images while generating the HTML output.
#
FILTER_IMAGES :=

#
#  Some usual shell commands with some arguments...
#
REMOVE        := /bin/rm -rf 
COPY          := /bin/cp -r 
MAKEDIR       := /bin/mkdir -p 
CAT           := /bin/cat 

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
HTML_DIR      := $(ROOT_DIR)/HTML/$(DOC_TYPE)
SHOTS_DIR     := snapshots

#
#  Sed command file used to filter the images:
#
SED_CMD_FILE  := $(ROOT_DIR)/tools/filter_images.sed

#
#  Defines the list of languages to process.
#
LANG_tmp      := $(shell ls)
FILTER_OUT    := CVS Makefile HTML tools

ALL_TYPES     := $(filter-out $(FILTER_OUT), $(LANG_tmp))
LANGS         := $(filter-out $(FILTER_OUT), $(LANG_tmp))

#
#  List the source files, count the number of sections
#  and generate the sections number sequence. A complicated
#  GNU make + shell part just to count from 1 to the
#  number of sections of the SGML source. Looks like there
#  should be a better solution...
#
ifneq ($(LANG1), )
   SOURCE_FILES  := $(shell ls $(LANG1)/*.sgml)
   ifneq ($(FILTER_IMAGES), )
      SHOTS_tmp     :=
      SCREENSHOTS   :=
   else
      SHOTS_tmp     := $(shell ls $(LANG1)/$(SHOTS_DIR))
      SCREENSHOTS   := $(shell ls $(LANG1)/$(SHOTS_DIR)/*.png)
   endif
endif

ifneq ($(SOURCE_FILES), )
   SECTION_NUM   := $(shell /bin/cat $(SOURCE_FILES) | /bin/grep -c -i "<sect>")
   FILE_PREFIX   := $(basename $(notdir $(SOURCE_FILES)))
   NUM_SEQUENCE  := $(shell \
      index=1;\
      while [ $$index -le $(SECTION_NUM) ];\
      do\
         printf "%3d" $$index | /bin/sed 's/ /0/g' | /bin/sed 's/^/ /';\
         index=$$[$$index + 1];\
      done;\
   )
   html_doc_TARGETS := $(HTML_DIR)/$(LANG1)/$(DOC_TYPE).sgml $(addprefix $(HTML_DIR)/, $(SCREENSHOTS))
endif

#
#  Defines the SGML filter: when filtering images, remove them
#  while generating the complete SGML file.
#
ifneq ($(FILTER_IMAGES), )
   FILTER := /bin/sed -f $(SED_CMD_FILE) | /bin/sed -e '/<REMOVE_ME>/,/<\/REMOVE_ME>/d'
else
   FILTER := /usr/bin/tee 
endif


#
#  Top level targets: then propagate the make for each
#  document type (manual, faq,...), then for each language.
#

all:
	@ for ONE_TYPE in $(ALL_TYPES);\
	do \
		echo "### Making all_langs in $$ONE_TYPE...";\
		$(MAKE) \
			-C $$ONE_TYPE \
			-f $(ROOT_DIR)/Makefile \
			DOC_TYPE=$$ONE_TYPE \
			ROOT_DIR=$(ROOT_DIR) \
			all_langs;\
	done;

all_langs:
	@ for ONE_LANG in $(LANGS);\
	do \
		echo "###### Making html_doc in $$ONE_LANG...";\
		$(MAKE) \
			-f $(ROOT_DIR)/Makefile \
			LANG1=$$ONE_LANG \
			DOC_TYPE=$(DOC_TYPE) \
			ROOT_DIR=$(ROOT_DIR) \
			html_doc;\
	done;

html_doc: $(html_doc_TARGETS)

$(HTML_DIR)/$(LANG1)/$(DOC_TYPE).sgml: $(SOURCE_FILES)
	@ echo "######### Building $(HTML_DIR)$(LANG1)/$(DOC_TYPE).sgml"
	@ $(MAKEDIR) $(HTML_DIR)/$(LANG1)
	@ $(CAT) $(SOURCE_FILES) | $(FILTER) > $(HTML_DIR)/$(LANG1)/$(DOC_TYPE).sgml
	@ echo "######### Building html file..."
	@ cd $(HTML_DIR)/$(LANG1); $(SGML_TOOL) $(SGML_TOOL_OPT) $@; cd $(HERE)

$(addprefix $(HTML_DIR)/, $(SCREENSHOTS)): $(HTML_DIR)/$(LANG1)/$(SHOTS_DIR)/%.png: $(LANG1)/$(SHOTS_DIR)/%.png
	@ if [ ! -d $(HTML_DIR)/$(LANG1)/$(SHOTS_DIR) ];\
	then\
		echo "######### Building $(HTML_DIR)/$(LANG1)/$(SHOTS_DIR)";\
		$(MAKEDIR) $(HTML_DIR)/$(LANG1)/$(SHOTS_DIR);\
	fi;
	@ echo "######### Importing: $<"
	@ $(COPY) $< $@
	
#
#  Usual clean target:
#
clean:
	@ for ONE_TYPE in $(ALL_TYPES);\
	do \
		echo "### Making html_clean in $$ONE_TYPE...";\
		$(MAKE) \
			-C $$ONE_TYPE \
			-f $(ROOT_DIR)/Makefile \
			DOC_TYPE=$$ONE_TYPE \
			ROOT_DIR=$(ROOT_DIR) \
			html_clean;\
	done;
	- $(REMOVE) $(PACKAGE_DIR)/*

html_clean:
	- $(REMOVE) $(HTML_DIR)
