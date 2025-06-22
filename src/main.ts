import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import '~/css/tailwind.css'
// SVG插件配置
import 'virtual:svg-icons-register'

/**
 * 应用启动
 */
function bootstrap() {
  const app = createApp(App)

  // 安装路由
  app.use(router)

  app.mount('#app')

  return app
}

bootstrap()
