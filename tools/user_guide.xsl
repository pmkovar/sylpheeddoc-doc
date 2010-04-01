<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY css SYSTEM "user_guide.css">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- Import original style sheet: chunk.xsl (multi-page) or docbook.xsl (one page) -->

  <xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets/html/docbook.xsl"/>

<!-- ******************************************************************
   -
   -  Load the common customization for HTML:
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
   -  Customization starts here:
   -
   - ******************************************************************
   -->

<!--
   -  Do not use the chunker in this version:
   -->

<xsl:param name="using.chunker" select="0"/>

<!-- Add CSS stylesheet content to the HTML header -->

<xsl:template name="user.head.content">
<style type="text/css">
&css;
</style>
</xsl:template>

<!-- Nice HTML output -->

<xsl:param name="chunker.output.indent">yes</xsl:param>

</xsl:stylesheet>
