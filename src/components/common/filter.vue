<script setup lang="ts">
import type { PaginationResponse } from '../../server/types/index'
import { reactive, ref, watch } from 'vue'
import { filterSearch } from '../../server/modules/filter'
import BookContainer from '../ui/BookContainer.vue'
import PageHelper from '../ui/PageHelper.vue'
import Search from '../ui/Search.vue'

// 搜索和过滤条件
const searchKeyword = ref('')
const filterForm = reactive({
  minPrice: undefined as number | undefined,
  maxPrice: undefined as number | undefined,
})

// 分页状态
const pagination = reactive({
  currentPage: 1,
  perPage: 10,
  total: 0,
})

// 数据和加载状态
const books = ref<any[]>([])
const loading = ref(false)
const errorMsg = ref('')

// 获取数据
async function fetchData() {
  loading.value = true
  errorMsg.value = ''

  try {
    // 构建过滤条件
    const filter = {
      name: searchKeyword.value || undefined,
      minPrice: filterForm.minPrice,
      maxPrice: filterForm.maxPrice,
    }

    // 调用带过滤条件的分页搜索接口
    const response: PaginationResponse<any> = await filterSearch(
      pagination.currentPage,
      pagination.perPage,
      filter,
    )

    if (response.success) {
      books.value = response.data
      pagination.total = response.meta.total
    }
    else {
      errorMsg.value = response.error || '获取数据失败'
    }
  }
  catch (err) {
    errorMsg.value = '网络错误，无法获取数据'
    console.error('数据获取失败:', err)
  }
  finally {
    loading.value = false
  }
}

// 监听搜索关键词变化，重置页码并重新获取数据
watch(searchKeyword, (newVal) => {
  if (newVal !== undefined) {
    pagination.currentPage = 1
    fetchData()
  }
})

// 监听价格过滤条件变化，重置页码并重新获取数据
watch([() => filterForm.minPrice, () => filterForm.maxPrice], () => {
  pagination.currentPage = 1
  fetchData()
})

// 处理页码变化
function handlePageChange(page: number) {
  pagination.currentPage = page
  fetchData()
}

// 初始化加载数据
fetchData()
</script>

<template>
  <div class="filter-container max-w-4xl mx-auto p-4">
    <!-- 搜索和过滤区域 -->
    <div class="bg-white rounded-lg shadow-sm border p-4 mb-6">
      <div class="flex flex-col md:flex-row gap-4 items-start md:items-center">
        <!-- 搜索框 -->
        <div class="w-full md:w-1/2">
          <Search
            v-model="searchKeyword"
            placeholder="请输入书名搜索..."
            :debounce="true"
            :debounce-delay="300"
          />
        </div>

        <!-- 价格过滤 -->
        <div class="w-full md:w-1/2 flex gap-4 items-center">
          <div class="flex-1">
            <label class="block text-sm text-gray-600 mb-1">最低价格</label>
            <input
              v-model.number="filterForm.minPrice"
              type="number"
              min="0"
              step="0.01"
              class="w-full px-3 py-2 border border-gray-300 rounded-md"
              placeholder="最低价格"
            >
          </div>

          <div class="flex-1">
            <label class="block text-sm text-gray-600 mb-1">最高价格</label>
            <input
              v-model.number="filterForm.maxPrice"
              type="number"
              min="0"
              step="0.01"
              class="w-full px-3 py-2 border border-gray-300 rounded-md"
              placeholder="最高价格"
            >
          </div>
        </div>
      </div>
    </div>

    <!-- 书籍列表 -->
    <BookContainer
      :books="books"
      :loading="loading"
      :error-msg="errorMsg"
    />

    <!-- 分页控件 -->
    <PageHelper
      v-if="pagination.total > 0"
      :current-page="pagination.currentPage"
      :per-page="pagination.perPage"
      :total="pagination.total"
      @page-change="handlePageChange"
    />
  </div>
</template>
