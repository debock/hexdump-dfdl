<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:my="http://www.example.com/my"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="fn my xs"
>

  <xsl:output method="text" encoding="UTF-8" />
  <xsl:key name="Filter" match="segmentdata" use="." />
  
<!-- helper functions defintion -->
  
  <!-- calculate big endian hex number from 16 Bit unsigned integer -->
  <xsl:function name="my:int-to-hex" as="xs:string">
    <xsl:param name="in" as="xs:integer"/>
    <xsl:sequence
      select="if ($in eq 0)
              then '0'
              else
                concat(if ($in gt 15)
                       then my:int-to-hex($in idiv 16)
                       else '',
                       substring('0123456789ABCDEF',
                                 ($in mod 16) + 1, 1))"
    />
  </xsl:function>
  
  <!-- fill 4 digit hex number with zero digits -->
  <xsl:function name="my:fill-to-two-bytes" as="xs:string">
    <xsl:param name="in"    as="xs:string"/>
    <xsl:sequence
      select="if      (string-length($in) eq 1) then concat('000', $in)
              else if (string-length($in) eq 2) then concat('00', $in)
              else if (string-length($in) eq 3) then concat('0', $in)
              else $in"
    />
  </xsl:function>
  
<!-- transformation -->
  
    <!-- preserve line breaks and spaces <xsl:strip-space elements="*"/> -->

  <xsl:template match="/hexdump">
      <xsl:apply-templates/>
  </xsl:template>
 
  <xsl:template match="segmentSize">
    <xsl:value-of select="my:fill-to-two-bytes(my:int-to-hex(.))"/>
    <xsl:text xml:space="preserve">
</xsl:text>
  </xsl:template>

</xsl:stylesheet>
