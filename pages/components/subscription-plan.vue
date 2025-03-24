<script setup lang="ts">
import { mockSubscriptionPlans, mockCourseSubscriptions } from '~/data/mockSubscriptions'

// Example course-specific subscriptions
const courseSubscriptions = [
  {
    id: 'sub_123',
    courseId: 'course_abc',
    courseName: 'Intermediate Salsa',
    planId: 'regular',
    price: 14.99,
    status: 'active',
    currentPeriodEnd: '2024-01-01T00:00:00Z',
    cancelAtPeriodEnd: false
  },
  {
    id: 'sub_456',
    courseId: 'course_def',
    courseName: 'Advanced Bachata',
    planId: 'premium',
    price: 19.99,
    status: 'active',
    currentPeriodEnd: '2024-01-15T00:00:00Z',
    cancelAtPeriodEnd: false
  }
]
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-16">Subscription</h1>

    <!-- Introduction -->
    <section class="mb-16">
      <p class="text-lg text-muted-foreground">
        The Subscription component allows users to view and manage their course subscriptions.
        Users can subscribe to multiple courses independently, with each course having its own
        subscription status. This component provides interfaces for viewing active subscriptions,
        changing plans, and canceling subscriptions.
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
&lt;SubscriptionSettings :courseId="courseId" /&gt;</pre
        >
      </div>
    </section>

    <!-- Features -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Features</h2>
      <div class="space-y-6">
        <div>
          <h3 class="text-lg font-medium mb-2">Subscription Management</h3>
          <p class="text-muted-foreground">
            Allows users to view all their course subscriptions in one place, with the ability to manage each one individually.
          </p>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-2">Course-specific Plans</h3>
          <p class="text-muted-foreground">
            Each course can have its own set of subscription plans with different features and pricing.
          </p>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-2">Subscription Cancellation</h3>
          <p class="text-muted-foreground">
            Provides a straightforward process for cancelling a course subscription with clear information
            about what happens after cancellation.
          </p>
        </div>
      </div>
    </section>
    
    <!-- Course Page Manage Subscription Button -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Course Page Button</h2>
      <p class="text-muted-foreground mb-6">
        When a user is already subscribed to a course, display a "Manage Subscription" button instead of the "View Pricing Plans" button.
      </p>
      
      <div class="border rounded-lg p-6 mb-8">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <!-- Non-subscribed View -->
          <div class="space-y-4">
            <h3 class="text-lg font-medium">Not Subscribed</h3>
            
            <div class="border rounded-lg p-6 bg-gray-50">
              <div class="mb-4">
                <div class="text-sm text-muted-foreground">Starting from</div>
                <div class="text-3xl font-bold mb-4">60 EUR</div>
                
                <Button class="w-full">View Pricing Plans</Button>
              </div>
              <div class="text-xs text-center text-muted-foreground">
                24-hours money-back guarantee
              </div>
            </div>
          </div>
          
          <!-- Subscribed View -->
          <div class="space-y-4">
            <h3 class="text-lg font-medium">Subscribed</h3>
            
            <div class="border rounded-lg p-6 bg-gray-50">
              <div class="mb-4">
                <div class="flex items-center gap-2 mb-1">
                  <Badge variant="success" class="bg-green-100 text-green-800 hover:bg-green-100">Active</Badge>
                  <div class="text-sm text-muted-foreground">Premium Plan</div>
                </div>
                <div class="text-sm text-muted-foreground mb-4">Renews on January 15, 2024</div>
                
                <Button variant="outline" class="w-full">
                  <Icon name="i-heroicons-adjustments-horizontal" class="mr-2 h-4 w-4" />
                  Manage Subscription
                </Button>
              </div>
              <div class="text-xs text-center text-muted-foreground">
                Access available until end of billing period
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Single Course Subscription View -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Single Course Subscription View</h2>
      <p class="text-muted-foreground mb-6">
        When a user clicks "Manage Subscription" from the course page, they see this focused view for the specific course.
      </p>
      
      <div class="border rounded-lg p-6 mb-8">
        <div>
          <!-- Course Info Header -->
          <div class="flex items-center justify-between mb-6">
            <div>
              <h3 class="text-xl font-medium">Advanced Bachata</h3>
              <p class="text-sm text-muted-foreground">Manage your subscription to this course</p>
            </div>
            <Button variant="ghost" size="sm">
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
                <div class="font-medium">January 15, 2024</div>
              </div>
            </div>
          </div>
          
          <!-- Available Plans -->
          <div class="grid md:grid-cols-2 gap-6 mb-6">
            <div class="relative border rounded-lg p-6">
              <h4 class="text-xl font-medium mb-2">Regular Plan</h4>
              <p class="text-sm text-muted-foreground mb-4">Essential course content</p>
              <div class="mb-6">
                <span class="text-3xl font-bold">€14.99</span>
                <span class="text-muted-foreground">/mo</span>
              </div>
              
              <ul class="mb-6 space-y-2">
                <li class="flex items-start">
                  <Icon name="i-heroicons-check-circle" class="text-primary mr-2 h-5 w-5 mt-0.5" />
                  <span class="text-sm">Full course access</span>
                </li>
                <li class="flex items-start">
                  <Icon name="i-heroicons-check-circle" class="text-primary mr-2 h-5 w-5 mt-0.5" />
                  <span class="text-sm">Downloadable resources</span>
                </li>
                <li class="flex items-start">
                  <Icon name="i-heroicons-x-circle" class="text-muted-foreground/50 mr-2 h-5 w-5 mt-0.5" />
                  <span class="text-sm">Live Q&A sessions</span>
                </li>
              </ul>
              
              <Button class="w-full">Downgrade</Button>
            </div>
            
            <div class="relative border rounded-lg p-6 border-primary bg-primary/5">
              <Badge class="absolute top-3 right-3">Current</Badge>
              <h4 class="text-xl font-medium mb-2">Premium Plan</h4>
              <p class="text-sm text-muted-foreground mb-4">Full access including practice videos</p>
              <div class="mb-6">
                <span class="text-3xl font-bold">€19.99</span>
                <span class="text-muted-foreground">/mo</span>
              </div>
              
              <ul class="mb-6 space-y-2">
                <li class="flex items-start">
                  <Icon name="i-heroicons-check-circle" class="text-primary mr-2 h-5 w-5 mt-0.5" />
                  <span class="text-sm">Full course access</span>
                </li>
                <li class="flex items-start">
                  <Icon name="i-heroicons-check-circle" class="text-primary mr-2 h-5 w-5 mt-0.5" />
                  <span class="text-sm">Downloadable resources</span>
                </li>
                <li class="flex items-start">
                  <Icon name="i-heroicons-check-circle" class="text-primary mr-2 h-5 w-5 mt-0.5" />
                  <span class="text-sm">Live Q&A sessions</span>
                </li>
              </ul>
              
              <Button variant="outline" class="w-full" disabled>Current Plan</Button>
            </div>
          </div>
          
          <!-- Cancel Subscription -->
          <div class="border-t pt-6 mt-6 flex justify-end">
            <Button variant="outline" class="text-red-600 hover:bg-red-50 hover:text-red-700 border-red-200">
              Cancel Subscription
            </Button>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Current Subscriptions View -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">All Subscriptions View</h2>
      <div class="border rounded-lg p-6 mb-8">
        <div class="space-y-6">
          <!-- Multiple subscriptions list -->
          <div v-for="subscription in courseSubscriptions" :key="subscription.id" class="border rounded-lg">
            <div class="border-b p-4">
              <h4 class="font-medium">{{ subscription.courseName }}</h4>
            </div>
            
            <div class="p-4 space-y-4">
              <!-- Plan details -->
              <div class="grid grid-cols-3 gap-4">
                <div>
                  <div class="text-sm text-muted-foreground">Plan</div>
                  <div class="font-medium">{{ subscription.planId === 'regular' ? 'Regular Plan' : 'Premium Plan' }}</div>
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
                <div class="font-medium">{{ new Date(subscription.currentPeriodEnd).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' }) }}</div>
              </div>
            </div>
            
            <!-- Subscription Actions -->
            <div class="border-t p-4 bg-muted/30 flex justify-end items-center">
              <Button variant="outline">
                Manage Subscription
              </Button>
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
                <div class="font-medium">Your subscription to "Intermediate Salsa" will be cancelled</div>
                <p class="text-sm">
                  Your subscription will end on January 1, 2024. You'll lose access to this course after this date.
                </p>
                <Button variant="link" class="p-0 h-auto text-sm">
                  Keep my subscription
                </Button>
              </div>
            </div>
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
              <h4 class="text-lg font-medium mb-2">Downgrade "Advanced Bachata" Subscription</h4>
              <p class="text-sm text-muted-foreground mb-4">
                Review your subscription change before confirming.
              </p>
            </div>
            
            <div class="py-4">
              <div class="grid grid-cols-2 gap-4 mb-4">
                <div class="border rounded-lg p-4">
                  <div class="text-sm text-muted-foreground mb-1">Current Plan</div>
                  <div class="font-medium">Premium Plan</div>
                  <div class="text-sm mt-4">€19.99/mo</div>
                </div>
                <div class="border rounded-lg p-4 bg-primary/5 border-primary">
                  <div class="text-sm text-muted-foreground mb-1">New Plan</div>
                  <div class="font-medium">Regular Plan</div>
                  <div class="text-sm mt-4">€14.99/mo</div>
                </div>
              </div>
              
              <Alert class="mb-4">
                <AlertTitle>When will this change take effect?</AlertTitle>
                <AlertDescription>
                  Your plan will change at the end of your current billing period on January 15, 2024. 
                  You'll continue to have access to your current plan until then.
                </AlertDescription>
              </Alert>
              
              <div class="flex items-start gap-x-3 mb-6">
                <Checkbox id="downgrade-terms" />
                <div>
                  <label for="downgrade-terms" class="text-sm font-medium cursor-pointer">
                    I understand that this will downgrade my course access at the end of my billing period.
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
              <h4 class="text-lg font-medium mb-2">Cancel "Intermediate Salsa" Subscription</h4>
              <p class="text-sm text-muted-foreground mb-4">
                Are you sure you want to cancel your subscription to this course?
              </p>
            </div>
            
            <div class="py-4">
              <Alert variant="warning" class="mb-4">
                <AlertTitle>Important information</AlertTitle>
                <AlertDescription>
                  <ul class="list-disc pl-4 space-y-1">
                    <li>Your subscription will remain active until the end of your current billing period on January 1, 2024.</li>
                    <li>After this date, you'll lose access to this course.</li>
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
                  <SelectItem value="completed">I've completed the course</SelectItem>
                  <SelectItem value="too-expensive">It's too expensive</SelectItem>
                  <SelectItem value="not-what-expected">Not what I expected</SelectItem>
                  <SelectItem value="technical-issues">Technical issues</SelectItem>
                  <SelectItem value="no-time">Don't have time right now</SelectItem>
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

        <!-- Money-Back Guarantee Cancellation Dialog -->
        <div class="border rounded-lg p-6">
          <h3 class="text-lg font-medium mb-6">Money-Back Guarantee Dialog</h3>
          <div class="border rounded-lg p-6 mx-auto">
            <div class="mb-4">
              <h4 class="text-lg font-medium mb-2">Cancel "Advanced Bachata" Subscription</h4>
              <p class="text-sm text-muted-foreground mb-4">
                You're eligible for a full refund under our 24-hour money-back guarantee.
              </p>
            </div>
            
            <div class="py-4">
              <div class="flex items-center gap-3 mb-6 bg-blue-50 border border-blue-200 rounded-md p-3 text-blue-800">
                <Icon name="i-heroicons-clock" class="h-5 w-5 flex-shrink-0" />
                <div>
                  <div class="font-medium">Your subscription is less than 24 hours old</div>
                  <p class="text-sm mt-1">
                    You subscribed on January 14, 2024 at 9:23 AM. You're eligible for a full refund.
                  </p>
                </div>
              </div>
              
              <Alert variant="success" class="mb-4">
                <AlertTitle>Full refund available</AlertTitle>
                <AlertDescription>
                  <ul class="list-disc pl-4 space-y-1">
                    <li>Your payment of <strong>€19.99</strong> will be refunded to your original payment method.</li>
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
            
            <div class="flex justify-end gap-x-2">
              <Button variant="ghost">
                Keep Subscription
              </Button>
              <Button variant="destructive">
                Cancel and Refund
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
          <div class="font-mono text-sm">courseId</div>
          <div class="text-muted-foreground">String</div>
          <div class="text-muted-foreground">undefined</div>
          <div class="text-muted-foreground">ID of the course to manage subscription for</div>
        </div>
        <div class="grid grid-cols-4 gap-4 p-4 border-b">
          <div class="font-mono text-sm">plans</div>
          <div class="text-muted-foreground">Array</div>
          <div class="text-muted-foreground">[ ]</div>
          <div class="text-muted-foreground">Array of available subscription plans for the course</div>
        </div>
        <div class="grid grid-cols-4 gap-4 p-4 border-b">
          <div class="font-mono text-sm">subscriptions</div>
          <div class="text-muted-foreground">Array</div>
          <div class="text-muted-foreground">[ ]</div>
          <div class="text-muted-foreground">User's current course subscriptions</div>
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
            <li>Clearly show which course each subscription belongs to</li>
            <li>Provide a simple way to cancel each course subscription</li>
            <li>Clearly explain when plan changes will take effect</li>
            <li>Show pricing in Euros with clear monthly charges</li>
            <li>Include confirmation steps for any subscription changes</li>
            <li>Allow users to undo pending cancellations</li>
          </ul>
        </div>
        <div>
          <h3 class="text-lg font-medium mb-4">Don't</h3>
          <ul class="list-disc pl-6 space-y-4 text-muted-foreground">
            <li>Hide or make it difficult to find the cancellation option</li>
            <li>Use confusing terminology for subscription statuses</li>
            <li>Implement cancellation without clear information about when it takes effect</li>
            <li>Force immediate changes without confirmation</li>
            <li>Use misleading or hidden pricing information</li>
            <li>Make cancellation process overly complicated with multiple steps</li>
          </ul>
        </div>
      </div>
    </section>
  </div>
</template> 