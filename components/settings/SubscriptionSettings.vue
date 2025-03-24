<script setup lang="ts">
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import { toast } from 'vue-sonner'
import { subscriptionUpdateSchema } from '~/schemas/subscription'
import { 
  mockSubscriptionPlans, 
  mockUserSubscription, 
  type SubscriptionPlan 
} from '~/data/mockSubscriptions'

const billingCycle = ref<'monthly' | 'annually'>('monthly')
const selectedPlanId = ref(mockUserSubscription.planId)
const confirmDialogOpen = ref(false)
const confirmCancelDialogOpen = ref(false)
const isUpgrade = ref(false)
const currentPlan = computed(() => 
  mockSubscriptionPlans.find(p => p.id === mockUserSubscription.planId)
)
const selectedPlan = computed(() => 
  mockSubscriptionPlans.find(p => p.id === selectedPlanId.value)
)

const formattedRenewalDate = computed(() => {
  const date = new Date(mockUserSubscription.currentPeriodEnd)
  return date.toLocaleDateString('en-US', { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric' 
  })
})

const priceDifference = computed(() => {
  if (!currentPlan.value || !selectedPlan.value) return 0
  const currentPrice = currentPlan.value.price[billingCycle.value]
  const newPrice = selectedPlan.value.price[billingCycle.value]
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
    planId: mockUserSubscription.planId,
    billingCycle: 'monthly',
    termsAccepted: false
  }
})

function selectPlan(plan: SubscriptionPlan) {
  if (plan.id === mockUserSubscription.planId) return
  selectedPlanId.value = plan.id
  form.setFieldValue('planId', plan.id)
  
  // Determine if this is an upgrade or downgrade
  const currentPlanIndex = mockSubscriptionPlans.findIndex(p => p.id === mockUserSubscription.planId)
  const newPlanIndex = mockSubscriptionPlans.findIndex(p => p.id === plan.id)
  
  isUpgrade.value = newPlanIndex > currentPlanIndex
  
  // Open the confirmation dialog
  confirmDialogOpen.value = true
}

function toggleBillingCycle() {
  billingCycle.value = billingCycle.value === 'monthly' ? 'annually' : 'monthly'
  form.setFieldValue('billingCycle', billingCycle.value)
}

function openCancelSubscriptionDialog() {
  confirmCancelDialogOpen.value = true
}

function cancelSubscription() {
  try {
    // In a real implementation, this would be an API call
    console.log('Cancelling subscription')
    
    // Set status to pending cancellation at end of billing period
    mockUserSubscription.cancelAtPeriodEnd = true
    
    // Show success message
    toast.success('Your subscription has been cancelled')
    
    // Close the dialog
    confirmCancelDialogOpen.value = false
  } catch (error) {
    toast.error(`Failed to cancel subscription: ${error.message}`)
  }
}

function cancelDowngrade() {
  // Reset the downgrade state
  mockUserSubscription.cancelAtPeriodEnd = false
  mockUserSubscription.downgradeToId = undefined
  
  // Show success message
  toast.success('Pending downgrade canceled')
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
      
      // Show success message
      toast.success(`Subscription ${actionType} successfully`)
      
      // Handle subscription state updates differently based on upgrade vs downgrade
      if (isUpgrade.value) {
        // For upgrades, update plan immediately
        mockUserSubscription.planId = values.planId
      } else {
        // For downgrades, schedule change for end of billing cycle
        mockUserSubscription.cancelAtPeriodEnd = true
        mockUserSubscription.downgradeToId = values.planId
      }
      
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
      <h3 class="text-xl font-medium">Subscription</h3>
      <p class="text-sm text-muted-foreground">
        Manage your subscription and billing details
      </p>
    </div>
    
    <!-- Current Subscription Details -->
    <div class="border rounded-lg mb-8">
      <div class="border-b p-4">
        <h4 class="font-medium">Current Plan</h4>
      </div>
      
      <div class="p-4 space-y-4">
        <!-- Plan details -->
        <div class="grid grid-cols-3 gap-4">
          <div>
            <div class="text-sm text-muted-foreground">Plan</div>
            <div class="font-medium">{{ currentPlan?.name }}</div>
          </div>
          <div>
            <div class="text-sm text-muted-foreground">Billing Cycle</div>
            <div class="font-medium capitalize">{{ billingCycle }}</div>
          </div>
          <div>
            <div class="text-sm text-muted-foreground">Price</div>
            <div class="font-medium">${{ currentPlan?.price[billingCycle].toFixed(2) }}/{{ billingCycle === 'monthly' ? 'mo' : 'yr' }}</div>
          </div>
        </div>
        
        <!-- Renewal info -->
        <div>
          <div class="text-sm text-muted-foreground">Renews On</div>
          <div class="font-medium">{{ formattedRenewalDate }}</div>
        </div>
        
        <!-- Pending changes notice -->
        <div v-if="mockUserSubscription.cancelAtPeriodEnd && !mockUserSubscription.downgradeToId" class="bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-800">
          <div class="flex items-start">
            <Icon name="i-heroicons-exclamation-triangle" class="h-5 w-5 mr-2 mt-0.5" />
            <div>
              <div class="font-medium">Your subscription will be cancelled</div>
              <p class="text-sm">
                Your subscription will end on {{ formattedRenewalDate }}. You'll lose access to premium features after this date.
              </p>
              <Button variant="link" class="p-0 h-auto text-sm" @click="cancelDowngrade">
                Keep my subscription
              </Button>
            </div>
          </div>
        </div>
        
        <!-- Downgrade notice -->
        <div v-if="mockUserSubscription.cancelAtPeriodEnd && mockUserSubscription.downgradeToId" class="bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-800">
          <div class="flex items-start">
            <Icon name="i-heroicons-exclamation-triangle" class="h-5 w-5 mr-2 mt-0.5" />
            <div>
              <div class="font-medium">Your plan will change soon</div>
              <p class="text-sm">
                On {{ formattedRenewalDate }}, your plan will change to {{ mockSubscriptionPlans.find(p => p.id === mockUserSubscription.downgradeToId)?.name }}.
              </p>
              <Button variant="link" class="p-0 h-auto text-sm" @click="cancelDowngrade">
                Cancel plan change
              </Button>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Subscription Actions -->
      <div class="border-t p-4 bg-muted/30 flex justify-between items-center">
        <div>
          <Button variant="outline" @click="openCancelSubscriptionDialog">
            Cancel Subscription
          </Button>
        </div>
        <div class="flex items-center gap-2">
          <span class="text-sm mr-2" :class="{ 'font-medium': billingCycle === 'monthly' }">Monthly</span>
          <Switch 
            :checked="billingCycle === 'annually'" 
            @update:checked="toggleBillingCycle"
          />
          <span class="text-sm ml-2" :class="{ 'font-medium': billingCycle === 'annually' }">Annually</span>
          <Badge variant="outline" class="ml-2">Save 20%</Badge>
        </div>
      </div>
    </div>
    
    <!-- Available Plans -->
    <div class="mb-8">
      <h4 class="text-lg font-medium mb-4">Available Plans</h4>
      <div class="grid md:grid-cols-3 gap-6">
        <div 
          v-for="plan in mockSubscriptionPlans" 
          :key="plan.id"
          :class="[
            'relative border rounded-lg p-6 transition-all',
            plan.id === mockUserSubscription.planId ? 'border-primary bg-primary/5' : 'hover:border-primary/50'
          ]"
        >
          <!-- Current Plan Badge -->
          <Badge 
            v-if="plan.id === mockUserSubscription.planId" 
            class="absolute top-3 right-3"
          >
            Current
          </Badge>
          
          <!-- Popular Badge -->
          <Badge 
            v-if="plan.popular" 
            variant="secondary"
            class="absolute top-3 right-3"
          >
            Popular
          </Badge>
          
          <h4 class="text-xl font-medium mb-2">{{ plan.name }}</h4>
          <p class="text-sm text-muted-foreground mb-4">{{ plan.description }}</p>
          
          <!-- Price -->
          <div class="mb-6">
            <span class="text-3xl font-bold">${{ plan.price[billingCycle].toFixed(2) }}</span>
            <span class="text-muted-foreground">/{{ billingCycle === 'monthly' ? 'mo' : 'yr' }}</span>
          </div>
          
          <!-- Features -->
          <ul class="space-y-3 mb-6">
            <li 
              v-for="feature in plan.features" 
              :key="feature.name"
              class="flex items-start"
            >
              <Icon 
                :name="getCheckIcon(feature.included)" 
                :class="['mr-2 h-5 w-5 mt-0.5', getCheckClass(feature.included)]" 
              />
              <div>
                <span class="text-sm font-medium">{{ feature.name }}</span>
              </div>
            </li>
          </ul>
          
          <!-- Action Button -->
          <Button 
            v-if="plan.id !== mockUserSubscription.planId" 
            class="w-full"
            @click="selectPlan(plan)"
          >
            {{ plan.price[billingCycle] > currentPlan?.price[billingCycle] ? 'Upgrade' : 'Downgrade' }}
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
    </div>
    
    <!-- Change Plan Confirmation Dialog -->
    <Dialog v-model:open="confirmDialogOpen">
      <DialogContent>
        <DialogHeader>
          <DialogTitle>
            {{ isUpgrade ? 'Upgrade' : 'Downgrade' }} to {{ selectedPlan?.name }}
          </DialogTitle>
          <DialogDescription>
            Review your subscription change before confirming.
          </DialogDescription>
        </DialogHeader>
        
        <form @submit="onSubmit">
          <div class="py-4">
            <div class="grid grid-cols-2 gap-4 mb-4">
              <div class="border rounded-lg p-4">
                <div class="text-sm text-muted-foreground mb-1">Current Plan</div>
                <div class="font-medium">{{ currentPlan?.name }}</div>
                <div class="text-sm mt-4">${{ currentPlan?.price[billingCycle].toFixed(2) }}/{{ billingCycle === 'monthly' ? 'mo' : 'yr' }}</div>
              </div>
              
              <div class="border rounded-lg p-4 bg-primary/5 border-primary">
                <div class="text-sm text-muted-foreground mb-1">New Plan</div>
                <div class="font-medium">{{ selectedPlan?.name }}</div>
                <div class="text-sm mt-4">${{ selectedPlan?.price[billingCycle].toFixed(2) }}/{{ billingCycle === 'monthly' ? 'mo' : 'yr' }}</div>
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
            Are you sure you want to cancel your subscription?
          </DialogDescription>
        </DialogHeader>
        
        <div class="py-4">
          <Alert variant="warning" class="mb-4">
            <AlertTitle>Important information</AlertTitle>
            <AlertDescription>
              <ul class="list-disc pl-4 space-y-1">
                <li>Your subscription will remain active until the end of your current billing period on {{ formattedRenewalDate }}.</li>
                <li>After this date, you'll lose access to all premium features.</li>
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
              <SelectItem value="too-expensive">It's too expensive</SelectItem>
              <SelectItem value="not-using">I'm not using it enough</SelectItem>
              <SelectItem value="missing-features">Missing features I need</SelectItem>
              <SelectItem value="switching">Switching to a different service</SelectItem>
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