<?php
class SLS_BoAddForeignKey extends SLS_BoControllerProtected 
{	
	public function action()
	{
		$user = $this->hasAuthorative();
		$sql = SLS_Sql::getInstance();
		
		$xml = $this->getXML();
		$xml = $this->makeMenu($xml);
		$errors = array();
		
		// Get the table name
		$table = SLS_String::substrAfterFirstDelimiter($this->_http->getParam("name"),"_");
		$db	   = SLS_String::substrBeforeFirstDelimiter($this->_http->getParam("name"),"_");
		$class = ucfirst($db)."_".SLS_String::tableToClass($table);
		$file  = ucfirst($db).".".SLS_String::tableToClass($table);
		
		// If current db is not this one
		if ($sql->getCurrentDb() != $db)
			$sql->changeDb($db);
		
		if ($sql->tableExists($table))
		{
			if ($this->_http->getParam("reload") == "true")
			{
				$replacements = array('&amp;','&gt;','&lt;','&#61;','"',"'");
				$masks = array('&','>','<','=','','','');
				
				$columnWanted 	= $this->_http->getParam("column");
				$tableWanted 	= $this->_http->getParam("table");
				$labelWanted 	= $this->_http->getParam($tableWanted.'_fkLabel');
				$labelSpecified = SLS_String::trimSlashesFromString($this->_http->getParam("fkLabel_specified"));				
				$multilang 		= $this->_http->getParam("multilanguage");
				$onDelete 		= $this->_http->getParam("ondelete");
								
				$pathsHandle = file_get_contents($this->_generic->getPathConfig("configSls")."/fks.xml");
				$xmlFk = new SLS_XMLToolbox($pathsHandle);
				$pathsHandle = file_get_contents($this->_generic->getPathConfig("configSls")."/types.xml");
				$xmlType = new SLS_XMLToolbox($pathsHandle);
				$pathsHandle = file_get_contents($this->_generic->getPathConfig("configSls")."/filters.xml");
				$xmlFilter = new SLS_XMLToolbox($pathsHandle);
				if (!empty($labelSpecified))
					$labelSpecified = str_replace(array('='),array('&#61;'),htmlentities(strtolower($labelSpecified),ENT_QUOTES,"UTF-8"));				
				$result = $xmlFk->getTags("//sls_configs/entry[@tableFk='".$db."_".$table."' and @columnFk='".$columnWanted."' and @tablePk='".$tableWanted."']");
				
				// If an entry already exists in the XML, delete this record
				if (!empty($result))
				{
					$xmlTmp = $xmlFk->deleteTags("//sls_configs/entry[@tableFk='".$db."_".$table."' and @columnFk='".$columnWanted."' and @tablePk='".$tableWanted."']");
					$xmlFk->saveXML($this->_generic->getPathConfig("configSls")."/fks.xml",$xmlTmp);
					$pathsHandle = file_get_contents($this->_generic->getPathConfig("configSls")."/fks.xml");
					$xmlFk = new SLS_XMLToolbox($pathsHandle);
				}
				
				// Save it into the XML
				$xmlNode = '<entry tableFk="'.$db."_".$table.'" columnFk="'.$columnWanted.'" multilanguage="'.$multilang.'" ondelete="'.$onDelete.'" labelPk="'.(empty($labelSpecified) ? $labelWanted : $labelSpecified).'" tablePk="'.$tableWanted.'" />';					
				$xmlFk->appendXMLNode("//sls_configs",$xmlNode);
				$xmlFk->saveXML($this->_generic->getPathConfig("configSls")."/fks.xml",$xmlFk->getXML());

				// Disable UserBo quick-edit feature on this column
				$xmlBo = new SLS_XMLToolbox(file_get_contents($this->_generic->getPathConfig("configSls")."/bo.xml"));
				$boPath = "//sls_configs/entry[@type='table' and @name='".strtolower($db."_".$table)."']/columns/column[@name='".$columnWanted."']";
				$boExists = $xmlBo->getTag($boPath."/@allowEdit");
				if (empty($boExists))		
					$boPath = "//sls_configs/entry/entry[@type='table' and @name='".strtolower($db."_".$table)."']/columns/column[@name='".$columnWanted."']";
				$boExists = $xmlBo->getTag($boPath."/@allowEdit");
				if (!empty($boExists))
				{
					$xmlBo->setTagAttributes($boPath,array("allowEdit" => "false"));
					$xmlBo->saveXML($this->_generic->getPathConfig("configSls")."/bo.xml",$xmlBo->getXML());
					$xmlBo->refresh();	
				}
				
				// Update model
				$this->_generic->goDirectTo("SLS_Bo","UpdateModel",array(array("key"=>"name","value"=>$this->_http->getParam("name"))));
			}
			
			// Get generic object
			$this->_generic->useModel(SLS_String::tableToClass($table),$db,"user");
			$object = new $class();
			
			// Get object's infos
			$pathsHandle = file_get_contents($this->_generic->getPathConfig("configSls")."/fks.xml");
			$xmlFk = new SLS_XMLToolbox($pathsHandle);
			$columnsP = $object->getParams();
			$pk = $object->getPrimaryKey();
			$multilanguage = $object->isMultilanguage();		
			$xml->startTag("model");
			$xml->addFullTag("table",$table,true);
			$xml->addFullTag("db",$db,true);
			$xml->addFullTag("class",$class,true);
			$xml->addFullTag("pk",$pk,true);
			$xml->addFullTag("multilanguage",($multilanguage) ? "true" : "false",true);
			$xml->startTag("columns");
			foreach($columnsP as $column => $value)
			{
				$res = $xmlFk->getTags("//sls_configs/entry[@tableFk='".$db."_".$table."' and @columnFk='".$column."']/@tablePk");				
				if ($object->getPrimaryKey() != $column && $column != "pk_lang" && empty($res))			
					$xml->addFullTag("column",$column,true);
			}
			$xml->endTag("columns");
			$tables = $this->getAllModels();
			
			sort($tables,SORT_REGULAR);			
				
			$xml->startTag("tables");			
			for($i=0 ; $i<$count=count($tables) ; $i++)
			{
				if (SLS_String::startsWith($tables[$i],$db))
				{
					$xml->startTag("table");
					$xml->addFullTag("name",SLS_String::substrAfterFirstDelimiter($tables[$i],"."));
					$xml->addFullTag("db",SLS_String::substrBeforeFirstDelimiter($tables[$i],"."));
					$tableN = SLS_String::substrAfterFirstDelimiter($tables[$i],".");
					$dbN = SLS_String::substrBeforeFirstDelimiter($tables[$i],".");
					$classN = ucfirst($dbN)."_".SLS_String::tableToClass($tableN);								
					$this->_generic->useModel($tableN,$dbN,"user");				
					$obj = new $classN();
					$properties = $obj->getParams();
					$xml->startTag("columns");
					foreach($properties as $key => $value)
						if ($key != "pk_lang")
							$xml->addFullTag("column",$key,true);
					$xml->endTag("columns");
					$xml->endTag("table");
				}
			}
				
			$xml->endTag("tables");	
			$xml->endTag("model");
		}
		else
		{
			$xml->addFullTag("error","Sorry this table doesn't exist anymore",true);
		}
		
		$this->saveXML($xml);
	}
}