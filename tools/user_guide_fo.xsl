<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- Import original style sheet: chunk.xsl (multi-page) or docbook.xsl (one page) -->

  <xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets-1.66.1/fo/docbook.xsl"/>

<!-- ******************************************************************
   -
   -  Load the common custimzation layer:
   -
   - ******************************************************************
   -->

	<xsl:include href="user_guide_common.xsl"/>

	<!-- xsl:include href="fo_titlepage.xsl"/ -->

<!-- ******************************************************************
   -
   -  Custimization starts here:
   -
   - ******************************************************************
   -->

<!--
   - Trial: use FOP extensions. Put here the stuf to generate PDF using FOP.
   -->
<xsl:param name="fop.extensions">1</xsl:param>
<xsl:param name="xep.extensions">1</xsl:param>

<!--
   - DO NOT HYPHENATE WORD IN PDF: as hyphenation is not intelligent, it
	- can produce strange output in some cases...
   -
   -->

<xsl:param name="hyphenate">false</xsl:param>

<!--
   - Page layout: page size, paper type, margins,...
	-
  -->

<!-- A4, portrait orientation/size, single sided -->

<xsl:param name="page.orientation">portrait</xsl:param>
<xsl:param name="paper.type"      >USletter</xsl:param>
<xsl:param name="double.sided"    >0</xsl:param>

<xsl:param name="draft.mode" select="'no'"></xsl:param>

<!-- Right margin -->

<xsl:param name="page.margin.inner"  >1.5cm</xsl:param>

<!-- Left margin -->

<xsl:param name="page.margin.outer"  >1.5cm</xsl:param>

<!-- Bottom margin, extend,... -->

<xsl:param name="page.margin.bottom" >0.5cm</xsl:param>
<xsl:param name="body.margin.bottom" >2.5cm</xsl:param>
<xsl:param name="region.after.extent">1.5cm</xsl:param>

<!-- Top margin, extend,... -->

<xsl:param name="page.margin.top"     >0.5cm</xsl:param>
<xsl:param name="body.margin.top"     >2.5cm</xsl:param>
<xsl:param name="region.before.extent">1.5cm</xsl:param>

<!-- Left margin for titles -->

<xsl:param name="title.margin.left"   >-0.5cm</xsl:param>

<!--
   - Headers and footers settings:
	-
	-->

<!-- Print headers and footers on blank pages -->

<xsl:param name="headers.on.blank.pages">1</xsl:param>
<xsl:param name="footers.on.blank.pages">1</xsl:param>

<xsl:param name="variablelist.as.blocks" select="1"></xsl:param>

<!-- monospace font size set to 0.8 of master font size -->
<!-- Affects programlisting, screen etc -->

<xsl:attribute-set name="monospace.properties">
  <xsl:attribute name="font-size">
    <xsl:value-of select="$body.font.master * 0.8"/>
    <xsl:text>pt</xsl:text>
  </xsl:attribute>
  <xsl:attribute name="font-family">
    <xsl:value-of select="$monospace.font.family"/>
  </xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="monospace.verbatim.properties" use-attribute-sets="verbatim.properties monospace.properties">
  <xsl:attribute name="font-size">
    <xsl:value-of select="$body.font.master * 0.8"/>
    <xsl:text>pt</xsl:text>
  </xsl:attribute>
  <xsl:attribute name="text-align">start</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="verbatim.properties">
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="font-size">
    <xsl:value-of select="$body.font.master * 0.8"/>
    <xsl:text>pt</xsl:text>
  </xsl:attribute>
</xsl:attribute-set>

</xsl:stylesheet>
