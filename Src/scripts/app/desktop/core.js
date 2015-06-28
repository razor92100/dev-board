var Core = $.inherit({
	__constructor : function(){
		this.body = $('body');
		this.classCaller();
		this.initGenerics();
	},

	initGenerics : function(){

	},

	classCaller : function(){
		var self = this;
		var classCaller = 'app';
		var _class = this.body.attr('app-class');
		_class = _class.replace('app-', '');
		_class =_class.split('-');
		for(var i=0; i<_class.length; i++)
			classCaller += _class[i].capitalizeFirstLetter();
		eval('new ' + classCaller + '()');
	}
});
$(document).ready(function(){
	new Core();
});
