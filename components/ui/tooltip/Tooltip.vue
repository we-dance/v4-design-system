<script setup lang="ts">
import { TooltipRoot } from 'radix-vue'

defineProps<{
  delayDuration?: number
}>()
</script>

<template>
  <TooltipRoot :delay-duration="delayDuration">
    <slot />
  </TooltipRoot>
</template> 