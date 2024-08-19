module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        ud: ['Noto Sans JP', 'Open Sans']
      }
    }
  },
  plugins: [
    require('daisyui')
  ],
}