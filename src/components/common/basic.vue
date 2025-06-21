<script setup lang="ts">
import { onMounted, ref } from 'vue'
import BookContainer from '@/components/ui/BookContainer.vue'
import { basicSearch } from '@/server/index'

const books = ref<any>([])
const errorMsg = ref('')
const loading = ref(false)

async function fetchBooks() {
  loading.value = true
  try {
    const response = await basicSearch()
    if (response.success) {
      books.value = response.data
    }
    else {
      errorMsg.value = response.error || '获取书籍失败'
    }
  }
  catch (err) {
    errorMsg.value = '网络请求异常，请稍后重试'
    console.error('请求错误:', err)
  }
  finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchBooks()
})
</script>

<template>
  <div class="page-container">
    <BookContainer
      :books="books"
      :loading="loading"
      :error-msg="errorMsg"
    />
  </div>
</template>
