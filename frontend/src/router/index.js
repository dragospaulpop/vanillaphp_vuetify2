import Vue from 'vue'
import VueRouter from 'vue-router'
import IndexView from '../views/IndexView.vue'
import LoginView from '../views/LoginView.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'index',
    component: IndexView,
    meta: { requiresLogin: true }
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView,
    meta: { requiresLogin: false }
  }
  // {
  //   path: '/about',
  //   name: 'about',
  //   // route level code-splitting
  //   // this generates a separate chunk (about.[hash].js) for this route
  //   // which is lazy-loaded when the route is visited.
  //   component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  // }
]

const router = new VueRouter({
  routes
})

router.beforeEach((to, from, next) => {
  const { requiresLogin } = to.meta

  const auth = sessionStorage.getItem('phpauth')

  const authenticated = !!auth

  if (requiresLogin && !authenticated) {
    next({ name: 'login' })
  } else {
    next()
  }
})

export default router
