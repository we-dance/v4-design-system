<script setup lang="ts">
import type { HTMLAttributes } from 'vue'
import { cn } from '@/lib/utils'
import { Primitive, type PrimitiveProps } from 'radix-vue'
import { type ButtonVariants, buttonVariants } from '.'

interface Props extends PrimitiveProps {
  variant?: ButtonVariants['variant']
  size?: ButtonVariants['size']
  class?: HTMLAttributes['class']
}

const props = withDefaults(defineProps<Props>(), {
  as: 'button',
})
</script>

<template>
  <Primitive
    :as="as"
    :as-child="asChild"
    :class="cn(buttonVariants({ variant, size }), props.class)"
    :style="{
      '--button-bg': 'hsl(var(--primary))',
      '--button-text': 'hsl(var(--primary-foreground))',
      '--button-hover': 'hsl(var(--primary))',
      '--button-active': 'hsl(var(--primary))'
    }"
  >
    <slot />
  </Primitive>
</template>

<style>
.btn {
  background-color: var(--button-bg);
  color: var(--button-text);
}

.btn:hover {
  background-color: var(--button-hover);
}

.btn:active {
  background-color: var(--button-active);
}
</style>
