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

	<xsl:variable name="css">
		<xsl:text>&#x0A;</xsl:text>
		<style type="text/css">
			body {
				margin:10px;
				font-family:verdana,helvetica,sans-serif;
				font-size:14px;
			}
			ul {
				margin: 6px auto 2px;
				padding-left: 10px;
			}
			li {
				list-style: none;
				text-indent: -1.5em;
				padding-left: 1.5em;
				padding-bottom: 3px;
			}
			h1 {
				font-size:18px;
				font-weight:bold;
				color: orange;
			}
			h2 {
				font-size:18px;
				font-weight:bold;
			}
			h3 {
				font-size:18px;
				font-weight:bold;
				color: green;
				margin: 18px auto 2px; 
			}
			p {
				margin: 3px 0px 3px 20px;
				text-indent: -1.5em;
				padding-left: 1.5em;
				padding-bottom: 2px;
			}
		</style>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:variable>

	<!--TRANSFORM BEGINS-->
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>


	<xsl:template match="/authority">
		<html>
			<head>
				<xsl:copy-of select="$css"/>
			</head>
			<body>
				<h1><xsl:call-template name="year"/> Annual Index by Subject (Main)</h1>
				<!--<xsl:call-template name="subjects" />-->
				<xsl:call-template name="main"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="main">
		<xsl:for-each select="/authority/categories/category">
			<xsl:sort select="title" />
			<h3>
				<xsl:value-of select="title" />
			</h3>
			<xsl:apply-templates select="see_also"/>
			<xsl:if test="exists(/authority/item[index-cat = current()/code])">
				<ul>
					<!-- Use xsl:for-each-group to catch Readers' Forum packages, which share common title -->
					<xsl:for-each-group select="/authority/item[index-cat = current()/code]" group-by="title">
						<xsl:sort select="iss" data-type="number"/>
						<xsl:sort select="fpage" data-type="number"/>
						<xsl:sort select="page-seq" data-type="number"/>
						<!-- 
							Take advantage of the fact that within xsl:for-each-group, 
							the context item is the first item of the current group.
							So the common group elements can be pulled from the current item's components
						-->
						<li>
							<!-- title formatting is different for feature articles -->
							<a href="{guid}">
								<xsl:choose>
									<xsl:when test="@dept = 'Articles'">
										<xsl:apply-templates select="title" mode="article"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="title" mode="nonarticle"/>
									</xsl:otherwise>
								</xsl:choose>
							</a>
							<xsl:if test="current-group()//contrib[matches(@contrib-type, '^author|reviewer') and not(@ptstaff = 'yes')]">
								<!-- Avoid '?,' and '!' at end of titles -->
								<xsl:choose>
									<xsl:when test="ends-with(title, '?') or ends-with(title, '!')"/>
									<xsl:otherwise>
										<xsl:text>,</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text> </xsl:text>
								<!-- process the authors of each item in current group, with semicolons separating items  -->
								<xsl:for-each select="current-group()">
									<a href="{guid}">
										<xsl:apply-templates select="contrib[matches(@contrib-type, '^author|reviewer') and not(@ptstaff='yes')]"/>
									</a>
									<xsl:if test="position() lt last()">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="@dept"/>
							<xsl:text> </xsl:text>
							<a href="{guid}">
								<xsl:apply-templates select="iss"/>
								<xsl:text>&#x00A0;</xsl:text>
								<xsl:value-of select="fpage"/>
							</a>
						</li>
					</xsl:for-each-group>
				</ul>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="contrib">
		<xsl:value-of select="string-name/given-names/replace(.,'(\w)\w+','$1.'), string-name/surname, string-name/suffix" separator=" "/>
		<xsl:if test="position() lt last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="@dept">
		<xsl:choose>
			<xsl:when test=". = 'From the Editor'">
				<xsl:text>(ED)</xsl:text>
			</xsl:when>
			<xsl:when test="contains(., 'Readers')">
				<xsl:text>(FOR)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'Search and Discovery' and ../@subdept = 'Physics Update'">
				<xsl:text>(UP)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'Search and Discovery'">
				<xsl:text>(SD)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'Issues and Events'">
				<xsl:text>(IE)</xsl:text>
			</xsl:when>
			<xsl:when test=".='Articles'">
				<xsl:text>(ART)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'Books'">
				<xsl:text>(BR)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'New Products'">
				<xsl:text>(NP)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'Obituaries'">
				<xsl:text>(OB)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'Quick Study'">
				<xsl:text>(QS)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'Back Scatter'">
				<xsl:text>(BS)</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'Annual Index'">
				<xsl:text>(AI)</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>[¡UNKNOWN Department: </xsl:text>
				<xsl:value-of select="."/>
				<xsl:text>!]</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:variable name="months" select="'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'"/>
	<xsl:template match="iss">
		<xsl:value-of select="$months[position() = current()]"/>
	</xsl:template>

	<xsl:template name="year">
		<xsl:value-of select="authority/item[1]/volume + 1947" />
	</xsl:template>

	<xsl:template match="see_also">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="see_also/italic">
		<em>
			<xsl:apply-templates/>
		</em>
	</xsl:template>
	
	<xd:doc>
		<xd:desc>title/italic, article: toggle off html emphasis</xd:desc>
	</xd:doc>
	<xsl:template match="title/italic" mode="article">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xd:doc>
		<xd:desc>title/text, article: use html emphasis</xd:desc>
	</xd:doc>
	<xsl:template match="title/text()" mode="article">
		<em><xsl:value-of select="."/></em>
	</xsl:template>
	
	<xd:doc>
		<xd:desc>title/italic, nonarticle: use html emphasis</xd:desc>
	</xd:doc>
	<xsl:template match="title/italic" mode="nonarticle">
		<em><xsl:apply-templates/></em>
	</xsl:template>
	
	<xd:doc>
		<xd:desc>title/text, nonarticle: no emphasis</xd:desc>
	</xd:doc>
	<xsl:template match="title/text()" mode="nonarticle">
		<xsl:value-of select="."/>
	</xsl:template>
	
</xsl:stylesheet>
