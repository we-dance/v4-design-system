<script setup lang="ts">
import { ref } from 'vue'

// Sample user data for preview
const mockUser = {
  firstName: 'Jane',
  lastName: 'Smith',
  email: 'jane.smith@example.com',
}

const previewMode = ref(true)
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-4">Welcome Email Component</h1>
    <p class="text-muted-foreground mb-6">
      A component for creating, previewing, and customizing welcome emails for
      new users.
    </p>

    <Tabs default-value="preview" class="mb-8">
      <TabsList>
        <TabsTrigger value="preview">Preview</TabsTrigger>
        <TabsTrigger value="code">Code</TabsTrigger>
        <TabsTrigger value="usage">Usage</TabsTrigger>
      </TabsList>
      <TabsContent value="preview" class="p-4 border rounded-md mt-2">
        <div class="mb-4 flex flex-wrap gap-4">
          <Button variant="outline" @click="previewMode = !previewMode">
            {{ previewMode ? 'Show Edit Mode' : 'Show Preview Mode' }}
          </Button>
        </div>
        <WelcomeEmail
          :firstName="mockUser.firstName"
          :lastName="mockUser.lastName"
          :email="mockUser.email"
          :previewMode="previewMode"
        />
      </TabsContent>
      <TabsContent value="code" class="p-4 border rounded-md mt-2">
        <div class="mb-4 font-semibold">Component Implementation</div>
        <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { toast } from 'vue-sonner'

const props = defineProps&lt;{
  firstName?: string
  lastName?: string
  email?: string
  previewMode?: boolean
}&gt;()

const isPreviewMode = ref(props.previewMode || false)

// Schema for email template fields
const emailTemplateSchema = z.object({
  subject: z.string().min(1, 'Subject is required'),
  greeting: z.string().min(1, 'Greeting is required'),
  introText: z.string().min(1, 'Introduction text is required'),
  // ... additional fields
})

// Form implementation
const form = useForm({
  validationSchema: toTypedSchema(emailTemplateSchema),
  initialValues: {
    subject: 'Welcome to WeDance! 💃',
    greeting: `Hi ${props.firstName || '{firstName}'},`,
    // ... additional fields
  }
})

// Toggle preview mode
const togglePreviewMode = () => {
  isPreviewMode.value = !isPreviewMode.value
}

// Save and send test email implementations
&lt;/script&gt;

&lt;template&gt;
  &lt;div&gt;
    &lt;div class="mb-6 flex items-center justify-between"&gt;
      &lt;h2 class="text-2xl font-bold"&gt;Welcome Email Template&lt;/h2&gt;
      &lt;div class="flex gap-2"&gt;
        &lt;Button variant="outline" @click="togglePreviewMode"&gt;
          {{ isPreviewMode ? 'Edit Template' : 'Preview Email' }}
        &lt;/Button&gt;
        &lt;Button v-if="!isPreviewMode" @click="saveTemplate"&gt;Save Template&lt;/Button&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Edit Mode --&gt;
    &lt;div v-if="!isPreviewMode" class="space-y-6"&gt;
      &lt;!-- Form fields --&gt;
    &lt;/div&gt;

    &lt;!-- Preview Mode --&gt;
    &lt;div v-else class="border rounded-lg overflow-hidden"&gt;
      &lt;!-- Email preview --&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/template&gt;
        </pre>
      </TabsContent>
      <TabsContent value="usage" class="p-4 border rounded-md mt-2">
        <div class="space-y-4">
          <div>
            <h3 class="text-lg font-semibold mb-2">Component Props</h3>
            <table class="w-full border-collapse">
              <thead>
                <tr class="border-b">
                  <th class="py-2 px-4 text-left">Prop</th>
                  <th class="py-2 px-4 text-left">Type</th>
                  <th class="py-2 px-4 text-left">Default</th>
                  <th class="py-2 px-4 text-left">Description</th>
                </tr>
              </thead>
              <tbody>
                <tr class="border-b">
                  <td class="py-2 px-4">firstName</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">undefined</td>
                  <td class="py-2 px-4">
                    Recipient's first name for personalization
                  </td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">lastName</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">undefined</td>
                  <td class="py-2 px-4">Recipient's last name</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">email</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">undefined</td>
                  <td class="py-2 px-4">
                    Recipient's email address (used for test emails)
                  </td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">previewMode</td>
                  <td class="py-2 px-4">boolean</td>
                  <td class="py-2 px-4">false</td>
                  <td class="py-2 px-4">
                    Whether to display in preview mode by default
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div>
            <h3 class="text-lg font-semibold mb-2">Example Usage</h3>
            <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;template&gt;
  &lt;WelcomeEmail 
    firstName="John"
    lastName="Doe"
    email="john.doe@example.com"
    :previewMode="true"
  /&gt;
&lt;/template&gt;
            </pre>
          </div>

          <div>
            <h3 class="text-lg font-semibold mb-2">Features</h3>
            <ul class="list-disc list-inside space-y-2">
              <li>Fully customizable email template with Zod validation</li>
              <li>
                Preview mode to see how the email will appear to recipients
              </li>
              <li>Support for personalization with dynamic content</li>
              <li>Send test emails to verify appearance</li>
              <li>Responsive design that works across email clients</li>
            </ul>
          </div>

          <Alert>
            <AlertTitle>Note</AlertTitle>
            <AlertDescription>
              This component provides only the UI for creating and previewing
              email templates. The actual email sending functionality would need
              to be implemented on the backend.
            </AlertDescription>
          </Alert>
        </div>
      </TabsContent>
    </Tabs>
  </div>
</template>
