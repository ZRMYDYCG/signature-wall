<script setup lang="ts">
defineProps({
  mood: {
    type: String as () => 'happy' | 'calm' | 'sad' | 'angry' | 'neutral',
    default: 'neutral',
  },
})
</script>

<template>
  <div
    class="card text-gray-600 hover:brightness-95 transition-all cursor-pointer group border border-gray-200 m-4 rounded-lg overflow-hidden relative"
    :class="{
      'bg-gradient-to-tr from-blue-100 to-indigo-50': mood === 'happy',
      'bg-gradient-to-br from-green-100 to-teal-50': mood === 'calm',
      'bg-gradient-to-tl from-purple-100 to-pink-50': mood === 'sad',
      'bg-gradient-to-bl from-red-100 to-orange-50': mood === 'angry',
      'bg-gradient-to-tl from-gray-100 to-gray-50': mood === 'neutral',
    }"
  >
    <div class="px-8 py-10">
      <div class="bg-amber-400 w-10 h-10 rounded-full rounded-tl-none mb-4 group-hover:-translate-y-1 group-hover:shadow-lg group-hover:shadow-amber-100 transition-all" />
      <div class="text-gray-500 uppercase tracking-widest font-medium">
        再等等，再找找。
      </div>
      <div class="text-gray-400 mt-8">
        <p class="font-bold">
          一勺
        </p>
        <p>2025-06-25</p>
      </div>
    </div>

    <div class="h-2 w-full bg-gradient-to-l via-amber-200 group-hover:blur-xl blur-2xl m-auto rounded transition-all absolute bottom-0 opacity-50" />
    <div class="h-0.5 group-hover:w-full bg-gradient-to-l via-amber-100 group-hover:via-amber-300 w-[70%] m-auto rounded transition-all" />
  </div>
</template>

<style scoped>
.card {
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.card:hover {
  box-shadow: 0 12px 48px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}
</style>
