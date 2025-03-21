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
const isUpgrade = ref(false)
const currentPlan = computed(() => 
  mockSubscriptionPlans.find(p => p.id === mockUserSubscription.planId)
)
const selectedPlan = computed(() => 
  mockSubscriptionPlans.find(p => p.id === selectedPlanId.value)
)

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
    const date = new Date(mockUserSubscription.currentPeriodEnd)
    return date.toLocaleDateString('en-US', { 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric' 
    })
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

function getCheckIcon(included: boolean) {
  return included ? 'i-heroicons-check-circle' : 'i-heroicons-x-circle'
}

function getCheckClass(included: boolean) {
  return included ? 'text-primary' : 'text-muted-foreground/50'
}

function getPlanCardClass(planId: string) {
  if (planId === mockUserSubscription.planId) {
    return 'border-primary'
  }
  if (planId === selectedPlanId.value) {
    return 'border-primary'
  }
  return 'border-border hover:border-primary/50'
}

function cancelDowngrade() {
  // Reset the downgrade state
  mockUserSubscription.cancelAtPeriodEnd = false
  mockUserSubscription.downgradeToId = undefined
  
  // Show success message
  toast.success('Pending downgrade canceled')
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
      <h3 class="text-lg font-medium">Subscription Plan</h3>
      <p class="text-sm text-muted-foreground">
        Manage your subscription plan and billing cycle
      </p>
    </div>
    
    <!-- Current Subscription Status (if downgrade pending) -->
    <div v-if="mockUserSubscription.cancelAtPeriodEnd" class="bg-muted p-4 rounded-lg mb-6">
      <p class="text-sm">
        Your subscription will be downgraded to 
        <Badge variant="outline">{{ mockSubscriptionPlans.find(p => p.id === mockUserSubscription.downgradeToId)?.name }}</Badge> 
        on 
        <strong>{{ new Date(mockUserSubscription.currentPeriodEnd).toLocaleDateString() }}</strong>.
      </p>
      <Button variant="link" class="p-0 h-auto text-sm" @click="cancelDowngrade">
        Cancel downgrade
      </Button>
    </div>
    
    <!-- Billing Cycle Toggle -->
    <div class="flex items-center justify-end mb-6">
      <span class="text-sm mr-2" :class="{ 'font-medium': billingCycle === 'monthly' }">Monthly</span>
      <Switch 
        :checked="billingCycle === 'annually'" 
        @update:checked="toggleBillingCycle"
      />
      <span class="text-sm ml-2" :class="{ 'font-medium': billingCycle === 'annually' }">Annually</span>
      <Badge variant="outline" class="ml-2">Save 20%</Badge>
    </div>
    
    <!-- Subscription Plans Grid -->
    <div class="grid md:grid-cols-3 gap-6 mb-6">
      <div 
        v-for="plan in mockSubscriptionPlans" 
        :key="plan.id"
        :class="[
          'relative border rounded-lg p-6 transition-all',
          getPlanCardClass(plan.id)
        ]"
      >
        <!-- Current Plan Badge -->
        <Badge 
          v-if="plan.id === mockUserSubscription.planId" 
          class="absolute top-3 right-3"
        >
          Current
        </Badge>
        
        <!-- Future Plan Badge (when downgrade is pending) -->
        <Badge 
          v-if="mockUserSubscription.cancelAtPeriodEnd && plan.id === mockUserSubscription.downgradeToId" 
          variant="outline"
          class="absolute top-3 right-3"
        >
          Future Plan
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
              <p class="text-xs text-muted-foreground">{{ feature.description }}</p>
            </div>
          </li>
        </ul>
        
        <!-- Action Button -->
        <Button 
          v-if="plan.id !== mockUserSubscription.planId && 
               !(mockUserSubscription.cancelAtPeriodEnd && plan.id === mockUserSubscription.downgradeToId)" 
          class="w-full"
          @click="selectPlan(plan)"
        >
          Select Plan
        </Button>
        <Button 
          v-else-if="mockUserSubscription.cancelAtPeriodEnd && plan.id === mockUserSubscription.downgradeToId"
          variant="outline" 
          class="w-full" 
          disabled
        >
          Future Plan
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
    
    <!-- Confirmation Dialog -->
    <Dialog v-model:open="confirmDialogOpen">
      <DialogContent>
        <DialogHeader>
          <DialogTitle>
            {{ isUpgrade ? 'Upgrade' : 'Downgrade' }} Subscription
          </DialogTitle>
          <DialogDescription>
            Review your subscription change before confirming.
          </DialogDescription>
        </DialogHeader>
        
        <form @submit="onSubmit">
          <div class="py-4">
            <div class="flex justify-between items-center mb-4">
              <div>
                <p class="font-medium">Current Plan:</p>
                <p class="text-muted-foreground">{{ currentPlan?.name }}</p>
              </div>
              <div>
                <p class="font-medium">New Plan:</p>
                <p class="text-muted-foreground">{{ selectedPlan?.name }}</p>
              </div>
            </div>
            
            <div class="flex justify-between items-center mb-4">
              <div>
                <p class="font-medium">Current price:</p>
                <p class="text-muted-foreground">
                  ${{ currentPlan?.price[billingCycle].toFixed(2) }}/{{ billingCycle === 'monthly' ? 'mo' : 'yr' }}
                </p>
              </div>
              <div>
                <p class="font-medium">New price:</p>
                <p class="text-muted-foreground">
                  ${{ selectedPlan?.price[billingCycle].toFixed(2) }}/{{ billingCycle === 'monthly' ? 'mo' : 'yr' }}
                </p>
              </div>
            </div>
            
            <Alert variant="info" class="mb-4">
              <AlertTitle>Effective Date</AlertTitle>
              <AlertDescription>
                This change will take effect {{ effectiveDate }}.
                {{ isUpgrade ? 'You will be charged the prorated difference immediately.' : 'You will continue to have access to your current plan until the end of your billing period.' }}
              </AlertDescription>
            </Alert>
            
            <FormField v-slot="{ value, handleChange }" name="termsAccepted">
              <FormItem class="flex flex-row items-start gap-x-3 space-y-0">
                <FormControl>
                  <Checkbox :checked="value" @update:checked="handleChange" />
                </FormControl>
                <div class="space-y-1 leading-none">
                  <FormLabel>
                    I agree to the terms and conditions for changing my subscription plan.
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
  </div>
</template> 