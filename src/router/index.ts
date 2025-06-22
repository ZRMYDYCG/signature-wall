import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'
import Layout from '@/layout/index.vue'
import Home from '@/pages/home/index.vue'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: Layout,
    children: [
      {
        path: '',
        name: 'home',
        component: Home,
      },
    ],
  },
]

// 创建路由实例
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
  // 配置滚动行为
  scrollBehavior() {
    return { top: 0, behavior: 'smooth' }
  },
})

// 全局前置守卫
router.beforeEach((to) => {
  document.title = to.meta.title as string || 'Signature'
})

export default router
