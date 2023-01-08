<template>
  <v-dialog v-model="visible"
    max-width="80vw"
    persistent>
    <v-card>
      <v-card-title class="flex-nowrap">
        <span class="d-inline-block text-truncate text-no-wrap">
          {{ options.title }}
        </span>
        <v-spacer></v-spacer>
        <v-btn icon @click="close('cancel')">
          <v-icon color="secondary">mdi-close</v-icon>
        </v-btn>
      </v-card-title>
      <v-card-text>
        <v-alert :type="options.type"  border="left" text v-if="options.content">{{ options.content }}</v-alert>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn text color="secondary" @click="close('cancel')">{{ options.cancelText }}</v-btn>
        <v-btn text color="primary" @click="close('ok')">{{ options.okText }}</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  name: 'PromptComponent',

  data: () => ({
    visible: false,
    ok: null,
    cancel: null,

    options: {
      type: 'info',
      title: 'Dialog title',
      content: null,
      okText: 'Ok',
      cancelText: 'Cancel'
    }
  }),

  methods: {
    async show (options) {
      this.options = Object.assign(this.options, options)

      this.visible = true

      return new Promise((resolve, reject) => {
        this.ok = resolve
        this.cancel = reject
      })
    },
    close (callback) {
      this.visible = false

      this[callback]()
    }
  }
}
</script>
