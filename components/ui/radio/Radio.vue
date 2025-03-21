<script setup lang="ts">
import type { RadioGroupItemProps, RadioGroupItemEmits } from 'radix-vue'
import { cn } from '@/lib/utils'
import { Circle } from 'lucide-vue-next'
import {
  RadioGroupIndicator,
  RadioGroupItem,
  useForwardPropsEmits,
} from 'radix-vue'
import { computed, type HTMLAttributes } from 'vue'

const props = defineProps<
  RadioGroupItemProps & { class?: HTMLAttributes['class'] }
>()
const emits = defineEmits<RadioGroupItemEmits>()

const delegatedProps = computed(() => {
  const { class: _, ...delegated } = props
  return delegated
})

const forwarded = useForwardPropsEmits(delegatedProps, emits)
</script>

<template>
  <RadioGroupItem
    v-bind="forwarded"
    :class="
      cn(
        'peer h-4 w-4 shrink-0 rounded-full border border-primary ring-offset-background focus:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 data-[state=checked]:bg-primary data-[state=checked]:text-primary-foreground',
        props.class
      )
    "
  >
    <RadioGroupIndicator
      class="flex h-full w-full items-center justify-center text-current"
    >
      <slot>
        <Circle class="h-2.5 w-2.5 fill-current text-current" />
      </slot>
    </RadioGroupIndicator>
  </RadioGroupItem>
</template> 