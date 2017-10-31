<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:i="http://categories.data"
	exclude-result-prefixes="xs xd" version="2.0">
	<xsl:output method="html" omit-xml-declaration="no" encoding="UTF-8"
		indent="yes" exclude-result-prefixes="#all" />
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Oct 25, 2017</xd:p>
			<xd:p><xd:b>Author:</xd:b> adombros</xd:p>
			<xd:p />
		</xd:desc>
	</xd:doc>
	
	
	
	<!--TRANSFORM BEGINS-->
	<!--<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>-->
	
	
	
	
	<xsl:template match="/">
		<html>
			<head>

<style type="text/css">
	

body
{
margin:10px;
font-family:verdana,helvetica,sans-serif;
font-size:14px;
}
li
{
style-type=none;
}
h1
{font-size:18px;
font-weight:bold;
font-color: orange;
}
h2
{
font-size:18px;
font-weight:bold;
}

h3
{
font-size:18px;
font-weight:bold;
color: green;
}
</style>
</head>
			<body>
				<h1><xsl:call-template name="year"/> Annual Index (Obituaries)</h1>
				<h3>
					Obituaries
				</h3>
				<p><xsl:value-of select="/authority/categories/category[child::title = 'Obituaries']/see_also" /></p>
				<xsl:call-template name="obits"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="obits">
		<xsl:for-each-group
			select="/authority/item[child::index-cat = 'obit']" group-by="title">
			<xsl:sort select="current-grouping-key"/>
			<xsl:sort select="index-lastname"/>
		
			<li>
				<xsl:value-of select="title" />
				<xsl:choose>
					<xsl:when test="@dept = 'From the Editor'">
						<xsl:text>(ED)</xsl:text>
					</xsl:when>
					<xsl:when test="contains(@dept, 'Readers')">
						<xsl:text>(FOR)</xsl:text>
					</xsl:when>
					<xsl:when
						test="@dept = 'Search and Discovery' and @subdept = 'Physics Update'">
						<xsl:text>(UP)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'Search and Discovery'">
						<xsl:text>(SD)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'Issues and Events'">
						<xsl:text>(IE)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'Articles'">
						<xsl:text>(ART)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'Books'">
						<xsl:text>(BR)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'New Products'">
						<xsl:text>(NP)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'Obituaries'">
						<xsl:text>(OB)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'Quick Study'">
						<xsl:text>(QS)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'Back Scatter'">
						<xsl:text>(BS)</xsl:text>
					</xsl:when>
					<xsl:when test="@dept = 'Annual Index'">
						<xsl:text>(AI)</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text> </xsl:text>
				<xsl:choose>
					<xsl:when test="iss = '1'">
						<xsl:text>JAN</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '2'">
						<xsl:text>FEB</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '3'">
						<xsl:text>MAR</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '4'">
						<xsl:text>APR</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '5'">
						<xsl:text>MAY</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '6'">
						<xsl:text>JUN</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '7'">
						<xsl:text>JUL</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '8'">
						<xsl:text>AUG</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '9'">
						<xsl:text>SEP</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '10'">
						<xsl:text>OCT</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '11'">
						<xsl:text>NOV</xsl:text>
					</xsl:when>
					<xsl:when test="iss = '12'">
						<xsl:text>DEC</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text> </xsl:text>
				<xsl:value-of select="fpage" />
			</li>
		</xsl:for-each-group>
		
		

	</xsl:template>
	
	
	
	<xsl:template name="year">
		<xsl:value-of select="item[1]/volume + 1947" />
	</xsl:template>
	
	
	
</xsl:stylesheet>
