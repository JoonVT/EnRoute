var jspaths = ['_js/classes/*.js','_js/model/*.js','_js/router/*.js','_js/collection/*.js','_js/view/*.js','_js/app.js'];
var csspaths = ["_scss/*.scss"];
var templatepaths = ["_hbs/*.hbs"];

var concatpaths = ['_js/templates.js'].concat(jspaths);

module.exports = function(grunt) {

  grunt.initConfig({

    concat: {
      options: {
        banner: "(function(){\n\n",
        footer: "\n\n})();",
        separator: '\n\n'
      },
      dist: {
        src: concatpaths,
        dest: 'js/app.js'
      }
    },

    watch: {
      js:{
        files: jspaths,
        tasks: ['jshint','handlebars','concat','clean']
      },
      scss:{
        files: csspaths,
        tasks:['compass:development']
      },
      hbs:{
        files: templatepaths,
        tasks: ['handlebars','concat','clean']
      }
    },

    uglify: {
      default: {
        options: {
          wrap: true
        },
        files: {
          'js/app.js': concatpaths
        }
      }
    },

    compass: {
      development: { 
        options: {
          sassDir: '_scss',
          cssDir: 'css',
          environment: 'development',
          force: true
        }
      },
      production: { 
        options: {
          sassDir: '_scss',
          cssDir: 'css',
          environment: 'production',
          outputStyle: 'compressed',
          force: true
        }
      }
    },

    handlebars: {
      compile: {
        options: {
          namespace: "tpl",
          processName: function(filePath) {
            var pieces = filePath.split("/");
            return pieces[pieces.length - 1].split(".")[0];
          },
          partialsUseNamespace: true
        },
        files: {
          "_js/templates.js": templatepaths
        }
      }
    },

    jshint:{
      default:{
        options: {
          curly: true,
          eqeqeq: true,
          immed: true,
          latedef: true,
          newcap: true,
          noarg: true,
          sub: true,
          undef: true,
          eqnull: true,
          browser: true,
          noempty: true,
          trailing: true,
          globals:{
              Backbone: true,
              $: true,
              console:true,
              Handlebars: true,
              tpl: true,
              moment: true,
              _:true
          },
        },
        files:{
          src: jspaths
        }
      }
    },

    clean: ["_js/templates.js"],

  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-handlebars');
  grunt.loadNpmTasks('grunt-contrib-jshint');

  grunt.registerTask('default', ['jshint','handlebars','concat','compass:development','clean','watch']);
  grunt.registerTask('production', ['jshint','handlebars','uglify','compass:production','clean']);

};