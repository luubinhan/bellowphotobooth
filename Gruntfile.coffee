module.exports = (grunt) ->
  grunt.initConfig
    serverConf: grunt.file.readJSON("server.json")
    partialPath: 'src/partials/'
    watch:
      options:
        livereload: true
      html:
        files: ['src/**/*.html']
        tasks: ['htmlbuild:main']
      css:
        files: ['docs/*.css']
      scripts:
        files: ['docs/*.js']        
    htmlbuild:
      options:            
        sections:
          the_header: '<%= partialPath %>header.html'
          the_footer: '<%= partialPath %>footer.html'
          the_gallery: '<%= partialPath %>gallery.html'
        data:
          version: '<%= grunt.template.today("yyyymmddHH") %>'
        relative: true
        beautify: true
      main:
        dest: 'docs/'
        src: ['**/*.html','!partials/*.html']
        expand: true
        cwd: 'src'
    clean:
      build: ['docs/*.html','!css/**','!js/**']    
      options:
        force: true
    copy:
      build:
        dest: 'docs/'
        src: ['**', '!data.json']
        expand: true
        cwd: 'docs/'
    connect:
      server:
        options:
          base: 'docs'
          hostname: '<%= serverConf.hostname %>'
          port: '<%= serverConf.port %>'
          livereload: true

  require('load-grunt-tasks')(grunt)
  grunt.registerTask 'default', ['connect', 'watch']
  grunt.registerTask 'build', ['clean:build', 'copy:build']
