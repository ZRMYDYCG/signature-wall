<script setup lang="ts">
import { computed } from 'vue'
import { userAvatar } from '@/config'

const props = defineProps({
  size: {
    type: Number,
    default: 40,
  },
  color: {
    type: [String, Number],
    default: null,
  },
  shape: {
    type: String as () => 'circle' | 'square',
    default: 'circle',
  },
})

const colorProp = computed(() => {
  if (props.color) {
    return typeof props.color === 'number'
      ? userAvatar[props.color]
      : props.color
  }

  return userAvatar[Math.floor(Math.random() * userAvatar.length)]
})
</script>

<template>
  <div
    class="avatar"
    :style="{
      background: colorProp,
      width: `${size}px`,
      height: `${size}px`,
      borderRadius: shape === 'circle' ? '50%' : '4px',
    }"
  />
</template>

<style scoped>
.avatar {
  display: inline-block;
  transition: transform 0.2s ease;
  cursor: pointer;

  &:hover {
    transform: scale(1.1);
  }
}
</style>
