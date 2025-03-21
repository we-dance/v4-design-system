<script setup>
import { useForm } from 'vee-validate'
import { toast } from 'vue-sonner'
import { z } from 'zod'
import { toTypedSchema } from '@vee-validate/zod'

const props = defineProps({
  profileId: {
    type: String,
    required: true
  },
  profileType: {
    type: String,
    required: true,
    validator: (value) => ['organizer', 'venue', 'teacher', 'assistant'].includes(value)
  },
  initialRating: {
    type: Number,
    default: 0
  },
  initialComment: {
    type: String,
    default: ''
  },
  isEdit: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['submitted', 'cancelled'])

const reviewSchema = toTypedSchema(
  z.object({
    rating: z.number().min(1, { message: 'Please select a rating' }).max(5),
    comment: z.string().min(10, { message: 'Review must be at least 10 characters long' })
  })
)

const { handleSubmit, isSubmitting, setFieldValue, values } = useForm({
  validationSchema: reviewSchema,
  initialValues: {
    rating: props.initialRating,
    comment: props.initialComment
  }
})

const onSubmit = handleSubmit(async (values) => {
  try {
    // In a real implementation, this would make an API call
    // For now, we'll just emit the event
    emit('submitted', {
      profileId: props.profileId,
      profileType: props.profileType,
      rating: values.rating,
      comment: values.comment
    })
    
    toast.success(props.isEdit ? 'Review updated successfully' : 'Review submitted successfully')
  } catch (error) {
    toast.error('Failed to submit review')
    console.error(error)
  }
})

const handleCancel = () => {
  emit('cancelled')
}

// For the star rating component
const setRating = (rating) => {
  setFieldValue('rating', rating)
}
</script>

<template>
  <div class="p-6 bg-card rounded-lg shadow-sm">
    <h3 class="text-2xl font-semibold mb-4">
      {{ isEdit ? 'Edit Review' : 'Write a Review' }}
    </h3>
    
    <form @submit.prevent="onSubmit" class="space-y-6">
      <div class="space-y-2">
        <Label for="rating">Rating</Label>
        <div class="flex items-center">
          <StarRating
            :initial-rating="values.rating"
            @update:rating="setRating"
          />
        </div>
      </div>
      
      <div class="space-y-2">
        <Label for="comment">Your Review</Label>
        <Textarea
          id="comment"
          v-model="values.comment"
          placeholder="Share your experience with others..."
          class="resize-none"
          rows="5"
        />
      </div>
      
      <div class="flex justify-end space-x-4">
        <Button
          variant="outline"
          type="button"
          @click="handleCancel"
        >
          Cancel
        </Button>
        
        <Button
          type="submit"
          :disabled="isSubmitting"
        >
          {{ isSubmitting ? 'Submitting...' : (isEdit ? 'Update Review' : 'Submit Review') }}
        </Button>
      </div>
    </form>
  </div>
</template> 