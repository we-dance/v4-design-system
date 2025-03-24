<script setup lang="ts">
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import { toast } from 'vue-sonner'
import { subscriptionUpdateSchema } from '~/schemas/subscription'
import { 
  mockSubscriptionPlans,
  type SubscriptionPlan 
} from '~/data/mockSubscriptions'

const props = defineProps({
  courseId: {
    type: String,
    required: true
  },
  courseName: {
    type: String,
    required: true
  },
  subscription: {
    type: Object,
    required: true
  },
  onBack: {
    type: Function,
    default: () => {}
  }
})

const emit = defineEmits(['update:subscription', 'back'])

const selectedPlanId = ref('')
const confirmDialogOpen = ref(false)
const confirmCancelDialogOpen = ref(false)
const isUpgrade = ref(false)

// Get the current plan details
const currentPlan = computed(() => {
  return mockSubscriptionPlans.find(p => p.id === props.subscription.planId)
})

// Get the selected plan details
const selectedPlan = computed(() => 
  mockSubscriptionPlans.find(p => p.id === selectedPlanId.value)
)

const formattedRenewalDate = computed(() => {
  const date = new Date(props.subscription.currentPeriodEnd)
  return date.toLocaleDateString('en-US', { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric' 
  })
})

const priceDifference = computed(() => {
  if (!currentPlan.value || !selectedPlan.value) return 0
  const currentPrice = props.subscription.price
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

const subscriptionAge = computed(() => {
  const now = new Date();
  const startDate = new Date(props.subscription.currentPeriodStart);
  // Return age in hours
  return Math.abs(now - startDate) / 36e5; // 36e5 is the number of milliseconds in an hour
});

const isEligibleForMoneyBack = computed(() => {
  return subscriptionAge.value <= 24;
});

const subscriptionStartFormatted = computed(() => {
  const date = new Date(props.subscription.currentPeriodStart);
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  }) + ' at ' + date.toLocaleTimeString('en-US', {
    hour: 'numeric',
    minute: '2-digit'
  });
});

const confirmMoneyBackDialogOpen = ref(false);

const form = useForm({
  validationSchema: toTypedSchema(subscriptionUpdateSchema),
  initialValues: {
    planId: props.subscription.planId,
    courseId: props.courseId,
    termsAccepted: false
  }
})

function selectPlan(plan: SubscriptionPlan) {
  if (plan.id === props.subscription.planId) return
  
  selectedPlanId.value = plan.id
  form.setFieldValue('planId', plan.id)
  
  // Determine if this is an upgrade or downgrade
  const currentPlanIndex = mockSubscriptionPlans.findIndex(p => p.id === props.subscription.planId)
  const newPlanIndex = mockSubscriptionPlans.findIndex(p => p.id === plan.id)
  
  isUpgrade.value = newPlanIndex > currentPlanIndex
  
  // Open the confirmation dialog
  confirmDialogOpen.value = true
}

function openCancelSubscriptionDialog() {
  confirmCancelDialogOpen.value = true
}

function cancelSubscription() {
  try {
    // Create a copy of the subscription with updated properties
    const updatedSubscription = {
      ...props.subscription,
      cancelAtPeriodEnd: true
    }
    
    // Emit the updated subscription
    emit('update:subscription', updatedSubscription)
    
    // Show success message
    toast.success('Your subscription has been cancelled')
    
    // Close the dialog
    confirmCancelDialogOpen.value = false
  } catch (error) {
    toast.error(`Failed to cancel subscription: ${error.message}`)
  }
}

function cancelDowngrade() {
  // Create a copy of the subscription with updated properties
  const updatedSubscription = {
    ...props.subscription,
    cancelAtPeriodEnd: false,
    downgradeToId: undefined
  }
  
  // Emit the updated subscription
  emit('update:subscription', updatedSubscription)
  
  // Show success message
  toast.success('Pending changes canceled')
}

function handleBack() {
  emit('back')
}

function openCancelMoneyBackDialog() {
  confirmMoneyBackDialogOpen.value = true;
}

function cancelWithRefund() {
  try {
    // Create a copy of the subscription with updated properties
    const updatedSubscription = {
      ...props.subscription,
      status: 'canceled',
      cancelAtPeriodEnd: false
    };
    
    // Emit the updated subscription
    emit('update:subscription', updatedSubscription);
    
    // Show success message
    toast.success('Your subscription has been cancelled and a refund has been issued');
    
    // Close the dialog
    confirmMoneyBackDialogOpen.value = false;
  } catch (error) {
    toast.error(`Failed to cancel subscription: ${error.message}`);
  }
}

const onSubmit = form.handleSubmit(
  async (values) => {
    try {
      // Create a copy of the subscription with updated properties
      let updatedSubscription = { ...props.subscription }
      
      // Handle subscription state updates differently based on upgrade vs downgrade
      if (isUpgrade.value) {
        // For upgrades, update plan immediately
        updatedSubscription.planId = values.planId
        
        // Update price based on the selected plan
        const selectedPlan = mockSubscriptionPlans.find(p => p.id === values.planId)
        if (selectedPlan) {
          updatedSubscription.price = selectedPlan.price.monthly
        }
      } else {
        // For downgrades, schedule change for end of billing cycle
        updatedSubscription.cancelAtPeriodEnd = true
        updatedSubscription.downgradeToId = values.planId
      }
      
      // Emit the updated subscription
      emit('update:subscription', updatedSubscription)
      
      // Show success message
      const actionType = isUpgrade.value ? 'upgraded' : 'downgraded'
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
    <!-- Course Info Header -->
    <div class="flex items-center justify-between mb-6">
      <div>
        <h3 class="text-xl font-medium">{{ courseName }}</h3>
        <p class="text-sm text-muted-foreground">Manage your subscription to this course</p>
      </div>
      <Button variant="ghost" size="sm" @click="handleBack">
        <Icon name="i-heroicons-arrow-left" class="mr-2 h-4 w-4" />
        Back to Course
      </Button>
    </div>
    
    <!-- Current Subscription -->
    <div class="border rounded-lg mb-6">
      <div class="border-b p-4">
        <h4 class="font-medium">Current Subscription</h4>
      </div>
      
      <div class="p-4 space-y-4">
        <!-- Renewal info -->
        <div>
          <div class="text-sm text-muted-foreground">Renews On</div>
          <div class="font-medium">{{ formattedRenewalDate }}</div>
        </div>
        
        <!-- Pending cancellation notice -->
        <div v-if="subscription.cancelAtPeriodEnd && !subscription.downgradeToId" class="bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-800">
          <div class="flex items-start">
            <Icon name="i-heroicons-exclamation-triangle" class="h-5 w-5 mr-2 mt-0.5" />
            <div>
              <div class="font-medium">Your subscription will be cancelled</div>
              <p class="text-sm">
                Your subscription will end on {{ formattedRenewalDate }}. You'll lose access to this course after this date.
              </p>
              <Button variant="link" class="p-0 h-auto text-sm" @click="cancelDowngrade">
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
                On {{ formattedRenewalDate }}, your plan will change to {{ mockSubscriptionPlans.find(p => p.id === subscription.downgradeToId)?.name }}.
              </p>
              <Button variant="link" class="p-0 h-auto text-sm" @click="cancelDowngrade">
                Cancel plan change
              </Button>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Available Plans -->
    <div class="grid md:grid-cols-2 gap-6 mb-6">
      <div 
        v-for="plan in mockSubscriptionPlans" 
        :key="plan.id"
        :class="[
          'relative border rounded-lg p-6 transition-all',
          plan.id === subscription.planId ? 'border-primary bg-primary/5' : 'hover:border-primary/50'
        ]"
      >
        <!-- Current Plan Badge -->
        <Badge 
          v-if="plan.id === subscription.planId" 
          class="absolute top-3 right-3"
        >
          Current
        </Badge>
        
        <h4 class="text-xl font-medium mb-2">{{ plan.name }}</h4>
        <p class="text-sm text-muted-foreground mb-4">{{ plan.description }}</p>
        <div class="mb-6">
          <span class="text-3xl font-bold">€{{ plan.price.monthly.toFixed(2) }}</span>
          <span class="text-muted-foreground">/mo</span>
        </div>
        
        <ul class="mb-6 space-y-2">
          <li 
            v-for="feature in plan.features.slice(0, 3)" 
            :key="feature.name"
            class="flex items-start"
          >
            <Icon 
              :name="feature.included ? 'i-heroicons-check-circle' : 'i-heroicons-x-circle'" 
              :class="[
                'mr-2 h-5 w-5 mt-0.5', 
                feature.included ? 'text-primary' : 'text-muted-foreground/50'
              ]" 
            />
            <span class="text-sm">{{ feature.name }}</span>
          </li>
        </ul>
        
        <!-- Action Button -->
        <Button 
          v-if="plan.id !== subscription.planId" 
          class="w-full"
          @click="selectPlan(plan)"
        >
          {{ plan.price.monthly > subscription.price ? 'Upgrade' : 'Downgrade' }}
        </Button>
        <Button 
          v-else 
          variant="outline" 
          class="w-full" 
          disabled
        >
          Current Plan
        </Button>
      </div>
    </div>
    
    <!-- Cancel Subscription -->
    <div class="border-t pt-6 mt-6 flex justify-end">
      <Button 
        variant="outline" 
        class="text-red-600 hover:bg-red-50 hover:text-red-700 border-red-200"
        @click="isEligibleForMoneyBack ? openCancelMoneyBackDialog() : openCancelSubscriptionDialog()"
      >
        Cancel Subscription
      </Button>
    </div>
    
    <!-- Change Plan Confirmation Dialog -->
    <Dialog v-model:open="confirmDialogOpen">
      <DialogContent>
        <DialogHeader>
          <DialogTitle>
            {{ isUpgrade ? 'Upgrade' : 'Downgrade' }} to {{ selectedPlan?.name }}
          </DialogTitle>
          <DialogDescription>
            Review your subscription change for {{ courseName }} before confirming.
          </DialogDescription>
        </DialogHeader>
        
        <form @submit="onSubmit">
          <div class="py-4">
            <div class="grid grid-cols-2 gap-4 mb-4">
              <div class="border rounded-lg p-4">
                <div class="text-sm text-muted-foreground mb-1">Current Plan</div>
                <div class="font-medium">{{ currentPlan?.name }}</div>
                <div class="text-sm mt-4">€{{ subscription.price.toFixed(2) }}/mo</div>
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
            Are you sure you want to cancel your subscription to {{ courseName }}?
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
    
    <!-- Money-Back Guarantee Cancellation Dialog -->
    <Dialog v-model:open="confirmMoneyBackDialogOpen">
      <DialogContent>
        <DialogHeader>
          <DialogTitle>
            Cancel Subscription
          </DialogTitle>
          <DialogDescription>
            You're eligible for a full refund under our 24-hour money-back guarantee.
          </DialogDescription>
        </DialogHeader>
        
        <div class="py-4">
          <div class="flex items-center gap-3 mb-6 bg-blue-50 border border-blue-200 rounded-md p-3 text-blue-800">
            <Icon name="i-heroicons-clock" class="h-5 w-5 flex-shrink-0" />
            <div>
              <div class="font-medium">Your subscription is less than 24 hours old</div>
              <p class="text-sm mt-1">
                You subscribed on {{ subscriptionStartFormatted }}. You're eligible for a full refund.
              </p>
            </div>
          </div>
          
          <Alert variant="success" class="mb-4">
            <AlertTitle>Full refund available</AlertTitle>
            <AlertDescription>
              <ul class="list-disc pl-4 space-y-1">
                <li>Your payment of <strong>€{{ subscription.price.toFixed(2) }}</strong> will be refunded to your original payment method.</li>
                <li>The refund typically processes within 3-5 business days.</li>
                <li>Your access to the course will end immediately after cancellation.</li>
              </ul>
            </AlertDescription>
          </Alert>
          
          <div class="text-sm text-muted-foreground mb-2">
            Please tell us why you're cancelling:
          </div>
          <Select>
            <SelectTrigger>
              <SelectValue placeholder="Select a reason" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="not-what-expected">Not what I expected</SelectItem>
              <SelectItem value="content-quality">Content quality issues</SelectItem>
              <SelectItem value="technical-issues">Technical issues</SelectItem>
              <SelectItem value="purchased-by-mistake">Purchased by mistake</SelectItem>
              <SelectItem value="other">Other reason</SelectItem>
            </SelectContent>
          </Select>
          
          <div class="mt-4">
            <div class="text-sm text-muted-foreground mb-2">Additional feedback (optional):</div>
            <Textarea placeholder="Tell us more about your experience" class="w-full" />
          </div>
        </div>
        
        <DialogFooter>
          <Button 
            type="button" 
            variant="ghost" 
            @click="confirmMoneyBackDialogOpen = false"
          >
            Keep Subscription
          </Button>
          <Button 
            variant="destructive"
            @click="cancelWithRefund"
          >
            Cancel and Refund
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  </div>
</template> 