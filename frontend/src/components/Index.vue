<template>
  <v-container>
    <v-row>
      <v-col>
        <!-- formular adaugare todo -->
        <v-card elevation="2" outlined rounded>
          <v-card-title>Add new todo</v-card-title>
          <v-card-text>
            <v-text-field
              v-model="newTitle"
              label="Title"
              hint="A short descriptive title for the new todo"
              persistent-hint>
              <template v-slot:prepend>
                <v-avatar tile size="24">
                  <v-img src="title.png" contain/>
                </v-avatar>
              </template>
            </v-text-field>
            <v-textarea
              v-model="newDescription"
              prepend-icon="mdi-text"
              label="Description"
              hint="More info for the new todo"
              auto-grow
              rows="3"
              persistent-hint>
              <template v-slot:prepend>
                <v-avatar tile size="24">
                  <v-img src="details.png" contain/>
                </v-avatar>
              </template>
            </v-textarea>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="error" text @click="cancelAdd">Cancel</v-btn>
            <v-btn
              color="primary"
              text
              @click="addTodo"
              :disabled="!newTitle || !newDescription">
              Add todo
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <!-- listare todos cu toggle completed, delete si add -->
        <v-card elevation="2" outlined rounded>
          <v-card-title>My todos</v-card-title>
          <v-card-text>
            <v-list dense>
              <template v-for="(todo, index) in todos">
                <v-list-item :key="todo.id + 'item'">
                  <v-list-item-action>
                    <v-btn icon @click="toggleTodo(todo.id)">
                      <v-img contain max-height="20" max-width="20" src="completed.png" v-if="todo.completed === '1'" />
                      <v-img contain max-height="20" max-width="20" src="not_completed.png" v-else />
                    </v-btn>
                  </v-list-item-action>
                  <v-list-item-content>
                    <v-list-item-title>{{ todo.title }}</v-list-item-title>
                    <v-list-item-subtitle>{{ todo.description }}</v-list-item-subtitle>
                  </v-list-item-content>
                  <v-list-item-action>
                    <div>
                      <v-btn icon @click="setEditTodo(todo)">
                        <v-img
                          contain
                          max-height="24"
                          max-width="24"
                          src="edit.png" />
                      </v-btn>
                      <v-btn icon @click="deleteTodo(todo.id)">
                        <v-img
                          contain
                          max-height="24"
                          max-width="24"
                          src="delete.png" />
                      </v-btn>
                    </div>
                  </v-list-item-action>
                </v-list-item>
                <v-divider
                  v-if="index < todos.length - 1"
                  :key="todo.id + 'divider'">
                </v-divider>
              </template>
            </v-list>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <v-dialog
      v-model="editDialog"
      max-width="80vw"
      persistent
      transition="dialog-bottom-transition">
      <v-card elevation="2" outlined rounded>
        <v-card-title>Edit todo</v-card-title>
        <v-card-text>
          <v-text-field
            v-model="oldTitle"
            label="Title"
            hint="A short descriptive title for the exiting todo"
            persistent-hint>
            <template v-slot:prepend>
              <v-avatar tile size="24">
                <v-img src="title.png" contain/>
              </v-avatar>
            </template>
          </v-text-field>
          <v-textarea
            v-model="oldDescription"
            prepend-icon="mdi-text"
            label="Description"
            hint="More info for the exiting todo"
            auto-grow
            rows="3"
            persistent-hint>
            <template v-slot:prepend>
              <v-avatar tile size="24">
                <v-img src="details.png" contain/>
              </v-avatar>
            </template>
          </v-textarea>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="error" text @click="cancelEdit">Cancel</v-btn>
          <v-btn
            color="primary"
            text
            @click="editTodo"
            :disabled="!oldTitle || !oldDescription">
            Edit todo
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  name: 'IndexComponent',

  data: () => ({
    todos: [],
    newTitle: null,
    newDescription: null,
    oldTitle: null,
    oldDescription: null,
    oldId: null,
    editDialog: false
  }),

  methods: {
    cancelAdd () {
      this.newTitle = null
      this.newDescription = null
    },
    cancelEdit () {
      this.oldTitle = null
      this.oldDescription = null
      this.oldId = null

      this.editDialog = false
    },

    async addTodo () {
      const session_id = this.getSessionId()
      if (session_id) {
        try {
          await axios.post(this.$backendUrl + 'add.php', {
            session_id,
            title: this.newTitle,
            description: this.newDescription
          })

          await this.readTodos()
          this.cancelAdd()
        } catch (err) {
          console.log(err)
        }
      }
    },

    setEditTodo (todo) {
      this.oldTitle = todo.title
      this.oldDescription = todo.description
      this.oldId = todo.id

      this.editDialog = true
    },
    async editTodo () {
      const session_id = this.getSessionId()
      if (session_id) {
        try {
          await axios.post(this.$backendUrl + 'edit.php', {
            session_id,
            title: this.oldTitle,
            description: this.oldDescription,
            id: this.oldId
          })

          await this.readTodos()
          this.cancelEdit()
        } catch (err) {
          console.log(err)
        }
      }
    },
    async readTodos () {
      const session_id = this.getSessionId()
      if (session_id) {
        try {
          const response = await axios.get(this.$backendUrl + 'readDb.php?session_id=' + session_id)
          this.todos = response.data
        } catch (err) {
          console.log(err)
        }
      }
    },
    async deleteTodo (id) {
      const session_id = this.getSessionId()
      if (session_id) {
        try {
          await axios.delete(this.$backendUrl + 'delete.php', {
            data: {
              session_id,
              id
            }
          })

          await this.readTodos()
        } catch (err) {
          console.log(err)
        }
      }
    },
    async toggleTodo (id) {
      const session_id = this.getSessionId()
      if (session_id) {
        try {
          await axios.patch(this.$backendUrl + 'toggleTodo.php', {
            session_id,
            id
          })

          await this.readTodos()
        } catch (err) {
          console.log(err)
        }
      }
    },

    getSessionId () {
      const phpauth = sessionStorage.getItem('phpauth')
      if (phpauth) {
        const { session_id } = JSON.parse(phpauth)

        return session_id
      }

      return false
    }
  },

  async mounted () {
    await this.readTodos()
  }
}
</script>
