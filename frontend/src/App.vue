<template>
  <v-app>
    <v-app-bar app color="primary" dark>
      <v-avatar tile>
        <v-img src="logo.png"></v-img>
      </v-avatar>
      <v-spacer></v-spacer>
      <v-toolbar-title>TODOs</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn text @click="logout" v-if="isLoggedIn()">
        {{ isLoggedIn() }}
        <v-icon right>mdi-logout</v-icon>
      </v-btn>
    </v-app-bar>

    <v-main>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  methods: {
    logout () {
      sessionStorage.removeItem('phpauth')
      if (this.$router.currentRoute.name !== 'login') {
        this.$router.push({ name: 'login' })
      }
    },
    isLoggedIn () {
      const phpauth = sessionStorage.getItem('phpauth')
      if (phpauth) {
        const { username } = JSON.parse(phpauth)
        return username
      }
      return false
    }
  }
}
</script>
