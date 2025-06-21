<script setup lang="ts">
import { defineProps } from 'vue'

interface Book {
  id: number
  name: string
  price: number
}

defineProps<{
  /** 书籍列表数据 */
  books: Book[]
  /** 加载状态 */
  loading: boolean
  /** 错误信息 */
  errorMsg: string
}>()
</script>

<template>
  <div class="book-container max-w-3xl mx-auto my-8 border border-gray-200 rounded-lg shadow-sm bg-white overflow-hidden">
    <!-- 加载状态 -->
    <div v-if="loading" class="flex items-center justify-center min-h-[300px] p-8 text-gray-600">
      <div class="w-6 h-6 border-2 border-gray-300 border-t-blue-500 rounded-full animate-spin mr-2" />
      <span class="text-sm font-medium">加载中...</span>
    </div>

    <!-- 错误提示 -->
    <div v-else-if="errorMsg" class="p-6 bg-red-50 text-red-600 border border-red-100 rounded-md">
      <p class="flex items-center">
        <span class="mr-2">⚠️</span> {{ errorMsg }}
      </p>
    </div>

    <!-- 书籍列表 -->
    <div v-else class="p-6">
      <ul class="divide-y divide-gray-100">
        <li v-for="book in books" :key="book.id" class="py-3 px-2 hover:bg-gray-50 rounded-md transition-colors">
          <div class="flex justify-between items-center">
            <span class="font-medium">{{ book.name }}</span>
            <span class="text-gray-500 text-sm">编号:{{ book.id }}，价格:{{ book.price }}元</span>
          </div>
        </li>
        <!-- 空状态 -->
        <li v-if="books.length === 0" class="py-12 text-center text-gray-400">
          <div class="mb-2 text-4xl">
            📚
          </div>
          <p>暂无书籍数据</p>
        </li>
      </ul>
    </div>
  </div>
</template>
