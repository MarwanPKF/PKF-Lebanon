/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./**/*.{html,js}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui', '-apple-system', 'Segoe UI', 'Roboto', 'Arial', 'sans-serif'],
      },
      colors: {
        pkf: {
          blue: '#0B3C6D',
          'blue-dark': '#082744',
          'blue-light': '#1a5591',
          red: '#C8102E',
          gray: '#F4F6F8',
          text: '#1A1A1A',
        }
      }
    },
  },
  plugins: [],
}
