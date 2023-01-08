import Vue from 'vue'
import Vuetify from 'vuetify/lib/framework'

Vue.use(Vuetify)

export default new Vuetify({
  theme: {
    options: {
      customProperties: true
    },
    themes: {
      light: {
        primary: '#b543b1',
        secondary: '#054ea6',
        accent: '#9ceef3',
        error: '#B71C1C',
        info: '#03A9F4',
        success: '#4CAF50',
        warning: '#FF5722'
      }
    }
  }
})
