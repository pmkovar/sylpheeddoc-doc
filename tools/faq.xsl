<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY css SYSTEM "faq.css">
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
	<!-- xsl:include href="faq_common.xsl"/ -->

	<xsl:param name="page.margin.top">10in</xsl:param>
	<xsl:param name="page.margin.bottom">10in</xsl:param>
	<xsl:param name="page.margin.inner">10in</xsl:param>
	<xsl:param name="page.margin.outer">10in</xsl:param>

	<xsl:param name="generate.legalnotice.link" select="0"/>

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

<!-- Auto label qandadiv -->

<xsl:param name="qandadiv.autolabel" select="1"></xsl:param>

<!-- Add CSS stylesheet content to the HTML header -->

<xsl:template name="user.head.content">
<style type="text/css">
&css;
</style>
</xsl:template>

<!-- Nice HTML output -->

<xsl:param name="chunker.output.indent">yes</xsl:param>

<!-- Just list the chapter titles in the book ToC -->

<xsl:template match="preface|chapter|appendix|article" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <xsl:choose>
    <xsl:when test="local-name($toc-context) = 'book'">
      <xsl:call-template name="subtoc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
        <xsl:with-param name="nodes" select="foo"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="subtoc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
        <xsl:with-param name="nodes"
              select="section|sect1|glossary|bibliography|index
                     |bridgehead[$bridgehead.in.toc != 0]"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
