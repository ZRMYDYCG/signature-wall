import { createApp } from 'vue'
import App from './App.vue'
import '~/css/tailwind.css'

/**
 * 应用启动
 */
function bootstrap() {
  const app = createApp(App)

  app.mount('#app')

  return app
}

bootstrap()
