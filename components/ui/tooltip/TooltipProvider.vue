<script setup lang="ts">
import { TooltipProvider as RadixTooltipProvider } from 'radix-vue'

defineProps<{
  delayDuration?: number
}>()
</script>

<template>
  <RadixTooltipProvider :delay-duration="delayDuration">
    <slot />
  </RadixTooltipProvider>
</template> 