<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mml="http://www.w3.org/1998/Math/MathML"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
	<xsl:output method="xml" omit-xml-declaration="no" encoding="UTF-8"
		indent="yes" exclude-result-prefixes="#all" />
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Sep 7, 2017</xd:p>
			<xd:p><xd:b>Author:</xd:b> adombros</xd:p>
			<xd:p />
		</xd:desc>
	</xd:doc>



	<!--TRANSFORM BEGINS-->
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>

	<!--1. Authority File Metadata-->
	<xsl:template match="article">
		<authority>
			<!--2. Collect all files in selected directory for input-->
			<xsl:for-each
				select="collection(iri-to-uri(resolve-uri('?select=*.xml', document-uri(/))))">
				<item>
					<xsl:attribute name="dept">
						<xsl:value-of
							select="/article/front/article-meta/article-categories/subj-group/subject"
						 />
					</xsl:attribute>
					<xsl:attribute name="subdept">
						<xsl:value-of
							select="/article/front/article-meta/article-categories/subj-group/subj-group/subject"/>
					</xsl:attribute>


					<xsl:attribute name="access">
						<xsl:value-of
							select="/article/front/article-meta/permissions/license/@license-type"
						 />
					</xsl:attribute>
					<xsl:call-template name="title" />
					<xsl:call-template name="description" />
					<xsl:call-template name="author" />
					<xsl:call-template name="doi" />
					<xsl:copy-of select="/article/front/article-meta/volume" />
					<iss>
						<xsl:value-of select="/article/front/article-meta/issue"
						 />
					</iss>
					<fpage>
						<xsl:value-of select="/article/front/article-meta/fpage"
						 />
					</fpage>
					<lpage>
						<xsl:value-of select="/article/front/article-meta/lpage"
						 />
					</lpage>
					<page-seq>
						<xsl:value-of
							select="/article/front/article-meta/fpage/@seq" />
					</page-seq>
					<page><xsl:value-of
							select="/article/front/article-meta/fpage"
							 />_<xsl:value-of
							select="/article/front/article-meta/fpage/@seq"
						 /></page>
					<xsl:call-template name="pubDate" />
				</item>
			</xsl:for-each>
		</authority>
	</xsl:template>


	<!--3. Title Template-->
	<xsl:template name="title">
		<title><xsl:value-of select="/article/front/article-meta/title-group/article-title" /></title>
	</xsl:template>


	<!--4. Description Template-->
	<xsl:template name="description">
		<description>
			<xsl:value-of
				select="/article/front/article-meta/abstract[@abstract-type = 'teaser']/p"
			 />
		</description>
	</xsl:template>


	<!--5. Author Template-->

	<xsl:template name="author" xml:space="preserve"><xsl:choose><xsl:when test="/article/front/article-meta/contrib-group/contrib[@contrib-type='reviewer']"><contrib contrib-type="reviewer"><xsl:copy-of select="/article/front/article-meta/contrib-group/contrib/name"/></contrib><xsl:call-template name="bookauthors"></xsl:call-template></xsl:when><xsl:otherwise><xsl:for-each select="//article/front/article-meta/contrib-group/contrib"><contrib><xsl:attribute name="contrib-type"><xsl:value-of select="@contrib-type" /></xsl:attribute><string-name><xsl:attribute name="name-style"><xsl:value-of select="name/@name-style" /></xsl:attribute><xsl:copy-of select="name/*"/></string-name></contrib></xsl:for-each></xsl:otherwise></xsl:choose></xsl:template>









	<!--6. DOI & GUID Template-->
	<xsl:template name="doi">
		<xsl:copy-of
			select="/article/front/article-meta/article-id[@pub-id-type = 'doi']" />
		<link>http://physicstoday.scitation.org/doi/full/<xsl:value-of
				select="/article/front/article-meta/article-id[@pub-id-type = 'doi']"
			 /></link>
		<guid isPermaLink="true">https://doi.org/<xsl:value-of
				select="/article/front/article-meta/article-id[@pub-id-type = 'doi']"
			 /></guid>

	</xsl:template>

	<!--7. pubDate Template-->
	<xsl:template name="pubDate">
		<pubDate>
			<xsl:value-of
				select="format-dateTime(current-dateTime(), '[FNn,3-3], [D] [MNn,3-3] [Y0001] [h01]:[m01]:[s01] EST')"
			 />
		</pubDate>

	</xsl:template>


	<!--8. Department Template-->
	<xsl:template name="department">
		<department>
			<xsl:value-of
				select="/article/front/article-meta/article-categories/subj-group[@subj-group-type = 'toc-heading']/subject"
			 />
		</department>
	</xsl:template>

	<xsl:template name="subdept">
		<xsl:if
			test="/article/front/article-meta/article-categories/subj-group/subj-group/subject[contains('Physics Update', '')]"> </xsl:if>
		<xsl:value-of
			select="/article/front/article-meta/article-categories/subj-group/subj-group/subject"
		 />
	</xsl:template>


<xsl:template name="bookauthors" match="/article/front/article-meta/product"><xsl:for-each select="/article/front/article-meta/product/string-name"><contrib contrib-type="bookauthor"><xsl:copy-of select="."/></contrib></xsl:for-each></xsl:template>
	
	
	
	
	<xsl:template name="reviewer2">
		<dc:creator>Reviewed by <xsl:value-of
				select="(concat(/article/front/article-meta/contrib-group/contrib/name/given-names, ' ', /article/front/article-meta/contrib-group/contrib/name/surname))" />
			<xsl:value-of select="contrib/surname" /></dc:creator>
	</xsl:template>


	
</xsl:stylesheet>
