<script setup>
import { computed } from 'vue'

const props = defineProps({
  reviews: {
    type: Array,
    required: true
  }
})

const totalReviews = computed(() => props.reviews.length)

const averageRating = computed(() => {
  if (totalReviews.value === 0) return 0
  
  const sum = props.reviews.reduce((acc, review) => acc + review.rating, 0)
  return Math.round((sum / totalReviews.value) * 10) / 10
})

const ratingCounts = computed(() => {
  const counts = { 5: 0, 4: 0, 3: 0, 2: 0, 1: 0 }
  
  props.reviews.forEach(review => {
    counts[review.rating] = (counts[review.rating] || 0) + 1
  })
  
  return counts
})

const ratingPercentages = computed(() => {
  if (totalReviews.value === 0) return { 5: 0, 4: 0, 3: 0, 2: 0, 1: 0 }
  
  return {
    5: (ratingCounts.value[5] / totalReviews.value) *
    100,
    4: (ratingCounts.value[4] / totalReviews.value) * 100,
    3: (ratingCounts.value[3] / totalReviews.value) * 100,
    2: (ratingCounts.value[2] / totalReviews.value) * 100,
    1: (ratingCounts.value[1] / totalReviews.value) * 100
  }
})
</script>

<template>
  <Card class="mb-8">
    <CardHeader>
      <CardTitle>Rating Summary</CardTitle>
    </CardHeader>
    
    <CardContent>
      <div class="flex items-center justify-between mb-6">
        <div class="flex flex-col items-center">
          <span class="text-4xl font-bold">{{ averageRating }}</span>
          <StarRating :initial-rating="averageRating" :read-only="true" />
          <p class="text-sm text-muted-foreground mt-1">{{ totalReviews }} reviews</p>
        </div>
        
        <div class="flex-1 pl-8">
          <div
            v-for="star in [5, 4, 3, 2, 1]"
            :key="star"
            class="flex items-center mb-2"
          >
            <span class="w-6 text-sm">{{ star }}</span>
            <Icon name="heroicons:star-solid" class="w-4 h-4 text-amber-500 mr-2" />
            <div class="flex-1 bg-muted rounded-full h-2">
              <div
                class="bg-amber-500 h-2 rounded-full"
                :style="`width: ${ratingPercentages[star]}%`"
              ></div>
            </div>
            <span class="ml-2 text-sm text-muted-foreground w-10">{{ ratingCounts[star] }}</span>
          </div>
        </div>
      </div>
    </CardContent>
  </Card>
</template> 