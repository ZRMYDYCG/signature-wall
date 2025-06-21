<script setup lang="ts">
import { computed, ref } from 'vue'

interface IPageHelperProps {
  /** 当前页码 */
  currentPage: number
  /** 每页条数 */
  perPage: number
  /** 总记录数 */
  total: number
}

const props = defineProps<IPageHelperProps>()

const emit = defineEmits<{
  (e: 'pageChange', page: number): void
}>()

// 计算总页数
const totalPages = computed(() => {
  return Math.ceil(props.total / props.perPage) || 1
})

// 页码输入框绑定值
const pageInput = ref(props.currentPage)

// 跳转到指定页
function goToPage(page: number) {
  if (page >= 1 && page <= totalPages.value && page !== props.currentPage) {
    emit('pageChange', page)
    pageInput.value = page
  }
}

// 上一页
const prevPage = () => goToPage(props.currentPage - 1)

// 下一页
const nextPage = () => goToPage(props.currentPage + 1)

// 处理输入框回车事件
const handleInputEnter = () => goToPage(Number(pageInput.value))
</script>

<template>
  <div class="flex items-center justify-between mt-6 text-sm text-gray-600">
    <div class="flex items-center space-x-4">
      <span>共 {{ total }} 条记录，共 {{ totalPages }} 页</span>
      <span>当前第 {{ currentPage }} 页</span>
    </div>

    <div class="flex items-center space-x-2">
      <button
        :disabled="currentPage <= 1"
        class="px-3 py-1 border rounded hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
        @click="prevPage"
      >
        上一页
      </button>

      <div class="flex items-center border rounded overflow-hidden">
        <input
          v-model.number="pageInput"
          type="number"
          min="1"
          :max="totalPages"
          class="w-16 px-3 py-1 border-0 focus:ring-0"
          @keydown.enter="handleInputEnter"
        >
        <span class="px-2 text-gray-400">/{{ totalPages }}</span>
      </div>

      <button
        :disabled="currentPage >= totalPages"
        class="px-3 py-1 border rounded hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
        @click="nextPage"
      >
        下一页
      </button>
    </div>
  </div>
</template>
