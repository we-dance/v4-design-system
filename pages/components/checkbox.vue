# pages/components/checkbox.vue
<script setup lang="ts">
import { ref } from 'vue'

const checked = ref(false)
const disabled = ref(false)
const withError = ref(false)
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-4">Checkbox Component</h1>
    <p class="text-muted-foreground mb-6">
      A customizable checkbox component for forms and interactive elements.
    </p>

    <Tabs default-value="preview" class="mb-8">
      <TabsList>
        <TabsTrigger value="preview">Preview</TabsTrigger>
        <TabsTrigger value="code">Code</TabsTrigger>
        <TabsTrigger value="usage">Usage</TabsTrigger>
      </TabsList>

      <TabsContent value="preview" class="p-4 border rounded-md mt-2">
        <div class="mb-4 flex flex-wrap gap-4">
          <Button variant="outline" @click="disabled = !disabled">
            {{ disabled ? 'Enable' : 'Disable' }}
          </Button>
          <Button variant="outline" @click="withError = !withError">
            {{ withError ? 'Remove Error' : 'Show Error' }}
          </Button>
        </div>

        <div class="space-y-8">
          <!-- Default Checkbox -->
          <FormField v-slot="{ value, handleChange }" :name="'defaultCheckbox'">
            <FormItem class="flex flex-row items-start space-y-0 gap-x-3">
              <FormControl>
                <Checkbox
                  :checked="value"
                  @update:checked="handleChange"
                  :disabled="disabled"
                />
              </FormControl>
              <div class="space-y-1 leading-none">
                <FormLabel>Default checkbox</FormLabel>
                <FormDescription>
                  A simple checkbox with label and description
                </FormDescription>
                <FormMessage v-if="withError">
                  This field is required
                </FormMessage>
              </div>
            </FormItem>
          </FormField>

          <!-- Checkbox with Long Description -->
          <FormField v-slot="{ value, handleChange }" :name="'termsCheckbox'">
            <FormItem class="flex flex-row items-start space-y-0 gap-x-3">
              <FormControl>
                <Checkbox
                  :checked="value"
                  @update:checked="handleChange"
                  :disabled="disabled"
                />
              </FormControl>
              <div class="space-y-1 leading-none">
                <FormLabel>Terms and Conditions</FormLabel>
                <FormDescription class="text-sm text-muted-foreground">
                  By checking this box, you agree to our Terms of Service and
                  Privacy Policy. You can review these documents at any time on
                  our website.
                </FormDescription>
                <FormMessage v-if="withError">
                  You must accept the terms to continue
                </FormMessage>
              </div>
            </FormItem>
          </FormField>

          <!-- Checkbox in Form Context -->
          <form @submit.prevent class="border rounded-lg p-4">
            <FormField
              v-slot="{ value, handleChange }"
              :name="'newsletterCheckbox'"
            >
              <FormItem class="flex flex-row items-start space-y-0 gap-x-3">
                <FormControl>
                  <Checkbox
                    :checked="value"
                    @update:checked="handleChange"
                    :disabled="disabled"
                  />
                </FormControl>
                <div class="space-y-1 leading-none">
                  <FormLabel>Subscribe to newsletter</FormLabel>
                  <FormDescription>
                    Receive updates about new features and announcements
                  </FormDescription>
                  <FormMessage v-if="withError">
                    Please indicate your preference
                  </FormMessage>
                </div>
              </FormItem>
            </FormField>
          </form>
        </div>
      </TabsContent>

      <TabsContent value="code" class="p-4 border rounded-md mt-2">
        <div class="mb-4 font-semibold">Component Implementation</div>
        <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;script setup lang="ts"&gt;
const props = defineProps&lt;{
  checked?: boolean
  disabled?: boolean
  required?: boolean
  error?: string
}&gt;()

const emit = defineEmits&lt;{
  (e: 'update:checked', value: boolean): void
}&gt;()
&lt;/script&gt;

&lt;template&gt;
  &lt;FormField v-slot="{ value, handleChange }" :name="name"&gt;
    &lt;FormItem class="flex flex-row items-start space-y-0 gap-x-3"&gt;
      &lt;FormControl&gt;
        &lt;Checkbox
          :checked="value"
          @update:checked="handleChange"
          :disabled="disabled"
        /&gt;
      &lt;/FormControl&gt;
      &lt;div class="space-y-1 leading-none"&gt;
        &lt;FormLabel&gt;&lt;slot name="label" /&gt;&lt;/FormLabel&gt;
        &lt;FormDescription&gt;
          &lt;slot name="description" /&gt;
        &lt;/FormDescription&gt;
        &lt;FormMessage /&gt;
      &lt;/div&gt;
    &lt;/FormItem&gt;
  &lt;/FormField&gt;
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
                  <td class="py-2 px-4">checked</td>
                  <td class="py-2 px-4">boolean</td>
                  <td class="py-2 px-4">false</td>
                  <td class="py-2 px-4">The checked state of the checkbox</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">disabled</td>
                  <td class="py-2 px-4">boolean</td>
                  <td class="py-2 px-4">false</td>
                  <td class="py-2 px-4">Whether the checkbox is disabled</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">required</td>
                  <td class="py-2 px-4">boolean</td>
                  <td class="py-2 px-4">false</td>
                  <td class="py-2 px-4">
                    Whether the checkbox is required in a form
                  </td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">error</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">undefined</td>
                  <td class="py-2 px-4">Error message to display</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div>
            <h3 class="text-lg font-semibold mb-2">Example Usage</h3>
            <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;template&gt;
  &lt;FormField v-slot="{ value, handleChange }" name="terms"&gt;
    &lt;FormItem class="flex flex-row items-start space-y-0 gap-x-3"&gt;
      &lt;FormControl&gt;
        &lt;Checkbox
          :checked="value"
          @update:checked="handleChange"
          :disabled="false"
        /&gt;
      &lt;/FormControl&gt;
      &lt;div class="space-y-1 leading-none"&gt;
        &lt;FormLabel&gt;Accept terms&lt;/FormLabel&gt;
        &lt;FormDescription&gt;
          Please read and accept our terms and conditions
        &lt;/FormDescription&gt;
        &lt;FormMessage /&gt;
      &lt;/div&gt;
    &lt;/FormItem&gt;
  &lt;/FormField&gt;
&lt;/template&gt;
            </pre>
          </div>

          <div>
            <h3 class="text-lg font-semibold mb-2">Features</h3>
            <ul class="list-disc list-inside space-y-2">
              <li>Fully customizable checkbox with label and description</li>
              <li>Support for disabled state</li>
              <li>Form validation integration</li>
              <li>Error state handling</li>
              <li>Accessible by default</li>
              <li>Keyboard navigation support</li>
            </ul>
          </div>

          <Alert>
            <AlertTitle>Note</AlertTitle>
            <AlertDescription>
              This component is built on top of shadcn-vue's Checkbox component
              and integrates with vee-validate for form handling.
            </AlertDescription>
          </Alert>
        </div>
      </TabsContent>
    </Tabs>
  </div>
</template>
