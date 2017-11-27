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
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>


	<xsl:template match="/authority">
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
				<h1><xsl:call-template name="year"/> Annual Index by Subject (Main)</h1>
				<!--<xsl:call-template name="subjects" />-->
				<xsl:call-template name="main"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="main">
		<xsl:for-each select="/authority/categories/category/title">
			<xsl:sort order="ascending" />
			<h3>
				<xsl:value-of select="." />
			</h3>
			<p>
				<em>
				<xsl:value-of select="../see_also/italic" />
			</em>
			<xsl:text> </xsl:text>
			<xsl:value-of select="../see_also/text()[1]" />
			</p>
			<!--<xsl:choose>
				<xsl:when test="../see_also/*">
					<p><xsl:value-of select="../see_also" /></p>
				</xsl:when>
			</xsl:choose>-->
			<xsl:for-each-group
				select="/authority/item[child::index-cat = current()/../code]"
				group-by="title">
				<xsl:sort select="title" />
				<li>
					<xsl:value-of select="title" />
					<xsl:text>, </xsl:text>
					<xsl:value-of select="contrib/string-name/given-names, contrib/string-name/surname, contrib/string-name/suffix" separator=" "/>
				</li>
			</xsl:for-each-group>
		</xsl:for-each>
	</xsl:template>
	
	
	

	<xsl:template name="year">
		<xsl:value-of select="authority/item[1]/volume + 1947" />
	</xsl:template>



<!--<i:categories>
		<category>
			<title>Acoustics</title>
			<code>acou</code>
		</category>
		<category>
			<title>Astrophysics and cosmology</title>
			<see_also><italic>See also</italic> Space and planetary science</see_also>
			<code>astro</code>
		</category>
		<category>
			<title>Atmospheric science</title>
			<see_also><italic>See also</italic> Earth science; Environment; Space and planetary science</see_also>
			<code>atmos</code>
		</category>
		<category>
			<title>Atomic physics</title>
			<see_also><italic>See also</italic> Chemical and molecular physics; Nuclear physics; Quantum physics</see_also>
			<code>atomic</code>
		</category>
		<category>
			<title>Biography and personalities</title>
			<see_also><italic>See also</italic> History and philosophy; Obituaries</see_also>
			<code>biog</code>
		</category>
		<category>
			<title>Biological physics</title>
			<see_also><italic>See also</italic> Crystallography; Medical physics</see_also>
			<code>biophys</code>
		</category>
		<category>
			<title>Chemical and molecular physics</title>
			<see_also><italic>See also</italic> Atomic physics; Materials science; Quantum physics</see_also>
			<code>chem</code>
		</category>
		<category>
			<title>Classical mechanics and electromagnetism</title>
			<see_also><italic>See also</italic> Statistical physics and thermodynamics</see_also>
			<code>class</code>
		</category>
		<category>
			<title>Computers and computational physics</title>
			<see_also><italic>See also</italic> Nonlinear science; Technology and engineering; Theory and mathematical physics</see_also>
			<code>comput</code>
		</category>
		<category>
			<title>Condensed-matter physics</title>
			<see_also><italic>See also</italic> Crystallography; Fluids; Materials science; Microstructures and nanostructures; Rheology </see_also>
			<code>cond</code>
		</category>
		<category>
			<title>Crystallography</title>
			<see_also><italic>See also</italic> Biological physics; Condensed-matter physics; Medical physics</see_also>
			<code>cryst</code>
		</category>
		<category>
			<title>Earth science</title>
			<see_also><italic>See also</italic> Atmospheric science; Environment; Ocean science; Space and planetary science</see_also>
			<code>earth</code>
		</category>
		<category>
			<title>Education</title>
			<see_also><italic>See also</italic> Employment and careers; Society and physics; Sociology of science</see_also>
			<code>edu</code>
		</category>
		<category>
			<title>Emergent phenomena</title>
			<see_also><italic>See also</italic> Nonlinear science; Theory and mathematical physics</see_also>
			<code>emerg</code>
		</category>
		<category>
			<title>Employment and careers</title>
			<see_also><italic>See also</italic> Education; Industry and physics; Society and physics; Sociology of science</see_also>
			<code>employ</code>
		</category>
		<category>
			<title>Energy</title>
			<see_also><italic>See also</italic> Environment; Nuclear physics; Plasmas and fusion; Politics and policy; Society and physics</see_also>
			<code>ener</code>
		</category>
		<category>
			<title>Environment</title>
			<see_also><italic>See also</italic> Atmospheric science; Earth science; Energy; Ocean science; Politics and policy; Society and physics</see_also>
			<code>envir</code>
		</category>
		<category>
			<title>Facilities and laboratories</title>
			<see_also><italic>See also</italic> International science</see_also>
			<code>facil</code>
		</category>
		<category>
			<title>Fluids</title>
			<see_also><italic>See also</italic> Condensed-matter physics; Nonlinear science; Rheology</see_also>
			<code>flu</code>
		</category>
		<category>
			<title>History and philosophy</title>
			<see_also><italic>See also</italic> Biography and personalities; Obituaries; Sociology of science</see_also>
			<code>hist</code>
		</category>
		<category>
			<title>Industry and physics</title>
			<see_also><italic>See also</italic> Employment and careers; Sociology of science; Technology and engineering</see_also>
			<code>ind </code>
		</category>
		<category>
			<title>Instrumentation and techniques</title>
			<see_also><italic>See also</italic> Metrology and fundamental constants; Microscopy; Technology and engineering</see_also>
			<code>inst</code>
		</category>
		<category>
			<title>International science</title>
			<see_also><italic>See also</italic> Facilities and laboratories; Politics and policy</see_also>
			<code>int</code>
		</category>
		<category>
			<title>Materials science</title>
			<see_also><italic>See</italic>
				<italic>also</italic> Chemical and molecular physics; Condensed-matter physics; Microstructures and nanostructures</see_also>
			<code>matsci</code>
		</category>
		<category>
			<title>Medical physics</title>
			<see_also><italic>See also</italic> Biological physics; Crystallography</see_also>
			<code>medic</code>
		</category>
		<category>
			<title>Metrology and fundamental constants</title>
			<see_also><italic>See also</italic> Instrumentation and techniques</see_also>
			<code>metr</code>
		</category>
		<category>
			<title>Microscopy</title>
			<see_also><italic>See also</italic> Instrumentation and techniques; Optics and photonics</see_also>
			<code>mic</code>
		</category>
		<category>
			<title>Microstructures and nanostructures</title>
			<see_also><italic>See also</italic> Condensed-matter physics; Materials science; Quantum physics</see_also>
			<code>micnan</code>
		</category>
		<category>
			<title>Military physics and arms control</title>
			<see_also><italic>See also</italic> Politics and policy; Society and physics</see_also>
			<code>mil</code>
		</category>
		<category>
			<title>Miscellaneous</title>
			<code>misc</code>
		</category>
		<category>
			<title>NASA</title>
			<see_also><italic>See also</italic> Politics and policy</see_also>
			<code>nasa</code>
		</category>
		<category>
			<title>Nonlinear science</title>
			<see_also><italic>See also</italic> Computers and computational physics; Emergent phenomena; Fluids; Rheology; Theory and mathematical physics</see_also>
			<code>nonlin</code>
		</category>
		<category>
			<title>Nuclear physics</title>
			<see_also><italic>See also</italic> Atomic physics; Energy; Particle physics</see_also>
			<code>nucphys</code>
		</category>
		<category>
			<title>Obituaries</title>
			<see_also><italic>See also</italic> Biography and personalities; History and philosophy</see_also>
			<code>obit</code>
		</category>
		<category>
			<title>Ocean science</title>
			<see_also><italic>See also</italic> Earth science; Environment</see_also>
			<code>ocean</code>
		</category>
		<category>
			<title>Optics and photonics</title>
			<see_also><italic>See also</italic> Instrumentation and techniques; Microscopy</see_also>
			<code>opt</code>
		</category>
		<category>
			<title>Particle physics</title>
			<see_also><italic>See also</italic> Nuclear physics; Theory and mathematical physics</see_also>
			<code>part</code>
		</category>
		<category>
			<title>Physics in 2116</title>
			<code>phys</code>
		</category>
		<category>
			<title>Plasmas and fusion</title>
			<see_also><italic>See also</italic> Astrophysics and cosmology; Energy; Space and planetary science</see_also>
			<code>plas</code>
		</category>
		<category>
			<title>Politics and policy </title>
			<see_also><italic>See also</italic> International science; Military physics and arms control; Society and physics; Sociology of science</see_also>
			<code>politic</code>
		</category>
		<category>
			<title>Publishing, media, and the press</title>
			<see_also><italic>See also</italic> Sociology of science</see_also>
			<code>publish</code>
		</category>
		<category>
			<title>Quantum physics</title>
			<see_also><italic>See also</italic> Atomic physics; Chemical and molecular physics; Microstructures and nanostructures; Optics and photonics; Theory and mathematical physics</see_also>
			<code>quant</code>
		</category>
		<category>
			<title>Rheology</title>
			<see_also><italic>See also</italic> Condensed-matter physics; Fluids; Nonlinear science</see_also>
			<code>rheo</code>
		</category>
		<category>
			<title>Scientific societies</title>
			<code>scisocs</code>
		</category>
		<category>
			<title>Society and physics</title>
			<see_also><italic>See also</italic> Education; Employment and careers; Energy; Environment; Military physics and arms control; Publishing, media, and the press; Politics and policy; Sociology of science</see_also>
			<code>soc-phys</code>
		</category>
		<category>
			<title>Sociology of science</title>
			<see_also><italic>See also</italic> Education; Employment and careers; History and philosophy; Publishing, media, and the press; Politics and policy; Society and physics</see_also>
			<code>sociol</code>
		</category>
		<category>
			<title>Space and planetary science</title>
			<see_also><italic>See also</italic> Astrophysics and cosmology; Atmospheric science; Earth science; Plasmas and fusion</see_also>
			<code>space</code>
		</category>
		<category>
			<title>Statistical physics and thermodynamics</title>
			<see_also><italic>See also</italic> Classical mechanics and electromagnetism; Theory and mathematical physics</see_also>
			<code>statphys</code>
		</category>
		<category>
			<title>Technology and engineering</title>
			<see_also><italic>See also</italic> Computers and computational physics; Industry and physics; Instrumentation and techniques</see_also>
			<code>tech-eng</code>
		</category>
		<category>
			<title>Theory and mathematical physics</title>
			<see_also><italic>See also</italic> Computers and computational physics</see_also>
			<code>theo</code>
		</category>
		<category>
			<title>Accelerators</title>
			<see_also><italic>See</italic> Facilities and laboratories; Nuclear physics; Particle physics</see_also>
			<code>acc</code>
		</category>
		<category>
			<title>Arms control</title>
			<see_also><italic>See</italic> Military physics and arms control</see_also>
			<code>arms</code>
		</category>
		<category>
			<title>Asia</title>
			<see_also><italic>See</italic> International science</see_also>
			<code>asia</code>
		</category>
		<category>
			<title>Books</title>
			<see_also><italic>See</italic> separate BOOKS REVIEWED index (page #); Publishing, media, and the press</see_also>
			<code>bks</code>
		</category>
		<category>
			<title>Bose–Einstein condensation</title>
			<see_also><italic>See</italic> Atomic physics; Condensed-matter physics; Quantum physics</see_also>
			<code>bose</code>
		</category>
		<category>
			<title>Budgets</title>
			<see_also><italic>See</italic> Politics and policy</see_also>
			<code>budgets</code>
		</category>
		<category>
			<title>Careers</title>
			<see_also><italic>See</italic> Employment and careers</see_also>
			<code>careers</code>
		</category>
		<category>
			<title>Chaos</title>
			<see_also><italic>See</italic> Classical mechanics and electromagnetism; Nonlinear science; Theory and mathematical physics</see_also>
			<code>chaos</code>
		</category>
		<category>
			<title>China</title>
			<see_also><italic>See</italic> International science</see_also>
			<code>china</code>
		</category>
		<category>
			<title>Climate change</title>
			<see_also><italic>See</italic> Atmospheric science; Earth science; Environment; Ocean science</see_also>
			<code>climate</code>
		</category>
		<category>
			<title>Collective effects</title>
			<see_also><italic>See</italic> Emergent phenomena</see_also>
			<code>collective</code>
		</category>
		<category>
			<title>Complexity</title>
			<see_also><italic>See</italic> Emergent phenomena; Nonlinear science; Theory and mathematical physics</see_also>
			<code>complexity</code>
		</category>
		<category>
			<title>Cosmology</title>
			<see_also><italic>See</italic> Astrophysics and cosmology; Particle physics; Theory and mathematical physics</see_also>
			<code>cosmo</code>
		</category>
		<category>
			<title>Department of Defense</title>
			<see_also><italic>See</italic> Military physics and arms control; Politics and policy</see_also>
			<code>departmentdod</code>
		</category>
		<category>
			<title>Department of Energy</title>
			<see_also><italic>See</italic> Energy; Facilities and laboratories; Politics and policy</see_also>
			<code>departmentdoe</code>
		</category>
		<category>
			<title>Department of Homeland Security</title>
			<see_also><italic>See</italic> Military physics and arms control; Politics and policy</see_also>
			<code>departmenthomeland</code>
		</category>
		<category>
			<title>Device physics</title>
			<see_also><italic>See</italic> Instrumentation and techniques</see_also>
			<code>device</code>
		</category>
		<category>
			<title>Electromagnetism</title>
			<see_also><italic>See</italic> Classical mechanics and electromagnetism</see_also>
			<code>electromag</code>
		</category>
		<category>
			<title>Europe</title>
			<see_also><italic>See</italic> International science</see_also>
			<code>euro</code>
		</category>
		<category>
			<title>Funding and budgets</title>
			<see_also><italic>See</italic> Politics and policy</see_also>
			<code>funding</code>
		</category>
		<category>
			<title>Geophysics</title>
			<see_also><italic>See</italic> Atmospheric science; Earth science; Energy; Environment; Ocean science; Space and planetary science</see_also>
			<code>geophysics</code>
		</category>
		<category>
			<title>High-pressure physics</title>
			<see_also><italic>See</italic> Condensed-matter physics; Earth science; Space and planetary science</see_also>
			<code>high</code>
		</category>
		<category>
			<title>Japan</title>
			<see_also><italic>See</italic> International science</see_also>
			<code>japan</code>
		</category>
		<category>
			<title>Lasers</title>
			<see_also><italic>See</italic> Instrumentation and techniques; Optics and photonics; Quantum physics</see_also>
			<code>laser</code>
		</category>
		<category>
			<title>Latin America</title>
			<see_also><italic>See</italic> International science</see_also>
			<code>latin</code>
		</category>
		<category>
			<title>Low-temperature physics</title>
			<see_also><italic>See</italic> Instrumentation and techniques<italic>;</italic> Quantum physics</see_also>
			<code>low</code>
		</category>
		<category>
			<title>Magnetism</title>
			<see_also><italic>See</italic> Classical mechanics and electromagnetism; Condensed-matter physics; Quantum physics; Space and planetary science</see_also>
			<code>mag</code>
		</category>
		<category>
			<title>Mathematical physics</title>
			<see_also><italic>See</italic> Theory and mathematical physics</see_also>
			<code>mathematical</code>
		</category>
		<category>
			<title>Media and the press</title>
			<see_also><italic>See</italic> Publishing, media, and the press; Society and physics</see_also>
			<code>media</code>
		</category>
		<category>
			<title>Meteorology</title>
			<see_also><italic>See</italic> Atmospheric science; Earth science; Environment</see_also>
			<code>meteo</code>
		</category>
		<category>
			<title>Minorities in physics</title>
			<see_also><italic>See</italic> Sociology of science</see_also>
			<code>minorities</code>
		</category>
		<category>
			<title>Molecular physics</title>
			<see_also><italic>See</italic> Chemical and molecular physics</see_also>
			<code>molecular</code>
		</category>
		<category>
			<title>Nanostructures</title>
			<see_also><italic>See</italic> Microstructures and nanostructures</see_also>
			<code>nanostructures</code>
		</category>
		<category>
			<title>National Institute of Standards and Technology</title>
			<see_also><italic>See</italic> Facilities and laboratories; Metrology and fundamental constants; Politics and policy</see_also>
			<code>natinst</code>
		</category>
		<category>
			<title>National laboratories</title>
			<see_also><italic>See</italic> Facilities and laboratories</see_also>
			<code>natlab</code>
		</category>
		<category>
			<title>National Science Foundation</title>
			<see_also><italic>See</italic> Politics and policy</see_also>
			<code>nsf</code>
		</category>
		<category>
			<title>Nuclear reactors and nuclear energy</title>
			<see_also><italic>See</italic> Energy; Nuclear physics</see_also>
			<code>nucreact</code>
		</category>
		<category>
			<title>Nuclear weapons</title>
			<see_also><italic>See</italic> Military physics and arms control</see_also>
			<code>nucweap</code>
		</category>
		<category>
			<title>Philosophy of science</title>
			<see_also><italic>See</italic> History and philosophy</see_also>
			<code>philosophy</code>
		</category>
		<category>
			<title>Planetary science</title>
			<see_also><italic>See</italic> Earth science; Space and planetary science</see_also>
			<code>planetary</code>
		</category>
		<category>
			<title>Polymer physics</title>
			<see_also><italic>See</italic> Chemical and molecular physics; Materials science; Rheology</see_also>
			<code>polymer</code>
		</category>
		<category>
			<title>Superconductivity and superfluidity</title>
			<see_also><italic>See</italic> Condensed-matter physics; Quantum physics</see_also>
			<code>super</code>
		</category>
		<category>
			<title>Surface physics</title>
			<see_also><italic>See</italic> Condensed-matter physics; Materials science</see_also>
			<code>surfaces</code>
		</category>
		<category>
			<title>Synchrotron light sources</title>
			<see_also><italic>See</italic> Biological physics; Condensed-matter physics; Crystallography; Facilities and laboratories</see_also>
			<code>synch</code>
		</category>
		<category>
			<title>Thermodynamics</title>
			<see_also><italic>See</italic> Statistical physics and thermodynamics</see_also>
			<code>thermodynamics</code>
		</category>
		<category>
			<title>Underrepresented groups in physics</title>
			<see_also><italic>See</italic> Sociology of science</see_also>
			<code>underrep</code>
		</category>
		<category>
			<title>Universities and colleges</title>
			<see_also><italic>See</italic> Education; Politics and policy; Society and physics; Sociology of science</see_also>
			<code>univ</code>
		</category>
		<category>
			<title>Women in physics</title>
			<see_also><italic>See</italic> Sociology of science</see_also>
			<code>women</code>
		</category>
	</i:categories>-->


	

</xsl:stylesheet>
