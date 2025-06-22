<script setup lang="ts">
import { onUnmounted, ref, watch } from 'vue'

const props = defineProps<{
  /** 搜索框占位符 */
  placeholder?: string
  /** 是否开启防抖模式 */
  debounce?: boolean
  /** 防抖延迟时间(毫秒) */
  debounceDelay?: number
  /** 绑定的搜索关键词 */
  modelValue?: string
  /** 是否禁用搜索框 */
  disabled?: boolean
}>()

const emit = defineEmits<{
  /** 搜索事件，返回搜索关键词 */
  (e: 'search', keyword: string): void
  /** v-model双向绑定事件 */
  (e: 'update:modelValue', value: string): void
}>()

// 内部搜索关键词状态
const searchKeyword = ref(props.modelValue || '')
// 防抖定时器ID
let debounceTimer: NodeJS.Timeout | null = null

// 默认参数处理
const effectiveDebounce = props.debounce ?? true
const effectiveDebounceDelay = props.debounceDelay ?? 300

// 触发搜索
function triggerSearch(keyword: string) {
  emit('search', keyword)
  emit('update:modelValue', keyword)
}

// 防抖搜索处理
function handleSearch(keyword: string) {
  // 清除之前的定时器
  if (debounceTimer) {
    clearTimeout(debounceTimer)
  }

  // 如果禁用防抖，直接搜索
  if (!effectiveDebounce) {
    triggerSearch(keyword)
    return
  }

  // 防抖处理
  debounceTimer = setTimeout(() => {
    triggerSearch(keyword)
  }, effectiveDebounceDelay)
}

// 监听搜索关键词变化
watch(searchKeyword, (newVal) => {
  handleSearch(newVal)
})

// 组件卸载时清除定时器
onUnmounted(() => {
  if (debounceTimer) {
    clearTimeout(debounceTimer)
  }
})
</script>

<template>
  <div class="search-container relative">
    <input
      v-model="searchKeyword"
      :placeholder="placeholder || '请输入搜索关键词...'"
      :disabled="disabled"
      class="w-full px-4 py-2 pl-10 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-colors"
      type="text"
    >
    <!-- 搜索图标 -->
    <svg
      class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"
      xmlns="http://www.w3.org/2000/svg"
      width="18"
      height="18"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    >
      <circle cx="11" cy="11" r="8" />
      <path d="m21 21-4.3-4.3" />
    </svg>
  </div>
</template>
