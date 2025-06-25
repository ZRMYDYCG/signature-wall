<template>
  <div class="grade-layout">
    <slot />
  </div>
</template>

<style scoped>
.grade-layout {
  display: grid;
  gap: 20px;
  padding: 20px;
  background: #f5f7fa;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.1);
}
</style>
