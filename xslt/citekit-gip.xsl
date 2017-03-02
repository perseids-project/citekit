<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cite="http://chs.harvard.edu/xmlns/citeimg" exclude-result-prefixes="cite" version="1.0">
    <xsl:param name="ict-url"/>
    <xsl:param name="ImageServiceGIP"/>
    <xsl:param name="image-w">800</xsl:param>
<!--    <xsl:output method="html" omit-xml-declaration="yes"/>
-->    
    
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="(//cite:caption = 'null') and (//cite:rights = 'null')">
                <xsl:element name="span">
                    <xsl:attribute name="class">citekit-error</xsl:attribute>
                    Failed to load <xsl:value-of select="//cite:urn"/> from URL <code><xsl:value-of select="substring-before($ict-url,'ict')"/>.</code>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <!-- if we've been passed an image service url and we don't have an absolute url in the
                     values returned by the Image Service, use the passed version -->
                <xsl:variable name="ImageServiceURL">
                    <xsl:choose>
                        <xsl:when test="$ImageServiceGIP and not(starts-with(//cite-binaryUrl,'http'))">
                            <xsl:value-of select="substring-before($ImageServiceGIP,'api')"/>
                        </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
        <div class="citeimagediv">
        <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="concat($ImageServiceURL,//cite:binaryUrl)"/></xsl:attribute>
        <xsl:element name="img">
            <xsl:attribute name="class">cite-image</xsl:attribute>
            <xsl:attribute name="src"><xsl:value-of select="concat($ImageServiceURL,//cite:binaryUrl)"/>&amp;w=<xsl:value-of select="$image-w"/></xsl:attribute>
            <xsl:attribute name="alt"><xsl:value-of select="//cite:urn"/></xsl:attribute>
        </xsl:element>
        </xsl:element>
            <div class="citeimagecaption">
            <p><xsl:apply-templates select="//cite:urn"/></p>
            <p><xsl:value-of select="//cite:caption"/></p>
            <p><xsl:value-of select="//cite:rights"/></p>
			<p>
					<xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="$ict-url"/><xsl:value-of select="//cite:urn"/></xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							Cite &amp; Quote Image
					</xsl:element>
			</p>
            </div>
        </div>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

</xsl:stylesheet>
