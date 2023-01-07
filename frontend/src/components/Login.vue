<template>
  <v-container fill-height>
    <v-row>
      <v-col>
        <v-card max-width="400px" class="mx-auto">
          <v-card-title>Authentication</v-card-title>
          <v-card-text>
            <v-text-field
              v-model="username"
              label="Username"
              hint="Your username"
              persistent-hint>
              <template v-slot:prepend>
                <v-avatar tile size="24">
                  <v-img src="user.png" contain/>
                </v-avatar>
              </template>
            </v-text-field>
            <v-text-field
              type="password"
              v-model="password"
              label="Password"
              hint="Your password"
              persistent-hint>
              <template v-slot:prepend>
                <v-avatar tile size="24">
                  <v-img src="lock.png" contain/>
                </v-avatar>
              </template>
            </v-text-field>

            <v-alert type="error" v-if="error" class="mt-2" border="left" text>
              {{ error }}
            </v-alert>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              color="primary"
              text
              :disabled="!username || !password"
              @click="login">
              Login
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  name: 'LoginComponent',

  data: () => ({
    username: null,
    password: null,
    error: null
  }),

  methods: {
    async login () {
      try {
        // responds with session_id, username and id_user
        const response = await axios.post(this.$backendUrl + 'login.php', {
          user: this.username,
          pass: this.password
        })

        sessionStorage.setItem('phpauth', JSON.stringify(response.data))

        this.$router.push({ name: 'index' })
      } catch (err) {
        const { data, status } = err.response

        if (status === 401) {
          this.error = data.msg
        } else {
          this.error = 'yeah... idk... something went wrong'
        }
      }
    }
  }
}
</script>
