const mix = require('laravel-mix');

mix.js('src/app.js', 'dist')
   .copy('src/app.css', 'dist')
   .copy('src/index.html', 'dist')
   .copyDirectory('src/img', 'dist/img')
   .setPublicPath('dist');
