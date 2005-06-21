######################################################################
#  XSLT processing setup:
#  =====================
#
#  As this setup may change based on your install and distro, I put
#  all this into a separate file. This one is an example (the one
#  I use) and must be modified to fit your config.
#  By keeping it separate, we can modify the main Makefile without
#  breaking the config and avoid the switches.
#
#  For now it only supports Saxon+Fop+Jai+Java. I would like to include
#  the support for xsltproc (sablotron and xalan) for HTML output only.
#  I someone has the time and wants to add this, go ahead!
#
######################################################################

#
#  JAVA: for Saxon (xslt processor) and FOP (PDF generator)
#
JAVA_HOME     ?= $(shell  java-config --jdk-home)
JAVACMD       ?= $(JAVA_HOME)/bin/java

#
#  XSLT processors: Saxon.
#
SAXON_HOME    ?= /usr/share/saxon-bin/lib
SAXON_JAR     ?= $(SAXON_HOME)/saxon.jar:$(SAXON_HOME)/saxon-jdom.jar

#
#  XML catalog resolver and setting: for Saxon only
#
RES_CLASSPATH ?= /opt/xxe/resolver.jar

#
#  DOCBOOK XSL extension for Saxon:
#
EXT_CLASSPATH ?= $(DOCBOOK_XSL)/extensions/saxon65.jar

#
#  Formatting object processor: PDF generation only
#
FOP_HOME 	  ?= /usr/share/fop
FOP_CLASSPATH ?= $(FOP_HOME)/build/fop.jar
FOP_CLASSPATH ?= $(FOP_CLASSPATH):$(FOP_HOME)/lib/avalon-framework-cvs-20020806.jar
FOP_CLASSPATH ?= $(FOP_CLASSPATH):$(FOP_HOME)/lib/batik.jar

#
#  JAI: Java Advance Image lib: Saxon only
#
JAIHOME       ?= /usr/share/jai-bin
JAI_CLASSPATH ?= $(JAIHOME)/lib/jai_core.jar:$(JAIHOME)/lib/jai_codec.jar:$(JAIHOME)/lib/mlibwrapper_jai.jar

#
#  Final CLASSPATH for java:
#
CLASSPATH      := $(SAXON_JAR):$(RES_CLASSPATH):$(EXT_CLASSPATH):$(JAI_CLASSPATH):$(FOP_CLASSPATH)

#
# Bin libraries: for JAI
#
LD_LIBRARY_PATH += /opt/jai-bin/lib

#  Extra options for catalog handling:
#CATALOG_OPTS = "-x org.apache.xml.resolver.tools.ResolvingXMLReader -y org.apache.xml.resolver.tools.ResolvingXMLReader -r org.apache.xml.resolver.tools.CatalogResolver"
CATALOG_OPTS := 

#
#  DocBook stylesheets: common to all XSLT processors:
#
DOCBOOK_XSL   ?= /usr/share/sgml/docbook/xsl-stylesheets-1.66.1

# Make the HTML
HTML_CMD = $(JAVACMD) com.icl.saxon.StyleSheet \
	$(CATALOG_OPTS) \
	-o $@ \
	$< \
	$(SINGLE_STYLESHEET)
#	root.filename=all_in_one_page