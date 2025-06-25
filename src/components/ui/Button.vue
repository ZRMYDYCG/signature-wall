<script setup lang="ts">
import SvgIcon from './SvgIcon.vue'

interface ButtonProps {
  debounce?: boolean
  debounceTime?: number
}

const props = withDefaults(defineProps<ButtonProps>(), {
  debounce: false,
  debounceTime: 300,
})
const emits = defineEmits(['click'])

function debounce(fn: any, delay: number) {
  let timer: number | null = null
  return (...args: any[]) => {
    if (timer)
      clearTimeout(timer)
    timer = window.setTimeout(() => {
      fn(...args)
    }, delay)
  }
}

const handleClick = props.debounce
  ? debounce((e: MouseEvent) => emits('click', e), props.debounceTime)
  : (e: MouseEvent) => emits('click', e)
</script>

<template>
  <button
    class="group cursor-pointer relative dark:bg-neutral-800 bg-neutral-200 rounded-full p-px overflow-hidden"
    @click="handleClick"
  >
    <span class="absolute inset-0 rounded-full overflow-hidden">
      <span class="inset-0 absolute pointer-events-none select-none">
        <span
          class="block -translate-x-1/2 -translate-y-1/3 size-24 blur-xl"
          style="background: linear-gradient(135deg, rgb(122, 105, 249), rgb(242, 99, 120), rgb(245, 131, 63));"
        />
      </span>
    </span>

    <span
      class="inset-0 absolute pointer-events-none select-none"
      style="animation: 10s ease-in-out 0s infinite alternate none running border-glow-translate;"
    >
      <span
        class="block z-0 h-full w-12 blur-xl -translate-x-1/2 rounded-full"
        style="animation: 10s ease-in-out 0s infinite alternate none running border-glow-scale;
             background: linear-gradient(135deg, rgb(122, 105, 249), rgb(242, 99, 120), rgb(245, 131, 63));"
      />
    </span>

    <span
      class="flex items-center justify-center gap-1 relative z-[1] dark:bg-neutral-950/90 bg-neutral-50/90 rounded-full py-2 px-4 pl-2 w-full"
    >
      <span
        class="relative group-hover:scale-105 transition-transform group-hover:rotate-[360deg] duration-500"
      >
        <SvgIcon name="button-star" />
        <span
          class="rounded-full size-11 absolute opacity-0 dark:opacity-30 top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 blur-lg"
          style="animation: 14s ease-in-out 0s infinite alternate none running star-shine;
               background: linear-gradient(135deg, rgb(59, 196, 242), rgb(122, 105, 249), rgb(242, 99, 120), rgb(245, 131, 63));"
        />
      </span>
      <span
        class="bg-gradient-to-b ml-1.5 dark:from-white dark:to-white/50 from-neutral-950 to-neutral-950/50 bg-clip-text text-xs text-transparent group-hover:scale-105 transition transform-gpu"
      >
        <slot />
      </span>
    </span>
  </button>
</template>

<style scoped>

</style>
