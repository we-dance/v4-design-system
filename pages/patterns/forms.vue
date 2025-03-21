<script setup lang="ts">
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import { toast } from 'vue-sonner'
import * as z from 'zod'

// Example schema for the documentation
const exampleSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Please enter a valid email address'),
  message: z.string().min(10, 'Message must be at least 10 characters'),
  newsletter: z.boolean().default(false),
  category: z.enum(['feedback', 'support', 'feature']),
})

// Example form for the documentation
const form = useForm({
  validationSchema: toTypedSchema(exampleSchema),
  initialValues: {
    category: 'feedback',
  },
})

const onSubmit = form.handleSubmit(
  (values) => {
    toast.success('Form submitted successfully!')
    console.log(values)
  },
  (errors) => {
    toast.error('Please fix the errors in the form.')
    console.log(errors)
  }
)

// Form layout patterns
const formLayouts = [
  {
    name: 'standard',
    description: 'Default stacked layout with labels above inputs',
  },
  {
    name: 'horizontal',
    description: 'Layout with labels beside inputs, great for wider screens',
  },
  {
    name: 'grid',
    description: 'Grid layout for multiple fields in columns',
  },
  {
    name: 'compact',
    description: 'Compact layout with smaller spacing and optional labels',
  },
]

// Form field types
const fieldTypes = [
  {
    name: 'text',
    component: 'Input',
    description: 'Standard text input field',
  },
  {
    name: 'textarea',
    component: 'Textarea',
    description: 'Multi-line text input',
  },
  {
    name: 'select',
    component: 'Select',
    description: 'Dropdown selection field',
  },
  {
    name: 'checkbox',
    component: 'Checkbox',
    description: 'Single checkbox for boolean values',
  },
  {
    name: 'radio',
    component: 'RadioGroup',
    description: 'Radio button group for mutually exclusive options',
  },
  {
    name: 'phone',
    component: 'PhoneInput',
    description: 'Phone number input with country code selection',
  },
]
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-16">Form Patterns</h1>

    <!-- Introduction -->
    <section class="mb-16">
      <p class="text-lg text-muted-foreground">
        Forms allow users to input and submit data. This guide covers form
        patterns, validation, and best practices using vee-validate with zod for
        form validation.
      </p>
    </section>

    <!-- Form Architecture -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Form Architecture</h2>
      <div class="space-y-4">
        <p class="text-muted-foreground">
          The WeDance design system uses the following components for building
          forms:
        </p>
        <ul class="list-disc pl-6 space-y-2 text-muted-foreground">
          <li>
            <strong>vee-validate</strong> - Form validation library that
            provides components and functions to handle form state
          </li>
          <li>
            <strong>zod</strong> - Schema validation library used to define form
            schemas
          </li>
          <li>
            <strong>Form Components</strong> - Reusable UI components for form
            inputs (Input, Textarea, Select, etc.)
          </li>
          <li>
            <strong>FormField</strong> - A wrapper component that connects the
            form context to individual form controls
          </li>
        </ul>

        <div class="bg-muted p-4 rounded-lg mt-4">
          <p class="font-medium">The form component hierarchy</p>
          <pre class="mt-2 text-sm font-mono">
FormField
  └── FormItem
    ├── FormLabel
    ├── FormControl
    │   └── Input/Select/Checkbox/etc.
    ├── FormDescription
    └── FormMessage</pre
          >
        </div>
      </div>
    </section>

    <!-- Schema Validation -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Schema Validation with Zod</h2>
      <div class="space-y-4">
        <p class="text-muted-foreground">
          All form schemas should be defined in the <code>schemas</code> folder
          using zod. Here's an example schema:
        </p>
        <pre class="p-4 rounded-lg bg-muted font-mono text-sm">
import * as z from 'zod'

export const contactSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Please enter a valid email address'),
  message: z.string().min(10, 'Message must be at least 10 characters'),
  newsletter: z.boolean().default(false),
  category: z.enum(['feedback', 'support', 'feature']),
})</pre
        >
      </div>
    </section>

    <!-- Basic Form Example -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Basic Form Example</h2>
      <div class="space-y-4">
        <p class="text-muted-foreground">
          Here's a basic example of a form using vee-validate with zod:
        </p>
        <pre class="p-4 rounded-lg bg-muted font-mono text-sm overflow-auto">
&lt;script setup lang="ts"&gt;
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import { toast } from 'vue-sonner'
import { contactSchema } from '~/schemas/contact'

const form = useForm({
  validationSchema: toTypedSchema(contactSchema),
})

const onSubmit = form.handleSubmit(
  async (values) => {
    // Handle successful submit
    toast.success('Form submitted successfully!')
  },
  (e) => {
    // Handle validation errors
    toast.error('Please fix the errors in the form.')
  }
)
&lt;/script&gt;

&lt;template&gt;
  &lt;form @submit="onSubmit" class="space-y-6"&gt;
    &lt;FormField v-slot="{ componentField }" name="name"&gt;
      &lt;FormItem&gt;
        &lt;FormLabel&gt;Name&lt;/FormLabel&gt;
        &lt;FormControl&gt;
          &lt;Input v-bind="componentField" /&gt;
        &lt;/FormControl&gt;
        &lt;FormDescription&gt;Your full name&lt;/FormDescription&gt;
        &lt;FormMessage /&gt;
      &lt;/FormItem&gt;
    &lt;/FormField&gt;
    
    &lt;!-- Other form fields... --&gt;
    
    &lt;Button type="submit"&gt;Submit&lt;/Button&gt;
  &lt;/form&gt;
&lt;/template&gt;</pre
        >
      </div>

      <!-- Live Example -->
      <div class="mt-8 border rounded-lg p-6">
        <h3 class="text-lg font-medium mb-4">Live Example</h3>
        <form @submit="onSubmit" class="space-y-6">
          <FormField v-slot="{ componentField }" name="name">
            <FormItem>
              <FormLabel>Name</FormLabel>
              <FormControl>
                <Input v-bind="componentField" />
              </FormControl>
              <FormDescription>Your full name</FormDescription>
              <FormMessage />
            </FormItem>
          </FormField>

          <FormField v-slot="{ componentField }" name="email">
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input v-bind="componentField" type="email" />
              </FormControl>
              <FormDescription>We'll never share your email</FormDescription>
              <FormMessage />
            </FormItem>
          </FormField>

          <FormField v-slot="{ componentField }" name="message">
            <FormItem>
              <FormLabel>Message</FormLabel>
              <FormControl>
                <Textarea v-bind="componentField" />
              </FormControl>
              <FormDescription>Your feedback or question</FormDescription>
              <FormMessage />
            </FormItem>
          </FormField>

          <FormField v-slot="{ value, handleChange }" name="newsletter">
            <FormItem class="flex flex-row items-start gap-x-3 space-y-0">
              <FormControl>
                <Checkbox :checked="value" @update:checked="handleChange" />
              </FormControl>
              <div class="space-y-1 leading-none">
                <FormLabel>Subscribe to newsletter</FormLabel>
                <FormDescription>
                  Get updates about new features and events
                </FormDescription>
                <FormMessage />
              </div>
            </FormItem>
          </FormField>

          <FormField v-slot="{ componentField }" name="category">
            <FormItem>
              <FormLabel>Category</FormLabel>
              <FormControl>
                <Select v-bind="componentField">
                  <option value="feedback">Feedback</option>
                  <option value="support">Support</option>
                  <option value="feature">Feature Request</option>
                </Select>
              </FormControl>
              <FormDescription>Select a category</FormDescription>
              <FormMessage />
            </FormItem>
          </FormField>

          <div class="flex justify-end">
            <Button type="submit">Submit</Button>
          </div>
        </form>
      </div>
    </section>

    <!-- Form Layouts -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Form Layouts</h2>
      <div class="grid gap-8">
        <div v-for="layout in formLayouts" :key="layout.name" class="space-y-4">
          <div>
            <h3 class="font-medium">{{ layout.name }}</h3>
            <p class="text-sm text-muted-foreground">
              {{ layout.description }}
            </p>
          </div>

          <!-- Example layout previews -->
          <div class="border rounded-lg p-4">
            <div v-if="layout.name === 'standard'" class="space-y-4">
              <FormField v-slot="{ componentField }" name="standardExample">
                <FormItem>
                  <FormLabel>Standard Layout</FormLabel>
                  <FormControl>
                    <Input
                      v-bind="componentField"
                      placeholder="Input example"
                    />
                  </FormControl>
                  <FormDescription>Stacked layout example</FormDescription>
                  <FormMessage />
                </FormItem>
              </FormField>
            </div>

            <div v-if="layout.name === 'horizontal'" class="space-y-4">
              <FormField v-slot="{ componentField }" name="horizontalExample">
                <FormItem class="flex flex-row items-center gap-4">
                  <FormLabel class="min-w-32 text-right"
                    >Horizontal Layout</FormLabel
                  >
                  <div class="flex-1">
                    <FormControl>
                      <Input
                        v-bind="componentField"
                        placeholder="Input example"
                      />
                    </FormControl>
                    <FormDescription>Horizontal layout example</FormDescription>
                    <FormMessage />
                  </div>
                </FormItem>
              </FormField>
            </div>

            <div v-if="layout.name === 'grid'" class="grid grid-cols-2 gap-4">
              <FormField v-slot="{ componentField }" name="gridExample1">
                <FormItem>
                  <FormLabel>First Name</FormLabel>
                  <FormControl>
                    <Input v-bind="componentField" placeholder="First name" />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              </FormField>
              <FormField v-slot="{ componentField }" name="gridExample2">
                <FormItem>
                  <FormLabel>Last Name</FormLabel>
                  <FormControl>
                    <Input v-bind="componentField" placeholder="Last name" />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              </FormField>
            </div>

            <div v-if="layout.name === 'compact'" class="space-y-2">
              <FormField v-slot="{ componentField }" name="compactExample">
                <FormItem class="space-y-1">
                  <FormLabel class="text-xs">Compact Layout</FormLabel>
                  <FormControl>
                    <Input
                      v-bind="componentField"
                      class="h-8 text-sm"
                      placeholder="Compact input"
                    />
                  </FormControl>
                  <FormMessage class="text-xs" />
                </FormItem>
              </FormField>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Form Field Types -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Form Field Types</h2>
      <div class="space-y-8">
        <p class="text-muted-foreground">
          WeDance Design System provides various form field components to handle
          different input types:
        </p>

        <div class="border rounded-lg overflow-hidden">
          <div class="grid grid-cols-3 gap-4 p-4 border-b font-medium bg-muted">
            <div>Component</div>
            <div>Description</div>
            <div>Example</div>
          </div>

          <div
            v-for="field in fieldTypes"
            :key="field.name"
            class="grid grid-cols-3 gap-4 p-4 border-b"
          >
            <div class="font-mono text-sm">{{ field.component }}</div>
            <div class="text-muted-foreground">{{ field.description }}</div>
            <div>
              <!-- Examples of each field type -->
              <Input
                v-if="field.name === 'text'"
                placeholder="Text input"
                class="w-full"
              />
              <Textarea
                v-else-if="field.name === 'textarea'"
                placeholder="Textarea"
                class="w-full h-20"
              />
              <Select v-else-if="field.name === 'select'" class="w-full">
                <option value="1">Option 1</option>
                <option value="2">Option 2</option>
                <option value="3">Option 3</option>
              </Select>
              <div
                v-else-if="field.name === 'checkbox'"
                class="flex items-center"
              >
                <Checkbox id="example-checkbox" />
                <label
                  for="example-checkbox"
                  class="ml-2 text-sm text-muted-foreground"
                  >Checkbox example</label
                >
              </div>
              <div v-else-if="field.name === 'radio'" class="space-y-2">
                <div class="flex items-center">
                  <input
                    type="radio"
                    id="radio1"
                    name="radio-example"
                    class="mr-2"
                  />
                  <label for="radio1" class="text-sm text-muted-foreground"
                    >Option 1</label
                  >
                </div>
                <div class="flex items-center">
                  <input
                    type="radio"
                    id="radio2"
                    name="radio-example"
                    class="mr-2"
                  />
                  <label for="radio2" class="text-sm text-muted-foreground"
                    >Option 2</label
                  >
                </div>
              </div>
              <PhoneInput
                v-else-if="field.name === 'phone'"
                placeholder="Phone number"
                class="w-full"
              />
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Best Practices -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Best Practices</h2>
      <div class="space-y-6">
        <div>
          <h3 class="text-lg font-medium mb-2">Form Organization</h3>
          <ul class="list-disc pl-6 space-y-2 text-muted-foreground">
            <li>Group related fields together</li>
            <li>Order fields in a logical sequence</li>
            <li>Use clear section headings for longer forms</li>
            <li>Consider multi-step forms for complex processes</li>
          </ul>
        </div>

        <div>
          <h3 class="text-lg font-medium mb-2">Validation</h3>
          <ul class="list-disc pl-6 space-y-2 text-muted-foreground">
            <li>Use zod schemas for all form validation</li>
            <li>Provide clear error messages</li>
            <li>Validate in real-time for critical fields</li>
            <li>
              Show validation errors after the user has interacted with the
              field
            </li>
          </ul>
        </div>

        <div>
          <h3 class="text-lg font-medium mb-2">Accessibility</h3>
          <ul class="list-disc pl-6 space-y-2 text-muted-foreground">
            <li>Always use labels for form fields</li>
            <li>Provide descriptive error messages</li>
            <li>Ensure keyboard navigation works properly</li>
            <li>Use ARIA attributes when necessary</li>
            <li>Test forms with screen readers and keyboard-only navigation</li>
          </ul>
        </div>

        <div>
          <h3 class="text-lg font-medium mb-2">Performance</h3>
          <ul class="list-disc pl-6 space-y-2 text-muted-foreground">
            <li>
              Debounce validation for fields that trigger expensive operations
            </li>
            <li>
              Consider lazy loading complex form components that aren't
              initially visible
            </li>
            <li>
              Use v-model with caution in large forms, prefer vee-validate's
              state management
            </li>
          </ul>
        </div>
      </div>
    </section>

    <!-- Common Form Patterns -->
    <section class="mb-16">
      <h2 class="text-2xl font-semibold mb-8">Common Form Patterns</h2>
      <div class="space-y-8">
        <div>
          <h3 class="text-lg font-medium mb-4">Multi-step Forms</h3>
          <p class="text-muted-foreground mb-4">
            For complex forms, consider using a step-by-step approach:
          </p>
          <div class="border rounded-lg p-4">
            <div class="flex mb-6">
              <div
                v-for="(step, index) in ['Personal', 'Contact', 'Review']"
                :key="step"
                class="flex-1 relative"
              >
                <div
                  class="h-2 bg-muted"
                  :class="{ 'bg-primary': index === 0 }"
                ></div>
                <div
                  class="absolute top-4 left-0 w-full text-center text-sm text-muted-foreground"
                >
                  {{ step }}
                </div>
              </div>
            </div>
            <div class="py-8 px-4">
              <p class="text-center text-muted-foreground">
                Step content would appear here
              </p>
            </div>
            <div class="flex justify-between">
              <Button variant="outline">Previous</Button>
              <Button>Next</Button>
            </div>
          </div>
        </div>

        <div>
          <h3 class="text-lg font-medium mb-4">Inline Validation</h3>
          <p class="text-muted-foreground mb-4">
            Validate fields as the user types or when they lose focus:
          </p>
          <div class="border rounded-lg p-4">
            <FormField v-slot="{ componentField }" name="inlineExample">
              <FormItem>
                <FormLabel>Email</FormLabel>
                <FormControl>
                  <Input
                    v-bind="componentField"
                    type="email"
                    placeholder="your@email.com"
                  />
                </FormControl>
                <FormDescription>
                  We'll validate this as you type
                </FormDescription>
                <FormMessage />
              </FormItem>
            </FormField>
          </div>
        </div>

        <div>
          <h3 class="text-lg font-medium mb-4">Form Arrays</h3>
          <p class="text-muted-foreground mb-4">
            For repeatable sections like adding multiple items:
          </p>
          <div class="border rounded-lg p-4">
            <div class="space-y-4">
              <div class="flex items-center justify-between">
                <h4 class="font-medium">Items</h4>
                <Button variant="outline" size="sm">
                  <Icon name="i-heroicons-plus" class="w-4 h-4 mr-2" />
                  Add Item
                </Button>
              </div>

              <div class="space-y-4">
                <div class="border rounded p-4">
                  <div class="flex justify-between items-center mb-4">
                    <h5 class="font-medium">Item 1</h5>
                    <Button variant="ghost" size="icon">
                      <Icon name="i-heroicons-trash" class="w-4 h-4" />
                    </Button>
                  </div>
                  <div class="space-y-4">
                    <FormField v-slot="{ componentField }" name="items[0].name">
                      <FormItem>
                        <FormLabel>Name</FormLabel>
                        <FormControl>
                          <Input v-bind="componentField" />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    </FormField>
                    <FormField
                      v-slot="{ componentField }"
                      name="items[0].quantity"
                    >
                      <FormItem>
                        <FormLabel>Quantity</FormLabel>
                        <FormControl>
                          <Input
                            v-bind="componentField"
                            type="number"
                            min="1"
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    </FormField>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
