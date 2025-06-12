<template>
  <div>
    <button>Change Message</button>
  </div>
</template>  

<script setup lang="ts">
  import { ref } from 'vue'
  const message = ref('Hello Vue 3!')
</script>   

<style scoped>
</style>