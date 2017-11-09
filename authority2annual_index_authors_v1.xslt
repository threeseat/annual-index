<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:i="http://categories.data"
	exclude-result-prefixes="xs xd i" version="2.0">
	<xsl:output method="html" omit-xml-declaration="no" encoding="UTF-8"
		indent="yes" exclude-result-prefixes="#all" />
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Oct 25, 2017</xd:p>
			<xd:p><xd:b>Author:</xd:b> adombros</xd:p>
			<xd:p />
		</xd:desc>
	</xd:doc>
	
	<xsl:key name="ptauthors" match="contrib[not(@contrib-type = 'bookauthor')][not(@ptstaff)]" use="string-name"/>
	<!--TRANSFORM BEGINS-->



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
color: orange;
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
				<h1><xsl:call-template name="year"/> Annual Index by Authors</h1>
				<h3>Author Index</h3>
				<ul>
					<!-- Insert Author Name Sorted Alphabetically by Surname then Given-names -->
					<xsl:for-each select="//authority/item/contrib[generate-id(.)=
							generate-id(key('ptauthors', string-name)[1])]">
						<xsl:sort select="string-name"/>
						<li>
							<xsl:for-each select="key('ptauthors', string-name)">
								<xsl:sort select="surname"/>
								<xsl:sort select="given-names"/>
								<xsl:if test="position() = 1">
									<xsl:value-of select="(key('ptauthors', string-name[child::given-name])[1])" />
									<b>
										<xsl:value-of select="string-name/given-names, string-name/surname, string-name/suffix" separator=" "/>
									</b>
								</xsl:if>
								<!-- Insert Department, Issue, and Page Info -->
								<xsl:if test="./parent::item[@dept = 'Articles']">
									<xsl:text> </xsl:text>
									<em><xsl:value-of select="..//title"/></em>
								</xsl:if>
								<xsl:text> </xsl:text>
								<xsl:choose>
									<xsl:when
											test="./parent::item[@dept = 'From the Editor']">
										<xsl:text>(ED)</xsl:text>
									</xsl:when>
									<xsl:when
											test="./parent::item[contains(@dept, 'Readers')]">
										<xsl:text>(FOR)</xsl:text>
									</xsl:when>
									<xsl:when
											test="./parent::item[@dept = 'Search and Discovery' and @subdept = 'Physics Update']">
										<xsl:text>(UP)</xsl:text>
									</xsl:when>
									<xsl:when
											test="./parent::item[@dept = 'Search and Discovery']">
										<xsl:text>(SD)</xsl:text>
									</xsl:when>
									<xsl:when
											test="./parent::item[@dept = 'Issues and Events']">
										<xsl:text>(IE)</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[@dept = 'Articles']">
										<xsl:text>(ART)</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[@dept = 'Books']">
										<xsl:text>(BR)</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[@dept = 'New Products']">
										<xsl:text>(NP)</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[@dept = 'Obituaries']">
										<xsl:text>(OB)</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[@dept = 'Quick Study']">
										<xsl:text>(QS)</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[@dept = 'Back Scatter']">
										<xsl:text>(BS)</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[@dept = 'Annual Index']">
										<xsl:text>(AI)</xsl:text>
									</xsl:when>
								</xsl:choose>
								<xsl:text> </xsl:text>
								<xsl:choose>
									<xsl:when test="./parent::item[child::iss = '1']">
										<xsl:text>JAN</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '2']">
										<xsl:text>FEB</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '3']">
										<xsl:text>MAR</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '4']">
										<xsl:text>APR</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '5']">
										<xsl:text>MAY</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '6']">
										<xsl:text>JUN</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '7']">
										<xsl:text>JUL</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '8']">
										<xsl:text>AUG</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '9']">
										<xsl:text>SEP</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '10']">
										<xsl:text>OCT</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '11']">
										<xsl:text>NOV</xsl:text>
									</xsl:when>
									<xsl:when test="./parent::item[child::iss = '12']">
										<xsl:text>DEC</xsl:text>
									</xsl:when>
								</xsl:choose>
								<xsl:text> </xsl:text>
								<xsl:for-each select="current()/..//fpage">
								<xsl:choose>
									<xsl:when test="position()!=1" xml:space="preserve">
										<xsl:text>; </xsl:text><xsl:value-of select="..//fpage"/></xsl:when>
									<xsl:when test="position()=1" xml:space="preserve"><xsl:value-of select="..//fpage"/>
									</xsl:when>
								</xsl:choose>
								</xsl:for-each>
							</xsl:for-each>
						</li>
					</xsl:for-each>
				</ul>
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template name="year">
		<xsl:value-of select="authority/item[1]/volume + 1947" />
	</xsl:template>
	

</xsl:stylesheet>
