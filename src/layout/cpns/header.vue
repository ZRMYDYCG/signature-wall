<script setup lang="ts">
import { ref } from 'vue'
import Avatar from '@/components/ui/Avatar.vue'
import Button from '@/components/ui/Button.vue'
import Dialog from '@/components/ui/Dialog.vue'
import SvgIcon from '@/components/ui/SvgIcon.vue'
import Text from '@/components/ui/Text.vue'

import { globalConfig } from '@/config'

const showDialog = ref(false)
const isEditing = ref(false)
const content = ref('')

function handleConfirm() {
}
</script>

<template>
  <div class="header fixed top-0 left-0 right-0 z-[1000] flex items-center justify-between px-5 h-16 bg-white/70 backdrop-blur-[10px] shadow-[0_2px_10px_rgba(0,0,0,0.1)]">
    <!-- S Logo -->
    <div class="logo cursor-pointer flex items-center gap-2">
      <SvgIcon name="logo" size="25px" />
      <Text
        size="16px"
        bold
        italic
        align="center"
        custom-class="my-text"
        tag="div"
      >
        {{ globalConfig.appName }}
      </Text>
    </div>
    <!-- Logo E -->

    <!-- S Action -->
    <div class="right-actions flex items-center gap-[15px]">
      <div class="actions flex gap-[15px]">
        <Button @click="showDialog = true">
          发布
        </Button>
      </div>

      <!-- S Avatar -->
      <div class="avatar">
        <Avatar />
      </div>
      <!-- Avatar E -->
    </div>
    <!-- Action E -->
  </div>
  <!-- 占位 -->
  <div class="h-16" />
  <Dialog v-model:visible="showDialog" title="发布一条想法" @confirm="handleConfirm">
    <div class="relative h-[80%]">
      <div
        contenteditable="true"
        class="w-full h-full overflow-y-auto  p-4 outline-none border border-[#E5E7EB] rounded-lg bg-white text-left font-Poppin text-[1em] text-[#085991]"
        @focus="isEditing = true"
        @blur="isEditing = false"
        @input="content = ($event as any).target.innerText.trim()"
      />
      <!-- 占位符 -->
      <div v-if="!isEditing && !content" class="absolute top-4 left-4 text-gray-400 pointer-events-none font-Poppin text-[1em]">
        分享你此刻的想法
      </div>
    </div>
  </Dialog>
</template>

<style scoped>
</style>
