<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" xmlns="http://www.w3.org/1999/xhtml" xmlns:dyn="http://exslt.org/dynamic" extension-element-prefixes="dyn">
	<xsl:template name="Modify{{DB}}_{{TABLE}}">
		<xsl:call-template name="BoEdit" />
	</xsl:template>
</xsl:stylesheet>