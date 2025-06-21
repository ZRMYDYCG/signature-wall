<script setup lang="ts">
import type { PaginationResponse } from '@/server/types/index'
import { onMounted, ref } from 'vue'
import BookContainer from '@/components/ui/BookContainer.vue'
import PageHelper from '@/components/ui/PageHelper.vue'
import { paginationSearch } from '@/server/index'

// 分页状态管理
const currentPage = ref(1)
const perPage = ref(10)
const total = ref(0)
const books = ref<any[]>([])
const loading = ref(false)
const errorMsg = ref('')

// 获取分页数据
async function fetchPaginationData() {
  loading.value = true
  try {
    const response: PaginationResponse<any> = await paginationSearch(currentPage.value, perPage.value)
    if (response.success) {
      books.value = response.data
      total.value = response.meta.total
    }
    else {
      errorMsg.value = response.error || '获取分页数据失败'
    }
  }
  catch (err) {
    errorMsg.value = '网络请求异常，请稍后重试'
    console.error('分页请求错误:', err)
  }
  finally {
    loading.value = false
  }
}

// 处理页码变化
function handlePageChange(page: number) {
  currentPage.value = page
  fetchPaginationData()
}

onMounted(() => {
  fetchPaginationData()
})
</script>

<template>
  <div class="page-container max-w-3xl mx-auto p-4">
    <!-- 书籍列表展示 -->
    <BookContainer
      :books="books"
      :loading="loading"
      :error-msg="errorMsg"
    />

    <!-- 分页控件 (只有在有数据且无错误时显示) -->
    <PageHelper
      v-if="!loading && !errorMsg && total > 0"
      :current-page="currentPage"
      :per-page="perPage"
      :total="total"
      @page-change="handlePageChange"
    />
  </div>
</template>
