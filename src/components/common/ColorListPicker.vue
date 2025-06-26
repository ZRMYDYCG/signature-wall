<script setup lang="ts">
import { defineProps, ref } from 'vue'

export interface ColorListPickerProps {
  colors: string[]
}

defineProps<ColorListPickerProps>()

const selectedColor = ref<string | null>(null)

function handleColorSelect(color: string) {
  selectedColor.value = color
}
</script>

<template>
  <div class="p-2">
    <div class="flex flex-wrap gap-2">
      <div
        v-for="(color, index) in colors"
        :key="index"
        class="w-9 h-9 rounded cursor-pointer transition-transform duration-200 hover:scale-105"
        :style="{ background: color }"
        :class="{ 'ring-2 ring-black ring-offset-2': selectedColor === color }"
        :title="color"
        @click="handleColorSelect(color)"
      />
    </div>
  </div>
</template>
