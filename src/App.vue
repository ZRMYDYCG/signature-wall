<script setup>
import { onMounted, ref } from 'vue'

import { supabase } from '../supabase/index.ts'

const books = ref([])

async function getBooks() {
  const { data } = await supabase.from('book').select()

  books.value = data
}

onMounted(() => {
  getBooks()
})
</script>

<template>
  <ul>
    <li v-for="book in books" :key="book.id">
      {{ book.name }} （编号:{{ book.id }}，价格:{{ book.price }}）
    </li>
  </ul>
</template>
