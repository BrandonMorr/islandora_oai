<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dc="http://purl.org/dc/terms/" exclude-result-prefixes="xs mods" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="text()"/>
    <xsl:template match="/">
        <record>
            <xsl:apply-templates/>
        </record>
    </xsl:template>
    <xsl:template match="mods:titleInfo[@type='alternative']">
        <dcterms:alternative>
            <xsl:value-of select="mods:nonSort"/>
            <xsl:if test="mods:nonSort">
                <xsl:text/>
            </xsl:if>
            <xsl:value-of select="mods:title"/>
            <xsl:if test="mods:subTitle">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="mods:subTitle"/>
            </xsl:if>
            <xsl:if test="mods:partNumber">
                <xsl:text>.</xsl:text>
                <xsl:value-of select="mods:partNumber"/>
            </xsl:if>
            <xsl:if test="mods:partName">
                <xsl:text>.</xsl:text>
                <xsl:value-of select="mods:partName"/>
            </xsl:if>
        </dcterms:alternative>
    </xsl:template>
    <xsl:template match="mods:relatedItem[@type='host']">
        <dcterms:isPartOf>
            <xsl:value-of select="mods:nonSort"/>
            <xsl:if test="./mods:titleInfo/mods:nonSort">
                <xsl:text/>
            </xsl:if>
            <xsl:value-of select="./mods:titleInfo/mods:title"/>
            <xsl:if test="./mods:titleInfo/mods:subTitle">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="./mods:titleInfo/mods:subTitle"/>
            </xsl:if>
            <xsl:if test="./mods:titleInfo/mods:partNumber">
                <xsl:text>.</xsl:text>
                <xsl:value-of select="./mods:titleInfo/mods:partNumber"/>
            </xsl:if>
            <xsl:if test="./mods:titleInfo/mods:partName">
                <xsl:text>.</xsl:text>
                <xsl:value-of select="./mods:titleInfo/mods:partName"/>
            </xsl:if>
        </dcterms:isPartOf>
    </xsl:template>
    <xsl:template match="mods:name">
        <dc:contributor>
            <xsl:call-template name="name"/>
        </dc:contributor>
    </xsl:template>
    <xsl:template match="mods:originInfo/mods:dateIssued[@keyDate='yes']|mods:originInfo/mods:dateCreated[@keyDate='yes']">
        <dc:date>
            <xsl:value-of select="."/>
        </dc:date>
    </xsl:template>
    <xsl:template match="mods:note">
        <dc:description>
            <xsl:value-of select="."/>
        </dc:description>
    </xsl:template>
    <xsl:template match="mods:physicalDescripption/mods:extent">
        <dcterms:extent>
            <xsl:choose>
                <xsl:when test=".[@unit='pages']">
                    <xsl:apply-templates select="text()"/>
                    <xsl:text> pages</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </dcterms:extent>
    </xsl:template>
    <xsl:template match="mods:physicalDescription/mods:form[not(@*)]|mods:genre[@authority='aat']">
        <dcterms:medium>
            <xsl:value-of select="."/>
        </dcterms:medium>
    </xsl:template>
    <xsl:template match="mods:location/mods:url">
        <dc:identifier>
            <xsl:value-of select="."/>
        </dc:identifier>
    </xsl:template>
    <xsl:template match="mods:language/mods:languageTerm[@type='text']">
        <dc:language>
            <xsl:value-of select="."/>
        </dc:language>
    </xsl:template>
    <xsl:template match="mods:subject/mods:geographic">
        <dcterms:spatial>
            <xsl:value-of select="."/>
        </dcterms:spatial>
    </xsl:template>
    <xsl:template match="mods:originInfo/mods:publisher">
        <dc:publisher>
            <xsl:value-of select="."/>
        </dc:publisher>
    </xsl:template>
    <xsl:template match="mods:relatedItem/mods:location/mods:url|mods:relatedItem[not(@*)]/mods:titleInfo/mods:title">
        <dc:relation>
            <xsl:value-of select="."/>
        </dc:relation>
    </xsl:template>
    <xsl:template match="mods:relatedItem[@type='series']/mods:titleInfo[@type='uniform']">
        <dc:relation>
            <xsl:value-of select="mods:nonSort"/>
            <xsl:if test="./mods:nonSort">
                <xsl:text/>
            </xsl:if>
            <xsl:value-of select="./mods:title"/>
            <xsl:if test="./mods:subTitle">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="./mods:subTitle"/>
            </xsl:if>
            <xsl:if test="./mods:partNumber">
                <xsl:text> ; </xsl:text>
                <xsl:value-of select="./mods:partNumber"/>
            </xsl:if>
        </dc:relation>
    </xsl:template>
    <xsl:template match="mods:relatedItem[@type='succeeding']">
        <dcterms:replacedBy>
            <xsl:value-of select="./mods:titleInfo/mods:title"/>
        </dcterms:replacedBy>
    </xsl:template>
    <xsl:template match="mods:relatedItem[@type='preceeding']">
        <dcterms:replaces>
            <xsl:value-of select="./mods:titleInfo/mods:title"/>
        </dcterms:replaces>
    </xsl:template>
    <xsl:template match="mods:accessCondition">
        <dc:rights>
            <xsl:value-of select="."/>
        </dc:rights>
    </xsl:template>
    <xsl:template match="mods:accessCondition[@type='rightsstatement']">
        <dc:rights>
            <xsl:value-of select="./@xlink:href"/>
        </dc:rights>
    </xsl:template>
    <xsl:template match="mods:subject[mods:topic | mods:name]">
        <dc:subject>
            <xsl:for-each select="mods:topic">
                <xsl:value-of select="."/>
                <xsl:if test="position()!=last()">--</xsl:if>
            </xsl:for-each>
            <xsl:for-each select="mods:name">
                <xsl:call-template name="name"/>
            </xsl:for-each>
        </dc:subject>
    </xsl:template>
    <xsl:template match="mods:subject/mods:temporal">
        <dcterms:temporal>
            <xsl:value-of select="."/>
        </dcterms:temporal>
    </xsl:template>
    <xsl:template match="/mods:mods/mods:titleInfo[not(@*)]">
        <dc:title>
            <xsl:value-of select="mods:nonSort"/>
            <xsl:if test="mods:nonSort">
                <xsl:text/>
            </xsl:if>
            <xsl:value-of select="mods:title"/>
            <xsl:if test="mods:subTitle">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="mods:subTitle"/>
            </xsl:if>
            <xsl:if test="mods:partNumber">
                <xsl:text>.</xsl:text>
                <xsl:value-of select="mods:partNumber"/>
            </xsl:if>
            <xsl:if test="mods:partName">
                <xsl:text>.</xsl:text>
                <xsl:value-of select="mods:partName"/>
            </xsl:if>
        </dc:title>
    </xsl:template>
    <xsl:template match="mods:typeOfResource">
        <xsl:if test="@collection='yes'">
            <dc:type>Collection</dc:type>
        </xsl:if>
        <xsl:if test=". ='software' and ../mods:genre='database'">
            <dc:type>Dataset</dc:type>
        </xsl:if>
        <xsl:if test=".='software' and ../mods:genre='online system or service'">
            <dc:type>Service</dc:type>
        </xsl:if>
        <xsl:if test=".='software'">
            <dc:type>Software</dc:type>
        </xsl:if>
        <xsl:if test=".='cartographic material'">
            <dc:type>Image</dc:type>
        </xsl:if>
        <xsl:if test=".='multimedia'">
            <dc:type>InteractiveResource</dc:type>
        </xsl:if>
        <xsl:if test=".='moving image'">
            <dc:type>MovingImage</dc:type>
        </xsl:if>
        <xsl:if test=".='three dimensional object'">
            <dc:type>PhysicalObject</dc:type>
        </xsl:if>
        <xsl:if test="starts-with(.,'sound recording')">
            <dc:type>Sound</dc:type>
        </xsl:if>
        <xsl:if test=".='still image'">
            <dc:type>StillImage</dc:type>
        </xsl:if>
        <xsl:if test=". ='text'">
            <dc:type>Text</dc:type>
        </xsl:if>
        <xsl:if test=".='notated music'">
            <dc:type>Text</dc:type>
        </xsl:if>
    </xsl:template>
    <xsl:template name="name">
        <xsl:variable name="name">
            <xsl:for-each select="mods:namePart[not(@type)]">
                <xsl:value-of select="."/>
                <xsl:text/>
            </xsl:for-each>
            <xsl:value-of select="mods:namePart[@type='family']"/>
            <xsl:if test="mods:namePart[@type='given']">
                <xsl:text>,</xsl:text>
                <xsl:value-of select="mods:namePart[@type='given']"/>
            </xsl:if>
            <xsl:if test="mods:namePart[@type='date']">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="mods:namePart[@type='date']"/>
                <xsl:text/>
            </xsl:if>
            <xsl:if test="mods:displayForm">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="mods:displayForm"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="normalize-space($name)"/>
    </xsl:template>
</xsl:stylesheet>
