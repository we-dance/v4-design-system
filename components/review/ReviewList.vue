<script setup>
import { ref, onMounted } from 'vue'
import { toast } from 'vue-sonner'
import { mockReviews } from '~/data/reviews'

const props = defineProps({
  profileId: {
    type: String,
    required: true
  },
  profileType: {
    type: String,
    required: true
  }
})

const reviews = ref([])
const reviewToEdit = ref(null)
const isFormVisible = ref(false)
const isLoading = ref(true)

// In a real implementation, this would fetch reviews from an API
onMounted(async () => {
  // Simulating API call with mock data
  try {
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 1000))
    
    // Load mock data
    reviews.value = mockReviews.filter(
      review => review.profileId === props.profileId && review.profileType === props.profileType
    )
  } catch (error) {
    console.error('Failed to load reviews', error)
  } finally {
    isLoading.value = false
  }
})

const handleNewReview = () => {
  reviewToEdit.value = null
  isFormVisible.value = true
}

const handleEditReview = (review) => {
  reviewToEdit.value = review
  isFormVisible.value = true
}

const handleDeleteReview = async (reviewId) => {
  try {
    // In a real implementation, this would make an API call
    // For now, we'll just update the local state
    reviews.value = reviews.value.filter(review => review.id !== reviewId)
    toast.success('Review deleted successfully')
  } catch (error) {
    toast.error('Failed to delete review')
    console.error(error)
  }
}

const handleSubmitted = async (reviewData) => {
  try {
    if (reviewToEdit.value) {
      // Update existing review
      const index = reviews.value.findIndex(r => r.id === reviewToEdit.value.id)
      if (index !== -1) {
        reviews.value[index] = {
          ...reviewToEdit.value,
          ...reviewData,
          updatedAt: new Date().toISOString()
        }
      }
    } else {
      // Add new review
      const newReview = {
        id: `review-${Date.now()}`,
        ...reviewData,
        userId: 'current-user-id', // In a real app, this would be the current user's ID
        user: {
          name: 'Current User', // In a real app, this would be the current user's name
          avatar: '' // In a real app, this would be the current user's avatar
        },
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      }
      reviews.value.unshift(newReview)
    }
    
    isFormVisible.value = false
    reviewToEdit.value = null
  } catch (error) {
    console.error('Failed to submit review', error)
    toast.error('Failed to submit review')
  }
}

const handleCancelled = () => {
  isFormVisible.value = false
  reviewToEdit.value = null
}
</script>

<template>
  <div>
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold">Reviews</h2>
      <Button v-if="!isFormVisible" @click="handleNewReview">
        <Icon name="heroicons:star" class="w-4 h-4 mr-2" />
        Write a Review
      </Button>
    </div>
    
    <div v-if="isFormVisible" class="mb-8">
      <ReviewForm
        :profile-id="profileId"
        :profile-type="profileType"
        :initial-rating="reviewToEdit ? reviewToEdit.rating : 0"
        :initial-comment="reviewToEdit ? reviewToEdit.comment : ''"
        :is-edit="!!reviewToEdit"
        @submitted="handleSubmitted"
        @cancelled="handleCancelled"
      />
    </div>
    
    <div v-if="isLoading" class="py-8 text-center">
      <Spinner />
      <p class="mt-2 text-muted-foreground">Loading reviews...</p>
    </div>
    
    <div v-else-if="reviews.length === 0" class="py-12 text-center border rounded-lg">
      <Icon name="heroicons:chat-bubble-bottom-center-text" class="w-12 h-12 mx-auto text-muted-foreground" />
      <h3 class="mt-2 text-lg font-medium">No reviews yet</h3>
      <p class="text-muted-foreground">Be the first to share your experience!</p>
    </div>
    
    <div v-else>
      <ReviewCard
        v-for="review in reviews"
        :key="review.id"
        :review="review"
        @edit="handleEditReview"
        @delete="handleDeleteReview"
      />
    </div>
  </div>
</template> 