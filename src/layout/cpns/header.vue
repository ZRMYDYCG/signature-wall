<script setup lang="ts">
import { ref } from 'vue'
import ColorListPicker from '@/components/common/ColorListPicker.vue'
import Avatar from '@/components/ui/Avatar.vue'
import Button from '@/components/ui/Button.vue'
import Dialog from '@/components/ui/Dialog.vue'
import SvgIcon from '@/components/ui/SvgIcon.vue'
import Text from '@/components/ui/Text.vue'
import { userAvatar } from '@/config'

import { globalConfig } from '@/config'

const showIdeaDialog = ref(false)
const showSettingDialog = ref(false)
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
        <Button @click="showIdeaDialog = true">
          发布
        </Button>
      </div>

      <!-- S Avatar -->
      <div class="avatar" @click="showSettingDialog = true">
        <Avatar />
      </div>
      <!-- Avatar E -->
    </div>
    <!-- Action E -->
  </div>
  <!-- 占位 -->
  <div class="h-16" />
  <!-- 发布想法弹窗 -->
  <Dialog v-model:visible="showIdeaDialog" title="发布一条想法" @confirm="handleConfirm">
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
  <!-- 用户自定义设置弹窗 -->
  <Dialog v-model:visible="showSettingDialog" title="用户自定义设置">
    <div class="flex flex-col gap-4  h-[90%] overflow-y-auto">
      <div class="flex flex-col gap-1">
        <div class="flex items-center space-x-2 py-2">
          <div class="w-3 h-3 rounded-full bg-gradient-to-r from-pink-400 to-red-600" />
          <div>头像设置</div>
        </div>
        <ColorListPicker :colors="userAvatar" />
        <div class="flex items-center space-x-2 py-2">
          <div class="w-3 h-3 rounded-full bg-gradient-to-r from-pink-400 to-red-600" />
          <div>昵称设置</div>
        </div>
        <input
          type="text"
          placeholder="请输入昵称"
          class="w-full px-4 py-2 border rounded-md outline-none"
        >
      </div>
    </div>
    <template #footer>
      <Button>
        保存
      </Button>
    </template>
  </Dialog>
</template>

<style scoped>
</style>
