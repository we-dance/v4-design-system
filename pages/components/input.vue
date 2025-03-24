<script setup lang="ts">
import { computed } from 'vue'

const variants = [
  { name: 'default', description: 'Default input style' },
  {
    name: 'error',
    description: 'Input with error state',
    value: '',
    error: 'This field is required',
  },
]

const types = [
  { name: 'text', description: 'Text input', placeholder: 'Enter text' },
  { name: 'email', description: 'Email input', placeholder: 'Enter email' },
  {
    name: 'password',
    description: 'Password input',
    placeholder: 'Enter password',
  },
  { name: 'number', description: 'Number input', placeholder: 'Enter number' },
  { name: 'search', description: 'Search input', placeholder: 'Search...' },
]

const props = defineProps<{
  modelValue?: string
  type?: string
  placeholder?: string
  error?: string
  disabled?: boolean
}>()

const emit = defineEmits(['update:modelValue'])

const classes = computed(() => [
  'flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm',
  'ring-offset-background',
  'file:border-0 file:bg-transparent file:text-sm file:font-medium',
  'placeholder:text-muted-foreground',
  'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2',
  props.disabled && 'cursor-not-allowed opacity-50',
  props.error && 'border-destructive',
])
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-4">Input Component</h1>
    <p class="text-muted-foreground mb-6">
      Input components are used to collect user data through various types of form fields.
      They provide a consistent way to gather user input across the application.
    </p>

    <Tabs default-value="preview" class="mb-8">
      <TabsList>
        <TabsTrigger value="preview">Preview</TabsTrigger>
        <TabsTrigger value="code">Code</TabsTrigger>
        <TabsTrigger value="usage">Usage</TabsTrigger>
      </TabsList>

      <TabsContent value="preview" class="p-4 border rounded-md mt-2">
        <div class="space-y-8">
          <!-- Variants Preview -->
          <div>
            <h3 class="text-lg font-medium mb-4">Variants</h3>
            <div class="grid gap-6">
              <div v-for="variant in variants" :key="variant.name">
                <div class="mb-2">
                  <span class="font-medium">{{ variant.name }}</span>
                  <p class="text-sm text-muted-foreground">{{ variant.description }}</p>
                </div>
                <div class="w-full max-w-sm">
                  <Input
                    :error="variant.error"
                    :placeholder="variant.name + ' input'"
                  />
                  <p v-if="variant.error" class="mt-1 text-sm text-destructive">
                    {{ variant.error }}
                  </p>
                </div>
              </div>
            </div>
          </div>

          <!-- Types Preview -->
          <div>
            <h3 class="text-lg font-medium mb-4">Input Types</h3>
            <div class="grid gap-6">
              <div v-for="type in types" :key="type.name">
                <div class="mb-2">
                  <span class="font-medium">{{ type.name }}</span>
                  <p class="text-sm text-muted-foreground">{{ type.description }}</p>
                </div>
                <div class="w-full max-w-sm">
                  <Input :type="type.name" :placeholder="type.placeholder" />
                </div>
              </div>
            </div>
          </div>

          <!-- Examples -->
          <div>
            <h3 class="text-lg font-medium mb-4">Examples</h3>
            <div class="space-y-6">
              <div>
                <p class="text-sm text-muted-foreground mb-2">With Label</p>
                <div class="w-full max-w-sm space-y-2">
                  <Label for="email">Email</Label>
                  <Input id="email" type="email" placeholder="Enter your email" />
                </div>
              </div>

              <div>
                <p class="text-sm text-muted-foreground mb-2">With Icon</p>
                <div class="w-full max-w-sm">
                  <div class="relative">
                    <Icon
                      name="search"
                      class="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground"
                    />
                    <Input class="pl-9" type="search" placeholder="Search..." />
                  </div>
                </div>
              </div>

              <div>
                <p class="text-sm text-muted-foreground mb-2">With Description</p>
                <div class="w-full max-w-sm space-y-2">
                  <Label for="username">Username</Label>
                  <Input id="username" placeholder="Enter username" />
                  <p class="text-sm text-muted-foreground">
                    This will be your public display name.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </TabsContent>

      <TabsContent value="code" class="p-4 border rounded-md mt-2">
        <div class="mb-4 font-semibold">Component Implementation</div>
        <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;script setup lang="ts"&gt;
import { computed } from 'vue'

const props = defineProps&lt;{
  modelValue?: string
  type?: string
  placeholder?: string
  error?: string
  disabled?: boolean
}&gt;()

const emit = defineEmits(['update:modelValue'])

const classes = computed(() => [
  'flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm',
  'ring-offset-background',
  'file:border-0 file:bg-transparent file:text-sm file:font-medium',
  'placeholder:text-muted-foreground',
  'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2',
  props.disabled && 'cursor-not-allowed opacity-50',
  props.error && 'border-destructive',
])
&lt;/script&gt;

&lt;template&gt;
  &lt;input
    :value="modelValue"
    :type="type"
    :placeholder="placeholder"
    :disabled="disabled"
    :class="classes"
    @input="$emit('update:modelValue', ($event.target as HTMLInputElement).value)"
  /&gt;
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
                  <td class="py-2 px-4">modelValue</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">''</td>
                  <td class="py-2 px-4">v-model binding value</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">type</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">'text'</td>
                  <td class="py-2 px-4">Type of input field</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">placeholder</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">''</td>
                  <td class="py-2 px-4">Placeholder text</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">error</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">''</td>
                  <td class="py-2 px-4">Error message to display</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">disabled</td>
                  <td class="py-2 px-4">boolean</td>
                  <td class="py-2 px-4">false</td>
                  <td class="py-2 px-4">Whether the input is disabled</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div>
            <h3 class="text-lg font-semibold mb-2">Example Usage</h3>
            <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;template&gt;
  &lt;!-- Basic Input --&gt;
  &lt;Input v-model="text" placeholder="Enter text" /&gt;

  &lt;!-- Input with Label and Description --&gt;
  &lt;div class="space-y-2"&gt;
    &lt;Label for="email"&gt;Email&lt;/Label&gt;
    &lt;Input
      id="email"
      v-model="email"
      type="email"
      placeholder="Enter your email"
    /&gt;
    &lt;p class="text-sm text-muted-foreground"&gt;
      We'll never share your email with anyone else.
    &lt;/p&gt;
  &lt;/div&gt;

  &lt;!-- Input with Error --&gt;
  &lt;Input
    v-model="username"
    :error="errors.username"
    placeholder="Enter username"
  /&gt;

  &lt;!-- Input with Icon --&gt;
  &lt;div class="relative"&gt;
    &lt;Icon
      name="search"
      class="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground"
    /&gt;
    &lt;Input
      v-model="search"
      class="pl-9"
      type="search"
      placeholder="Search..."
    /&gt;
  &lt;/div&gt;
&lt;/template&gt;
            </pre>
          </div>

          <div>
            <h3 class="text-lg font-semibold mb-2">Features</h3>
            <ul class="list-disc list-inside space-y-2">
              <li>Support for all HTML input types</li>
              <li>v-model support for two-way data binding</li>
              <li>Error state handling</li>
              <li>Customizable placeholder text</li>
              <li>Disabled state support</li>
              <li>Compatible with form validation libraries</li>
              <li>Consistent styling with the design system</li>
              <li>Accessible with proper ARIA attributes</li>
            </ul>
          </div>

          <Alert>
            <AlertTitle>Note</AlertTitle>
            <AlertDescription>
              When using inputs in forms, always provide labels and descriptions for better accessibility.
              Use the FormField component for proper form validation integration.
            </AlertDescription>
          </Alert>
        </div>
      </TabsContent>
    </Tabs>
  </div>
</template>
