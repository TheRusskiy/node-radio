// Generated on 2014-01-24 using generator-angular-fullstack 1.2.4
'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'
require('coffee-script');

module.exports = function (grunt) {

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-nodemon');
  grunt.loadNpmTasks('grunt-concurrent');
  grunt.loadNpmTasks('grunt-shell');

  // Define the configuration for all the tasks
  grunt.initConfig({
      open : {
          dev : {
              path: 'http://localhost:3000',
              options: {
//                  openOn: 'serverListening',
//                  delay: 3000
              }
//              app: 'google-chrome'
          }
      },
    coffee: {
      compile: {
        expand: true,
        options: {
          sourceMap: true
        },
        // flatten: true,
        cwd: '',
        src: ['<%= yeoman.app %>/scripts/**/*.coffee'],
        dest: '.',
        ext: '.js'
      }
    },

    mochaTest: {
        test: {
            options: {
                reporter: 'min',
                clearRequireCache: true,
                require: [
                    'coffee-script',
                    'should'
                ]
            },
            src: ['test/server/**/*.{js,coffee}']
        }
    },

    // Project settings
    yeoman: {
      // configurable paths
      app: require('./bower.json').appPath || 'app',
      dist: 'dist'
    },


    express: {
      options: {
        port: process.env.PORT || 9000
      },
//        REPLACED WITH NODEMON:
//      dev: {
//        options: {
//          script: 'server.js',
//          debug: true
//        }
//      },
      prod: {
        options: {
          script: 'dist/server.js',
          node_env: 'production'
        }
      }
    },
      shell: {
          nodemon: {
              command: function(){
//                  console.log('!!!!!!!!!!!!!!!!!');
//                  grunt.event.emit('serverListening');
                  return 'nodemon -e js,coffee --watch lib --watch server.js server.js'
              },
              options: {
                  stdout: true,
                  stderr: true // no such thing :-(
              }
          }
      },
//  nodemon: {
//      dev: {
//          script: 'server.js',
//          options: {
//              nodeArgs: ['--debug'],
//              ignore: ['node_modules/**'],
//              env: {
//                  PORT: '9000'
//              },
//              // omit this property if you aren't serving HTML files and
//              // don't want to open a browser tab on start
//              callback: function (nodemon) {
//                  nodemon.on('log', function (event) {
//                      console.log(event.colour);
//                  });
//
//                  // opens browser on initial server start
//                  nodemon.on('config:update', function () {
//                      // Delay before server listens on port
//                      setTimeout(function() {
//                          require('open')('http://localhost:9000');
//                      }, 1000);
//                  });
//
//                  // refreshes browser when server reboots
//                  nodemon.on('restart', function () {
//                      // Delay before server listens on port
//                      setTimeout(function() {
//                          require('fs').writeFileSync('.grunt/rebooted', 'rebooted');
//                      }, 1000);
//                  });
//              },
//              watch: ['./lib'],
//              delayTime: 100,
//              legacyWatch: true,
//              ext: 'js,coffee'
//          }
//      }
//  },
//    open: {
//      server: {
//        url: 'http://localhost:3000'
//      }
//    },
    watch: {
        coffeeCompile: {
          files: ['' +
              '<%= yeoman.app %>/scripts/**/*.coffee'
          ],
          tasks: ['coffee'],
          options: {
            // livereload: true
          }
        },
        clientJs: {
          files: ['' +
              '<%= yeoman.app %>/scripts/**/*.js'
          ],
          // tasks: ['coffee'],
          options: {
            livereload: true
          }
        },
        compiledCss: {
            files: [
            '{.tmp,<%= yeoman.app %>}/styles/{,*//*}*.css'
          ],
          options: {
//            debounceDelay: 2000,
            livereload: true
          }

        },
        // jsTest: {
        //   files: ['test/spec/{,*/}*.js'],
        //   tasks: ['newer:jshint:test', 'karma']
        // },
        compass: {
          files: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}'],
          tasks: ['compass:server', 'autoprefixer']
        },
        gruntfile: {
          files: ['Gruntfile.js']
        },
        livereload: {
          files: [
            '<%= yeoman.app %>/views/{,*//*}*.{html,jade}',
//            '{.tmp,<%= yeoman.app %>}/styles/{,*//*}*.css',
            '{.tmp,<%= yeoman.app %>}/scripts/{,*//*}*.js',
            '<%= yeoman.app %>/images/{,*//*}*.{png,jpg,jpeg,gif,webp,svg}'
          ],

          options: {
            debounceDelay: 2000,
            livereload: true
          }
        },
//        express: {
//            files: [
//              'server.js',
//              'lib/**/*.{js,json,coffee}'
//            ],
//            tasks: ['express:dev'], // 'newer:jshint:server',
//            options: {
//            //          livereload: true
//              nospawn: true //Without this option specified express won't be reloaded
//            }
//        },
        server: {
            files: ['.grunt/rebooted'],
            options: {
                // livereload: true
            }
        },
        serverTest: {
            options: {
        //              spawn: false
            },
            files: [
                'test/server/**/*.{js,coffee}',
                'lib/**/*.{js,json,coffee}',
                'server.js'
            ],
            tasks: ['mochaTest']
        },
        karmaTest: {
            options: {
        //              spawn: false
            },
            files: [
                'test/client/**/*.{js,coffee}',
                '<%= yeoman.app %>/scripts/{,*/}*.{js,coffee}'
            ],
            tasks: ['karma:continuous:run']
        }
    },

    // Make sure code styles are up to par and there are no obvious mistakes
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      server: {
        options: {
          jshintrc: 'lib/.jshintrc'
        },
        src: [ 'lib/{,*/}*.js']
      },
      all: [
        '<%= yeoman.app %>/scripts/{,*/}*.js'
      ],
      test: {
        options: {
          jshintrc: 'test/.jshintrc'
        },
        src: ['test/{,*/}*.js']
      }
    },

    // Empties folders to start fresh
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%= yeoman.dist %>/views/*',
            '<%= yeoman.dist %>/public/*',
            '!<%= yeoman.dist %>/public/.git*'
          ]
        }]
      },
      heroku: {
        files: [{
          dot: true,
          src: [
            'heroku/*',
            '!heroku/.git*',
            '!heroku/Procfile'
          ]
        }]
      },
      server: '.tmp'
    },

    // Add vendor prefixed styles
    autoprefixer: {
      options: {
        browsers: ['last 1 version']
      },
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '{,*/}*.css',
          dest: '.tmp/styles/'
        }]
      }
    },

    // Automatically inject Bower components into the app
    'bower-install': {
      app: {
        html: '<%= yeoman.app %>/views/index.html',
        ignorePath: '<%= yeoman.app %>/'
      }
    },

    // Compiles Sass to CSS and generates necessary files if requested
    compass: {
      options: {
        sassDir: '<%= yeoman.app %>/styles',
        cssDir: '.tmp/styles',
        generatedImagesDir: '.tmp/images/generated',
        imagesDir: '<%= yeoman.app %>/images',
        javascriptsDir: '<%= yeoman.app %>/scripts',
        fontsDir: '<%= yeoman.app %>/styles/fonts',
        importPath: '<%= yeoman.app %>/bower_components',
        httpImagesPath: '/images',
        httpGeneratedImagesPath: '/images/generated',
        httpFontsPath: '/styles/fonts',
        relativeAssets: false,
        assetCacheBuster: false,
        raw: 'Sass::Script::Number.precision = 10\n'
      },
      dist: {
        options: {
          generatedImagesDir: '<%= yeoman.dist %>/public/images/generated'
        }
      },
      server: {
        options: {
          debugInfo: true
        }
      }
    },

    // Renames files for browser caching purposes
    rev: {
      dist: {
        files: {
          src: [
            '<%= yeoman.dist %>/public/scripts/{,*/}*.js',
            '<%= yeoman.dist %>/public/styles/{,*/}*.css',
//            '<%= yeoman.dist %>/public/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}',
            '<%= yeoman.dist %>/public/styles/fonts/*'
          ]
        }
      }
    },

    // Reads HTML for usemin blocks to enable smart builds that automatically
    // concat, minify and revision files. Creates configurations in memory so
    // additional tasks can operate on them
    useminPrepare: {
      html: ['<%= yeoman.app %>/views/index.html',
             '<%= yeoman.app %>/views/index.jade'],
      options: {
        dest: '<%= yeoman.dist %>/public'
      }
    },

    // Performs rewrites based on rev and the useminPrepare configuration
    usemin: {
      html: ['<%= yeoman.dist %>/views/{,*/}*.html',
             '<%= yeoman.dist %>/views/{,*/}*.jade'],
      css: ['<%= yeoman.dist %>/styles/{,*/}*.css'],
      options: {
        assetsDirs: ['<%= yeoman.dist %>/public']
      }
    },

    // The following *-min tasks produce minified files in the dist folder
    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/images',
          src: '{,*/}*.{png,jpg,jpeg,gif}',
          dest: '<%= yeoman.dist %>/public/images'
        }]
      }
    },

    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/images',
          src: '{,*/}*.svg',
          dest: '<%= yeoman.dist %>/public/images'
        }]
      }
    },

    htmlmin: {
      dist: {
        options: {
          //collapseWhitespace: true,
          //collapseBooleanAttributes: true,
          //removeCommentsFromCDATA: true,
          //removeOptionalTags: true
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/views',
          src: ['*.html', 'partials/*.html'],
          dest: '<%= yeoman.dist %>/views'
        }]
      }
    },

    // Allow the use of non-minsafe AngularJS files. Automatically makes it
    // minsafe compatible so Uglify does not destroy the ng references
    ngmin: {
      dist: {
        files: [{
          expand: true,
          cwd: './app/scripts',
          src: './**/*.js',
          dest: './app/scripts'
        }]
      }
    },

    // Replace Google CDN references
    cdnify: {
      dist: {
        html: ['<%= yeoman.dist %>/views/*.html']
      }
    },

    // Copies remaining files to places other tasks can use
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>',
          dest: '<%= yeoman.dist %>/public',
          src: [
            '*.{ico,png,txt}',
            '.htaccess',
            'bower_components/**/*',
            'images/{,*/}*.{webp}',
            'fonts/**/*',
            'scripts/*.swf'
          ]
        }, {
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>/views',
          dest: '<%= yeoman.dist %>/views',
          src: '**/*.jade'
        }, {
          expand: true,
          cwd: '.tmp/images',
          dest: '<%= yeoman.dist %>/public/images',
          src: ['generated/*']
        }, {
          expand: true,
          cwd: 'app/styles',
          dest: '<%= yeoman.dist %>/public/styles',
          src: ['*.jpg', '*.gif', '*.png']
        }, {
          expand: true,
          dest: '<%= yeoman.dist %>',
          src: [
            'package.json',
            'server.js',
            'lib/**/*'
          ]
        }]
      },
      styles: {
        expand: true,
        cwd: '<%= yeoman.app %>/styles',
        dest: '.tmp/styles/',
        src: '{,*/}*.css'
      }
    },

    // Run some tasks in parallel to speed up the build process
    concurrent: {
      server: [
        'compass:server'
      ],
      test: [
        'compass'
      ],
      dist: [
        'compass:dist',
        'imagemin',
        'svgmin',
        'htmlmin'
      ],

        dev: {
            tasks: ['shell:nodemon', 'watch', 'open:dev'],
            options: {
                logConcurrentOutput: true
            }
        }
    },

    // By default, your `index.html`'s <!-- Usemin block --> will take care of
    // minification. These next options are pre-configured if you do not wish
    // to use the Usemin blocks.
    // cssmin: {
    //   dist: {
    //     files: {
    //       '<%= yeoman.dist %>/styles/main.css': [
    //         '.tmp/styles/{,*/}*.css',
    //         '<%= yeoman.app %>/styles/{,*/}*.css'
    //       ]
    //     }
    //   }
    // },
    // uglify: {
    //   dist: {
    //     files: {
    //       '<%= yeoman.dist %>/scripts/*.js': [
    //         '<%= yeoman.dist %>/scripts/*.js'
    //       ]
    //     }
    //   }
    // },
    // concat: {
    //   dist: {}
    // },

    // Test settings
    karma: {
        unit: {
            configFile: 'karma.conf.js',
            singleRun: true,
            autoWatch: false
        },
        continuous: {
            configFile: 'karma.conf.js',
            singleRun: false,
            background: true,
            autoWatch: false,
            browsers: ['PhantomJS']
        }
    }
  });

  grunt.registerTask('express-keepalive', 'Keep grunt running', function() {
    this.async();
  });

  grunt.registerTask('serve', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'express:prod', 'open', 'express-keepalive']);
    }

    grunt.task.run([
      'clean:server',
      'bower-install',
      'concurrent:server',
      'autoprefixer',
      'express:dev',
      'open',
      'watch'
    ]);
  });

  grunt.registerTask('server', function () {
    grunt.log.warn('The `server` task has been deprecated. Use `grunt serve` to start a server.');
    grunt.task.run(['serve']);
  });

  grunt.registerTask('test', [
    'clean:server',
    'concurrent:test',
    'autoprefixer',
    'karma',
    'mochaTest'
  ]);

    // On watch events configure mochaTest to run only on the test if it is one
    // otherwise, run the whole testsuite
    var defaultSimpleSrc = grunt.config('mochaTest.simple.src');
    grunt.event.on('watch', function(action, filepath) {
        grunt.config('mochaTest.simple.src', defaultSimpleSrc);
        if (filepath.match('test/server')) {
            grunt.config('mochaTest.simple.src', filepath);
        }
    });

  grunt.registerTask('test-watch', function(){
    grunt.option('force', true);
    grunt.task.run([
        'clean:server',
        'concurrent:server',
        'coffee',
        'autoprefixer',
//        'express:dev',
        'karma:continuous',
        'karma:continuous:run',
        'mochaTest',
        'concurrent:dev'
    ])
  });

  grunt.registerTask('build', [
    'clean:dist',
    'bower-install',
    'coffee',
    'ngmin',
    'useminPrepare',
    'concurrent:dist',
    'autoprefixer',
    'concat',
    'copy:dist',
    'cdnify',
    'cssmin',
    'uglify',
    'rev',
    'usemin'
  ]);

  grunt.registerTask('heroku', function () {
    grunt.log.warn('The `heroku` task has been deprecated. Use `grunt build` to build for deployment.');
    grunt.task.run(['build']);
  });

  grunt.registerTask('default', [
//    'newer:jshint',
//    'build',
      'test-watch'
  ]);
};
