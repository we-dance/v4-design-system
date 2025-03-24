<script setup lang="ts">
import { ref, computed } from 'vue'
import { colord, extend } from 'colord'
import a11yPlugin from 'colord/plugins/a11y'

extend([a11yPlugin])

type ButtonVariant =
  | 'primary'
  | 'secondary'
  | 'outline'
  | 'ghost'
  | 'link'
  | 'destructive'
type ButtonSize = 'default' | 'sm' | 'lg' | 'icon'

const buttonLabel = ref('Button Label')
const selectedSize = ref<ButtonSize>('default')
const showHoverStates = ref(false)

const variants: Array<{ name: ButtonVariant; description: string }> = [
  { name: 'primary', description: 'Primary action button' },
  { name: 'secondary', description: 'Secondary action button' },
  { name: 'outline', description: 'Outlined button for less emphasis' },
  { name: 'ghost', description: 'Ghost button for subtle actions' },
  { name: 'link', description: 'Link-styled button' },
  { name: 'destructive', description: 'For destructive actions' },
]

const sizes: Array<{ name: ButtonSize; description: string }> = [
  { name: 'default', description: 'Default size' },
  { name: 'sm', description: 'Small size' },
  { name: 'lg', description: 'Large size' },
  { name: 'icon', description: 'Icon button' },
]

// Contrast checking functions
const getButtonColors = (variant: ButtonVariant) => {
  switch (variant) {
    case 'primary':
      return { bg: 'hsl(var(--primary))', text: 'hsl(var(--primary-foreground))' }
    case 'secondary':
      return { bg: 'hsl(var(--secondary))', text: 'hsl(var(--secondary-foreground))' }
    case 'destructive':
      return { bg: 'hsl(var(--destructive))', text: 'hsl(var(--destructive-foreground))' }
    case 'outline':
      return { bg: 'transparent', text: 'hsl(var(--foreground))' }
    case 'ghost':
      return { bg: 'transparent', text: 'hsl(var(--foreground))' }
    case 'link':
      return { bg: 'transparent', text: 'hsl(var(--primary))' }
    default:
      return { bg: 'hsl(var(--primary))', text: 'hsl(var(--primary-foreground))' }
  }
}

const getContrastRatio = (variant: ButtonVariant) => {
  const colors = getButtonColors(variant)
  const contrast = colord(colors.bg).contrast(colors.text)
  return {
    ratio: contrast.toFixed(2),
    passes: {
      aa: contrast >= 4.5,
      aaa: contrast >= 7
    }
  }
}

const getContrastBadge = (ratio: number) => {
  if (ratio >= 7) return { label: 'AAA', class: 'bg-success text-success-foreground' }
  if (ratio >= 4.5) return { label: 'AA', class: 'bg-warning text-warning-foreground' }
  return { label: 'Fails', class: 'bg-destructive text-destructive-foreground' }
}
</script>

<template>
  <div class="space-y-8">
    <!-- Interactive Controls -->
    <div class="space-y-4 rounded-lg border bg-card p-6">
      <h3 class="font-medium">Customize Button</h3>
      <div class="grid gap-4 sm:grid-cols-2">
        <div class="space-y-2">
          <label for="buttonLabel" class="text-sm font-medium">Button Label</label>
          <Input
            id="buttonLabel"
            v-model="buttonLabel"
            placeholder="Enter button text"
          />
        </div>
        <div class="space-y-2">
          <label for="buttonSize" class="text-sm font-medium">Button Size</label>
          <Select v-model="selectedSize">
            <SelectTrigger id="buttonSize">
              <SelectValue :placeholder="selectedSize" />
            </SelectTrigger>
            <SelectContent>
              <SelectGroup>
                <SelectItem
                  v-for="size in sizes"
                  :key="size.name"
                  :value="size.name"
                >
                  <span class="font-medium">{{ size.name }}</span>
                  <span class="ml-2 text-xs text-muted-foreground">{{ size.description }}</span>
                </SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>
        </div>
      </div>
      <div class="flex items-center gap-2">
        <Switch v-model="showHoverStates" id="hover-states" />
        <label for="hover-states" class="text-sm font-medium">Show hover states</label>
      </div>
    </div>

    <!-- Button Preview -->
    <div class="space-y-6">
      <div v-for="variant in variants" :key="variant.name" 
           class="group rounded-lg border p-4">
        <div class="mb-4 flex items-center justify-between">
          <div>
            <h4 class="font-medium capitalize">{{ variant.name }}</h4>
            <p class="text-sm text-muted-foreground">{{ variant.description }}</p>
          </div>
          <!-- Contrast Badge -->
          <div class="space-x-2">
            <Badge 
              :class="getContrastBadge(Number(getContrastRatio(variant.name).ratio)).class"
              class="font-mono"
            >
              {{ getContrastRatio(variant.name).ratio }}:1
            </Badge>
            <Badge 
              :class="getContrastBadge(Number(getContrastRatio(variant.name).ratio)).class"
            >
              {{ getContrastBadge(Number(getContrastRatio(variant.name).ratio)).label }}
            </Badge>
          </div>
        </div>

        <div class="flex flex-wrap items-center gap-4">
          <!-- Normal State -->
          <div class="space-y-2">
            <Button 
              :variant="variant.name"
              :size="selectedSize"
              :class="[
                showHoverStates && 'hover:shadow-sm transform hover:-translate-y-0.5 transition-all',
                variant.name === 'destructive' && 'ring-destructive/20 hover:ring-4 transition-shadow'
              ]"
            >
              {{ buttonLabel }}
            </Button>
            <p class="text-xs text-muted-foreground">Normal</p>
          </div>

          <!-- Disabled State -->
          <div class="space-y-2">
            <Button 
              :variant="variant.name"
              :size="selectedSize"
              disabled
            >
              {{ buttonLabel }}
            </Button>
            <p class="text-xs text-muted-foreground">Disabled</p>
          </div>

          <!-- With Icon -->
          <div class="space-y-2">
            <Button 
              :variant="variant.name"
              :size="selectedSize"
              :class="[
                showHoverStates && 'hover:shadow-sm transform hover:-translate-y-0.5 transition-all'
              ]"
            >
              <Icon name="i-heroicons-plus" class="mr-2 h-4 w-4" />
              {{ buttonLabel }}
            </Button>
            <p class="text-xs text-muted-foreground">With Icon</p>
          </div>

          <!-- Loading State -->
          <div class="space-y-2">
            <Button 
              :variant="variant.name"
              :size="selectedSize"
              disabled
            >
              <Icon name="i-heroicons-arrow-path" class="mr-2 h-4 w-4 animate-spin" />
              Loading...
            </Button>
            <p class="text-xs text-muted-foreground">Loading</p>
          </div>
        </div>

        <!-- Contrast Information -->
        <div class="mt-4 rounded-md bg-muted/50 p-3">
          <div class="space-y-1.5">
            <p class="text-sm font-medium">Contrast Information</p>
            <div class="grid gap-1 text-sm">
              <div class="flex items-center justify-between">
                <span class="text-muted-foreground">WCAG AA (4.5:1)</span>
                <Badge :variant="getContrastRatio(variant.name).passes.aa ? 'success' : 'destructive'">
                  {{ getContrastRatio(variant.name).passes.aa ? 'Passes' : 'Fails' }}
                </Badge>
              </div>
              <div class="flex items-center justify-between">
                <span class="text-muted-foreground">WCAG AAA (7:1)</span>
                <Badge :variant="getContrastRatio(variant.name).passes.aaa ? 'success' : 'destructive'">
                  {{ getContrastRatio(variant.name).passes.aaa ? 'Passes' : 'Fails' }}
                </Badge>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template> 