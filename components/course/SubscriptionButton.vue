<script setup lang="ts">
import { type CourseSubscription, mockSubscriptionPlans } from '~/data/mockSubscriptions'

const props = defineProps({
  courseId: {
    type: String,
    required: true
  },
  basePrice: {
    type: Number,
    required: true
  },
  subscription: {
    type: Object as () => CourseSubscription | null,
    default: null
  }
})

const emit = defineEmits(['manage', 'view-plans'])

const isSubscribed = computed(() => !!props.subscription)

const formattedDate = computed(() => {
  if (!props.subscription) return ''
  
  const date = new Date(props.subscription.currentPeriodEnd)
  return date.toLocaleDateString('en-US', { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric' 
  })
})

const planName = computed(() => {
  if (!props.subscription) return ''
  
  const plan = mockSubscriptionPlans.find(p => p.id === props.subscription.planId)
  return plan?.name || props.subscription.planId
})

function handleViewPlans() {
  emit('view-plans')
}

function handleManage() {
  emit('manage')
}
</script>

<template>
  <div>
    <!-- Not Subscribed -->
    <div v-if="!isSubscribed" class="p-6 bg-background rounded-lg border">
      <div class="mb-4">
        <div class="text-sm text-muted-foreground">Starting from</div>
        <div class="text-3xl font-bold mb-4">{{ basePrice }} EUR</div>
        
        <Button class="w-full" @click="handleViewPlans">View Pricing Plans</Button>
      </div>
      <div class="text-xs text-center text-muted-foreground">
        24-hours money-back guarantee
      </div>
    </div>
    
    <!-- Subscribed -->
    <div v-else class="p-6 bg-background rounded-lg border">
      <div class="mb-4">
        <div class="flex items-center gap-2 mb-1">
          <Badge 
            v-if="subscription.status === 'active'" 
            variant="outline" 
            class="bg-green-100 text-green-800 hover:bg-green-100 border-green-200"
          >
            Active
          </Badge>
          <Badge 
            v-else-if="subscription.cancelAtPeriodEnd" 
            variant="outline" 
            class="bg-amber-100 text-amber-800 hover:bg-amber-100 border-amber-200"
          >
            Ending Soon
          </Badge>
          <div class="text-sm text-muted-foreground">{{ planName }}</div>
        </div>
        <div class="text-sm text-muted-foreground mb-4">
          <template v-if="subscription.cancelAtPeriodEnd">
            Access until {{ formattedDate }}
          </template>
          <template v-else>
            Renews on {{ formattedDate }}
          </template>
        </div>
        
        <Button variant="outline" class="w-full" @click="handleManage">
          <Icon name="i-heroicons-adjustments-horizontal" class="mr-2 h-4 w-4" />
          Manage Subscription
        </Button>
      </div>
      <div class="text-xs text-center text-muted-foreground">
        <template v-if="subscription.cancelAtPeriodEnd">
          Your subscription will end on the date above
        </template>
        <template v-else>
          Access available until end of billing period
        </template>
      </div>
    </div>
  </div>
</template> 