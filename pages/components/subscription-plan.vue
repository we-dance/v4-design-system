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
    <h1 class="text-3xl font-bold mb-16">Subscription</h1>

    <!-- Introduction -->
    <section class="mb-16">
      <p class="text-lg text-muted-foreground">
        The Subscription component allows users to view and manage their subscription status,
        change plans, and cancel their subscription. It follows industry best practices seen in
        services like Netflix, Notion, and Trello.
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
          <h3 class="text-lg font-medium mb-2">Current Subscription View</h3>
          <p class="text-muted-foreground">
            Displays the user's current subscription status, plan details, renewal date, and provides
            options to change or cancel their subscription.
          </p>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-2">Plan Selection</h3>
          <p class="text-muted-foreground">
            Allows users to compare available plans and upgrade or downgrade to a different plan.
          </p>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-2">Subscription Cancellation</h3>
          <p class="text-muted-foreground">
            Provides a straightforward process for cancelling a subscription with clear information
            about what happens after cancellation.
          </p>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-2">Billing Cycle Toggle</h3>
          <p class="text-muted-foreground">
            Allows users to switch between monthly and annual billing cycles to compare prices and savings.
          </p>
        </div>
      </div>
    </section>
    
    <!-- Current Subscription View -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Current Subscription View</h2>
      <div class="border rounded-lg p-6 mb-8">
        <div class="border rounded-lg mb-8">
          <div class="border-b p-4">
            <h4 class="font-medium">Current Plan</h4>
          </div>
          
          <div class="p-4 space-y-4">
            <!-- Plan details -->
            <div class="grid grid-cols-3 gap-4">
              <div>
                <div class="text-sm text-muted-foreground">Plan</div>
                <div class="font-medium">Pro</div>
              </div>
              <div>
                <div class="text-sm text-muted-foreground">Billing Cycle</div>
                <div class="font-medium">Monthly</div>
              </div>
              <div>
                <div class="text-sm text-muted-foreground">Price</div>
                <div class="font-medium">$19.99/mo</div>
              </div>
            </div>
            
            <!-- Renewal info -->
            <div>
              <div class="text-sm text-muted-foreground">Renews On</div>
              <div class="font-medium">January 1, 2024</div>
            </div>
          </div>
          
          <!-- Subscription Actions -->
          <div class="border-t p-4 bg-muted/30 flex justify-between items-center">
            <div>
              <Button variant="outline">
                Cancel Subscription
              </Button>
            </div>
            <div class="flex items-center gap-2">
              <span class="text-sm mr-2 font-medium">Monthly</span>
              <Switch />
              <span class="text-sm ml-2">Annually</span>
              <Badge variant="outline" class="ml-2">Save 20%</Badge>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Pending Changes -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Pending Changes</h2>
      <div class="grid md:grid-cols-2 gap-8">
        <!-- Cancellation Notice -->
        <div class="border rounded-lg p-6">
          <h3 class="text-lg font-medium mb-6">Cancellation Notice</h3>
          <div class="bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-800">
            <div class="flex items-start">
              <Icon name="i-heroicons-exclamation-triangle" class="h-5 w-5 mr-2 mt-0.5" />
              <div>
                <div class="font-medium">Your subscription will be cancelled</div>
                <p class="text-sm">
                  Your subscription will end on January 1, 2024. You'll lose access to premium features after this date.
                </p>
                <Button variant="link" class="p-0 h-auto text-sm">
                  Keep my subscription
                </Button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Downgrade Notice -->
        <div class="border rounded-lg p-6">
          <h3 class="text-lg font-medium mb-6">Downgrade Notice</h3>
          <div class="bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-800">
            <div class="flex items-start">
              <Icon name="i-heroicons-exclamation-triangle" class="h-5 w-5 mr-2 mt-0.5" />
              <div>
                <div class="font-medium">Your plan will change soon</div>
                <p class="text-sm">
                  On January 1, 2024, your plan will change to Basic.
                </p>
                <Button variant="link" class="p-0 h-auto text-sm">
                  Cancel plan change
                </Button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Plan Selection -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Plan Selection</h2>
      <div class="border rounded-lg p-6 mb-8">
        <h4 class="text-lg font-medium mb-4">Available Plans</h4>
        <div class="grid md:grid-cols-3 gap-6">
          <div class="relative border rounded-lg p-6">
            <h4 class="text-xl font-medium mb-2">Free</h4>
            <p class="text-sm text-muted-foreground mb-4">Basic features for casual dancers</p>
            <div class="mb-6">
              <span class="text-3xl font-bold">$0.00</span>
              <span class="text-muted-foreground">/mo</span>
            </div>
            <Button class="w-full">Downgrade</Button>
          </div>
          
          <div class="relative border rounded-lg p-6">
            <h4 class="text-xl font-medium mb-2">Basic</h4>
            <p class="text-sm text-muted-foreground mb-4">Essential features for active dancers</p>
            <div class="mb-6">
              <span class="text-3xl font-bold">$9.99</span>
              <span class="text-muted-foreground">/mo</span>
            </div>
            <Button class="w-full">Downgrade</Button>
          </div>
          
          <div class="relative border rounded-lg p-6 border-primary bg-primary/5">
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

    <!-- Confirmation Dialogs -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Confirmation Dialogs</h2>
      <div class="grid md:grid-cols-2 gap-8">
        <!-- Plan Change Dialog -->
        <div class="border rounded-lg p-6">
          <h3 class="text-lg font-medium mb-6">Plan Change Dialog</h3>
          <div class="border rounded-lg p-6 mx-auto">
            <div class="mb-4">
              <h4 class="text-lg font-medium mb-2">Downgrade to Basic</h4>
              <p class="text-sm text-muted-foreground mb-4">
                Review your subscription change before confirming.
              </p>
            </div>
            
            <div class="py-4">
              <div class="grid grid-cols-2 gap-4 mb-4">
                <div class="border rounded-lg p-4">
                  <div class="text-sm text-muted-foreground mb-1">Current Plan</div>
                  <div class="font-medium">Pro</div>
                  <div class="text-sm mt-4">$19.99/mo</div>
                </div>
                <div class="border rounded-lg p-4 bg-primary/5 border-primary">
                  <div class="text-sm text-muted-foreground mb-1">New Plan</div>
                  <div class="font-medium">Basic</div>
                  <div class="text-sm mt-4">$9.99/mo</div>
                </div>
              </div>
              
              <Alert class="mb-4">
                <AlertTitle>When will this change take effect?</AlertTitle>
                <AlertDescription>
                  Your plan will change at the end of your current billing period on January 1, 2024. 
                  You'll continue to have access to your current plan until then.
                </AlertDescription>
              </Alert>
              
              <div class="flex items-start gap-x-3 mb-6">
                <Checkbox id="downgrade-terms" />
                <div>
                  <label for="downgrade-terms" class="text-sm font-medium cursor-pointer">
                    I understand that this will downgrade my plan at the end of my billing period.
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
        
        <!-- Cancel Subscription Dialog -->
        <div class="border rounded-lg p-6">
          <h3 class="text-lg font-medium mb-6">Cancel Subscription Dialog</h3>
          <div class="border rounded-lg p-6 mx-auto">
            <div class="mb-4">
              <h4 class="text-lg font-medium mb-2">Cancel Subscription</h4>
              <p class="text-sm text-muted-foreground mb-4">
                Are you sure you want to cancel your subscription?
              </p>
            </div>
            
            <div class="py-4">
              <Alert variant="warning" class="mb-4">
                <AlertTitle>Important information</AlertTitle>
                <AlertDescription>
                  <ul class="list-disc pl-4 space-y-1">
                    <li>Your subscription will remain active until the end of your current billing period on January 1, 2024.</li>
                    <li>After this date, you'll lose access to all premium features.</li>
                    <li>You can resubscribe at any time.</li>
                  </ul>
                </AlertDescription>
              </Alert>
              
              <div class="text-sm text-muted-foreground mb-2">
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
            
            <div class="flex justify-end gap-x-2">
              <Button variant="ghost">
                Keep Subscription
              </Button>
              <Button variant="destructive">
                Cancel Subscription
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
          <div class="text-muted-foreground">Array of available subscription plans</div>
        </div>
        <div class="grid grid-cols-4 gap-4 p-4 border-b">
          <div class="font-mono text-sm">userSubscription</div>
          <div class="text-muted-foreground">Object</div>
          <div class="text-muted-foreground">{ }</div>
          <div class="text-muted-foreground">User's current subscription details</div>
        </div>
        <div class="grid grid-cols-4 gap-4 p-4">
          <div class="font-mono text-sm">onSubscriptionChange</div>
          <div class="text-muted-foreground">Function</div>
          <div class="text-muted-foreground">undefined</div>
          <div class="text-muted-foreground">
            Callback function when subscription status changes
          </div>
        </div>
      </div>
    </section>

    <!-- Accessibility -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Accessibility</h2>
      <div class="space-y-4">
        <p class="text-muted-foreground">
          The Subscription component follows these accessibility guidelines:
        </p>
        <ul class="list-disc pl-6 space-y-2 text-muted-foreground">
          <li>Color contrast meets WCAG 2.1 AA standards for all text elements</li>
          <li>Interactive elements are keyboard navigable and have proper focus states</li>
          <li>Clear visual indicators for the current plan selection</li>
          <li>Form inputs use proper labels and validation messages</li>
          <li>Dialogs have proper focus management and can be closed with the Escape key</li>
          <li>Important information is communicated clearly with appropriate notices and alerts</li>
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
            <li>Clearly show the user's current subscription status</li>
            <li>Provide a simple way to cancel a subscription</li>
            <li>Clearly explain when plan changes will take effect</li>
            <li>Show pricing differences between plans and billing cycles</li>
            <li>Include confirmation steps for changes that affect billing</li>
            <li>Allow users to undo pending cancellations or plan changes</li>
          </ul>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-4">Don't</h3>
          <ul class="list-disc pl-6 space-y-4 text-muted-foreground">
            <li>Hide or make it difficult to find the cancellation option</li>
            <li>Use confusing terminology for subscription statuses</li>
            <li>Implement downgrade/cancellation without clear information about when it takes effect</li>
            <li>Force immediate changes without confirmation</li>
            <li>Use misleading or hidden pricing information</li>
            <li>Make cancellation process overly complicated with multiple steps</li>
          </ul>
        </div>
      </div>
    </section>
  </div>
</template> 