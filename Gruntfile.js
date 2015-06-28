module.exports = function(grunt)
	{
		grunt.initConfig({
			pkg     :   grunt.file.readJSON('package.json'),

			paths    :   {
				src : {
					js : 'Src/scripts/app/desktop/',
					less : 'Src/styles/less/',
					img : 'Src/styles/img/',
					fonts : 'Src/styles/fonts/'
				},
				dest : {
					js : 'Public/Scripts/Javascript/Dyn/',
					css : 'Public/Style/Css/',
					fonts : 'Public/Style/Fonts/',
					img : 'Public/Style/Img/'
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
						compression: 5
					}
				}
			}
		});

        grunt.loadNpmTasks('grunt-contrib-copy');
		grunt.loadNpmTasks('grunt-contrib-less');
		grunt.loadNpmTasks('grunt-concat-sourcemap');
		grunt.loadNpmTasks('grunt-contrib-imagemin');
		grunt.loadNpmTasks('grunt-zip');
		grunt.loadNpmTasks('grunt-contrib-uglify');
		grunt.loadNpmTasks('grunt-contrib-cssmin');
        grunt.loadNpmTasks('grunt-contrib-watch');
		grunt.loadNpmTasks('grunt-real-favicon');

		grunt.registerTask('concatfav', ['real_favicon']);
		grunt.registerTask('less-compile', ['less:developmentDesktop']);
		grunt.registerTask('concatjs', ['concat_sourcemap:desktop']);
		grunt.registerTask('concatimg', ['imagemin']);
		grunt.registerTask('build', ['less:developmentDesktop', 'cssmin', 'uglify:all', 'zip', 'imagemin']);

	}
	
