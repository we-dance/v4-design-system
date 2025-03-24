<script setup>
import { ref, watch } from 'vue'

const props = defineProps({
  initialRating: {
    type: Number,
    default: 0
  },
  size: {
    type: String,
    default: 'md',
    validator: (value) => ['sm', 'md', 'lg'].includes(value)
  },
  readOnly: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:rating'])

const currentRating = ref(props.initialRating)
const hoverRating = ref(0)

watch(() => props.initialRating, (newValue) => {
  currentRating.value = newValue
})

const handleMouseEnter = (star) => {
  if (props.readOnly) return
  hoverRating.value = star
}

const handleMouseLeave = () => {
  if (props.readOnly) return
  hoverRating.value = 0
}

const handleClick = (star) => {
  if (props.readOnly) return
  currentRating.value = star
  emit('update:rating', star)
}

const starSize = {
  sm: 'w-4 h-4',
  md: 'w-6 h-6',
  lg: 'w-8 h-8'
}
</script>

<template>
  <div class="flex items-center">
    <div
      v-for="star in 5"
      :key="star"
      class="cursor-pointer"
      :class="{ 'cursor-default': readOnly }"
      @mouseenter="handleMouseEnter(star)"
      @mouseleave="handleMouseLeave"
      @click="handleClick(star)"
    >
      <Icon
        :name="
          (hoverRating || currentRating) >= star
            ? 'heroicons:star-solid'
            : 'heroicons:star'
        "
        :class="[
          starSize[size],
          (hoverRating || currentRating) >= star
            ? 'text-amber-500'
            : 'text-gray-300'
        ]"
      />
    </div>
    
    <span v-if="currentRating > 0" class="ml-2 text-sm text-muted-foreground">
      {{ currentRating }}/5
    </span>
  </div>
</template> 