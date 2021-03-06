<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template name="BoForgottenPwd">

		<div id="Login">
			<div class="title-block">
				<div class="padded">
					<p class="title">
						|||sls:lang:SLS_BO_FORGOTTEN_WELCOME|||
					</p>
					<div class="user-img">
						<img class="sls-image" sls-image-fit="cover" title="" sls-image-src="{concat($sls_url_img_core, 'BO-2014/Pictos/default_account_small.jpg')}" style="opacity: 1; visibility: visible; position: relative; width: 163px; height: 163px; top: 0px; left: 0px;" />
					</div>
				</div>
			</div>
			<div class="content-block">
				<div class="padded">
					<form action="" method="post">
						<input type="hidden" name="reload-forgotten" value="true" />
						<xsl:if test="count(//View/errors/error) &gt; 0">
							<div class="error">
								<xsl:for-each select="//View/errors/error">
									<xsl:value-of select="." />
								</xsl:for-each>
							</div>
						</xsl:if>
						<div class="field">
							<input type="text" name="admin[login]" id="login" placeholder="|||sls:lang:SLS_BO_FORGOTTEN_EMAIL|||" />
						</div>
						<div class="form-actions">
							<input type="submit" value="|||sls:lang:SLS_BO_FORGOTTEN_SUBMIT|||" />
							<div class="separator"></div>
							<a href="{//Statics/Site/BoMenu/various/login}" title="" class="forgotten">|||sls:lang:SLS_BO_FORGOTTEN_LOGIN|||</a>
						</div>
					</form>
					<div class="wandi-logo">
						<a href="http://www.wandi.fr" title="Wandi Agency" target="_blank">
							<img class="sls-image" sls-image-fit="cover" sls-image-src="{$sls_url_img_core}BO-2014/Logos/wandi.png" title="" alt="" />
						</a>
					</div>
				</div>
			</div>
		</div>
		
	</xsl:template>
</xsl:stylesheet>