<template>
  <v-container>
    <v-row>
      <v-col>
        <!-- formular adaugare todo -->
        <v-card elevation="2" outlined rounded>
          <v-card-title>
            <span>Add new todo</span>
            <v-spacer></v-spacer>
            <v-btn icon @click="toggleCollapseAdd">
              <v-icon color="secondary">
                {{ collapsedAdd ? 'mdi-unfold-more-horizontal' : 'mdi-unfold-less-horizontal' }}
              </v-icon>
            </v-btn>
          </v-card-title>
          <div class="grid-auto-height-transition-hack" :class="{ 'expanded': !collapsedAdd }">
            <div class="grid-content">
              <v-divider></v-divider>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col>
                      <v-text-field
                        v-model="newTitle"
                        label="Title"
                        hint="A short descriptive title for the new todo"
                        persistent-hint>
                        <template v-slot:prepend>
                          <v-avatar tile size="32">
                            <v-img src="title.png" contain/>
                          </v-avatar>
                        </template>
                      </v-text-field>
                    </v-col>
                  </v-row>
                  <v-row>
                    <v-col>
                      <v-textarea
                        v-model="newDescription"
                        prepend-icon="mdi-text"
                        label="Description"
                        hint="More info for the new todo"
                        auto-grow
                        rows="3"
                        persistent-hint>
                        <template v-slot:prepend>
                          <v-avatar tile size="32">
                            <v-img src="details.png" contain/>
                          </v-avatar>
                        </template>
                      </v-textarea>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
              <v-divider></v-divider>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="secondary" text @click="cancelAdd">Cancel</v-btn>
                <v-btn
                  color="primary"
                  text
                  @click="addTodo"
                  :disabled="!newTitle || !newDescription">
                  Add todo
                </v-btn>
              </v-card-actions>
            </div>
          </div>
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <!-- listare todos cu toggle completed, delete si add -->
        <v-card elevation="2" outlined rounded>
          <v-card-title>My todos</v-card-title>
          <v-divider></v-divider>
          <v-card-text>
            <v-list dense>
              <v-list-item-group :value="completedTodos" active-class="secondary--text" multiple>
                <template v-for="(todo, index) in todos">
                  <v-list-item :key="todo.id + 'item'" :value="todo.id" @click="toggleTodo(todo.id)">
                    <v-list-item-avatar>
                      <v-avatar tile size="32">
                        <v-img contain src="completed.png" v-if="todo.completed === '1'" />
                        <v-img contain src="not_completed.png" v-else />
                      </v-avatar>
                    </v-list-item-avatar>
                    <v-list-item-content :class="{ 'text-decoration-line-through': todo.completed === '1' }">
                      <v-list-item-title :class="{ 'text--primary': todo.completed ==='0', 'text--disabled': todo.completed ==='1' }">{{ todo.title }}</v-list-item-title>
                      <v-list-item-title :class="{ 'text--secondary': todo.completed ==='0', 'text--disabled': todo.completed ==='1' }">{{ todo.description }}</v-list-item-title>
                    </v-list-item-content>
                    <v-list-item-action>
                      <div>
                        <v-btn icon @click.stop="setEditTodo(todo)">
                          <v-img
                            contain
                            max-height="32"
                            max-width="32"
                            src="edit.png" />
                        </v-btn>
                        <v-btn icon @click.stop="deleteTodo(todo.id)">
                          <v-img
                            contain
                            max-height="32"
                            max-width="32"
                            src="delete.png" />
                        </v-btn>
                      </div>
                    </v-list-item-action>
                  </v-list-item>
                  <v-divider :key="todo.id + 'divider'" v-if="index < todos.length - 1">
                  </v-divider>
                </template>
              </v-list-item-group>
            </v-list>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-progress-linear v-if="generating" height="35" :value="(generated * 100 / generateTotal).toFixed(0)" dark>
              {{ generated }} / {{ generateTotal }}
            </v-progress-linear>
            <v-spacer></v-spacer>
            <v-btn text color="secondary" @click="deleteAll">
              Delete all
            </v-btn>
            <v-btn text color="primary" @click="random">
              Generate random todos
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>

    <v-dialog
      v-model="editDialog"
      max-width="80vw"
      persistent>
      <v-card elevation="2" outlined rounded>
        <v-card-title>
          <span>Edit todo</span>
          <v-spacer></v-spacer>
          <v-btn icon @click="cancelEdit">
            <v-icon color="secondary">mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-divider></v-divider>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col>
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
              </v-col>
            </v-row>
            <v-row>
              <v-col>
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
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="secondary" text @click="cancelEdit">Cancel</v-btn>
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
    <prompt ref="prompt" />
  </v-container>
</template>

<script>
import axios from 'axios'
import Prompt from '@/components/Prompt'
import { faker } from '@faker-js/faker'

export default {
  name: 'IndexComponent',

  components: {
    Prompt
  },

  data: () => ({
    todos: [],
    newTitle: null,
    newDescription: null,
    oldTitle: null,
    oldDescription: null,
    oldId: null,
    editDialog: false,
    collapsedAdd: true,

    generating: false,
    generateTotal: 0,
    generated: 0
  }),

  computed: {
    completedTodos () {
      return this.todos.filter(todo => todo.completed === '1').map(todo => todo.id)
    }
  },

  methods: {
    async random () {
      const noTodos = faker.datatype.number({ min: 1, max: 20 })
      this.generateTotal = noTodos

      const session_id = this.getSessionId()
      if (session_id) {
        this.generating = true
        for (let i = 0; i < noTodos; i++) {
          try {
            this.generated = i
            const noTitle = faker.datatype.number({ min: 1, max: 15 })
            const noDescription = faker.datatype.number({ min: 1, max: 15 })
            const title = faker.lorem.words(noTitle)
            const description = faker.lorem.words(noDescription)

            await axios.post(this.$backendUrl + 'add.php', {
              session_id,
              title,
              description
            })

            await this.readTodos()

            await sleep(500)
          } catch (err) {
            console.log(err)
          }
        }
        this.generating = false
      }
    },
    async deleteAll () {
      for (const todo of this.todos) {
        await this.deleteTodo(todo.id, false)
        await sleep(250)
      }
    },
    toggleCollapseAdd () {
      this.collapsedAdd = !this.collapsedAdd
    },
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
    async deleteTodo (id, prompt = true) {
      try {
        if (prompt) {
          await this.$refs.prompt.show({
            type: 'warning',
            title: 'Do you really wanna delete that todo?',
            content: 'This action is irreversible!'
          })
        }

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
      } catch (err) {
        console.log(err, 'delete canceled')
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

function sleep (howLong) {
  return new Promise(resolve => {
    setTimeout(resolve, howLong)
  })
}
</script>

<style lang="stylus">
.grid-auto-height-transition-hack {
  display: grid;
  grid-template-rows: 0fr;
  overflow: hidden;
  transition: grid-template-rows 1s;
}
.grid-content {
  min-height: 0;
  transition: visibility 1s;
  visibility: hidden;
}
.grid-auto-height-transition-hack.expanded {
  grid-template-rows: 1fr;
}
.grid-auto-height-transition-hack.expanded .grid-content {
  visibility: visible;
}
</style>
