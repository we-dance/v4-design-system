# Create new file
<script setup lang="ts">
import {
  ChevronRight,
  X,
  Check,
  Menu,
  Search,
  Settings,
  Plus,
  Trash,
  Edit,
  Share,
  Download,
  Upload,
  Mail,
  MessageSquare,
  Bell,
  Heart,
  User
} from 'lucide-vue-next'

const iconComponents = {
  'chevron-right': ChevronRight,
  'x': X,
  'check': Check,
  'menu': Menu,
  'search': Search,
  'settings': Settings,
  'plus': Plus,
  'trash': Trash,
  'edit': Edit,
  'share': Share,
  'download': Download,
  'upload': Upload,
  'mail': Mail,
  'message-square': MessageSquare,
  'bell': Bell,
  'heart': Heart,
  'user': User
}

const iconSections = [
  {
    title: 'Interface Icons',
    description: 'Common UI actions and elements',
    icons: [
      { name: 'chevron-right', usage: 'Navigation, expandable items' },
      { name: 'x', usage: 'Close, remove, cancel' },
      { name: 'check', usage: 'Success, completion, selected state' },
      { name: 'menu', usage: 'Navigation menu toggle' },
      { name: 'search', usage: 'Search functionality' },
      { name: 'settings', usage: 'Configuration, preferences' }
    ]
  },
  {
    title: 'Action Icons',
    description: 'User interactions and operations',
    icons: [
      { name: 'plus', usage: 'Add new item' },
      { name: 'trash', usage: 'Delete, remove' },
      { name: 'edit', usage: 'Edit, modify content' },
      { name: 'share', usage: 'Share content' },
      { name: 'download', usage: 'Download files' },
      { name: 'upload', usage: 'Upload files' }
    ]
  },
  {
    title: 'Social Icons',
    description: 'Social media and communication',
    icons: [
      { name: 'mail', usage: 'Email communication' },
      { name: 'message-square', usage: 'Chat, comments' },
      { name: 'bell', usage: 'Notifications' },
      { name: 'heart', usage: 'Like, favorite' },
      { name: 'user', usage: 'User profile' }
    ]
  }
]
</script>

<template>
  <div class="max-w-3xl mx-auto py-10">
    <h1 class="text-4xl font-bold mb-6">Icons</h1>
    <p class="text-lg text-muted-foreground mb-8">
      Our icon system uses Lucide icons, providing a consistent and accessible set of icons across the application.
    </p>

    <div class="space-y-12">
      <!-- Installation -->
      <section>
        <h2 class="text-2xl font-semibold mb-4">Installation</h2>
        <Card>
          <CardHeader>
            <CardTitle>Using Icons</CardTitle>
            <CardDescription>Icons are automatically imported from lucide-vue-next.</CardDescription>
          </CardHeader>
          <CardContent>
            <pre class="bg-muted p-4 rounded-lg"><code>// Example usage in template
&lt;template&gt;
  &lt;ChevronRight class="h-4 w-4" /&gt;
&lt;/template&gt;</code></pre>
          </CardContent>
        </Card>
      </section>

      <!-- Icon Guidelines -->
      <section>
        <h2 class="text-2xl font-semibold mb-4">Guidelines</h2>
        <div class="grid gap-6">
          <Card>
            <CardHeader>
              <CardTitle>Sizing</CardTitle>
              <CardDescription>
                Use consistent icon sizes throughout your interface. Common sizes:
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div class="flex items-center gap-8">
                <div class="flex flex-col items-center gap-2">
                  <ChevronRight class="h-4 w-4" />
                  <span class="text-sm text-muted-foreground">Small (16px)</span>
                </div>
                <div class="flex flex-col items-center gap-2">
                  <ChevronRight class="h-5 w-5" />
                  <span class="text-sm text-muted-foreground">Medium (20px)</span>
                </div>
                <div class="flex flex-col items-center gap-2">
                  <ChevronRight class="h-6 w-6" />
                  <span class="text-sm text-muted-foreground">Large (24px)</span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Color</CardTitle>
              <CardDescription>
                Icons inherit their color from the parent text color. Use semantic color tokens for consistency.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div class="flex items-center gap-8">
                <div class="flex flex-col items-center gap-2">
                  <ChevronRight class="h-5 w-5 text-primary" />
                  <span class="text-sm text-muted-foreground">Primary</span>
                </div>
                <div class="flex flex-col items-center gap-2">
                  <ChevronRight class="h-5 w-5 text-muted-foreground" />
                  <span class="text-sm text-muted-foreground">Muted</span>
                </div>
                <div class="flex flex-col items-center gap-2">
                  <ChevronRight class="h-5 w-5 text-destructive" />
                  <span class="text-sm text-muted-foreground">Destructive</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </section>

      <!-- Icon Catalog -->
      <section v-for="section in iconSections" :key="section.title">
        <h2 class="text-2xl font-semibold mb-4">{{ section.title }}</h2>
        <p class="text-muted-foreground mb-6">{{ section.description }}</p>
        <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
          <Card v-for="icon in section.icons" :key="icon.name">
            <CardHeader>
              <div class="flex items-center justify-between">
                <component :is="iconComponents[icon.name]" class="h-5 w-5" />
                <Badge variant="outline">{{ icon.name }}</Badge>
              </div>
            </CardHeader>
            <CardContent>
              <p class="text-sm text-muted-foreground">{{ icon.usage }}</p>
            </CardContent>
          </Card>
        </div>
      </section>

      <!-- Accessibility -->
      <section>
        <h2 class="text-2xl font-semibold mb-4">Accessibility</h2>
        <Card>
          <CardHeader>
            <CardTitle>Best Practices</CardTitle>
          </CardHeader>
          <CardContent>
            <ul class="list-disc pl-6 space-y-2">
              <li>Always provide an aria-label when the icon is used without accompanying text</li>
              <li>Use role="img" for decorative icons</li>
              <li>Ensure sufficient color contrast when icons are used to convey meaning</li>
            </ul>
          </CardContent>
        </Card>
      </section>
    </div>
  </div>
</template> 