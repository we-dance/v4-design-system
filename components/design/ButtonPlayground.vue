<script setup lang="ts">
import { ref, computed } from 'vue'
import { useClipboard } from '@vueuse/core'

// Import necessary components
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from '~/components/ui/select'
import { Button } from '~/components/ui/button'
import { Card, CardContent } from '~/components/ui/card'
import { Label } from '~/components/ui/label'

const { copy } = useClipboard()

type ButtonVariant = 'primary' | 'secondary' | 'accent' | 'outline'
type ButtonSize = 'default' | 'sm' | 'lg' | 'icon'

interface ButtonConfig {
  label: string
  variant: ButtonVariant
  size: ButtonSize
}

// Button configuration state
const config = ref<ButtonConfig>({
  label: 'Button',
  variant: 'primary',
  size: 'default'
})

const variants: Array<{ name: ButtonVariant; description: string }> = [
  { name: 'primary', description: 'Primary action button for main actions' },
  { name: 'secondary', description: 'Secondary action button for alternative actions' },
  { name: 'accent', description: 'Accent button for highlighted actions' },
  { name: 'outline', description: 'Outlined button for subtle actions' },
]

const sizes: Array<{ name: ButtonSize; description: string }> = [
  { name: 'default', description: 'Default size' },
  { name: 'sm', description: 'Small size' },
  { name: 'lg', description: 'Large size' },
  { name: 'icon', description: 'Icon button' },
]

// Generate the button code based on current configuration
const buttonCode = computed(() => {
  const props = []
  
  // Add variant prop if not default
  if (config.value.variant !== 'primary') {
    props.push(`variant="${config.value.variant}"`)
  }
  
  // Add size prop if not default
  if (config.value.size !== 'default') {
    props.push(`size="${config.value.size}"`)
  }

  // Build the button code with proper indentation
  const propsString = props.length ? '\n  ' + props.join('\n  ') : ''
  let code = `<Button${propsString}>`
  code += `\n  ${config.value.label}`
  code += '\n</Button>'
  return code
})
</script>

<template>
  <div class="space-y-8">
    <!-- Configuration Controls -->
    <div class="grid gap-6 sm:grid-cols-2">
      <!-- Label Input -->
      <div class="space-y-2">
        <Label>Label</Label>
        <input
          v-model="config.label"
          type="text"
          class="w-full px-3 py-2 border rounded-md"
        />
      </div>

      <!-- Variant Select -->
      <div class="space-y-2">
        <Label>Variant</Label>
        <Select v-model="config.variant">
          <SelectTrigger>
            <SelectValue placeholder="Select variant" />
          </SelectTrigger>
          <SelectContent>
            <SelectGroup>
              <SelectLabel>Variants</SelectLabel>
              <SelectItem
                v-for="variant in variants"
                :key="variant.name"
                :value="variant.name"
              >
                {{ variant.name }}
              </SelectItem>
            </SelectGroup>
          </SelectContent>
        </Select>
      </div>

      <!-- Size Select -->
      <div class="space-y-2">
        <Label>Size</Label>
        <Select v-model="config.size">
          <SelectTrigger>
            <SelectValue placeholder="Select size" />
          </SelectTrigger>
          <SelectContent>
            <SelectGroup>
              <SelectLabel>Sizes</SelectLabel>
              <SelectItem
                v-for="size in sizes"
                :key="size.name"
                :value="size.name"
              >
                {{ size.name }}
              </SelectItem>
            </SelectGroup>
          </SelectContent>
        </Select>
      </div>
    </div>

    <!-- Preview -->
    <Card>
      <CardContent class="flex items-center justify-center p-6">
        <Button
          :variant="config.variant"
          :size="config.size"
        >
          {{ config.label }}
        </Button>
      </CardContent>
    </Card>

    <!-- Code Preview -->
    <Card>
      <CardContent class="p-6">
        <pre class="bg-muted p-4 rounded-lg overflow-x-auto"><code>{{ buttonCode }}</code></pre>
      </CardContent>
    </Card>
  </div>
</template> 