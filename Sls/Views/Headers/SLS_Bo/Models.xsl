<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template name="HeaderModels">
		<script type="text/javascript">
			function confirmDelete(link){if (confirm("Are you sure to delete this record ?"))window.location = link;else return false;}
			function confirmFlush(link){if (confirm("Are you sure to flush this object's cache ?"))window.location = link;else return false;}
		</script>
	</xsl:template>
</xsl:stylesheet>