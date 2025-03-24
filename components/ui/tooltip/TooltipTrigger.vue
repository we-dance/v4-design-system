<script setup lang="ts">
import { TooltipTrigger as RadixTooltipTrigger } from 'radix-vue'

defineProps<{
  asChild?: boolean
}>()
</script>

<template>
  <RadixTooltipTrigger :as-child="asChild">
    <slot />
  </RadixTooltipTrigger>
</template> 