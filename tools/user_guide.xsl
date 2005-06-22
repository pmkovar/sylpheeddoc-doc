<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- Import original style sheet: chunk.xsl (multi-page) or docbook.xsl (one page) -->

  <xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets-1.66.1/html/docbook.xsl"/>

<!-- ******************************************************************
   -
   -  Load the common custimzation for HTML:
   -
   - ******************************************************************
   -->

	<xsl:include href="user_guide_common.xsl"/>
	<!-- xsl:include href="html_titlepage.xsl"/ -->

	<xsl:param name="page.margin.top">10in</xsl:param>
	<xsl:param name="page.margin.bottom">10in</xsl:param>
	<xsl:param name="page.margin.inner">10in</xsl:param>
	<xsl:param name="page.margin.outer">10in</xsl:param>

<!-- ******************************************************************
   -
   -  Custimization starts here:
   -
   - ******************************************************************
   -->

<!--
   -  Do not use the chunker in this version:
   -->

<xsl:param name="using.chunker" select="0"/>

</xsl:stylesheet>
