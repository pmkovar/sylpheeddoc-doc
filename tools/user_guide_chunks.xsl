<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- Import original style sheet: chunk.xsl (multi-page) or docbook.xsl (one page) -->

	<xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets-1.66.1/html/chunk.xsl"/>

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

	<xsl:param name="generate.legalnotice.link" select="1"/>

<!-- ******************************************************************
   -
   -  Chunks specific customization:
   -
   - ******************************************************************
   -->

<!-- Generate a message for each chunked file -->

<xsl:param name="chunk.quietly" select="0"/>

<!-- New top-level file name: index.html is reserved for the index  -->

<xsl:param name="root.filename" select="'user_guide'"/>

<!-- Yes we use the chunker: splits the output into several files. -->

<xsl:param name="using.chunker" select="0"/>

<!-- Chunk only the first level of chapter/sections -->

<xsl:param name="chunk.section.depth" select="1"/>

<!-- Generate a separate chunk for the first element of each section -->

<xsl:param name="chunk.first.sections" select="1"/>

<!-- Do not use the ID as filename: they contain forbidden chars -->

<xsl:param name="use.id.as.filename" select="'0'"/>

<!-- Use the following extension for output files: .html -->

<xsl:param name="html.ext" select="'.html'"/>

<!-- Generate extra HEAD links for Mozilla -->

<xsl:param name="html.extra.head.links" select="1"/>

<!-- Use graphics in navigation headers/footers -->

<xsl:param name="navig.graphics" select="1"/>
<xsl:param name="navig.graphics.extension" select="'.png'"/>
<xsl:param name="navig.graphics.path">images/</xsl:param>

<!-- Show next and previous sections titles in nav bars -->

<xsl:param name="navig.showtitles">1</xsl:param>

</xsl:stylesheet>
