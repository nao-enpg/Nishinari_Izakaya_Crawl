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
        ud: ['BIZ UDPGothic', 'Open Sans']
      }
    }
  },
  plugins: [
    require('daisyui')
  ],
}