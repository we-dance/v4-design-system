<script setup lang="ts">
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import { toast } from 'vue-sonner'
import { subscriptionUpdateSchema } from '~/schemas/subscription'
import { 
  mockSubscriptionPlans,
  mockCourseSubscriptions,
  type SubscriptionPlan 
} from '~/data/mockSubscriptions'

const props = defineProps({
  courseId: {
    type: String,
    required: true
  }
})

// Initialize subscriptions from mock data
const courseSubscriptions = ref(mockCourseSubscriptions)

const selectedPlanId = ref('')
const confirmDialogOpen = ref(false)
const confirmCancelDialogOpen = ref(false)
const selectedCourseId = ref('')
const isUpgrade = ref(false)

// Get current subscription for the selected course
const currentSubscription = computed(() => 
  courseSubscriptions.value.find(s => s.courseId === (selectedCourseId.value || props.courseId))
)

// Get the current plan details
const currentPlan = computed(() => {
  if (!currentSubscription.value) return null
  return mockSubscriptionPlans.find(p => p.id === currentSubscription.value.planId)
})

// Get the selected plan details
const selectedPlan = computed(() => 
  mockSubscriptionPlans.find(p => p.id === selectedPlanId.value)
)

const formattedRenewalDate = computed(() => {
  if (!currentSubscription.value) return ''
  const date = new Date(currentSubscription.value.currentPeriodEnd)
  return date.toLocaleDateString('en-US', { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric' 
  })
})

const priceDifference = computed(() => {
  if (!currentPlan.value || !selectedPlan.value) return 0
  const currentPrice = currentSubscription.value.price
  const newPrice = selectedPlan.value.price.monthly
  return newPrice - currentPrice
})

const effectiveDate = computed(() => {
  if (!priceDifference.value) return ''
  
  if (priceDifference.value > 0) {
    // Upgrade - immediate
    return 'immediately'
  } else {
    // Downgrade - end of billing cycle
    return formattedRenewalDate.value
  }
})

const form = useForm({
  validationSchema: toTypedSchema(subscriptionUpdateSchema),
  initialValues: {
    planId: '',
    courseId: props.courseId,
    termsAccepted: false
  }
})

function selectPlan(plan: SubscriptionPlan) {
  if (!currentSubscription.value || plan.id === currentSubscription.value.planId) return
  
  selectedCourseId.value = currentSubscription.value.courseId
  selectedPlanId.value = plan.id
  form.setFieldValue('planId', plan.id)
  form.setFieldValue('courseId', currentSubscription.value.courseId)
  
  // Determine if this is an upgrade or downgrade
  const currentPlanIndex = mockSubscriptionPlans.findIndex(p => p.id === currentSubscription.value.planId)
  const newPlanIndex = mockSubscriptionPlans.findIndex(p => p.id === plan.id)
  
  isUpgrade.value = newPlanIndex > currentPlanIndex
  
  // Open the confirmation dialog
  confirmDialogOpen.value = true
}

function openCancelSubscriptionDialog(subscription) {
  selectedCourseId.value = subscription.courseId
  confirmCancelDialogOpen.value = true
}

function cancelSubscription() {
  try {
    // In a real implementation, this would be an API call
    console.log('Cancelling subscription for course', selectedCourseId.value)
    
    // Set status to pending cancellation at end of billing period
    const subscription = courseSubscriptions.value.find(s => s.courseId === selectedCourseId.value)
    if (subscription) {
      subscription.cancelAtPeriodEnd = true
    }
    
    // Show success message
    toast.success('Your subscription has been cancelled')
    
    // Close the dialog
    confirmCancelDialogOpen.value = false
  } catch (error) {
    toast.error(`Failed to cancel subscription: ${error.message}`)
  }
}

function cancelDowngrade(subscription) {
  // Reset the cancellation state
  subscription.cancelAtPeriodEnd = false
  subscription.downgradeToId = undefined
  
  // Show success message
  toast.success('Pending cancellation canceled')
}

function getCheckIcon(included: boolean) {
  return included ? 'i-heroicons-check-circle' : 'i-heroicons-x-circle'
}

function getCheckClass(included: boolean) {
  return included ? 'text-primary' : 'text-muted-foreground/50'
}

const onSubmit = form.handleSubmit(
  async (values) => {
    try {
      // This would be an API call in a real implementation
      console.log('Update subscription:', values)
      
      const actionType = isUpgrade.value ? 'upgraded' : 'downgraded'
      
      // Find the subscription to update
      const subscription = courseSubscriptions.value.find(s => s.courseId === values.courseId)
      if (!subscription) {
        throw new Error('Subscription not found')
      }
      
      // Handle subscription state updates differently based on upgrade vs downgrade
      if (isUpgrade.value) {
        // For upgrades, update plan immediately
        subscription.planId = values.planId
        
        // Update price based on the selected plan
        const selectedPlan = mockSubscriptionPlans.find(p => p.id === values.planId)
        if (selectedPlan) {
          subscription.price = selectedPlan.price.monthly
        }
      } else {
        // For downgrades, schedule change for end of billing cycle
        subscription.cancelAtPeriodEnd = true
        subscription.downgradeToId = values.planId
      }
      
      // Show success message
      toast.success(`Subscription ${actionType} successfully`)
      
      // Reset and close dialog
      confirmDialogOpen.value = false
      
    } catch (error) {
      toast.error(`Failed to update subscription: ${error.message}`)
    }
  },
  (e) => {
    toast.error('Please fix the errors in the form.')
  }
)
</script>

<template>
  <div>
    <div class="mb-6">
      <h3 class="text-xl font-medium">Course Subscriptions</h3>
      <p class="text-sm text-muted-foreground">
        Manage your course subscriptions and billing details
      </p>
    </div>
    
    <!-- Current Subscriptions -->
    <div v-if="courseSubscriptions.length > 0" class="space-y-6 mb-8">
      <div 
        v-for="subscription in courseSubscriptions" 
        :key="subscription.id" 
        class="border rounded-lg"
      >
        <div class="border-b p-4">
          <h4 class="font-medium">{{ subscription.courseName }}</h4>
        </div>
        
        <div class="p-4 space-y-4">
          <!-- Plan details -->
          <div class="grid grid-cols-3 gap-4">
            <div>
              <div class="text-sm text-muted-foreground">Plan</div>
              <div class="font-medium capitalize">{{ subscription.planId }}</div>
            </div>
            <div>
              <div class="text-sm text-muted-foreground">Price</div>
              <div class="font-medium">€{{ subscription.price.toFixed(2) }}/mo</div>
            </div>
            <div>
              <div class="text-sm text-muted-foreground">Status</div>
              <div class="font-medium capitalize">{{ subscription.status }}</div>
            </div>
          </div>
          
          <!-- Renewal info -->
          <div>
            <div class="text-sm text-muted-foreground">Renews On</div>
            <div class="font-medium">
              {{ new Date(subscription.currentPeriodEnd).toLocaleDateString('en-US', { 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
              }) }}
            </div>
          </div>
          
          <!-- Pending cancellation notice -->
          <div v-if="subscription.cancelAtPeriodEnd && !subscription.downgradeToId" class="bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-800">
            <div class="flex items-start">
              <Icon name="i-heroicons-exclamation-triangle" class="h-5 w-5 mr-2 mt-0.5" />
              <div>
                <div class="font-medium">Your subscription will be cancelled</div>
                <p class="text-sm">
                  Your subscription will end on {{ new Date(subscription.currentPeriodEnd).toLocaleDateString('en-US', { 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                  }) }}. You'll lose access to this course after this date.
                </p>
                <Button variant="link" class="p-0 h-auto text-sm" @click="cancelDowngrade(subscription)">
                  Keep my subscription
                </Button>
              </div>
            </div>
          </div>
          
          <!-- Downgrade notice -->
          <div v-if="subscription.cancelAtPeriodEnd && subscription.downgradeToId" class="bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-800">
            <div class="flex items-start">
              <Icon name="i-heroicons-exclamation-triangle" class="h-5 w-5 mr-2 mt-0.5" />
              <div>
                <div class="font-medium">Your plan will change soon</div>
                <p class="text-sm">
                  On {{ new Date(subscription.currentPeriodEnd).toLocaleDateString('en-US', { 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                  }) }}, your plan will change to {{ mockSubscriptionPlans.find(p => p.id === subscription.downgradeToId)?.name }}.
                </p>
                <Button variant="link" class="p-0 h-auto text-sm" @click="cancelDowngrade(subscription)">
                  Cancel plan change
                </Button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Available Plans -->
        <div class="p-4 border-t space-y-4">
          <h5 class="font-medium">Available Plans</h5>
          <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
            <div 
              v-for="plan in mockSubscriptionPlans" 
              :key="plan.id"
              :class="[
                'relative border rounded-lg p-4 transition-all',
                plan.id === subscription.planId ? 'border-primary bg-primary/5' : 'hover:border-primary/50'
              ]"
            >
              <!-- Current Plan Badge -->
              <Badge 
                v-if="plan.id === subscription.planId" 
                class="absolute top-2 right-2"
              >
                Current
              </Badge>
              
              <h5 class="text-lg font-medium">{{ plan.name }}</h5>
              <div class="my-2">
                <span class="text-xl font-bold">€{{ plan.price.monthly.toFixed(2) }}</span>
                <span class="text-muted-foreground">/mo</span>
              </div>
              
              <!-- Action Button -->
              <Button 
                v-if="plan.id !== subscription.planId" 
                size="sm"
                class="mt-2"
                @click="() => { selectedCourseId = subscription.courseId; selectPlan(plan); }"
              >
                {{ plan.price.monthly > subscription.price ? 'Upgrade' : 'Downgrade' }}
              </Button>
              <Button 
                v-else 
                variant="outline" 
                size="sm"
                class="mt-2" 
                disabled
              >
                Current Plan
              </Button>
            </div>
          </div>
        </div>
        
        <!-- Subscription Actions -->
        <div class="border-t p-4 bg-muted/30 flex justify-end items-center">
          <Button 
            variant="outline" 
            @click="openCancelSubscriptionDialog(subscription)"
          >
            Cancel Subscription
          </Button>
        </div>
      </div>
    </div>
    
    <!-- No Subscriptions Message -->
    <div v-else class="border rounded-lg p-6 mb-8 text-center">
      <div class="text-muted-foreground mb-4">You don't have any active course subscriptions.</div>
      <Button>Browse Courses</Button>
    </div>
    
    <!-- Change Plan Confirmation Dialog -->
    <Dialog v-model:open="confirmDialogOpen">
      <DialogContent>
        <DialogHeader>
          <DialogTitle>
            {{ isUpgrade ? 'Upgrade' : 'Downgrade' }} to {{ selectedPlan?.name }}
          </DialogTitle>
          <DialogDescription>
            Review your subscription change for {{ courseSubscriptions.find(s => s.courseId === selectedCourseId)?.courseName }} before confirming.
          </DialogDescription>
        </DialogHeader>
        
        <form @submit="onSubmit">
          <div class="py-4">
            <div class="grid grid-cols-2 gap-4 mb-4">
              <div class="border rounded-lg p-4">
                <div class="text-sm text-muted-foreground mb-1">Current Plan</div>
                <div class="font-medium">{{ currentPlan?.name }}</div>
                <div class="text-sm mt-4">€{{ currentSubscription?.price.toFixed(2) }}/mo</div>
              </div>
              
              <div class="border rounded-lg p-4 bg-primary/5 border-primary">
                <div class="text-sm text-muted-foreground mb-1">New Plan</div>
                <div class="font-medium">{{ selectedPlan?.name }}</div>
                <div class="text-sm mt-4">€{{ selectedPlan?.price.monthly.toFixed(2) }}/mo</div>
              </div>
            </div>
            
            <Alert variant="info" class="mb-4">
              <AlertTitle>When will this change take effect?</AlertTitle>
              <AlertDescription>
                <template v-if="isUpgrade">
                  Your plan will upgrade immediately. You'll be charged the prorated difference for the remainder of your billing period.
                </template>
                <template v-else>
                  Your plan will change at the end of your current billing period on {{ formattedRenewalDate }}. 
                  You'll continue to have access to your current plan until then.
                </template>
              </AlertDescription>
            </Alert>
            
            <FormField v-slot="{ value, handleChange }" name="termsAccepted">
              <FormItem class="flex flex-row items-start gap-x-3 space-y-0">
                <FormControl>
                  <Checkbox :checked="value" @update:checked="handleChange" />
                </FormControl>
                <div class="space-y-1 leading-none">
                  <FormLabel>
                    I understand that this will {{ isUpgrade ? 'upgrade my plan immediately' : 'downgrade my plan at the end of my billing period' }}.
                  </FormLabel>
                  <FormMessage />
                </div>
              </FormItem>
            </FormField>
          </div>
          
          <DialogFooter>
            <Button 
              type="button" 
              variant="ghost" 
              @click="confirmDialogOpen = false"
            >
              Cancel
            </Button>
            <Button type="submit">
              Confirm {{ isUpgrade ? 'Upgrade' : 'Downgrade' }}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
    
    <!-- Cancel Subscription Dialog -->
    <Dialog v-model:open="confirmCancelDialogOpen">
      <DialogContent>
        <DialogHeader>
          <DialogTitle>
            Cancel Subscription
          </DialogTitle>
          <DialogDescription>
            Are you sure you want to cancel your subscription to {{ courseSubscriptions.find(s => s.courseId === selectedCourseId)?.courseName }}?
          </DialogDescription>
        </DialogHeader>
        
        <div class="py-4">
          <Alert variant="warning" class="mb-4">
            <AlertTitle>Important information</AlertTitle>
            <AlertDescription>
              <ul class="list-disc pl-4 space-y-1">
                <li>Your subscription will remain active until the end of your current billing period on {{ formattedRenewalDate }}.</li>
                <li>After this date, you'll lose access to this course.</li>
                <li>You can resubscribe at any time.</li>
              </ul>
            </AlertDescription>
          </Alert>
          
          <div class="text-sm text-muted-foreground">
            Tell us why you're cancelling (optional):
          </div>
          <Select>
            <SelectTrigger>
              <SelectValue placeholder="Select a reason" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="completed">I've completed the course</SelectItem>
              <SelectItem value="too-expensive">It's too expensive</SelectItem>
              <SelectItem value="not-what-expected">Not what I expected</SelectItem>
              <SelectItem value="technical-issues">Technical issues</SelectItem>
              <SelectItem value="no-time">Don't have time right now</SelectItem>
              <SelectItem value="other">Other reason</SelectItem>
            </SelectContent>
          </Select>
        </div>
        
        <DialogFooter>
          <Button 
            type="button" 
            variant="ghost" 
            @click="confirmCancelDialogOpen = false"
          >
            Keep Subscription
          </Button>
          <Button 
            variant="destructive" 
            @click="cancelSubscription"
          >
            Cancel Subscription
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  </div>
</template> 