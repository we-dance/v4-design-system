<script setup>
import { computed, ref } from 'vue'
import { useAuth } from '~/composables/useAuth'

const props = defineProps({
  review: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['edit', 'delete'])

const { user } = useAuth()
const confirmDelete = ref(false)

const formattedDate = computed(() => {
  return new Date(props.review.createdAt).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
})

const isCurrentUserReview = computed(() => {
  return user && user.id === props.review.userId
})

const handleDelete = () => {
  confirmDelete.value = true
}

const confirmDeleteAction = () => {
  emit('delete', props.review.id)
  confirmDelete.value = false
}

const cancelDelete = () => {
  confirmDelete.value = false
}

const handleEdit = () => {
  emit('edit', props.review)
}

// Added for avatar fallback
const getInitial = computed(() => {
  return props.review.user?.name?.charAt(0) || 'U'
})

const avatarUrl = computed(() => {
  return props.review.user?.avatar || ''
})
</script>

<template>
  <Card class="mb-4">
    <CardHeader class="pb-2">
      <div class="flex justify-between items-start">
        <div class="flex items-center gap-2">
          <!-- Replace the shadcn Avatar with the simple Avatar component -->
          <div v-if="review.user" class="w-10 h-10 rounded-full overflow-hidden flex items-center justify-center bg-gray-200 text-gray-700">
            <Avatar v-if="avatarUrl" :avatar-url="avatarUrl" alt="User avatar" class="w-full h-full object-cover" />
            <span v-else class="text-lg font-semibold">{{ getInitial }}</span>
          </div>
          
          <div>
            <CardTitle class="text-base">{{ review.user?.name || 'Anonymous' }}</CardTitle>
            <CardDescription>{{ formattedDate }}</CardDescription>
          </div>
        </div>
        
        <StarRating :initial-rating="review.rating" size="sm" :read-only="true" />
      </div>
    </CardHeader>
    
    <CardContent>
      <p class="text-sm">{{ review.comment }}</p>
    </CardContent>
    
    <CardFooter v-if="isCurrentUserReview" class="flex justify-end gap-2 pt-0">
      <Button variant="ghost" size="sm" @click="handleEdit">
        <Icon name="heroicons:pencil-square" class="w-4 h-4 mr-1" />
        Edit
      </Button>
      <Button variant="ghost" size="sm" @click="handleDelete">
        <Icon name="heroicons:trash" class="w-4 h-4 mr-1" />
        Delete
      </Button>
    </CardFooter>
  </Card>
  
  <Dialog v-model:open="confirmDelete">
    <DialogContent>
      <DialogHeader>
        <DialogTitle>Delete Review</DialogTitle>
        <DialogDescription>
          Are you sure you want to delete your review? This action cannot be undone.
        </DialogDescription>
      </DialogHeader>
      <DialogFooter>
        <Button variant="outline" @click="cancelDelete">Cancel</Button>
        <Button variant="destructive" @click="confirmDeleteAction">Delete</Button>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</template> 