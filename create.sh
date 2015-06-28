#!/bin/bash

echo ""
echo "####################################"
echo "#  SWEET PUNK - Project Deployer   #"
echo "#        v.0.5 - 2015-05-27        #"
echo "####################################"
echo ""

# Temp
# rm -R tmp/*
# cp -Rf res/mobile-detect tmp/
# cd tmp/
# Temp

# Copy Ressources
#cd res/
#cp -Rf mobile-detect ../
#cd ..
# / Copy Ressources

# VARS 
IS_MOBILE=false
#  / VARS 

# TEMP folder

# / TEMP folder

echo -n "# Please type project name : "
read PROJECT_NAME

echo -n "# Please type project description : "
read PROJECT_DESCRIPTION

echo -n "# Website is mobile ? (y) : "
read r

if [ $r == "y" ]; then
	# HERE
	IS_MOBILE=true
fi

###########################################################################

echo ""
echo " - Creating dev. Desktop folders (src)"

# SRC
mkdir src/

mkdir src/config

mkdir src/scripts
mkdir src/scripts/app
mkdir src/scripts/app/desktop
mkdir src/scripts/lib

mkdir src/styles

mkdir src/styles/fonts

mkdir src/styles/img
mkdir src/styles/img/desktop

mkdir src/styles/less
mkdir src/styles/less/generics
mkdir src/styles/less/desktop

mkdir src/templates
mkdir src/templates/generics
mkdir src/templates/desktop
mkdir src/templates/desktop/generics

if [ "$IS_MOBILE" = true ] ; then
	echo " - Creating dev. Mobile folders (src)"
	mkdir src/scripts/app/mobile

	mkdir src/styles/img/mobile

	mkdir src/styles/less/mobile

	mkdir src/templates/mobile
	mkdir src/templates/mobile/generics
fi
# / SRC

# PUBLIC
echo " - Creating Public folder (public)"
mkdir public/
mkdir public/scripts
mkdir public/styles
mkdir public/styles/css
mkdir public/styles/fonts
mkdir public/styles/img
# / PUBLIC

echo " - Creating Public folder (public)"

###########################################################################

# Update Node
echo "# Your current version of NodeJS is "
npm --v
echo -n "# Would you update NodeJS (recommanded) ? (y) : "
read r

if [ $r == "y" ]; then
	sudo npm cache clean -f
	sudo npm install -g n
	sudo n stable
fi
# / Update Node

# Package JSON
echo " - Creating package.json"
echo "{
	\"name\": \"$PROJECT_NAME\",
	\"description\": \"$PROJECT_DESCRIPTION\",
	\"version\": \"0.1.0\",
	\"devDependencies\": {
		\"grunt\": \"~0.4.5\",
		\"grunt-cli\": \"~0.1.13\",
		\"grunt-concat-sourcemap\": \"~0.4.3\",
		\"grunt-contrib-clean\": \"~0.6.0\",
		\"grunt-contrib-concat\": \"~0.5.0\",
		\"grunt-contrib-copy\": \"~0.7.0\",
		\"grunt-contrib-cssmin\": \"~0.12.1\",
		\"grunt-contrib-less\": \"~1.0.0\",
		\"grunt-contrib-uglify\": \"~0.7.0\",
		\"grunt-contrib-watch\": \"~0.6.1\",
		\"grunt-contrib-imagemin\": \"~0.9.3\",
		\"grunt-ejs\": \"~0.3.0\",
		\"grunt-zip\": \"~0.16.2\",
		\"grunt-real-favicon\": \"~0.0.4\",
		\"grunt-exec\": \"~0.4.6\"
	}
}" > package.json

echo " - Installing Node dependecies & packages"
sudo npm install

# / Package JSON

###########################################################################

# Remove Mobile Detect
if [ "$IS_MOBILE" = false ] ; then
	echo " - Removing mobile detection"
	rm -Rf mobile-detect
fi
# / Remove Mobile Detect

###########################################################################

# Create Less Files
echo " - Creating Less Files"
## Colors
echo "/** $PROJECT_NAME Colors LESS File **/" > src/styles/less/generics/colors.less
echo "/** $PROJECT_NAME Fonts LESS File **/" > src/styles/less/generics/fonts.less
echo "/** $PROJECT_NAME Desktop Reset LESS File **/

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed,
figure, figcaption, footer, header, hgroup,
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}
article, aside, details, figcaption, figure,
footer, header, hgroup, menu, nav, section {
	display: block;
}
body {
	line-height: 1;
}
ol, ul {
	list-style: none;
}
blockquote, q {
	quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
	content: '';
	content: none;
}
table {
	border-collapse: collapse;
	border-spacing: 0;
}
h1, h2, h3, h4, h5, h6, p{
	font-weight: normal;
}
:focus {
	outline: 0;
}" > src/styles/less/generics/reset.less
echo ".relative{
	position: relative;
	height:100%;
	width:100%;
}
.clear{
	clear: both;
	width: 100%;
	height: 0px;
	float: none;
}
.clearfix:after{
	.clear;
	content: ' ';
}
a{
	text-decoration: none;
	color: inherit;
}" > src/styles/less/generics/generics.less

## Core
echo "/** $PROJECT_NAME Desktop Core LESS File **/

@import '../generics/reset.less';
@import '../generics/fonts.less';
@import '../generics/colors.less';
@import '../generics/generics.less';
html{
	width: 100%;
	height: 100%;
}
body{
	width: 100%;
	height: 100%;
	font-style: normal;
}
body.no-scroll{
	overflow: hidden;
}" > src/styles/less/desktop/core.less

## Core Mobile
if [ "$IS_MOBILE" = true ] ; then
	echo "/** $PROJECT_NAME Mobile Core LESS File **/

@import '../generics/reset.less';
@import '../generics/fonts.less';
@import '../generics/colors.less';
@import '../generics/generics.less';
html{
	width: 100%;
	height: 100%;
}
body{
	width: 100%;
	height: 100%;
	font-style: normal;
}
body.no-scroll{
	overflow: hidden;
}" > src/styles/less/mobile/core.less
fi

# / Create Less Files

###########################################################################

# JS Libraries
echo -n "# Would you install jQuery ? (y) : "
read r
if [ $r == "y" ]; then
	echo -n "# Which ver. of jQuery would you install (e.g. : 1.X.X / 2.X.X) ? - versions available on https://developers.google.com/speed/libraries/devguide : "
	read r
	curl "https://ajax.googleapis.com/ajax/libs/jquery/$r/jquery.min.js" > src/scripts/lib/jquery.min.js
	echo " - jQuery $r : OK"
	cp res/inherit.min.js src/scripts/lib/inherit.min.js
	echo " - inherit.min.js : OK"
	cp res/prototypes.js src/scripts/lib/prototypes.js
	echo " - prototypes.js : OK"
	cp res/visible.min.js src/scripts/lib/visible.min.js
	echo " - visible.min.js : OK"
fi

echo -n "# Would you install TweenMax (GSAP) ? (y) : "
read r
if [ $r == "y" ]; then
	curl "http://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js" > src/scripts/lib/tweenmax.min.js
	echo " - tweenmax.min.js : OK"
fi

echo -n "# Would you install VideoJS (HTML5) ? (y) : "
read r
if [ $r == "y" ]; then
	curl "http://cdnjs.cloudflare.com/ajax/libs/video.js/4.11.4/video.js" > src/scripts/lib/videojs.min.js
fi

echo -n "# Would you install HammerJS ? : "
read r
if [ $r == "y" ]; then
	curl "http://hammerjs.github.io/dist/hammer.min.js" > src/scripts/lib/hammerjs.min.js
fi
# JS Libraries

###########################################################################

# Build Gruntfile
echo " - Creating Gruntfile"
if [ "$IS_MOBILE" = true ] ; then
	echo "module.exports = function(grunt)
	{
		grunt.initConfig({
			pkg     :   grunt.file.readJSON('package.json'),

			paths    :   {
				src : {
					js : 'src/scripts/',
					less : 'src/styles/less/',
					img : 'src/styles/img/',
					fonts : 'src/styles/fonts/',
					templates : 'src/templates/'
				},
				dest : {
					js : 'public/scripts/',
					css : 'public/styles/css/',
					fonts : 'public/styles/fonts/',
					img : 'public/styles/img/'
				}
			},
			less : {
				developmentDesktop : {
					options : {
						strictMath : true,
						sourceMap : true,
						outputSourceFiles : true,
						sourceMapURL : '<%= pkg.name %>-desktop.css.map',
						sourceMapFilename : '<%= paths.dest.css %><%= pkg.name %>-desktop.css.map'
					},
					files : {
						'<%= paths.dest.css %><%= pkg.name %>-desktop.css' : '<%= paths.src.less %>desktop/core.less'
					}
				},
				developmentMobile : {
					options : {
						strictMath : true,
						sourceMap : true,
						outputSourceFiles : true,
						sourceMapURL : '<%= pkg.name %>-mobile.css.map',
						sourceMapFilename : '<%= paths.dest.css %><%= pkg.name %>-mobile.css.map'
					},
					files : {
						'<%= paths.dest.css %><%= pkg.name %>-mobile.css' : '<%= paths.src.less %>mobile/core.less'
					}
				}
			},

			ejs : {
				all: {
					src: ['<%= paths.src.templates %>/*.ejs'],
					dest: './',
					expand: true,
					flatten: true,
					ext: '.php'
				}
			},

			copy : {
				img : {
					expand: true,
					cwd: '<%= paths.src.img %>',
					src: ['**'],
					dest: '<%= paths.dest.img %>'
				},
				fonts : {
					expand: true,
					cwd: '<%= paths.src.fonts %>',
					src: ['**'],
					dest: '<%= paths.dest.fonts %>'
				}
			},

			concat_sourcemap : {
				options : {
					sourcesContent: true
				},
				desktop : {
					src : [
						'<%= paths.src.js %>lib/*.js',

						// App
						'<%= paths.src.js %>app/**/*.js'
					],
					dest : '<%= paths.dest.js %><%= pkg.name %>-desktop.js'
				},
				mobile : {
					src : [
						'<%= paths.src.js %>lib/*.js',

						// App
						'<%= paths.src.js %>app/**/*.js'
					],
					dest : '<%= paths.dest.js %><%= pkg.name %>-mobile.js'
				}
			},

			watch: {
				options: {
					livereload: true
				},
				javascript: {
					files: ['<%= paths.src.js %>*js', '<%= paths.src.js %>**/*js'],
					tasks: ['concatjs']
				},
				css: {
					files: ['<%= paths.src.less %>**/*.less'],
					tasks: ['less-compile']
				},
				ejs: {
					files: ['<%= paths.src.templates %>/*.ejs', '<%= paths.src.templates %>/**/*.ejs'],
					tasks: ['ejs:all']
				}
			},
			imagemin: {
				dynamic: {
					files: [{
						expand: true,
						cwd: '<%= paths.src.img %>',
						src: ['**/*.{png,jpg,gif}'],
						dest: '<%= paths.dest.img %>'
					}]
				}
			},
			uglify: {
				all: {
					options: {
						sourceMap: true
					},
					files: {
						'<%= paths.dest.js %><%= pkg.name %>-desktop.js': '<%= paths.dest.js %><%= pkg.name %>-desktop.js'
					}
				}
			},
			cssmin: {
				options: {
					compatibility: 'ie8',
					keepSpecialComments: '*'
				},
				core: {
					files: {
						'<%= paths.dest.css %><%= pkg.name %>-desktop.css': '<%= paths.dest.css %><%= pkg.name %>-desktop.css'
					}
				}
			},
			zip: {
				'long-format': {
					src: [
						'public/**',
						'*.php'
					],
					dest: '<%= pkg.name %>-desktop.zip'
				}
			},
			real_favicon: {
				my_icon: {
					src: '<%= paths.src.img %>/favicon.png',
					dest: '<%= paths.dest.img %>/favicons',
					icons_path: '<%= paths.dest.img %>/favicons',
					html: ['public/index.html'],
					design: {
						ios: {},
						windows: {}
					},
					settings: {
						// 0 = no compression, 5 = maximum compression 
						compression: 5,
					}
				}
			}
		});

		grunt.loadNpmTasks('grunt-contrib-copy');
		grunt.loadNpmTasks('grunt-contrib-less');
		grunt.loadNpmTasks('grunt-contrib-watch');
		grunt.loadNpmTasks('grunt-concat-sourcemap');
		grunt.loadNpmTasks('grunt-contrib-imagemin');
		grunt.loadNpmTasks('grunt-zip');
		grunt.loadNpmTasks('grunt-contrib-uglify');
		grunt.loadNpmTasks('grunt-contrib-cssmin');
		grunt.loadNpmTasks('grunt-real-favicon');

		grunt.registerTask('concatfav', ['real_favicon']);
		grunt.registerTask('less-compile', ['less:developmentDesktop', 'less:developmentMobile']);
		grunt.registerTask('concatjs', ['concat_sourcemap:desktop', 'concat_sourcemap:mobile']);
		grunt.registerTask('concatimg', ['imagemin']);
		grunt.registerTask('build', ['less:developmentDesktop', 'cssmin', 'uglify:all', 'zip', 'imagemin']);

	}
	" > Gruntfile.js
else
	echo "module.exports = function(grunt)
	{
		grunt.initConfig({
			pkg     :   grunt.file.readJSON('package.json'),

			paths    :   {
				src : {
					js : 'src/scripts/',
					less : 'src/styles/less/',
					img : 'src/styles/img/',
					fonts : 'src/styles/fonts/',
					templates : 'src/templates/'
				},
				dest : {
					js : 'public/scripts/',
					css : 'public/styles/css/',
					fonts : 'public/styles/fonts/',
					img : 'public/styles/img/'
				}
			},
			less : {
				developmentDesktop : {
					options : {
						strictMath : true,
						sourceMap : true,
						outputSourceFiles : true,
						sourceMapURL : '<%= pkg.name %>-desktop.css.map',
						sourceMapFilename : '<%= paths.dest.css %><%= pkg.name %>-desktop.css.map'
					},
					files : {
						'<%= paths.dest.css %><%= pkg.name %>-desktop.css' : '<%= paths.src.less %>desktop/core.less'
					}
				}
			},

			ejs : {
				all: {
					src: ['<%= paths.src.templates %>/*.ejs'],
					dest: './',
					expand: true,
					flatten: true,
					ext: '.php'
				}
			},

			copy : {
				img : {
					expand: true,
					cwd: '<%= paths.src.img %>',
					src: ['**'],
					dest: '<%= paths.dest.img %>'
				},
				fonts : {
					expand: true,
					cwd: '<%= paths.src.fonts %>',
					src: ['**'],
					dest: '<%= paths.dest.fonts %>'
				}
			},

			concat_sourcemap : {
				options : {
					sourcesContent: true
				},
				desktop : {
					src : [
						'<%= paths.src.js %>lib/*.js',

						// App
						'<%= paths.src.js %>app/**/*.js'
					],
					dest : '<%= paths.dest.js %><%= pkg.name %>-desktop.js'
				}
			},

			watch: {
				options: {
					livereload: true
				},
				javascript: {
					files: ['<%= paths.src.js %>*js', '<%= paths.src.js %>**/*js'],
					tasks: ['concatjs']
				},
				css: {
					files: ['<%= paths.src.less %>**/*.less'],
					tasks: ['less-compile']
				},
				ejs: {
					files: ['<%= paths.src.templates %>/*.ejs', '<%= paths.src.templates %>/**/*.ejs'],
					tasks: ['ejs:all']
				}
			},
			imagemin: {
				dynamic: {
					files: [{
						expand: true,
						cwd: '<%= paths.src.img %>',
						src: ['**/*.{png,jpg,gif}'],
						dest: '<%= paths.dest.img %>'
					}]
				}
			},
			uglify: {
				all: {
					options: {
						sourceMap: true
					},
					files: {
						'<%= paths.dest.js %><%= pkg.name %>-desktop.js': '<%= paths.dest.js %><%= pkg.name %>-desktop.js'
					}
				}
			},
			cssmin: {
				options: {
					compatibility: 'ie8',
					keepSpecialComments: '*'
				},
				core: {
					files: {
						'<%= paths.dest.css %><%= pkg.name %>-desktop.css': '<%= paths.dest.css %><%= pkg.name %>-desktop.css'
					}
				}
			},
			zip: {
				'long-format': {
					src: [
						'public/**',
						'*.php'
					],
					dest: '<%= pkg.name %>-desktop.zip'
				}
			},
			real_favicon: {
				my_icon: {
					src: '<%= paths.src.img %>/favicon.png',
					dest: '<%= paths.dest.img %>/favicons',
					icons_path: '<%= paths.dest.img %>/favicons',
					html: ['public/index.html'],
					design: {
						ios: {},
						windows: {}
					},
					settings: {
						// 0 = no compression, 5 = maximum compression 
						compression: 5,
					}
				}
			}
		});

		grunt.loadNpmTasks('grunt-contrib-copy');
		grunt.loadNpmTasks('grunt-contrib-less');
		grunt.loadNpmTasks('grunt-contrib-watch');
		grunt.loadNpmTasks('grunt-concat-sourcemap');
		grunt.loadNpmTasks('grunt-contrib-imagemin');
		grunt.loadNpmTasks('grunt-zip');
		grunt.loadNpmTasks('grunt-contrib-uglify');
		grunt.loadNpmTasks('grunt-contrib-cssmin');
		grunt.loadNpmTasks('grunt-real-favicon');

		grunt.registerTask('concatfav', ['real_favicon']);
		grunt.registerTask('less-compile', ['less:developmentDesktop']);
		grunt.registerTask('concatjs', ['concat_sourcemap:desktop']);
		grunt.registerTask('concatimg', ['imagemin']);
		grunt.registerTask('build', ['less:developmentDesktop', 'cssmin', 'uglify:all', 'zip', 'imagemin']);

	}
	" > Gruntfile.js
fi
echo " - Installing Grunt"

# npm install -g crunt-cli

# / Build Gruntfile

###########################################################################

echo " - Creating templates"

# Build EJS (With MOBILE)
if [ "$IS_MOBILE" = true ] ; then
# Create Templates EJS WITH Mobile
echo "<?php
	require_once 'mobile-detect/Mobile_Detect.php';
	\$detect = new Mobile_Detect();
	if(!\$detect->isMobile() || \$detect->isTablet())
		\$isMobile = false;
	if(\$detect->isMobile() && !\$detect->isTablet())
		\$isMobile = true;
?>
<!DOCTYPE html>

<!--[if lt IE 7 ]> <html class=\"ie6\"> <![endif]-->
<!--[if IE 7 ]>    <html class=\"ie7\"> <![endif]-->
<!--[if IE 8 ]>    <html class=\"ie8\"> <![endif]-->
<!--[if IE 9 ]>    <html class=\"ie9\"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html class=\"\"> <!--<![endif]-->

	<head>
		<meta charset=\"utf-8\">

		<meta name=\"viewport\" content=\"initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,width=device-width,user-scalable=no\" />

		<meta property=\"og:image\" content=\"/public/styles/img/facebook-og.jpg\"/>
		<meta property=\"og:title\" content=\"\"/>
		<meta property=\"og:url\" content=\"\"/>
		<meta property=\"og:site_name\" content=\"\"/>
		<meta property=\"og:description\" content=\"\" />

		<meta name=\"robots\" content=\"index,follow\" />
		<meta name=\"description\" content=\"\" />

		<title></title>
		<% include generics/styles.ejs %>
		<script src=\"./public/scripts/modernizr.js\"></script>
		<!--[if (gte IE 6)&(lte IE 8)]>
			<script type=\"text/javascript\" src=\"./public/scripts/selectivizr-min.js\"></script>
		<![endif]-->
	</head>

	<body app-class=\"%\">
		<?php if(!\$isMobile) echo '<% include desktop/index.ejs %>'; ?>
		<?php if(\$isMobile) echo '<% include mobile/index.ejs %>'; ?>
		<% include generics/scripts.ejs %>
	</body>
</html>" > src/templates/index.ejs

echo "<div class=\"main-wrapper %\"></div>" > src/templates/desktop/index.ejs
echo "<div class=\"main-wrapper %\"></div>" > src/templates/mobile/index.ejs
else
# Create Templates EJS WITHOUT Mobile
echo "<!DOCTYPE html>

<!--[if lt IE 7 ]> <html class=\"ie6\"> <![endif]-->
<!--[if IE 7 ]>    <html class=\"ie7\"> <![endif]-->
<!--[if IE 8 ]>    <html class=\"ie8\"> <![endif]-->
<!--[if IE 9 ]>    <html class=\"ie9\"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html class=\"\"> <!--<![endif]-->

	<head>
		<meta charset=\"utf-8\">

		<meta name=\"viewport\" content=\"initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,width=device-width,user-scalable=no\" />

		<meta property=\"og:image\" content=\"/public/styles/img/facebook-og.jpg\"/>
		<meta property=\"og:title\" content=\"\"/>
		<meta property=\"og:url\" content=\"\"/>
		<meta property=\"og:site_name\" content=\"\"/>
		<meta property=\"og:description\" content=\"\" />

		<meta name=\"robots\" content=\"index,follow\" />
		<meta name=\"description\" content=\"\" />

		<title></title>
		<% include generics/styles.ejs %>
		<script src=\"./public/scripts/modernizr.js\"></script>
		<!--[if (gte IE 6)&(lte IE 8)]>
			<script type=\"text/javascript\" src=\"./public/scripts/selectivizr-min.js\"></script>
		<![endif]-->
	</head>

	<body app-class=\"%\">
		<% include desktop/index.ejs %>
		<% include generics/scripts.ejs %>
	</body>
</html>" > src/templates/index.ejs
echo "<div class=\"main-wrapper %\">
	
</div>" > src/templates/desktop/index.ejs
fi

# EJS // Generecis/Scripts
if [ "$IS_MOBILE" = true ] ; then
	echo "<?php if(!\$isMobile) echo '<script src=\"./public/scripts/$PROJECT_NAME-desktop.js\"></script>'; ?>
<?php if(\$isMobile) echo '<script src=\"./public/scripts/$PROJECT_NAME-mobile.js\"></script>'; ?>" > src/templates/generics/scripts.ejs
else
	echo "<script src=\"./public/scripts/$PROJECT_NAME-desktop.js\"></script>" > src/templates/generics/scripts.ejs
fi

# EJS // Generecis/Styles
if [ "$IS_MOBILE" = true ] ; then
	echo "<?php if(!\$isMobile) echo '<link rel=\"stylesheet\" href=\"./public/styles/css/$PROJECT_NAME-desktop.css\" />'; ?>
<?php if(\$isMobile) echo '<link rel=\"stylesheet\" href=\"./public/styles/css/$PROJECT_NAME-mobile.css\" />'; ?>" > src/templates/generics/styles.ejs
else
	echo "<link rel=\"stylesheet\" href=\"./public/styles/css/$PROJECT_NAME-desktop.css\" />" > src/templates/generics/styles.ejs
fi

# Build JS

# JS // Core
echo "var Core = $.inherit({
	__constructor : function(){
		this.body = \$('body');
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
\$(document).ready(function(){
	new Core();
});" > src/scripts/app/desktop/core.js

if [ "$IS_MOBILE" = true ] ; then
 cp src/scripts/app/desktop/core.js src/scripts/app/mobile/core.js
fi

# JS // Index
echo "var appIndex = $.inherit({
	__constructor : function(){
		this.myFunction();
	},

	myFunction : function(){
		console.log('Hello you! => appIndex');
	}
});" > src/scripts/app/desktop/index.js
if [ "$IS_MOBILE" = true ] ; then
	cp src/scripts/app/desktop/index.js src/scripts/app/mobile/index.js
fi

cp res/modernizr.js public/scripts/modernizr.js
	echo " - modernizr.js : OK"
cp res/selectivizr-min.js public/scripts/selectivizr-min.js
	echo " - selectivizr-min.js : OK"

grunt less-compile
grunt ejs
grunt concat_sourcemap

echo ""
echo ""
echo "######  ####### #     # ####### 
#     # #     # ##    # #       
#     # #     # # #   # #       
#     # #     # #  #  # #####   
#     # #     # #   # # #       
#     # #     # #    ## #       
######  ####### #     # ####### 
                                
#     # ####### ####### ####### ### 
##   ## #     # #       #     # ### 
# # # # #     # #       #     # ### 
#  #  # #     # #####   #     #  #  
#     # #     # #       #     #     
#     # #     # #       #     # ### 
#     # ####### #       ####### ### ";
echo ""
echo ""

echo ""




