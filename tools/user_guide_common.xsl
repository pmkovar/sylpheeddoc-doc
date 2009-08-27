<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- Allow extensions usage -->

<xsl:param name="tablecolumns.extension">1</xsl:param>
<xsl:param name="use.extensions"        >1</xsl:param>

<!-- Insert the abstract into the META header part -->

<xsl:param name="generate.meta.abstract">1</xsl:param>

<!-- =================================================================
   -  HTML: Navigation parts: Leave nav buttons on footer, keep rulers.
   - =================================================================
   -->

<xsl:param name="suppress.footer.navigation">0</xsl:param>
<xsl:param name="header.rule"               >1</xsl:param>
<xsl:param name="footer.rule"               >1</xsl:param>

<xsl:param name="admon.graphics"            >1</xsl:param>

<!-- URL rendering:                          -->

<xsl:param name="ulink.show">1</xsl:param>

<!-- Cross references: add page number in cross-refs -->

<xsl:param name="insert.xref.page.number">1</xsl:param>


<!-- =================================================================
   -  HTML: Use HTML stylesheet with the output:
   - =================================================================
   -->

<xsl:param name="html.stylesheet"     >user_guides.css</xsl:param>
<xsl:param name="html.stylesheet.type">text/css</xsl:param>
<xsl:param name="css.decoration"      >1</xsl:param>

<!-- Show revision flag as class attribute for CSS decoration -->

<xsl:param name="show.revisionflag">0</xsl:param>


<!-- =================================================================
   -  Automatically generated parts: ToC, numbering, index,....
   - =================================================================
   -->

<!-- Auto label chapters, appendix and sections -->

<xsl:param name="chapter.autolabel" >1</xsl:param>
<xsl:param name="section.autolabel" >1</xsl:param>
<xsl:param name="appendix.autolabel">1</xsl:param>

<xsl:param name="part.autolabel"    >1</xsl:param>
<xsl:param name="preface.autolabel" >0</xsl:param>

<!-- Section label includes parent hierarchy -->

<xsl:param name="section.label.includes.component.label">1</xsl:param>

<!-- Do not restart numbering at each part -->

<xsl:param name="label.from.part">0</xsl:param>

<!-- Generate ToC for book, article, chapter, qandaset and appendix -->

<xsl:param name="generate.toc">
	appendix toc
	article toc
	book toc,figure
	chapter toc
	qandaset  toc
</xsl:param>

<!-- Indent between levels of the ToC..: 10       -->
<!-- ToC char between number and title.: '.<tab>' -->
<!-- Show bridgeheads in ToC...........: false    -->
<!-- HTML type for ToC entries.........: 'dl'     -->
<!-- Recursive depth of ToC ...........: 5        -->
<!-- Depth of sections in ToC..........: not used -->
<!-- Generate the index................: true     -->


<xsl:param name="toc.indent.width"          >10</xsl:param>
<xsl:param name="autotoc.label.separator"   >.  </xsl:param>
<xsl:param name="bridgehead.in.toc"         >0</xsl:param>
<xsl:param name="toc.list.type"             >dl</xsl:param>
<xsl:param name="toc.section.depth"         >5</xsl:param>
<xsl:param name="generate.section.toc.level">3</xsl:param>

<xsl:param name="generate.index"            >1</xsl:param>

<!-- ToC margin settings -->

<xsl:attribute-set name="toc.margin.properties">
	<xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
	<xsl:attribute name="space-before.optimum">1em</xsl:attribute>
	<xsl:attribute name="space-before.maximum">2em</xsl:attribute>
	<xsl:attribute name="space-after.minimum" >0.5em</xsl:attribute>
	<xsl:attribute name="space-after.optimum" >1em</xsl:attribute>
	<xsl:attribute name="space-after.maximum" >2em</xsl:attribute>
</xsl:attribute-set>


<!-- =================================================================
   -  Generic decoration and rendering:
   - =================================================================
   -->

<!-- Do not include dummy paras for spacing -->

<xsl:param name="spacing.paras">0</xsl:param>

<!-- Text justification: justified -->

<xsl:param name="alignment">justify</xsl:param>

<!-- Pass the role attribute of 'emphasis'/'phrase' as HTML class attribute -->

<xsl:param name="emphasis.propagates.style">1</xsl:param>
<xsl:param name="phrase.propagates.style"  >1</xsl:param>

<!-- Number of columns...................: 1 -->
<!-- Number of columns in back matter....: 1 -->
<!-- Number of columns in front matter...: 1 -->
<!-- Number of columns in body...........: 1 -->
<!-- Number of columns in index..........: 1 -->
<!-- Number of columns in list-of-titles.: 1 -->

<xsl:param name="column.count"          >1</xsl:param>
<xsl:param name="column.count.back"     >1</xsl:param>
<xsl:param name="column.count.front"    >1</xsl:param>
<xsl:param name="column.count.body"     >1</xsl:param>
<xsl:param name="column.count.index"    >1</xsl:param>
<xsl:param name="column.count.lot"      >1</xsl:param>
<xsl:param name="column.count.titlepage">1</xsl:param>

<!-- Formal element title placement: any element with title -->

<xsl:param name="formal.title.placement">
	figure    after
	example   after
	equation  after
	table     after
	procedure after
</xsl:param>

<!-- Fonts: *********************************** -->

<xsl:param name="body.font.family"     >Times</xsl:param>
<xsl:param name="title.font.family"    >Helvetica</xsl:param>
<xsl:param name="monospace.font.family">Courier</xsl:param>
<xsl:param name="sans.font.family"     >Helvetica</xsl:param>
<xsl:param name="dingbat.font.family"  >Times Roman</xsl:param>

<xsl:param name="body.font.master"     >12</xsl:param>
<xsl:param name="body.font.size">
  <xsl:value-of select="$body.font.master"/><xsl:text>pt</xsl:text>
</xsl:param>

<xsl:param name="monospace.verbatim.font.master" select="$body.font.master * 0.8"/>
<xsl:attribute-set name="monospace.verbatim.properties">
	<xsl:attribute name="font-size">
		<xsl:value-of select="$monospace.verbatim.font.master"/><xsl:text>pt</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>

<!-- =================================================================
   -  Specific parts layout:
   - =================================================================
   -->

<!-- Paragraph: -->

<xsl:attribute-set name="normal.para.spacing">
	<xsl:attribute name="space-before.optimum">1em</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
	<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
</xsl:attribute-set>

<!-- Lists: -->

<xsl:attribute-set name="list.block.spacing">
	<xsl:attribute name="space-before.optimum">0.2cm</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.1cm</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.5cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="list.item.spacing">
	<xsl:attribute name="start-indent"        >0.3cm</xsl:attribute>
	<xsl:attribute name="space-before.optimum">0.1cm</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.0cm</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.2cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="compact.list.item.spacing">
	<xsl:attribute name="space-before.optimum">0cm</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0cm</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.1cm</xsl:attribute>
</xsl:attribute-set>

<!-- Verbatim sections: -->

<xsl:attribute-set name="verbatim.properties">
	<xsl:attribute name="space-before.minimum">0.1cm</xsl:attribute>
	<xsl:attribute name="space-before.optimum">0.2cm</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.3cm</xsl:attribute>
	<xsl:attribute name="text-align">left</xsl:attribute>
</xsl:attribute-set>

<xsl:param name="shade.verbatim">1</xsl:param>
<xsl:attribute-set name="shade.verbatim.style">
	<xsl:attribute name="background-color">#E0E0E0</xsl:attribute>
</xsl:attribute-set>


<!-- blockquote rendering: -->

<xsl:attribute-set name="blockquote.properties">
	<xsl:attribute name="start-indent"        >0.2cm</xsl:attribute>
	<xsl:attribute name="end-indent"          >0.1cm</xsl:attribute>
	<xsl:attribute name="space-after.minimum" >0.1cm</xsl:attribute>
	<xsl:attribute name="space-after.optimum" >0.2cm</xsl:attribute>
	<xsl:attribute name="space-after.maximum" >0.3cm</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.1cm</xsl:attribute>
	<xsl:attribute name="space-before.optimum">0.2cm</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.3cm</xsl:attribute>
</xsl:attribute-set>

<!-- Sections and chapters titles: -->

<xsl:attribute-set name="section.title.properties">
	<xsl:attribute name="font-family">
		<xsl:value-of select="$title.font.family"></xsl:value-of>
	</xsl:attribute>
	<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.5cm</xsl:attribute>
	<xsl:attribute name="space-before.optimum">1cm</xsl:attribute>
	<xsl:attribute name="space-before.maximum">1.5cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="section.title.level1.properties">
	<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	<xsl:attribute name="font-size">16pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="section.title.level2.properties">
	<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	<xsl:attribute name="font-size">14pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="section.title.level3.properties">
	<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	<xsl:attribute name="font-size">12pt</xsl:attribute>
</xsl:attribute-set>

<!-- Do not use table to create images viewports: breaks the alignement -->

<xsl:param name="make.graphic.viewport">0</xsl:param>

<!-- Functions synopsys style: -->

<xsl:param name="funcsynopsis.style">ansi</xsl:param>


<!-- =================================================================
   -  Tables layout and properties:
   - =================================================================
   -->

<xsl:param name="table.frame.border.thickness">1pt</xsl:param>
<xsl:param name="table.frame.border.style"    >solid</xsl:param>
<xsl:param name="table.cell.border.thickness" >1pt</xsl:param>
<xsl:param name="table.cell.border.style"     >solid</xsl:param>

<xsl:attribute-set name="table.cell.padding">
	<xsl:attribute name="padding-left"  >2pt</xsl:attribute>
	<xsl:attribute name="padding-right" >2pt</xsl:attribute>
	<xsl:attribute name="padding-top"   >2pt</xsl:attribute>
	<xsl:attribute name="padding-bottom">2pt</xsl:attribute>
</xsl:attribute-set>

<xsl:param name="table.entry.padding">2pt</xsl:param>

<xsl:param name="default.table.width">18cm</xsl:param>
<xsl:param name="nominal.table.width">18cm</xsl:param>


</xsl:stylesheet>
