<script setup lang="ts">
import { ref, computed } from 'vue'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { toast } from 'vue-sonner'

const props = defineProps<{
  firstName?: string
  lastName?: string
  email?: string
  previewMode?: boolean
}>()

const isPreviewMode = ref(props.previewMode || false)

// Schema for email template fields
const emailTemplateSchema = z.object({
  subject: z.string().min(1, 'Subject is required'),
  greeting: z.string().min(1, 'Greeting is required'),
  introText: z.string().min(1, 'Introduction text is required'),
  feature1Title: z.string().min(1, 'Feature title is required'),
  feature1Text: z.string().min(1, 'Feature description is required'),
  feature2Title: z.string().min(1, 'Feature title is required'),
  feature2Text: z.string().min(1, 'Feature description is required'),
  feature3Title: z.string().min(1, 'Feature title is required'),
  feature3Text: z.string().min(1, 'Feature description is required'),
  ctaText: z.string().min(1, 'Call to action text is required'),
  ctaUrl: z.string().url('Please enter a valid URL'),
  signatureText: z.string().min(1, 'Signature is required'),
})

const form = useForm({
  validationSchema: toTypedSchema(emailTemplateSchema),
  initialValues: {
    subject: 'Welcome to WeDance! 💃',
    greeting: `Hi ${props.firstName || '{firstName}'},`,
    introText:
      "Thank you for joining WeDance! We're excited to have you as part of our global dance community. Here's what you can do with your new account:",
    feature1Title: 'Discover Events',
    feature1Text:
      'Find dance events, workshops, and festivals happening near you or anywhere in the world.',
    feature2Title: 'Connect with Dancers',
    feature2Text:
      'Meet other dancers, teachers, and organizers who share your passion for dance.',
    feature3Title: 'Share Your Journey',
    feature3Text:
      'Post your dance experiences, ask questions, and contribute to our growing community.',
    ctaText: 'Start Exploring',
    ctaUrl: 'https://wedance.vip/explore',
    signatureText: 'The WeDance Team',
  },
})

const testEmailForm = useForm({
  initialValues: {
    testEmail: props.email || '',
  },
  validationSchema: toTypedSchema(
    z.object({
      testEmail: z.string().email('Please enter a valid email address'),
    })
  ),
})

const personalizedSubject = computed(() => {
  return form.values.subject
})

const personalizedGreeting = computed(() => {
  if (!props.firstName) return form.values.greeting
  return form.values.greeting.replace('{firstName}', props.firstName)
})

const togglePreviewMode = () => {
  isPreviewMode.value = !isPreviewMode.value
}

const saveTemplate = form.handleSubmit(
  async (values) => {
    // This would typically connect to a backend API to save the template
    toast.success('Email template saved successfully')
  },
  () => {
    toast.error('Please fix the errors in the form')
  }
)

const sendTestEmail = testEmailForm.handleSubmit(
  async (values) => {
    // This would typically connect to a backend API to send a test email
    toast.success(`Test email sent to ${values.testEmail}`)
  },
  () => {
    toast.error('Please provide a valid email address')
  }
)
</script>

<template>
  <div>
    <div class="mb-6 flex items-center justify-between">
      <h2 class="text-2xl font-bold">Welcome Email Template</h2>
      <div class="flex gap-2">
        <Button variant="outline" @click="togglePreviewMode">
          {{ isPreviewMode ? 'Edit Template' : 'Preview Email' }}
        </Button>
        <Button v-if="!isPreviewMode" @click="saveTemplate"
          >Save Template</Button
        >
      </div>
    </div>

    <!-- Edit Mode -->
    <div v-if="!isPreviewMode" class="space-y-6">
      <form @submit="saveTemplate" class="space-y-4">
        <FormField v-slot="{ componentField }" name="subject">
          <FormItem>
            <FormLabel>Email Subject</FormLabel>
            <FormControl>
              <Input
                v-bind="componentField"
                placeholder="Welcome to WeDance!"
              />
            </FormControl>
            <FormDescription>The subject line of the email</FormDescription>
            <FormMessage />
          </FormItem>
        </FormField>

        <FormField v-slot="{ componentField }" name="greeting">
          <FormItem>
            <FormLabel>Greeting</FormLabel>
            <FormControl>
              <Input v-bind="componentField" placeholder="Hi {firstName}," />
            </FormControl>
            <FormDescription
              >Use {firstName} as a placeholder for the recipient's first
              name</FormDescription
            >
            <FormMessage />
          </FormItem>
        </FormField>

        <FormField v-slot="{ componentField }" name="introText">
          <FormItem>
            <FormLabel>Introduction Text</FormLabel>
            <FormControl>
              <Textarea
                v-bind="componentField"
                placeholder="Welcome to WeDance..."
              />
            </FormControl>
            <FormDescription>The initial welcome message</FormDescription>
            <FormMessage />
          </FormItem>
        </FormField>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div class="space-y-4">
            <h3 class="font-semibold">Feature 1</h3>
            <FormField v-slot="{ componentField }" name="feature1Title">
              <FormItem>
                <FormLabel>Title</FormLabel>
                <FormControl>
                  <Input
                    v-bind="componentField"
                    placeholder="Discover Events"
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            </FormField>

            <FormField v-slot="{ componentField }" name="feature1Text">
              <FormItem>
                <FormLabel>Description</FormLabel>
                <FormControl>
                  <Textarea
                    v-bind="componentField"
                    placeholder="Find dance events near you..."
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            </FormField>
          </div>

          <div class="space-y-4">
            <h3 class="font-semibold">Feature 2</h3>
            <FormField v-slot="{ componentField }" name="feature2Title">
              <FormItem>
                <FormLabel>Title</FormLabel>
                <FormControl>
                  <Input
                    v-bind="componentField"
                    placeholder="Connect with Dancers"
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            </FormField>

            <FormField v-slot="{ componentField }" name="feature2Text">
              <FormItem>
                <FormLabel>Description</FormLabel>
                <FormControl>
                  <Textarea
                    v-bind="componentField"
                    placeholder="Meet other dancers..."
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            </FormField>
          </div>

          <div class="space-y-4">
            <h3 class="font-semibold">Feature 3</h3>
            <FormField v-slot="{ componentField }" name="feature3Title">
              <FormItem>
                <FormLabel>Title</FormLabel>
                <FormControl>
                  <Input
                    v-bind="componentField"
                    placeholder="Share Your Journey"
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            </FormField>

            <FormField v-slot="{ componentField }" name="feature3Text">
              <FormItem>
                <FormLabel>Description</FormLabel>
                <FormControl>
                  <Textarea
                    v-bind="componentField"
                    placeholder="Post your dance experiences..."
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            </FormField>
          </div>

          <div class="space-y-4">
            <h3 class="font-semibold">Call to Action</h3>
            <FormField v-slot="{ componentField }" name="ctaText">
              <FormItem>
                <FormLabel>Button Text</FormLabel>
                <FormControl>
                  <Input
                    v-bind="componentField"
                    placeholder="Start Exploring"
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            </FormField>

            <FormField v-slot="{ componentField }" name="ctaUrl">
              <FormItem>
                <FormLabel>Button URL</FormLabel>
                <FormControl>
                  <Input
                    v-bind="componentField"
                    placeholder="https://wedance.vip/explore"
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            </FormField>
          </div>
        </div>

        <FormField v-slot="{ componentField }" name="signatureText">
          <FormItem>
            <FormLabel>Signature</FormLabel>
            <FormControl>
              <Input v-bind="componentField" placeholder="The WeDance Team" />
            </FormControl>
            <FormMessage />
          </FormItem>
        </FormField>
      </form>

      <div class="border-t pt-6">
        <h3 class="font-semibold mb-4">Send Test Email</h3>
        <form @submit.prevent="sendTestEmail" class="flex gap-4 items-end">
          <FormField
            v-slot="{ componentField }"
            name="testEmail"
            class="flex-1"
          >
            <FormItem>
              <FormLabel>Email Address</FormLabel>
              <FormControl>
                <Input
                  v-bind="componentField"
                  placeholder="Enter email address"
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          </FormField>
          <Button type="submit">Send Test Email</Button>
        </form>
      </div>
    </div>

    <!-- Preview Mode -->
    <div v-else class="border rounded-lg overflow-hidden">
      <div class="bg-muted p-4 border-b">
        <div class="flex items-center gap-4">
          <div class="w-3 h-3 rounded-full bg-red-500"></div>
          <div class="w-3 h-3 rounded-full bg-yellow-500"></div>
          <div class="w-3 h-3 rounded-full bg-green-500"></div>
          <div
            class="flex-1 text-center text-sm font-mono text-muted-foreground truncate"
          >
            {{ personalizedSubject }}
          </div>
        </div>
      </div>

      <div class="bg-background text-foreground p-8 max-w-2xl mx-auto">
        <div class="mb-6">
          <WeDanceLogo class="h-12 w-auto" />
        </div>

        <p class="text-lg font-medium mb-4">{{ personalizedGreeting }}</p>

        <p class="mb-6">{{ form.values.introText }}</p>

        <div class="space-y-6 mb-8">
          <div class="flex gap-4">
            <div class="bg-primary/10 rounded-full p-2 h-fit">
              <Icon name="ph:calendar" class="text-primary w-5 h-5" />
            </div>
            <div>
              <h3 class="font-bold text-lg">{{ form.values.feature1Title }}</h3>
              <p>{{ form.values.feature1Text }}</p>
            </div>
          </div>

          <div class="flex gap-4">
            <div class="bg-primary/10 rounded-full p-2 h-fit">
              <Icon name="ph:users" class="text-primary w-5 h-5" />
            </div>
            <div>
              <h3 class="font-bold text-lg">{{ form.values.feature2Title }}</h3>
              <p>{{ form.values.feature2Text }}</p>
            </div>
          </div>

          <div class="flex gap-4">
            <div class="bg-primary/10 rounded-full p-2 h-fit">
              <Icon name="ph:share-network" class="text-primary w-5 h-5" />
            </div>
            <div>
              <h3 class="font-bold text-lg">{{ form.values.feature3Title }}</h3>
              <p>{{ form.values.feature3Text }}</p>
            </div>
          </div>
        </div>

        <div class="text-center my-8">
          <Button size="lg" class="px-8">{{ form.values.ctaText }}</Button>
        </div>

        <div class="border-t pt-6 text-center text-muted-foreground">
          <p class="mb-2">{{ form.values.signatureText }}</p>
          <p class="text-sm">
            © {{ new Date().getFullYear() }} WeDance. All rights reserved.
          </p>
          <p class="text-xs mt-2">
            <a href="#" class="underline hover:text-primary">Unsubscribe</a> ·
            <a href="#" class="underline hover:text-primary">Privacy Policy</a>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>
