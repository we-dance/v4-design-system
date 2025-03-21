<script setup lang="ts">
import { ref } from 'vue'

type ContainerSize = 'sm' | 'md' | 'lg' | 'xl' | '2xl' | 'fluid'
type ColumnCount = 1 | 2 | 3 | 4 | 6 | 12

const containerSizes: Array<{ name: ContainerSize; maxWidth: string; description: string }> = [
  { name: 'sm', maxWidth: '640px', description: 'Small container for compact layouts' },
  { name: 'md', maxWidth: '768px', description: 'Medium container for content-focused layouts' },
  { name: 'lg', maxWidth: '1024px', description: 'Large container for standard layouts' },
  { name: 'xl', maxWidth: '1280px', description: 'Extra large container for wide layouts' },
  { name: '2xl', maxWidth: '1536px', description: 'Double extra large container for very wide layouts' },
  { name: 'fluid', maxWidth: '100%', description: 'Full-width container that adapts to viewport' },
]

const columnLayouts: Array<{ columns: ColumnCount; description: string }> = [
  { columns: 1, description: 'Single column layout' },
  { columns: 2, description: 'Two column layout' },
  { columns: 3, description: 'Three column layout' },
  { columns: 4, description: 'Four column layout' },
  { columns: 6, description: 'Six column layout' },
  { columns: 12, description: 'Twelve column layout' },
]

const gutterSizes = ['0', '2', '4', '6', '8', '12', '16']
</script>

<template>
  <div>
    <h1 class="text-3xl font-bold mb-4">Grid System</h1>
    <p class="text-muted-foreground mb-6">
      A flexible and responsive layout system built on top of Tailwind CSS's grid and flexbox utilities.
    </p>

    <Tabs default-value="preview" class="mb-8">
      <TabsList>
        <TabsTrigger value="preview">Preview</TabsTrigger>
        <TabsTrigger value="code">Code</TabsTrigger>
        <TabsTrigger value="usage">Usage</TabsTrigger>
      </TabsList>

      <!-- Preview Tab -->
      <TabsContent value="preview" class="p-4 border rounded-md mt-2">
        <!-- Containers -->
        <section class="mb-8">
          <h2 class="text-2xl font-semibold mb-4">Containers</h2>
          <div class="grid gap-4">
            <div v-for="size in containerSizes" :key="size.name">
              <div>
                <h3 class="font-medium">Container {{ size.name }}</h3>
                <p class="text-sm text-muted-foreground mb-2">
                  {{ size.description }} ({{ size.maxWidth }})
                </p>
              </div>
              <div :class="`container-${size.name} bg-muted p-4 rounded-lg border border-border`">
                <div class="bg-primary/10 p-4 rounded text-center">
                  Content
                </div>
              </div>
            </div>
          </div>
        </section>

        <!-- Grid Columns -->
        <section class="mb-8">
          <h2 class="text-2xl font-semibold mb-4">Grid Columns</h2>
          <div class="grid gap-4">
            <div v-for="layout in columnLayouts" :key="layout.columns">
              <div>
                <h3 class="font-medium">{{ layout.columns }} Column{{ layout.columns > 1 ? 's' : '' }}</h3>
                <p class="text-sm text-muted-foreground mb-2">{{ layout.description }}</p>
              </div>
              <div :class="`grid grid-cols-${layout.columns} gap-4`">
                <div v-for="i in layout.columns" :key="i" class="bg-primary/10 p-4 rounded text-center">
                  Column {{ i }}
                </div>
              </div>
            </div>
          </div>
        </section>

        <!-- Gutters -->
        <section class="mb-8">
          <h2 class="text-2xl font-semibold mb-4">Gutters</h2>
          <div class="grid gap-4">
            <div v-for="size in gutterSizes" :key="size">
              <div>
                <h3 class="font-medium">Gap {{ size }}</h3>
                <p class="text-sm text-muted-foreground mb-2">
                  {{ size === '0' ? 'No gap' : `${parseInt(size) * 0.25}rem spacing` }}
                </p>
              </div>
              <div :class="`grid grid-cols-3 gap-${size}`">
                <div class="bg-primary/10 p-4 rounded text-center">Column 1</div>
                <div class="bg-primary/10 p-4 rounded text-center">Column 2</div>
                <div class="bg-primary/10 p-4 rounded text-center">Column 3</div>
              </div>
            </div>
          </div>
        </section>
      </TabsContent>

      <!-- Code Tab -->
      <TabsContent value="code" class="p-4 border rounded-md mt-2">
        <div class="space-y-8">
          <div>
            <h3 class="font-semibold mb-2">Container Implementation</h3>
            <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;template&gt;
  &lt;div class="container-md mx-auto px-4"&gt;
    Your content here
  &lt;/div&gt;
&lt;/template&gt;</pre>
          </div>

          <div>
            <h3 class="font-semibold mb-2">Grid Implementation</h3>
            <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;template&gt;
  &lt;div class="grid grid-cols-3 gap-4"&gt;
    &lt;div&gt;Column 1&lt;/div&gt;
    &lt;div&gt;Column 2&lt;/div&gt;
    &lt;div&gt;Column 3&lt;/div&gt;
  &lt;/div&gt;
&lt;/template&gt;</pre>
          </div>

          <div>
            <h3 class="font-semibold mb-2">Responsive Grid Implementation</h3>
            <pre class="bg-muted p-4 rounded-md overflow-auto">
&lt;template&gt;
  &lt;div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4"&gt;
    &lt;div&gt;Column 1&lt;/div&gt;
    &lt;div&gt;Column 2&lt;/div&gt;
    &lt;div&gt;Column 3&lt;/div&gt;
    &lt;div&gt;Column 4&lt;/div&gt;
  &lt;/div&gt;
&lt;/template&gt;</pre>
          </div>
        </div>
      </TabsContent>

      <!-- Usage Tab -->
      <TabsContent value="usage" class="p-4 border rounded-md mt-2">
        <div class="space-y-8">
          <!-- Container Sizes -->
          <div>
            <h3 class="text-lg font-semibold mb-2">Container Sizes</h3>
            <table class="w-full border-collapse">
              <thead>
                <tr class="border-b">
                  <th class="py-2 px-4 text-left">Size</th>
                  <th class="py-2 px-4 text-left">Class</th>
                  <th class="py-2 px-4 text-left">Max Width</th>
                  <th class="py-2 px-4 text-left">Description</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="size in containerSizes" :key="size.name" class="border-b">
                  <td class="py-2 px-4">{{ size.name }}</td>
                  <td class="py-2 px-4 font-mono">container-{{ size.name }}</td>
                  <td class="py-2 px-4">{{ size.maxWidth }}</td>
                  <td class="py-2 px-4">{{ size.description }}</td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Grid Features -->
          <div>
            <h3 class="text-lg font-semibold mb-2">Features</h3>
            <ul class="list-disc list-inside space-y-2">
              <li>Responsive 12-column grid system</li>
              <li>Flexible container sizes for different viewport widths</li>
              <li>Customizable gutters using Tailwind's gap utilities</li>
              <li>Support for nested grids</li>
              <li>Built-in responsive breakpoints</li>
            </ul>
          </div>

          <!-- Breakpoints -->
          <div>
            <h3 class="text-lg font-semibold mb-2">Responsive Breakpoints</h3>
            <table class="w-full border-collapse">
              <thead>
                <tr class="border-b">
                  <th class="py-2 px-4 text-left">Breakpoint</th>
                  <th class="py-2 px-4 text-left">Prefix</th>
                  <th class="py-2 px-4 text-left">Width</th>
                </tr>
              </thead>
              <tbody>
                <tr class="border-b">
                  <td class="py-2 px-4">Small</td>
                  <td class="py-2 px-4 font-mono">sm:</td>
                  <td class="py-2 px-4">640px</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">Medium</td>
                  <td class="py-2 px-4 font-mono">md:</td>
                  <td class="py-2 px-4">768px</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">Large</td>
                  <td class="py-2 px-4 font-mono">lg:</td>
                  <td class="py-2 px-4">1024px</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">Extra Large</td>
                  <td class="py-2 px-4 font-mono">xl:</td>
                  <td class="py-2 px-4">1280px</td>
                </tr>
                <tr class="border-b">
                  <td class="py-2 px-4">2XL</td>
                  <td class="py-2 px-4 font-mono">2xl:</td>
                  <td class="py-2 px-4">1536px</td>
                </tr>
              </tbody>
            </table>
          </div>

          <Alert>
            <AlertTitle>Best Practices</AlertTitle>
            <AlertDescription>
              <ul class="list-disc list-inside space-y-1">
                <li>Use containers to maintain consistent content width</li>
                <li>Choose appropriate column counts based on content type</li>
                <li>Utilize responsive breakpoints for optimal layouts across devices</li>
                <li>Keep gutters consistent throughout your application</li>
              </ul>
            </AlertDescription>
          </Alert>
        </div>
      </TabsContent>
    </Tabs>
  </div>
</template> 