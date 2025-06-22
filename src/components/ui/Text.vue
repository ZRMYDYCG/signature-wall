<script setup lang="ts">
import { computed, useSlots } from 'vue'

interface Props {
  /** 文本内容 */
  content?: string
  /** 文字颜色 */
  color?: string
  /** 字体大小 */
  size?: string | number
  /** 是否加粗 */
  bold?: boolean
  /** 是否斜体 */
  italic?: boolean
  /** 是否显示下划线 */
  underline?: boolean
  /** 是否删除线 */
  lineThrough?: boolean
  /** 文字对齐方式 */
  align?: 'left' | 'center' | 'right' | 'justify'
  /** 行高 */
  lineHeight?: string | number
  /** 是否自动换行 */
  wrap?: boolean
  /** 最大行数（超出显示省略号） */
  maxLines?: number
  /** 自定义类名 */
  customClass?: string
  /** 渲染标签类型 */
  tag?: keyof HTMLElementTagNameMap
}

const props = withDefaults(defineProps<Props>(), {
  content: '',
  color: '#333',
  size: '14px',
  bold: false,
  italic: false,
  underline: false,
  lineThrough: false,
  align: 'left',
  lineHeight: 1.5,
  wrap: true,
  maxLines: undefined,
  customClass: '',
  tag: 'span',
})

const slots = useSlots()

// 计算样式
const textStyles = computed(() => ({
  color: props.color,
  fontSize: typeof props.size === 'number' ? `${props.size}px` : props.size,
  fontWeight: props.bold ? 'bold' : 'normal',
  fontStyle: props.italic ? 'italic' : 'normal',
  textDecoration: [props.underline ? 'underline' : '', props.lineThrough ? 'line-through' : '']
    .filter(Boolean)
    .join(' ') || 'none',
  textAlign: props.align,
  lineHeight: typeof props.lineHeight === 'number' ? props.lineHeight : props.lineHeight,
  whiteSpace: props.wrap ? 'normal' : 'nowrap',
  overflow: props.maxLines ? 'hidden' : 'visible',
  display: props.maxLines ? '-webkit-box' : 'inline',
  WebkitBoxOrient: 'vertical',
  WebkitLineClamp: props.maxLines,
}))

// 处理内容显示
const displayContent = computed(() => props.content || (slots.default?.() ? undefined : ''))
</script>

<template>
  <component
    :is="tag"
    class="text-component" :class="[customClass]"
    :style="textStyles"
  >
    <slot>{{ displayContent }}</slot>
  </component>
</template>

<style scoped>
.text-component {
  word-break: break-word;
}
</style>
