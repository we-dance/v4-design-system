<script setup lang="ts">
import { ref } from 'vue'
import { Button } from '~/components/ui/button'
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from '~/components/ui/tooltip'

type TooltipPosition = 'top' | 'right' | 'bottom' | 'left'

const positions: Array<{ name: TooltipPosition; description: string }> = [
  { name: 'top', description: 'Displays tooltip above the trigger element' },
  { name: 'right', description: 'Displays tooltip to the right of the trigger element' },
  { name: 'bottom', description: 'Displays tooltip below the trigger element' },
  { name: 'left', description: 'Displays tooltip to the left of the trigger element' },
]

const positionExamples = {
  top: `<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">Top Tooltip</Button>
    </TooltipTrigger>
    <TooltipContent side="top">
      <p>Tooltip appears on top</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>`,
  right: `<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">Right Tooltip</Button>
    </TooltipTrigger>
    <TooltipContent side="right">
      <p>Tooltip appears on right</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>`,
  bottom: `<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">Bottom Tooltip</Button>
    </TooltipTrigger>
    <TooltipContent side="bottom">
      <p>Tooltip appears on bottom</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>`,
  left: `<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">Left Tooltip</Button>
    </TooltipTrigger>
    <TooltipContent side="left">
      <p>Tooltip appears on left</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>`,
}

const codeExamples = [
  {
    title: 'Basic Usage',
    description: 'Simple tooltip examples',
    code: `<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">Hover me</Button>
    </TooltipTrigger>
    <TooltipContent>
      <p>Basic tooltip content</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>

<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="primary">Help</Button>
    </TooltipTrigger>
    <TooltipContent>
      <p>Click for more information</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>`
  },
  {
    title: 'With Delay',
    description: 'Tooltip with custom delay duration',
    code: `<TooltipProvider :delay-duration="1000">
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">Hover me (1s delay)</Button>
    </TooltipTrigger>
    <TooltipContent>
      <p>Tooltip appears after 1 second</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>

<TooltipProvider :delay-duration="500">
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">Quick tooltip (0.5s)</Button>
    </TooltipTrigger>
    <TooltipContent>
      <p>Tooltip appears after 0.5 seconds</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>`
  },
  {
    title: 'With Icons',
    description: 'Tooltips with icon buttons',
    code: `<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button size="icon" variant="secondary" aria-label="Settings">
        <Icon name="i-heroicons-cog-6-tooth" class="h-4 w-4" />
      </Button>
    </TooltipTrigger>
    <TooltipContent>
      <p>Settings</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>

<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button size="icon" variant="secondary" aria-label="Help">
        <Icon name="i-heroicons-question-mark-circle" class="h-4 w-4" />
      </Button>
    </TooltipTrigger>
    <TooltipContent>
      <p>Help and documentation</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>`
  },
  {
    title: 'Custom Styling',
    description: 'Tooltips with custom styles',
    code: `<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">Custom style</Button>
    </TooltipTrigger>
    <TooltipContent class="bg-primary text-primary-foreground">
      <p>Custom styled tooltip</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>

<TooltipProvider>
  <Tooltip>
    <TooltipTrigger asChild>
      <Button variant="secondary">With icon</Button>
    </TooltipTrigger>
    <TooltipContent class="flex items-center gap-2">
      <Icon name="i-heroicons-information-circle" class="h-4 w-4" />
      <p>Tooltip with icon</p>
    </TooltipContent>
  </Tooltip>
</TooltipProvider>`
  }
]

const dosAndDonts = [
  {
    do: [
      'Use tooltips to provide additional context',
      'Keep tooltip content concise and clear',
      'Add delay to prevent accidental triggering',
      'Use tooltips for icon-only buttons',
      'Ensure tooltips are keyboard accessible'
    ],
    dont: [
      'Put essential information in tooltips',
      'Use tooltips for obvious information',
      'Make tooltips too long or complex',
      'Nest interactive elements in tooltips',
      'Use tooltips for error messages'
    ]
  }
]

const activeCodeTab = ref(codeExamples[0].title)
const copiedStates = ref<{ [key: string]: boolean }>({})
const showPositionCode = ref<{ [key: string]: boolean }>({})

const copyCode = (code: string, tab: string) => {
  navigator.clipboard.writeText(code)
  copiedStates.value[tab] = true
  setTimeout(() => {
    copiedStates.value[tab] = false
  }, 2000)
}

const togglePositionCode = (position: string) => {
  showPositionCode.value[position] = !showPositionCode.value[position]
}
</script>

<template>
  <div class="container py-10 max-w-screen-2xl">
    <!-- Header Section -->
    <div class="mb-8">
      <h1 class="scroll-m-20 text-4xl font-bold tracking-tight">Tooltip Component</h1>
      <p class="text-lg text-muted-foreground mt-3">
        Tooltips display additional information when users hover over or focus on an element.
        They help provide context and improve user understanding of UI elements.
      </p>
    </div>

    <!-- Main Content -->
    <Tabs :default-value="'preview'" class="space-y-6">
      <TabsList class="w-full">
        <TabsTrigger value="preview" class="flex-1">Preview</TabsTrigger>
        <TabsTrigger value="code" class="flex-1">Code</TabsTrigger>
        <TabsTrigger value="usage" class="flex-1">Usage</TabsTrigger>
        <TabsTrigger value="guidelines" class="flex-1">Best Practices</TabsTrigger>
      </TabsList>

      <!-- Preview Tab -->
      <TabsContent value="preview">
        <Card>
          <CardHeader>
            <CardTitle>Tooltip Positions</CardTitle>
            <CardDescription>
              Available tooltip positions and their use cases
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="grid gap-6">
              <div v-for="position in positions" :key="position.name" class="space-y-4">
                <div class="flex items-center justify-between p-6 border rounded-lg bg-muted/5">
                  <div class="space-y-2">
                    <p class="font-medium capitalize">{{ position.name }}</p>
                    <p class="text-sm text-muted-foreground">{{ position.description }}</p>
                  </div>
                  <div class="flex items-center gap-4">
                    <TooltipProvider>
                      <Tooltip>
                        <TooltipTrigger asChild>
                          <Button variant="secondary">{{ position.name }}</Button>
                        </TooltipTrigger>
                        <TooltipContent :side="position.name">
                          <p>Tooltip on {{ position.name }}</p>
                        </TooltipContent>
                      </Tooltip>
                    </TooltipProvider>
                    <Button
                      size="icon"
                      variant="secondary"
                      @click="togglePositionCode(position.name)"
                      :aria-label="showPositionCode[position.name] ? 'Hide code' : 'Show code'"
                    >
                      <Icon
                        :name="showPositionCode[position.name] ? 'i-heroicons-code-bracket-square' : 'i-heroicons-code-bracket'"
                        class="h-4 w-4"
                      />
                    </Button>
                  </div>
                </div>
                <Collapsible v-if="showPositionCode[position.name]">
                  <div class="relative rounded-md bg-muted/50 p-4">
                    <Button
                      size="sm"
                      variant="secondary"
                      class="absolute right-4 top-4"
                      @click="copyCode(positionExamples[position.name], position.name)"
                    >
                      <Icon
                        :name="copiedStates[position.name] ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                        class="mr-2 h-4 w-4"
                      />
                      {{ copiedStates[position.name] ? 'Copied' : 'Copy' }}
                    </Button>
                    <pre class="language-vue mt-4"><code>{{ positionExamples[position.name] }}</code></pre>
                  </div>
                </Collapsible>
              </div>
            </div>
          </CardContent>
        </Card>
      </TabsContent>

      <!-- Code Tab -->
      <TabsContent value="code">
        <Card>
          <CardHeader>
            <CardTitle>Code Examples</CardTitle>
            <CardDescription>
              Common tooltip patterns and usage examples
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="grid gap-6">
              <div v-for="example in codeExamples" :key="example.title">
                <div class="flex items-center justify-between mb-4">
                  <div>
                    <h3 class="text-lg font-medium">{{ example.title }}</h3>
                    <p class="text-sm text-muted-foreground">{{ example.description }}</p>
                  </div>
                  <Button
                    size="sm"
                    variant="secondary"
                    @click="copyCode(example.code, example.title)"
                  >
                    <Icon
                      :name="copiedStates[example.title] ? 'i-heroicons-check' : 'i-heroicons-clipboard'"
                      class="mr-2 h-4 w-4"
                    />
                    {{ copiedStates[example.title] ? 'Copied' : 'Copy' }}
                  </Button>
                </div>
                <div class="relative rounded-md bg-muted/50 p-4">
                  <pre class="language-vue"><code>{{ example.code }}</code></pre>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </TabsContent>

      <!-- Usage Tab -->
      <TabsContent value="usage">
        <Card>
          <CardHeader>
            <CardTitle>Component Usage</CardTitle>
            <CardDescription>
              Learn how to use the tooltip component effectively
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="space-y-6">
              <!-- Anatomy -->
              <div>
                <h3 class="text-lg font-medium mb-2">Component Anatomy</h3>
                <ul class="list-disc list-inside space-y-2 text-sm text-muted-foreground">
                  <li><code>TooltipProvider</code> - Wrapper component that provides context</li>
                  <li><code>Tooltip</code> - Root component that manages state</li>
                  <li><code>TooltipTrigger</code> - Element that triggers the tooltip</li>
                  <li><code>TooltipContent</code> - Content displayed in the tooltip</li>
                </ul>
              </div>

              <!-- Props -->
              <div>
                <h3 class="text-lg font-medium mb-2">Props</h3>
                <div class="border rounded-lg">
                  <div class="grid grid-cols-4 gap-4 p-4 border-b font-medium">
                    <div>Name</div>
                    <div>Type</div>
                    <div>Default</div>
                    <div>Description</div>
                  </div>
                  <div class="grid grid-cols-4 gap-4 p-4 border-b">
                    <div class="font-mono text-sm">delayDuration</div>
                    <div class="text-muted-foreground">number</div>
                    <div class="text-muted-foreground">700</div>
                    <div class="text-muted-foreground">
                      Delay in milliseconds before showing the tooltip
                    </div>
                  </div>
                  <div class="grid grid-cols-4 gap-4 p-4 border-b">
                    <div class="font-mono text-sm">side</div>
                    <div class="text-muted-foreground">string</div>
                    <div class="text-muted-foreground">'top'</div>
                    <div class="text-muted-foreground">
                      Position of the tooltip relative to the trigger
                    </div>
                  </div>
                  <div class="grid grid-cols-4 gap-4 p-4">
                    <div class="font-mono text-sm">asChild</div>
                    <div class="text-muted-foreground">boolean</div>
                    <div class="text-muted-foreground">false</div>
                    <div class="text-muted-foreground">
                      Whether to merge trigger props with child element
                    </div>
                  </div>
                </div>
              </div>

              <!-- Features -->
              <div>
                <h3 class="text-lg font-medium mb-2">Features</h3>
                <ul class="list-disc list-inside space-y-2 text-sm text-muted-foreground">
                  <li>Four positioning options (top, right, bottom, left)</li>
                  <li>Customizable delay duration</li>
                  <li>Custom styling support</li>
                  <li>Keyboard navigation</li>
                  <li>Screen reader announcements</li>
                  <li>Auto-positioning when near viewport edges</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>
      </TabsContent>

      <!-- Guidelines Tab -->
      <TabsContent value="guidelines">
        <Card>
          <CardHeader>
            <CardTitle>Best Practices</CardTitle>
            <CardDescription>
              Guidelines for using tooltips effectively
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div class="grid gap-8 sm:grid-cols-2">
              <div>
                <h3 class="font-semibold mb-4 text-green-500">Do's</h3>
                <ul class="space-y-4">
                  <li v-for="item in dosAndDonts[0].do" :key="item" class="flex gap-2">
                    <Icon name="i-heroicons-check-circle" class="h-5 w-5 text-green-500 flex-shrink-0" />
                    <span class="text-sm text-muted-foreground">{{ item }}</span>
                  </li>
                </ul>
              </div>
              <div>
                <h3 class="font-semibold mb-4 text-destructive">Don'ts</h3>
                <ul class="space-y-4">
                  <li v-for="item in dosAndDonts[0].dont" :key="item" class="flex gap-2">
                    <Icon name="i-heroicons-x-circle" class="h-5 w-5 text-destructive flex-shrink-0" />
                    <span class="text-sm text-muted-foreground">{{ item }}</span>
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