<script setup lang="ts">
import { mockSubscriptionPlans, mockUserSubscription, mockUserSubscriptionWithDowngrade } from '~/data/mockSubscriptions'

// Sample billing cycle options
const billingCycles = [
  { name: 'monthly', description: 'Monthly billing' },
  { name: 'annually', description: 'Annual billing with discount' },
]

// Example of downgrade state for documentation purposes
const pendingDowngradeExample = ref(true)
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-16">Subscription Plan</h1>

    <!-- Introduction -->
    <section class="mb-16">
      <p class="text-lg text-muted-foreground">
        The Subscription Plan component allows users to view, compare, and select subscription plans
        with different feature sets and pricing options. It also provides upgrade/downgrade functionality
        with clear information about billing changes.
      </p>
    </section>

    <!-- Usage -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Usage</h2>
      <div class="space-y-4">
        <p class="text-muted-foreground">
          Import and use the SubscriptionSettings component in your settings page:
        </p>
        <pre class="p-4 rounded-lg bg-muted font-mono text-sm">
&lt;SubscriptionSettings /&gt;</pre
        >
      </div>
    </section>

    <!-- Features -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Features</h2>
      <div class="space-y-6">
        <div>
          <h3 class="text-lg font-medium mb-2">Plan Comparison</h3>
          <p class="text-muted-foreground">
            Displays available subscription plans with feature comparison to help users
            make informed decisions about which plan best suits their needs.
          </p>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-2">Billing Cycle Toggle</h3>
          <p class="text-muted-foreground">
            Allows users to switch between monthly and annual billing cycles, with
            the option to save by choosing annual billing.
          </p>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-2">Upgrade/Downgrade Flow</h3>
          <p class="text-muted-foreground">
            Handles the subscription change process with clear information about pricing
            changes and when the new plan will take effect. Upgrades are immediate, while 
            downgrades take effect at the end of the billing cycle.
          </p>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-2">Pending Downgrade Management</h3>
          <p class="text-muted-foreground">
            Provides clear visibility of pending downgrades and allows users to cancel
            the downgrade before it takes effect at the end of the billing cycle.
          </p>
        </div>
      </div>
    </section>
    
    <!-- Pending Downgrade State -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Pending Downgrade State</h2>
      <div class="border rounded-lg p-6 mb-8">
        <div class="bg-muted p-4 rounded-lg mb-6">
          <p class="text-sm">
            Your subscription will be downgraded to 
            <Badge variant="outline">Basic</Badge> 
            on 
            <strong>January 1, 2024</strong>.
          </p>
          <Button variant="link" class="p-0 h-auto text-sm">
            Cancel downgrade
          </Button>
        </div>
        
        <div class="grid md:grid-cols-3 gap-6">
          <div class="relative border rounded-lg p-6">
            <h4 class="text-xl font-medium mb-2">Free</h4>
            <p class="text-sm text-muted-foreground mb-4">Basic features for casual dancers</p>
            <div class="mb-6">
              <span class="text-3xl font-bold">$0.00</span>
              <span class="text-muted-foreground">/mo</span>
            </div>
            <Button class="w-full">Select Plan</Button>
          </div>
          
          <div class="relative border rounded-lg p-6 border-primary">
            <Badge variant="outline" class="absolute top-3 right-3">Future Plan</Badge>
            <h4 class="text-xl font-medium mb-2">Basic</h4>
            <p class="text-sm text-muted-foreground mb-4">Essential features for active dancers</p>
            <div class="mb-6">
              <span class="text-3xl font-bold">$9.99</span>
              <span class="text-muted-foreground">/mo</span>
            </div>
            <Button variant="outline" class="w-full" disabled>Future Plan</Button>
          </div>
          
          <div class="relative border rounded-lg p-6 border-primary">
            <Badge class="absolute top-3 right-3">Current</Badge>
            <h4 class="text-xl font-medium mb-2">Pro</h4>
            <p class="text-sm text-muted-foreground mb-4">Advanced features for dedicated dancers</p>
            <div class="mb-6">
              <span class="text-3xl font-bold">$19.99</span>
              <span class="text-muted-foreground">/mo</span>
            </div>
            <Button variant="outline" class="w-full" disabled>Current Plan</Button>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Plan Display -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Plan Display</h2>
      <div class="border rounded-lg p-6 mb-8">
        <div class="flex justify-end mb-6">
          <div class="flex items-center">
            <span class="text-sm mr-2">Monthly</span>
            <Switch />
            <span class="text-sm ml-2">Annually</span>
            <Badge variant="outline" class="ml-2">Save 20%</Badge>
          </div>
        </div>
        <div class="grid md:grid-cols-3 gap-6">
          <div 
            v-for="plan in mockSubscriptionPlans.slice(0, 3)" 
            :key="plan.id"
            class="relative border rounded-lg p-6"
            :class="plan.id === mockUserSubscription.planId ? 'border-primary' : ''"
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
              <span class="text-3xl font-bold">${{ plan.price.monthly.toFixed(2) }}</span>
              <span class="text-muted-foreground">/mo</span>
            </div>
            
            <!-- Features -->
            <ul class="space-y-3 mb-6">
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
                <div>
                  <span class="text-sm font-medium">{{ feature.name }}</span>
                </div>
              </li>
            </ul>
            
            <!-- Action Button -->
            <Button 
              v-if="plan.id !== mockUserSubscription.planId" 
              class="w-full"
            >
              Select Plan
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
    </section>

    <!-- Confirmation Dialogs -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Confirmation Dialogs</h2>
      <div class="grid md:grid-cols-2 gap-8">
        <!-- Upgrade Dialog -->
        <div class="border rounded-lg p-6">
          <h3 class="text-lg font-medium mb-6">Upgrade Confirmation</h3>
          <div class="border rounded-lg p-6 mx-auto">
            <div class="mb-4">
              <h4 class="text-lg font-medium mb-2">Upgrade Subscription</h4>
              <p class="text-sm text-muted-foreground mb-4">
                Review your subscription change before confirming.
              </p>
            </div>
            
            <div class="py-4">
              <div class="flex justify-between items-center mb-4">
                <div>
                  <p class="font-medium">Current Plan:</p>
                  <p class="text-muted-foreground">Basic</p>
                </div>
                <div>
                  <p class="font-medium">New Plan:</p>
                  <p class="text-muted-foreground">Pro</p>
                </div>
              </div>
              
              <div class="flex justify-between items-center mb-4">
                <div>
                  <p class="font-medium">Current price:</p>
                  <p class="text-muted-foreground">$9.99/mo</p>
                </div>
                <div>
                  <p class="font-medium">New price:</p>
                  <p class="text-muted-foreground">$19.99/mo</p>
                </div>
              </div>
              
              <Alert class="mb-4">
                <AlertTitle>Effective Date</AlertTitle>
                <AlertDescription>
                  This change will take effect immediately.
                  You will be charged the prorated difference immediately.
                </AlertDescription>
              </Alert>
              
              <div class="flex items-start gap-x-3 mb-6">
                <Checkbox id="upgrade-terms" />
                <div>
                  <label for="upgrade-terms" class="text-sm font-medium cursor-pointer">
                    I agree to the terms and conditions for changing my subscription plan.
                  </label>
                </div>
              </div>
            </div>
            
            <div class="flex justify-end gap-x-2">
              <Button variant="ghost">
                Cancel
              </Button>
              <Button>
                Confirm Upgrade
              </Button>
            </div>
          </div>
        </div>
        
        <!-- Downgrade Dialog -->
        <div class="border rounded-lg p-6">
          <h3 class="text-lg font-medium mb-6">Downgrade Confirmation</h3>
          <div class="border rounded-lg p-6 mx-auto">
            <div class="mb-4">
              <h4 class="text-lg font-medium mb-2">Downgrade Subscription</h4>
              <p class="text-sm text-muted-foreground mb-4">
                Review your subscription change before confirming.
              </p>
            </div>
            
            <div class="py-4">
              <div class="flex justify-between items-center mb-4">
                <div>
                  <p class="font-medium">Current Plan:</p>
                  <p class="text-muted-foreground">Pro</p>
                </div>
                <div>
                  <p class="font-medium">New Plan:</p>
                  <p class="text-muted-foreground">Basic</p>
                </div>
              </div>
              
              <div class="flex justify-between items-center mb-4">
                <div>
                  <p class="font-medium">Current price:</p>
                  <p class="text-muted-foreground">$19.99/mo</p>
                </div>
                <div>
                  <p class="font-medium">New price:</p>
                  <p class="text-muted-foreground">$9.99/mo</p>
                </div>
              </div>
              
              <Alert class="mb-4">
                <AlertTitle>Effective Date</AlertTitle>
                <AlertDescription>
                  This change will take effect on January 1, 2024.
                  You will continue to have access to your current plan until the end of your billing period.
                </AlertDescription>
              </Alert>
              
              <div class="flex items-start gap-x-3 mb-6">
                <Checkbox id="downgrade-terms" />
                <div>
                  <label for="downgrade-terms" class="text-sm font-medium cursor-pointer">
                    I agree to the terms and conditions for changing my subscription plan.
                  </label>
                </div>
              </div>
            </div>
            
            <div class="flex justify-end gap-x-2">
              <Button variant="ghost">
                Cancel
              </Button>
              <Button>
                Confirm Downgrade
              </Button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Props -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Props</h2>
      <div class="border rounded-lg">
        <div class="grid grid-cols-4 gap-4 p-4 border-b font-medium">
          <div>Name</div>
          <div>Type</div>
          <div>Default</div>
          <div>Description</div>
        </div>
        <div class="grid grid-cols-4 gap-4 p-4 border-b">
          <div class="font-mono text-sm">plans</div>
          <div class="text-muted-foreground">Array</div>
          <div class="text-muted-foreground">[ ]</div>
          <div class="text-muted-foreground">Array of subscription plans</div>
        </div>
        <div class="grid grid-cols-4 gap-4 p-4 border-b">
          <div class="font-mono text-sm">userSubscription</div>
          <div class="text-muted-foreground">Object</div>
          <div class="text-muted-foreground">{ }</div>
          <div class="text-muted-foreground">User's current subscription details</div>
        </div>
        <div class="grid grid-cols-4 gap-4 p-4">
          <div class="font-mono text-sm">onPlanChange</div>
          <div class="text-muted-foreground">Function</div>
          <div class="text-muted-foreground">undefined</div>
          <div class="text-muted-foreground">
            Callback function when a plan is changed
          </div>
        </div>
      </div>
    </section>

    <!-- Accessibility -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Accessibility</h2>
      <div class="space-y-4">
        <p class="text-muted-foreground">
          The Subscription Plan component follows these accessibility guidelines:
        </p>
        <ul class="list-disc pl-6 space-y-2 text-muted-foreground">
          <li>Color contrast meets WCAG 2.1 AA standards for all text elements</li>
          <li>Interactive elements are keyboard navigable and have proper focus states</li>
          <li>Clear visual indicators for the current plan selection</li>
          <li>Form inputs use proper labels and validation messages</li>
          <li>Dialog has proper focus management and can be closed with the Escape key</li>
        </ul>
      </div>
    </section>
    
    <!-- Best Practices -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Best Practices</h2>
      <div class="grid md:grid-cols-2 gap-8">
        <div>
          <h3 class="text-lg font-medium mb-4">Do</h3>
          <ul class="list-disc pl-6 space-y-4 text-muted-foreground">
            <li>Clearly highlight the user's current plan</li>
            <li>Provide detailed feature comparisons between plans</li>
            <li>Clearly explain when plan changes will take effect</li>
            <li>Show pricing differences between billing cycles</li>
            <li>Include confirmation steps for changes that affect billing</li>
            <li>Allow users to cancel pending downgrades</li>
          </ul>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-4">Don't</h3>
          <ul class="list-disc pl-6 space-y-4 text-muted-foreground">
            <li>Hide important information about billing changes</li>
            <li>Use confusing terminology for subscription statuses</li>
            <li>Make it difficult to compare plans</li>
            <li>Force immediate changes without confirmation</li>
            <li>Use misleading or hidden pricing information</li>
            <li>Implement downgrade without showing clear information about when it takes effect</li>
          </ul>
        </div>
      </div>
    </section>
  </div>
</template> 