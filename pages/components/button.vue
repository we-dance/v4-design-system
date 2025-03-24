<script setup lang="ts">
import { ref } from 'vue'

type ButtonVariant =
  | 'primary'
  | 'secondary'
  | 'accent'
  | 'destructive'
  | 'outline'
type ButtonSize = 'default' | 'sm' | 'lg' | 'icon'

const variants: Array<{ name: ButtonVariant; description: string }> = [
  { name: 'primary', description: 'Primary action button for main actions' },
  { name: 'secondary', description: 'Secondary action button for alternative actions' },
  { name: 'accent', description: 'Accent button for highlighted actions' },
  { name: 'destructive', description: 'Destructive button for destructive actions' },
  { name: 'outline', description: 'Outlined button for subtle actions' },
]

const sizes: Array<{ name: ButtonSize; description: string }> = [
  { name: 'default', description: 'Default size' },
  { name: 'sm', description: 'Small size' },
  { name: 'lg', description: 'Large size' },
  { name: 'icon', description: 'Icon button' },
]

const variantExamples = {
  primary: `<Button variant="primary">Button</Button>
<Button variant="primary" disabled>Disabled</Button>`,
  secondary: `<Button variant="secondary">Button</Button>
<Button variant="secondary" disabled>Disabled</Button>`,
  accent: `<Button variant="accent">Button</Button>
<Button variant="accent" disabled>Disabled</Button>`,
  destructive: `<Button variant="destructive">Button</Button>
<Button variant="destructive" disabled>Disabled</Button>`,
  outline: `<Button variant="outline">Button</Button>
<Button variant="outline" disabled>Disabled</Button>`,
}

const sizeExamples = {
  default: `<Button>Default Button</Button>`,
  sm: `<Button size="sm">Small Button</Button>`,
  lg: `<Button size="lg">Large Button</Button>`,
  icon: `<Button size="icon" aria-label="Add">
  <Icon name="i-heroicons-plus" class="h-4 w-4" />
</Button>`,
}

const codeExamples = [
  {
    title: 'Basic Usage',
    description: 'Simple button examples',
    code: `<Button>Click me</Button>

<Button variant="primary" size="lg">
  Large Primary Button
</Button>

<Button variant="secondary">
  Secondary Button
</Button>

<Button variant="accent">
  Accent Button
</Button>`
  },
  {
    title: 'With Icon',
    description: 'Buttons with icons',
    code: `<!-- Add item button -->
<Button variant="primary">
  <Icon name="i-heroicons-plus" class="mr-2 h-4 w-4" />
  Add item
</Button>

<!-- Delete button -->
<Button variant="destructive">
  <Icon name="i-heroicons-trash" class="mr-2 h-4 w-4" />
  Delete
</Button>`
  },
  {
    title: 'Loading State',
    description: 'Button with loading state',
    code: `<!-- Loading state button -->
<Button variant="primary" disabled>
  <Icon name="i-heroicons-arrow-path" class="mr-2 h-4 w-4 animate-spin" />
  Please wait
</Button>

<!-- Alternative loading state -->
<Button variant="secondary" disabled>
  <Icon name="i-heroicons-arrow-path" class="mr-2 h-4 w-4 animate-spin" />
  Processing...
</Button>`
  },
  {
    title: 'Icon Button',
    description: 'Icon-only buttons with proper accessibility',
    code: `<!-- Settings icon button -->
<Button size="icon" variant="primary" aria-label="Settings">
  <Icon name="i-heroicons-cog-6-tooth" class="h-4 w-4" />
</Button>

<!-- Search icon button -->
<Button size="icon" variant="secondary" aria-label="Search">
  <Icon name="i-heroicons-magnifying-glass" class="h-4 w-4" />
</Button>

<!-- Add icon button -->
<Button size="icon" variant="accent" aria-label="Add">
  <Icon name="i-heroicons-plus" class="h-4 w-4" />
</Button>

<!-- Delete icon button -->
<Button size="icon" variant="destructive" aria-label="Delete">
  <Icon name="i-heroicons-trash" class="h-4 w-4" />
</Button>`
  }
]

const dosAndDonts = [
  {
    do: [
      'Use clear, action-oriented labels',
      'Include icons to enhance visual hierarchy',
      'Maintain consistent spacing between buttons',
      'Use appropriate variant for the action importance',
      'Provide loading states for async actions'
    ],
    dont: [
      'Use lengthy button labels',
      'Mix different button sizes in the same group',
      'Use too many primary buttons on one page',
      'Forget aria-labels for icon-only buttons',
      'Use destructive variant for non-destructive actions'
    ]
  }
]

const activeCodeTab = ref(codeExamples[0].title)
const copiedStates = ref<{ [key: string]: boolean }>({})
const showVariantCode = ref<{ [key: string]: boolean }>({})
const showSizeCode = ref<{ [key: string]: boolean }>({})
const showExampleCode = ref<{ [key: string]: boolean }>({})

const exampleCodes = {
  withIcon: `<!-- Add item button -->
<Button variant="primary">
  <Icon name="i-heroicons-plus" class="mr-2 h-4 w-4" />
  Add item
</Button>

<!-- Delete button -->
<Button variant="destructive">
  <Icon name="i-heroicons-trash" class="mr-2 h-4 w-4" />
  Delete
</Button>`,
  loadingState: `<!-- Loading state button -->
<Button variant="primary" disabled>
  <Icon name="i-heroicons-arrow-path" class="mr-2 h-4 w-4 animate-spin" />
  Please wait
</Button>

<!-- Alternative loading state -->
<Button variant="secondary" disabled>
  <Icon name="i-heroicons-arrow-path" class="mr-2 h-4 w-4 animate-spin" />
  Processing...
</Button>`,
  iconButtons: `<!-- Settings icon button -->
<Button size="icon" variant="primary" aria-label="Settings">
  <Icon name="i-heroicons-cog-6-tooth" class="h-4 w-4" />
</Button>

<!-- Search icon button -->
<Button size="icon" variant="secondary" aria-label="Search">
  <Icon name="i-heroicons-magnifying-glass" class="h-4 w-4" />
</Button>

<!-- Add icon button -->
<Button size="icon" variant="accent" aria-label="Add">
  <Icon name="i-heroicons-plus" class="h-4 w-4" />
</Button>

<!-- Delete icon button -->
<Button size="icon" variant="destructive" aria-label="Delete">
  <Icon name="i-heroicons-trash" class="h-4 w-4" />
</Button>`,
  allVariants: `<!-- Primary variant -->
<Button variant="primary">Primary</Button>

<!-- Secondary variant -->
<Button variant="secondary">Secondary</Button>

<!-- Accent variant -->
<Button variant="accent">Accent</Button>

<!-- Outline variant -->
<Button variant="outline">Outline</Button>

<!-- Destructive variant -->
<Button variant="destructive">Destructive</Button>

<!-- Disabled states -->
<Button variant="primary" disabled>Primary</Button>
<Button variant="secondary" disabled>Secondary</Button>
<Button variant="accent" disabled>Accent</Button>
<Button variant="outline" disabled>Outline</Button>
<Button variant="destructive" disabled>Destructive</Button>`
}

const copyCode = (code: string, tab: string) => {
  navigator.clipboard.writeText(code)
  copiedStates.value[tab] = true
  setTimeout(() => {
    copiedStates.value[tab] = false
  }, 2000)
}

const toggleVariantCode = (variant: string) => {
  showVariantCode.value[variant] = !showVariantCode.value[variant]
}

const toggleSizeCode = (size: string) => {
  showSizeCode.value[size] = !showSizeCode.value[size]
}

const toggleExampleCode = (example: string) => {
  showExampleCode.value[example] = !showExampleCode.value[example]
}

const sections = [
  { id: 'preview', label: 'Preview' },
  { id: 'playground', label: 'Playground' },
  { id: 'code', label: 'Code' },
  { id: 'usage', label: 'Usage' },
  { id: 'guidelines', label: 'Best Practices' }
]
</script>

<template>
  <div class="container py-10 max-w-screen-2xl">
    <!-- Header Section -->
    <div class="mb-8">
      <h1 class="scroll-m-20 text-4xl font-bold tracking-tight">Button Component</h1>
      <p class="text-lg text-muted-foreground mt-3">
        Buttons trigger actions or navigation when clicked. They communicate
        calls to action and allow users to interact with the interface.
      </p>
    </div>

    <!-- Main Content -->
    <Tabs :default-value="sections[0].id" class="space-y-6">
      <TabsList class="w-full">
        <TabsTrigger 
          v-for="section in sections" 
          :key="section.id"
          :value="section.id"
          class="flex-1"
        >
          {{ section.label }}
        </TabsTrigger>
      </TabsList>

      <!-- Preview Tab -->
      <TabsContent :value="sections[0].id">
        <Card>
          <CardHeader>
            <CardTitle>Button Variants</CardTitle>
            <CardDescription>
              Available button styles and their use cases
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="grid gap-6">
              <div v-for="variant in variants" :key="variant.name" class="space-y-4">
                <div class="flex items-center justify-between p-6 border rounded-lg bg-muted/5">
                  <div class="space-y-2">
                    <p class="font-medium capitalize">{{ variant.name }}</p>
                    <p class="text-sm text-muted-foreground">{{ variant.description }}</p>
                  </div>
                  <div class="flex items-center gap-4">
                    <div class="flex items-center space-x-4">
                      <Button :variant="variant.name">Button</Button>
                      <Button :variant="variant.name" disabled>Disabled</Button>
                    </div>
                    <Button
                      size="icon"
                      variant="ghost"
                      @click="toggleVariantCode(variant.name)"
                      :aria-label="showVariantCode[variant.name] ? 'Hide code' : 'Show code'"
                    >
                      <Icon
                        :name="showVariantCode[variant.name] ? 'i-heroicons-code-bracket-square' : 'i-heroicons-code-bracket'"
                        class="h-4 w-4"
                      />
                    </Button>
                  </div>
                </div>
                <Collapsible v-if="showVariantCode[variant.name]">
                  <div class="relative rounded-md bg-muted/50 p-4">
                    <Button
                      size="sm"
                      variant="secondary"
                      class="absolute right-4 top-4"
                      @click="copyCode(variantExamples[variant.name], variant.name)"
                    >
                      <Icon
                        :name="copiedStates[variant.name] ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                        class="mr-2 h-4 w-4"
                      />
                      {{ copiedStates[variant.name] ? 'Copied' : 'Copy' }}
                    </Button>
                    <pre class="language-vue mt-4"><code>{{ variantExamples[variant.name] }}</code></pre>
                  </div>
                </Collapsible>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card class="mt-8">
          <CardHeader>
            <CardTitle>Button Sizes</CardTitle>
            <CardDescription>
              Different button sizes for various contexts
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="grid gap-6">
              <div v-for="size in sizes" :key="size.name" class="space-y-4">
                <div class="flex items-center justify-between p-6 border rounded-lg bg-muted/5">
                  <div class="space-y-2">
                    <p class="font-medium">{{ size.name }}</p>
                    <p class="text-sm text-muted-foreground">{{ size.description }}</p>
                  </div>
                  <div class="flex items-center gap-4">
                    <Button :size="size.name">
                      <template v-if="size.name === 'icon'">
                        <Icon name="i-heroicons-plus" class="h-4 w-4" />
                      </template>
                      <template v-else>Button</template>
                    </Button>
                    <Button
                      size="icon"
                      variant="ghost"
                      @click="toggleSizeCode(size.name)"
                      :aria-label="showSizeCode[size.name] ? 'Hide code' : 'Show code'"
                    >
                      <Icon
                        :name="showSizeCode[size.name] ? 'i-heroicons-code-bracket-square' : 'i-heroicons-code-bracket'"
                        class="h-4 w-4"
                      />
                    </Button>
                  </div>
                </div>
                <Collapsible v-if="showSizeCode[size.name]">
                  <div class="relative rounded-md bg-muted/50 p-4">
                    <Button
                      size="sm"
                      variant="secondary"
                      class="absolute right-4 top-4"
                      @click="copyCode(sizeExamples[size.name], size.name)"
                    >
                      <Icon
                        :name="copiedStates[size.name] ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                        class="mr-2 h-4 w-4"
                      />
                      {{ copiedStates[size.name] ? 'Copied' : 'Copy' }}
                    </Button>
                    <pre class="language-vue mt-4"><code>{{ sizeExamples[size.name] }}</code></pre>
                  </div>
                </Collapsible>
              </div>
            </div>
          </CardContent>
        </Card>

        <!-- Common Examples -->
        <Card class="mt-8">
          <CardHeader>
            <CardTitle>Common Examples</CardTitle>
            <CardDescription>
              Frequently used button patterns
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="grid gap-8">
              <!-- With Icon -->
              <div class="space-y-4">
                <div class="flex items-center justify-between p-6 border rounded-lg bg-muted/5">
                  <div class="space-y-2">
                    <p class="font-medium">With Icon</p>
                    <p class="text-sm text-muted-foreground">Buttons with icons for better visual hierarchy</p>
                  </div>
                  <div class="flex items-center gap-4">
                    <div class="flex items-center space-x-4">
                      <Button variant="primary">
                        <Icon name="i-heroicons-plus" class="mr-2 h-4 w-4" />
                        Add item
                      </Button>
                      <Button variant="destructive">
                        <Icon name="i-heroicons-trash" class="mr-2 h-4 w-4" />
                        Delete
                      </Button>
                    </div>
                    <Button
                      size="icon"
                      variant="ghost"
                      @click="toggleExampleCode('withIcon')"
                      :aria-label="showExampleCode.withIcon ? 'Hide code' : 'Show code'"
                    >
                      <Icon
                        :name="showExampleCode.withIcon ? 'i-heroicons-code-bracket-square' : 'i-heroicons-code-bracket'"
                        class="h-4 w-4"
                      />
                    </Button>
                  </div>
                </div>
                <Collapsible v-if="showExampleCode.withIcon">
                  <div class="relative rounded-md bg-muted/50 p-4">
                    <Button
                      size="sm"
                      variant="secondary"
                      class="absolute right-4 top-4"
                      @click="copyCode(exampleCodes.withIcon, 'withIcon')"
                    >
                      <Icon
                        :name="copiedStates.withIcon ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                        class="mr-2 h-4 w-4"
                      />
                      {{ copiedStates.withIcon ? 'Copied' : 'Copy' }}
                    </Button>
                    <pre class="language-vue mt-4"><code>{{ exampleCodes.withIcon }}</code></pre>
                  </div>
                </Collapsible>
              </div>

              <!-- Loading State -->
              <div class="space-y-4">
                <div class="flex items-center justify-between p-6 border rounded-lg bg-muted/5">
                  <div class="space-y-2">
                    <p class="font-medium">Loading State</p>
                    <p class="text-sm text-muted-foreground">Buttons with loading indicators</p>
                  </div>
                  <div class="flex items-center gap-4">
                    <div class="flex items-center space-x-4">
                      <Button variant="primary" disabled>
                        <Icon name="i-heroicons-arrow-path" class="mr-2 h-4 w-4 animate-spin" />
                        Please wait
                      </Button>
                      <Button variant="secondary" disabled>
                        <Icon name="i-heroicons-arrow-path" class="mr-2 h-4 w-4 animate-spin" />
                        Processing...
                      </Button>
                    </div>
                    <Button
                      size="icon"
                      variant="ghost"
                      @click="toggleExampleCode('loadingState')"
                      :aria-label="showExampleCode.loadingState ? 'Hide code' : 'Show code'"
                    >
                      <Icon
                        :name="showExampleCode.loadingState ? 'i-heroicons-code-bracket-square' : 'i-heroicons-code-bracket'"
                        class="h-4 w-4"
                      />
                    </Button>
                  </div>
                </div>
                <Collapsible v-if="showExampleCode.loadingState">
                  <div class="relative rounded-md bg-muted/50 p-4">
                    <Button
                      size="sm"
                      variant="secondary"
                      class="absolute right-4 top-4"
                      @click="copyCode(exampleCodes.loadingState, 'loadingState')"
                    >
                      <Icon
                        :name="copiedStates.loadingState ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                        class="mr-2 h-4 w-4"
                      />
                      {{ copiedStates.loadingState ? 'Copied' : 'Copy' }}
                    </Button>
                    <pre class="language-vue mt-4"><code>{{ exampleCodes.loadingState }}</code></pre>
                  </div>
                </Collapsible>
              </div>

              <!-- Icon Buttons -->
              <div class="space-y-4">
                <div class="flex items-center justify-between p-6 border rounded-lg bg-muted/5">
                  <div class="space-y-2">
                    <p class="font-medium">Icon Buttons</p>
                    <p class="text-sm text-muted-foreground">Compact icon-only buttons</p>
                  </div>
                  <div class="flex items-center gap-4">
                    <div class="flex items-center space-x-4">
                      <Button size="icon" variant="primary" aria-label="Settings">
                        <Icon name="i-heroicons-cog-6-tooth" class="h-4 w-4" />
                      </Button>
                      <Button size="icon" variant="secondary" aria-label="Search">
                        <Icon name="i-heroicons-magnifying-glass" class="h-4 w-4" />
                      </Button>
                      <Button size="icon" variant="accent" aria-label="Add">
                        <Icon name="i-heroicons-plus" class="h-4 w-4" />
                      </Button>
                      <Button size="icon" variant="destructive" aria-label="Delete">
                        <Icon name="i-heroicons-trash" class="h-4 w-4" />
                      </Button>
                    </div>
                    <Button
                      size="icon"
                      variant="ghost"
                      @click="toggleExampleCode('iconButtons')"
                      :aria-label="showExampleCode.iconButtons ? 'Hide code' : 'Show code'"
                    >
                      <Icon
                        :name="showExampleCode.iconButtons ? 'i-heroicons-code-bracket-square' : 'i-heroicons-code-bracket'"
                        class="h-4 w-4"
                      />
                    </Button>
                  </div>
                </div>
                <Collapsible v-if="showExampleCode.iconButtons">
                  <div class="relative rounded-md bg-muted/50 p-4">
                    <Button
                      size="sm"
                      variant="secondary"
                      class="absolute right-4 top-4"
                      @click="copyCode(exampleCodes.iconButtons, 'iconButtons')"
                    >
                      <Icon
                        :name="copiedStates.iconButtons ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                        class="mr-2 h-4 w-4"
                      />
                      {{ copiedStates.iconButtons ? 'Copied' : 'Copy' }}
                    </Button>
                    <pre class="language-vue mt-4"><code>{{ exampleCodes.iconButtons }}</code></pre>
                  </div>
                </Collapsible>
              </div>

              <!-- All Variants -->
              <div class="space-y-4">
                <div class="flex items-center justify-between p-6 border rounded-lg bg-muted/5">
                  <div class="space-y-2">
                    <p class="font-medium">All Variants</p>
                    <p class="text-sm text-muted-foreground">Complete set of button variants with their disabled states</p>
                  </div>
                  <div class="flex items-center gap-4">
                    <div class="flex flex-wrap items-center gap-4">
                      <Button variant="primary">Primary</Button>
                      <Button variant="secondary">Secondary</Button>
                      <Button variant="accent">Accent</Button>
                      <Button variant="outline">Outline</Button>
                      <Button variant="destructive">Destructive</Button>
                    </div>
                    <Button
                      size="icon"
                      variant="ghost"
                      @click="toggleExampleCode('allVariants')"
                      :aria-label="showExampleCode.allVariants ? 'Hide code' : 'Show code'"
                    >
                      <Icon
                        :name="showExampleCode.allVariants ? 'i-heroicons-code-bracket-square' : 'i-heroicons-code-bracket'"
                        class="h-4 w-4"
                      />
                    </Button>
                  </div>
                </div>
                <Collapsible v-if="showExampleCode.allVariants">
                  <div class="relative rounded-md bg-muted/50 p-4">
                    <Button
                      size="sm"
                      variant="secondary"
                      class="absolute right-4 top-4"
                      @click="copyCode(exampleCodes.allVariants, 'allVariants')"
                    >
                      <Icon
                        :name="copiedStates.allVariants ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                        class="mr-2 h-4 w-4"
                      />
                      {{ copiedStates.allVariants ? 'Copied' : 'Copy' }}
                    </Button>
                    <pre class="language-vue mt-4"><code>{{ exampleCodes.allVariants }}</code></pre>
                  </div>
                </Collapsible>

                <!-- Disabled States -->
                <div class="flex items-center justify-between p-6 border rounded-lg bg-muted/5">
                  <div class="space-y-2">
                    <p class="font-medium">Disabled States</p>
                    <p class="text-sm text-muted-foreground">Disabled state for each variant</p>
                  </div>
                  <div class="flex flex-wrap items-center gap-4">
                    <Button variant="primary" disabled>Primary</Button>
                    <Button variant="secondary" disabled>Secondary</Button>
                    <Button variant="accent" disabled>Accent</Button>
                    <Button variant="outline" disabled>Outline</Button>
                    <Button variant="destructive" disabled>Destructive</Button>
                  </div>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </TabsContent>

      <!-- Playground Tab -->
      <TabsContent :value="sections[1].id">
        <Card>
          <CardHeader>
            <CardTitle>Interactive Playground</CardTitle>
            <CardDescription>
              Experiment with different button configurations
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="space-y-8">
              <!-- All Variants Preview -->
              <div class="space-y-4">
                <h3 class="text-sm font-medium">All Variants</h3>
                <div class="flex flex-wrap gap-4">
                  <Button variant="primary">Primary</Button>
                  <Button variant="secondary">Secondary</Button>
                  <Button variant="accent">Accent</Button>
                  <Button variant="destructive">Destructive</Button>
                </div>
                <div class="flex flex-wrap gap-4">
                  <Button variant="primary" disabled>Primary</Button>
                  <Button variant="secondary" disabled>Secondary</Button>
                  <Button variant="accent" disabled>Accent</Button>
                  <Button variant="destructive" disabled>Destructive</Button>
                </div>
              </div>

              <!-- Interactive Configuration -->
              <ButtonPlayground />
            </div>
          </CardContent>
        </Card>
      </TabsContent>

      <!-- Code Tab -->
      <TabsContent :value="sections[2].id">
        <Card>
          <CardHeader>
            <CardTitle>Code Examples</CardTitle>
            <CardDescription>
              Implementation examples for common use cases
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Tabs v-model="activeCodeTab" class="w-full">
              <TabsList class="w-full">
                <TabsTrigger
                  v-for="example in codeExamples"
                  :key="example.title"
                  :value="example.title"
                  class="flex-1"
                >
                  {{ example.title }}
                </TabsTrigger>
              </TabsList>
              <div class="mt-4">
                <TabsContent
                  v-for="example in codeExamples"
                  :key="example.title"
                  :value="example.title"
                >
                  <div class="relative">
                    <Button
                      size="sm"
                      variant="secondary"
                      class="absolute right-4 top-4"
                      @click="copyCode(example.code, example.title)"
                    >
                      <Icon
                        :name="copiedStates[example.title] ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                        class="mr-2 h-4 w-4"
                      />
                      {{ copiedStates[example.title] ? 'Copied' : 'Copy' }}
                    </Button>
                    <pre class="language-vue line-numbers"><code>{{ example.code }}</code></pre>
                  </div>
                </TabsContent>
              </div>
            </Tabs>
          </CardContent>
        </Card>
      </TabsContent>

      <!-- Usage Tab -->
      <TabsContent :value="sections[3].id">
        <Card>
          <CardHeader>
            <CardTitle>Usage Guidelines</CardTitle>
            <CardDescription>
              Best practices for implementing buttons
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="prose prose-sm max-w-none">
              <h3>When to use</h3>
              <ul>
                <li>Use buttons to trigger actions or navigation</li>
                <li>Primary buttons for main actions</li>
                <li>Secondary buttons for alternative actions</li>
                <li>Icon buttons for compact UI elements</li>
              </ul>

              <h3 class="mt-6">Implementation</h3>
              <ul>
                <li>Import the Button component</li>
                <li>Choose appropriate variant and size props</li>
                <li>Add icons or loading states as needed</li>
                <li>Ensure proper accessibility attributes</li>
              </ul>
            </div>
          </CardContent>
        </Card>
      </TabsContent>

      <!-- Guidelines Tab -->
      <TabsContent :value="sections[4].id">
        <Card>
          <CardHeader>
            <CardTitle>Best Practices</CardTitle>
            <CardDescription>
              Guidelines for using buttons effectively
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="grid gap-6 md:grid-cols-2">
              <div class="space-y-4">
                <h3 class="font-medium">Do's</h3>
                <ul class="space-y-2">
                  <li v-for="item in dosAndDonts[0].do" :key="item" class="flex items-start gap-2">
                    <Icon name="i-heroicons-check-circle" class="h-5 w-5 text-success shrink-0" />
                    <span>{{ item }}</span>
                  </li>
                </ul>
              </div>
              <div class="space-y-4">
                <h3 class="font-medium">Don'ts</h3>
                <ul class="space-y-2">
                  <li v-for="item in dosAndDonts[0].dont" :key="item" class="flex items-start gap-2">
                    <Icon name="i-heroicons-x-circle" class="h-5 w-5 text-destructive shrink-0" />
                    <span>{{ item }}</span>
                  </li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>
      </TabsContent>
    </Tabs>
  </div>
</template>

<style scoped>
/* Add smooth scrolling behavior */
html {
  scroll-behavior: smooth;
}

/* Add styles for syntax highlighting */
pre code {
  tab-size: 2;
  -moz-tab-size: 2;
  white-space: pre;
}

.dark pre code {
  color: #e4e4e7; /* Zinc-200 for better contrast in dark mode */
}

pre code .tag {
  color: #60a5fa; /* Blue-400 */
}

pre code .attr {
  color: #34d399; /* Emerald-400 */
}

/* Add styles for active section indicator */
.scroll-link {
  position: relative;
  padding-bottom: 2px;
}

.scroll-link.active::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 100%;
  height: 2px;
  background-color: var(--primary);
  border-radius: 2px;
}
</style>
