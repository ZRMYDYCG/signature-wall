<script setup lang="ts">
import { defineModel, defineProps } from 'vue'

defineProps<DialogProps>()

const emit = defineEmits(['confirm'])

const visible = defineModel('visible')

export interface DialogProps {
  title?: string
}

function handleClose() {
  visible.value = false
}

function handleConfirm() {
  emit('confirm')
  visible.value = false
}
</script>

<template>
  <div v-if="visible" class="fixed inset-0 z-50 flex items-center justify-center">
    <div class="relative flex h-[20em] w-[25em] flex-col items-center justify-start overflow-clip rounded-[1.5em] bg-[#B7DFFB] px-[1em] py-[1.5em] shadow-[0px_2px_2px_0px_#1a4766,0px_2px_8px_0px_#3083bb]">
      <!-- 头部区域 -->
      <div class="w-full text-center">
        <h3 class="text-center font-Poppin text-[1.2em] font-bold text-[#085991]">
          {{ title }}
        </h3>
      </div>

      <!-- 内容区域 -->
      <div class="flex-1 py-2 px-2 w-[85%] h-[45%] font-Poppin text-[1em] font-medium text-[#085991]">
        <slot />
      </div>

      <!-- 底部区域 -->
      <slot name="footer">
        <div class="group absolute bottom-[-1em] flex max-h-[6em] w-[20em] items-center justify-center gap-[11rem]">
          <button
            class="no relative cursor-pointer origin-bottom duration-300 hover:rotate-[-40deg] peer-has-[:checked]:rotate-[-160deg]"
            @click="handleClose"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="42"
              height="89"
              fill="none"
              viewBox="0 0 42 89"
              class="absolute bottom-0 right-1/2 h-[6rem] w-[6rem] origin-bottom translate-x-1/2 rotate-[-45deg] duration-300 hover:rotate-[-40deg]"
            >
              <path
                fill="#ED487E"
                d="M21.481.49h-.48a3.35 3.35 0 0 0-3.35 3.35V85.1c0 1.85 1.5 3.35 3.35 3.35h.48c1.85 0 3.35-1.5 3.35-3.35V3.84c0-1.85-1.5-3.35-3.35-3.35Z"
              />
              <path
                fill="#FC932D"
                d="M23.131 45.03c10.118 0 18.32-8.202 18.32-18.32S33.25 8.39 23.132 8.39c-10.117 0-18.32 8.202-18.32 18.32s8.203 18.32 18.32 18.32Z"
              />
              <path
                fill="#FDD259"
                d="M18.801 45.03c10.118 0 18.32-8.202 18.32-18.32S28.92 8.39 18.801 8.39C8.684 8.39.481 16.592.481 26.71s8.203 18.32 18.32 18.32Z"
              />
              <path
                fill="#000"
                d="M16.431 33.05a1.4 1.4 0 0 1-1.1-.52l-4.34-5.29v4.38a1.44 1.44 0 0 1-2.87 0v-8.37a1.44 1.44 0 0 1 1-1.35 1.42 1.42 0 0 1 1.59.44l4.28 5.28v-4.66a1.44 1.44 0 1 1 2.87 0v8.66a1.44 1.44 0 0 1-1 1.35 1.62 1.62 0 0 1-.43.08Zm8.221-.39a5.3 5.3 0 1 1 5.3-5.3 5.31 5.31 0 0 1-5.3 5.3Zm0-7.73a2.43 2.43 0 1 0 .019 4.859 2.43 2.43 0 0 0-.02-4.859Z"
              />
            </svg>
          </button>

          <button
            class="yes relative cursor-pointer"
            @click="handleConfirm"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="43"
              height="90"
              fill="none"
              viewBox="0 0 43 90"
              class="absolute bottom-0 left-1/2 h-[6rem] w-[6rem] origin-bottom -translate-x-1/2 rotate-[45deg] duration-300 hover:rotate-[40deg]"
            >
              <path
                fill="#1269EF"
                d="M24.87 4.21a3.52 3.52 0 0 0-7.04 0v80.96a3.52 3.52 0 1 0 7.04 0V4.21Z"
              />
              <path
                fill="#231F20"
                d="M21.35 89.34a4.17 4.17 0 0 1-4.17-4.17v-81a4.17 4.17 0 1 1 8.34 0v81a4.17 4.17 0 0 1-4.17 4.17Zm0-88a2.88 2.88 0 0 0-2.87 2.87v81a2.87 2.87 0 0 0 5.74 0v-81a2.88 2.88 0 0 0-2.87-2.87Z"
              />
              <path
                fill="#000"
                d="M21.35 44.69c11.427 0 20.69-8.117 20.69-18.13 0-10.013-9.263-18.13-20.69-18.13C9.923 8.43.66 16.547.66 26.56c0 10.013 9.263 18.13 20.69 18.13Z"
              />
              <path
                fill="#231F20"
                d="M21.35 45.34C9.58 45.34 0 36.92 0 26.56 0 16.2 9.58 7.78 21.35 7.78c11.77 0 21.34 8.42 21.34 18.78 0 10.36-9.57 18.78-21.34 18.78Zm0-36.26c-11 0-20 7.84-20 17.48s9 17.48 20 17.48 20-7.84 20-17.48-8.95-17.48-20-17.48Z"
              />
              <path fill="#ED487E" d="M.66 26.56v-4.99h41.38v3.92L.66 26.56Z" />
              <path
                fill="#231F20"
                d="M0 27.23v-6.31h42.69v5.21L0 27.23Zm1.31-5v3.66l40.08-1v-2.67l-40.08.01Z"
              />
              <path
                fill="#ED487E"
                d="M21.35 40.6c11.427 0 20.69-8.117 20.69-18.13 0-10.013-9.263-18.13-20.69-18.13C9.923 4.34.66 12.457.66 22.47c0 10.013 9.263 18.13 20.69 18.13Z"
              />
              <path
                fill="#231F20"
                d="M21.35 41.26C9.58 41.26 0 32.83 0 22.47S9.58 3.69 21.35 3.69c11.77 0 21.34 8.43 21.34 18.78 0 10.35-9.57 18.79-21.34 18.79Zm0-36.26c-11 0-20 7.84-20 17.47 0 9.63 9 17.48 20 17.48s20-7.84 20-17.48S32.4 5 21.35 5Z"
              />
              <path
                fill="#fff"
                d="M9.76 27.76v-4.28l-3.73-5.9h2.41l2.4 4 2.34-4h2.37l-3.74 5.91v4.27H9.76Zm7.59 0V17.58h7.55v1.72h-5.5v2.26h5.11v1.71H19.4v2.78h5.69v1.71h-7.74Zm9.941-3.31 2-.2a2.44 2.44 0 0 0 .73 1.44 2.21 2.21 0 0 0 1.49.48 2.28 2.28 0 0 0 1.5-.42 1.25 1.25 0 0 0 .51-1 .93.93 0 0 0-.17-.56 1.59 1.59 0 0 0-.74-.44c-.24-.09-.79-.23-1.64-.45a5.64 5.64 0 0 1-2.32-1 2.68 2.68 0 0 1-.5-3.51 2.79 2.79 0 0 1 1.27-1 5.061 5.061 0 0 1 2-.35 4.29 4.29 0 0 1 2.88.84 2.929 2.929 0 0 1 1 2.24l-2.06.09a1.72 1.72 0 0 0-.56-1.13 2.08 2.08 0 0 0-1.3-.34 2.34 2.34 0 0 0-1.41.37.71.71 0 0 0-.32.63.8.8 0 0 0 .3.62 5.679 5.679 0 0 0 1.89.68c.766.154 1.512.4 2.22.73a3 3 0 0 1 1.13 1 3.06 3.06 0 0 1-1.46 4.4 5.719 5.719 0 0 1-2.22.37 4.38 4.38 0 0 1-3-.89 3.89 3.89 0 0 1-1.22-2.6Z"
              />
            </svg>
          </button>
        </div>
      </slot>
    </div>
  </div>
</template>
