######################################################################
#
#  Just a wrapper to launch the 'big' Makefile from above...
#  For details read ../Makefile.
#
######################################################################
# $Log: Makefile,v $
# Revision 1.4  2002/03/30 21:27:27  fbarriere
# Modified to build the HTML directory locally.
#
# Revision 1.3  2002/03/20 21:20:08  fbarriere
# Now just a wrapper around the unique Makefile you should find
# in the parent directory.
#
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
HERE := $(shell pwd)

.DEFAULT:
	$(MAKE) -C .. ALL_TYPES=faq HTML_DIR=$(HERE)/HTML $@
