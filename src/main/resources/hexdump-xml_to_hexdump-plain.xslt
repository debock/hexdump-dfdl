<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
>

  <xsl:output method="text" encoding="UTF-8" />
  <xsl:strip-space elements="*" />
 
  <xsl:template match="/hexdump">
    <xsl:apply-templates />
    <!-- insert line break after each line of hex values-->
    <xsl:text xml:space="preserve">
</xsl:text>
  </xsl:template>
 
  <xsl:template match="hexbin30">
    <xsl:value-of select="." />
    <!-- insert line break after each line of hex values-->
    <xsl:text xml:space="preserve">
</xsl:text>
  </xsl:template>

  <xsl:template match="hexbin01">
    <xsl:value-of select="." />
  </xsl:template>
 
</xsl:stylesheet>
