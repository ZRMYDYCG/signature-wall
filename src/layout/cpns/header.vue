<script setup lang="ts">
import Avatar from '@/components/ui/Avatar.vue'
import Button from '@/components/ui/Button.vue'
import SvgIcon from '@/components/ui/SvgIcon.vue'
import Text from '@/components/ui/Text.vue'
import { globalConfig } from '@/config'
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
        <Button>发布</Button>
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
</template>

<style scoped>
</style>
