<script setup lang="ts">
import { ref } from 'vue'

type ButtonVariant =
  | 'primary'
  | 'secondary'
  | 'outline'
  | 'ghost'
  | 'link'
  | 'destructive'
type ButtonSize = 'default' | 'sm' | 'lg' | 'icon'

const variants: Array<{ name: ButtonVariant; description: string }> = [
  { name: 'primary', description: 'Primary action button, used for main calls to action' },
  { name: 'secondary', description: 'Secondary action button, used for supporting actions' },
  { name: 'outline', description: 'Outlined button for less emphasis, good for optional actions' },
  { name: 'ghost', description: 'Ghost button for subtle actions, often used in toolbars' },
  { name: 'link', description: 'Link-styled button for navigation-like actions' },
  { name: 'destructive', description: 'For destructive actions that need caution' },
]

const sizes: Array<{ name: ButtonSize; description: string }> = [
  { name: 'default', description: 'Standard size for most use cases' },
  { name: 'sm', description: 'Compact size for tight spaces or secondary actions' },
  { name: 'lg', description: 'Large size for primary calls to action' },
  { name: 'icon', description: 'Square button for icon-only usage' },
]

const previewMode = ref(true)

const buttonStates = [
  { name: 'Default', disabled: false, loading: false },
  { name: 'Disabled', disabled: true, loading: false },
  { name: 'Loading', disabled: true, loading: true },
]

const commonActions = [
  { text: 'Save Changes', variant: 'primary', icon: 'i-heroicons-check' },
  { text: 'Delete', variant: 'destructive', icon: 'i-heroicons-trash' },
  { text: 'Cancel', variant: 'outline', icon: 'i-heroicons-x-mark' },
  { text: 'Edit', variant: 'secondary', icon: 'i-heroicons-pencil' },
  { text: 'Share', variant: 'ghost', icon: 'i-heroicons-share' },
]

const buttonGroups = [
  {
    name: 'Action Group',
    buttons: [
      { text: 'Save', variant: 'primary' },
      { text: 'Cancel', variant: 'outline' },
    ],
  },
  {
    name: 'Toggle Group',
    buttons: [
      { text: 'List', variant: 'outline', icon: 'i-heroicons-list-bullet' },
      { text: 'Grid', variant: 'outline', icon: 'i-heroicons-squares-2x2' },
    ],
  },
]
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-4">Button Component</h1>
    <p class="text-muted-foreground mb-6">
      Buttons are interactive elements that trigger actions or navigation. They are a fundamental part of any user interface and should be used consistently throughout the application.
    </p>

    <Tabs default-value="preview" class="mb-8">
      <TabsList>
        <TabsTrigger value="preview">Preview</TabsTrigger>
        <TabsTrigger value="code">Code</TabsTrigger>
        <TabsTrigger value="usage">Usage</TabsTrigger>
      </TabsList>

      <!-- Preview Tab -->
      <TabsContent value="preview" class="p-4 border rounded-md mt-2">
        <div class="mb-4 flex flex-wrap gap-4">
          <Button variant="outline" @click="previewMode = !previewMode">
            {{ previewMode ? 'Show All Examples' : 'Show Interactive Preview' }}
          </Button>
        </div>

        <!-- Button Variants -->
        <section class="mb-8">
          <h3 class="text-lg font-medium mb-4">Button Variants</h3>
          <div class="grid gap-4">
            <div v-for="variant in variants" :key="variant.name" class="flex items-center justify-between p-4 border rounded-md">
              <div>
                <h4 class="font-medium">{{ variant.name }}</h4>
                <p class="text-sm text-muted-foreground">{{ variant.description }}</p>
              </div>
              <Button :variant="variant.name">Button</Button>
            </div>
          </div>
        </section>

        <!-- Button Sizes -->
        <section class="mb-8">
          <h3 class="text-lg font-medium mb-4">Button Sizes</h3>
          <div class="grid gap-4">
            <div v-for="size in sizes" :key="size.name" class="flex items-center justify-between p-4 border rounded-md">
              <div>
                <h4 class="font-medium">{{ size.name }}</h4>
                <p class="text-sm text-muted-foreground">{{ size.description }}</p>
              </div>
              <Button :size="size.name">
                <Icon v-if="size.name === 'icon'" name="i-heroicons-plus" class="h-4 w-4" />
                <template v-else>Button</template>
              </Button>
            </div>
          </div>
        </section>

        <!-- Button States -->
        <section class="mb-8">
          <h3 class="text-lg font-medium mb-4">Button States</h3>
          <div class="grid gap-4">
            <div v-for="state in buttonStates" :key="state.name" class="flex items-center justify-between p-4 border rounded-md">
              <div>
                <h4 class="font-medium">{{ state.name }}</h4>
                <p class="text-sm text-muted-foreground">
                  Button in {{ state.name.toLowerCase() }} state
                </p>
              </div>
              <Button :disabled="state.disabled">
                <Icon
                  v-if="state.loading"
                  name="i-heroicons-arrow-path"
                  class="mr-2 h-4 w-4 animate-spin"
                />
                {{ state.loading ? 'Loading...' : 'Button' }}
              </Button>
            </div>
          </div>
        </section>

        <!-- Common Actions -->
        <section class="mb-8">
          <h3 class="text-lg font-medium mb-4">Common Actions</h3>
          <div class="flex flex-wrap gap-4">
            <Button
              v-for="action in commonActions"
              :key="action.text"
              :variant="action.variant as ButtonVariant"
            >
              <Icon :name="action.icon" class="mr-2 h-4 w-4" />
              {{ action.text }}
            </Button>
          </div>
        </section>

        <!-- Button Groups -->
        <section class="mb-8">
          <h3 class="text-lg font-medium mb-4">Button Groups</h3>
          <div class="grid gap-8">
            <div v-for="group in buttonGroups" :key="group.name">
              <h4 class="text-sm font-medium mb-2">{{ group.name }}</h4>
              <div class="flex gap-2">
                <Button
                  v-for="button in group.buttons"
                  :key="button.text"
                  :variant="button.variant as ButtonVariant"
                >
                  <Icon
                    v-if="button.icon"
                    :name="button.icon"
                    class="mr-2 h-4 w-4"
                  />
                  {{ button.text }}
                </Button>
              </div>
            </div>
          </div>
        </section>
      </TabsContent>

      <!-- Code Tab -->
      <TabsContent value="code" class="p-4 border rounded-md mt-2">
        <div class="mb-4 font-semibold">Component Implementation</div>
        <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;script setup lang="ts"&gt;
// Define button props
interface Props {
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'link' | 'destructive'
  size?: 'default' | 'sm' | 'lg' | 'icon'
  disabled?: boolean
}

// Example usage with icon
&lt;Button variant="primary" size="default"&gt;
  &lt;Icon name="i-heroicons-plus" class="mr-2 h-4 w-4" /&gt;
  Add Item
&lt;/Button&gt;

// Example loading state
&lt;Button disabled&gt;
  &lt;Icon name="i-heroicons-arrow-path" class="mr-2 h-4 w-4 animate-spin" /&gt;
  Loading...
&lt;/Button&gt;

// Example button group
&lt;div class="flex gap-2"&gt;
  &lt;Button variant="primary"&gt;Save&lt;/Button&gt;
  &lt;Button variant="outline"&gt;Cancel&lt;/Button&gt;
&lt;/div&gt;
&lt;/script&gt;</pre>
      </TabsContent>

      <!-- Usage Tab -->
      <TabsContent value="usage" class="p-4 border rounded-md mt-2">
        <div class="space-y-6">
          <!-- Props Documentation -->
          <div>
            <h3 class="text-lg font-semibold mb-2">Props</h3>
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
                  <td class="py-2 px-4 font-mono text-sm">variant</td>
                  <td class="py-2 px-4">ButtonVariant</td>
                  <td class="py-2 px-4">'primary'</td>
                  <td class="py-2 px-4">Visual style of the button</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4 font-mono text-sm">size</td>
                  <td class="py-2 px-4">ButtonSize</td>
                  <td class="py-2 px-4">'default'</td>
                  <td class="py-2 px-4">Size of the button</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4 font-mono text-sm">disabled</td>
                  <td class="py-2 px-4">boolean</td>
                  <td class="py-2 px-4">false</td>
                  <td class="py-2 px-4">Whether the button is disabled</td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Best Practices -->
          <div>
            <h3 class="text-lg font-semibold mb-2">Best Practices</h3>
            <ul class="list-disc pl-6 space-y-2">
              <li>Use primary buttons for main calls to action</li>
              <li>Limit the number of primary buttons on a page</li>
              <li>Use secondary or outline variants for less important actions</li>
              <li>Include icons to enhance visual hierarchy and recognition</li>
              <li>Maintain consistent button ordering in forms (e.g., Submit on the right)</li>
              <li>Use destructive variant for dangerous actions</li>
              <li>Provide loading states for asynchronous actions</li>
              <li>Group related buttons together</li>
              <li>Use appropriate button sizes based on context and hierarchy</li>
            </ul>
          </div>

          <!-- Accessibility -->
          <div>
            <h3 class="text-lg font-semibold mb-2">Accessibility</h3>
            <ul class="list-disc pl-6 space-y-2">
              <li>Use semantic button elements</li>
              <li>Provide descriptive labels for screen readers</li>
              <li>Ensure sufficient color contrast</li>
              <li>Support keyboard navigation</li>
              <li>Include focus indicators</li>
              <li>Add ARIA labels for icon-only buttons</li>
            </ul>
          </div>

          <Alert>
            <AlertTitle>Note</AlertTitle>
            <AlertDescription>
              This component is built on top of shadcn-vue's Button component and follows WAI-ARIA button patterns for accessibility.
            </AlertDescription>
          </Alert>
        </div>
      </TabsContent>
    </Tabs>
  </div>
</template>
