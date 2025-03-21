<script setup lang="ts">
import { ref } from 'vue'
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'
import { FormField, FormItem, FormLabel, FormControl, FormDescription, FormMessage } from '@/components/ui/form'
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs'
import { Button } from '@/components/ui/button'
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert'

const selectedFruit = ref('apple')
const selectedSize = ref('m')
const selectedColor = ref('blue')
const disabled = ref(false)
const withError = ref(false)

const fruits = [
  { value: 'apple', label: 'Apple' },
  { value: 'banana', label: 'Banana' },
  { value: 'orange', label: 'Orange' },
]

const sizes = [
  { value: 's', label: 'Small' },
  { value: 'm', label: 'Medium' },
  { value: 'l', label: 'Large' },
]

const colors = [
  { value: 'blue', label: 'Blue' },
  { value: 'red', label: 'Red' },
  { value: 'green', label: 'Green' },
]
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-4">Radio Component</h1>
    <p class="text-muted-foreground mb-6">
      A customizable radio group component for selecting a single option from a list. Built on top of Radix Vue's RadioGroup component.
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
          <!-- Default Radio Group -->
          <FormField v-slot="{ value, handleChange }" :name="'defaultRadio'">
            <FormItem class="space-y-3">
              <FormLabel>Select a fruit</FormLabel>
              <FormControl>
                <RadioGroup
                  :value="value"
                  @update:value="handleChange"
                  :disabled="disabled"
                  class="flex flex-col space-y-2"
                >
                  <div v-for="fruit in fruits" :key="fruit.value" class="flex items-center space-x-2">
                    <RadioGroupItem :value="fruit.value" :id="fruit.value" />
                    <label :for="fruit.value" class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70">
                      {{ fruit.label }}
                    </label>
                  </div>
                </RadioGroup>
              </FormControl>
              <FormDescription>
                Choose your favorite fruit
              </FormDescription>
              <FormMessage v-if="withError">
                Please select a fruit
              </FormMessage>
            </FormItem>
          </FormField>

          <!-- Horizontal Layout -->
          <FormField v-slot="{ value, handleChange }" :name="'sizeRadio'">
            <FormItem class="space-y-3">
              <FormLabel>Select size</FormLabel>
              <FormControl>
                <RadioGroup
                  :value="value"
                  @update:value="handleChange"
                  :disabled="disabled"
                  class="flex space-x-4"
                >
                  <div v-for="size in sizes" :key="size.value" class="flex items-center space-x-2">
                    <RadioGroupItem :value="size.value" :id="size.value" />
                    <label :for="size.value" class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70">
                      {{ size.label }}
                    </label>
                  </div>
                </RadioGroup>
              </FormControl>
              <FormDescription>
                Choose your preferred size
              </FormDescription>
              <FormMessage v-if="withError">
                Please select a size
              </FormMessage>
            </FormItem>
          </FormField>

          <!-- Radio Group in Form Context -->
          <form @submit.prevent class="border rounded-lg p-4">
            <FormField
              v-slot="{ value, handleChange }"
              :name="'requiredRadio'"
              :validate="value => !!value || 'This field is required'"
            >
              <FormItem class="space-y-3">
                <FormLabel>Required Selection</FormLabel>
                <FormControl>
                  <RadioGroup
                    :value="value"
                    @update:value="handleChange"
                    :disabled="disabled"
                    class="flex flex-col space-y-2"
                  >
                    <div v-for="fruit in fruits" :key="fruit.value" class="flex items-center space-x-2">
                      <RadioGroupItem :value="fruit.value" :id="'form-' + fruit.value" />
                      <label :for="'form-' + fruit.value" class="text-sm font-medium leading-none">
                        {{ fruit.label }}
                      </label>
                    </div>
                  </RadioGroup>
                </FormControl>
                <FormDescription>
                  This is a required field with validation
                </FormDescription>
                <FormMessage />
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
  modelValue?: string
  disabled?: boolean
  required?: boolean
  error?: string
}&gt;()

const emit = defineEmits&lt;{
  (e: 'update:modelValue', value: string): void
}&gt;()
&lt;/script&gt;

&lt;template&gt;
  &lt;FormField v-slot="{ value, handleChange }" :name="name"&gt;
    &lt;FormItem class="space-y-3"&gt;
      &lt;FormLabel&gt;&lt;slot name="label" /&gt;&lt;/FormLabel&gt;
      &lt;FormControl&gt;
        &lt;RadioGroup
          :value="value"
          @update:value="handleChange"
          :disabled="disabled"
          class="flex flex-col space-y-2"
        &gt;
          &lt;slot /&gt;
        &lt;/RadioGroup&gt;
      &lt;/FormControl&gt;
      &lt;FormDescription&gt;
        &lt;slot name="description" /&gt;
      &lt;/FormDescription&gt;
      &lt;FormMessage /&gt;
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
                  <td class="py-2 px-4">modelValue</td>
                  <td class="py-2 px-4">string</td>
                  <td class="py-2 px-4">undefined</td>
                  <td class="py-2 px-4">The selected value of the radio group</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">disabled</td>
                  <td class="py-2 px-4">boolean</td>
                  <td class="py-2 px-4">false</td>
                  <td class="py-2 px-4">Whether the radio group is disabled</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">required</td>
                  <td class="py-2 px-4">boolean</td>
                  <td class="py-2 px-4">false</td>
                  <td class="py-2 px-4">Whether the radio group is required in a form</td>
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
  &lt;FormField v-slot="{ value, handleChange }" name="options"&gt;
    &lt;FormItem class="space-y-3"&gt;
      &lt;FormLabel&gt;Select an option&lt;/FormLabel&gt;
      &lt;FormControl&gt;
        &lt;RadioGroup
          :value="value"
          @update:value="handleChange"
          :disabled="false"
          class="flex flex-col space-y-2"
        &gt;
          &lt;div class="flex items-center space-x-2"&gt;
            &lt;RadioGroupItem value="option1" id="option1" /&gt;
            &lt;label for="option1" class="text-sm font-medium leading-none"&gt;
              Option 1
            &lt;/label&gt;
          &lt;/div&gt;
          &lt;div class="flex items-center space-x-2"&gt;
            &lt;RadioGroupItem value="option2" id="option2" /&gt;
            &lt;label for="option2" class="text-sm font-medium leading-none"&gt;
              Option 2
            &lt;/label&gt;
          &lt;/div&gt;
        &lt;/RadioGroup&gt;
      &lt;/FormControl&gt;
      &lt;FormDescription&gt;
        Select one of the available options
      &lt;/FormDescription&gt;
      &lt;FormMessage /&gt;
    &lt;/FormItem&gt;
  &lt;/FormField&gt;
&lt;/template&gt;
            </pre>
          </div>

          <div>
            <h3 class="text-lg font-semibold mb-2">Features</h3>
            <ul class="list-disc list-inside space-y-2">
              <li>Fully customizable radio group with label and description</li>
              <li>Support for disabled state</li>
              <li>Form validation integration</li>
              <li>Error state handling</li>
              <li>Accessible by default</li>
              <li>Keyboard navigation support</li>
              <li>Horizontal and vertical layout options</li>
            </ul>
          </div>

          <Alert>
            <AlertTitle>Note</AlertTitle>
            <AlertDescription>
              This component is built on top of Radix Vue's RadioGroup component
              and integrates with vee-validate for form handling.
            </AlertDescription>
          </Alert>
        </div>
      </TabsContent>
    </Tabs>
  </div>
</template> 