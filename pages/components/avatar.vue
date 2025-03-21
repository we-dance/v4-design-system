<script setup lang="ts">
const title = 'Avatar'
const description =
  'Display user profile pictures, initials, or fallback icons.'

const props = [
  {
    name: 'profile',
    type: 'Profile',
    description: 'User profile object containing id, photo, image, and/or name',
    required: false,
  },
  {
    name: 'size',
    type: "'sm' | 'md' | 'lg' | 'xl'",
    description: 'Size variant of the avatar',
    default: 'md',
    required: false,
  },
  {
    name: 'fallback',
    type: 'string',
    description: 'Custom fallback image URL',
    required: false,
  },
]

const examples = [
  {
    title: 'Basic Usage',
    description: 'Avatar with profile picture',
    code: `<Avatar :profile="{ photo: '/images/avatar.jpg', name: 'John Doe' }" />`,
  },
  {
    title: 'Sizes',
    description: 'Available size variants',
    code: `<div class="flex items-center gap-4">
  <Avatar :profile="profile" size="sm" />
  <Avatar :profile="profile" size="md" />
  <Avatar :profile="profile" size="lg" />
  <Avatar :profile="profile" size="xl" />
</div>`,
  },
  {
    title: 'Fallbacks',
    description: 'Different fallback states when no image is available',
    code: `<div class="flex items-center gap-4">
  <!-- Shows initials -->
  <Avatar :profile="{ name: 'John Doe' }" />
  <!-- Shows generic user icon -->
  <Avatar :profile="{}" />
  <!-- Shows custom fallback image -->
  <Avatar :profile="{}" fallback="/images/fallback.jpg" />
</div>`,
  },
]

// Example profile data
const profile = {
  id: '123',
  name: 'John Doe',
  photo: 'https://api.dicebear.com/7.x/avataaars/svg?seed=123',
}
</script>

<template>
  <div class="max-w-3xl mx-auto space-y-12">
    <!-- Header -->
    <div class="space-y-4">
      <h1 class="text-4xl font-bold">{{ title }}</h1>
      <p class="text-xl text-muted-foreground">{{ description }}</p>
    </div>

    <!-- Props -->
    <div class="space-y-4">
      <h2 class="text-2xl font-bold">Props</h2>
      <div class="border rounded-lg">
        <table class="w-full">
          <thead>
            <tr class="border-b">
              <th class="px-4 py-2 text-left">Name</th>
              <th class="px-4 py-2 text-left">Type</th>
              <th class="px-4 py-2 text-left">Default</th>
              <th class="px-4 py-2 text-left">Description</th>
            </tr>
          </thead>
          <tbody class="divide-y">
            <tr v-for="prop in props" :key="prop.name">
              <td class="px-4 py-2 font-mono text-sm">
                {{ prop.name }}
                <span v-if="prop.required" class="text-destructive">*</span>
              </td>
              <td class="px-4 py-2 font-mono text-sm">{{ prop.type }}</td>
              <td class="px-4 py-2 font-mono text-sm">
                {{ prop.default || '-' }}
              </td>
              <td class="px-4 py-2 text-sm text-muted-foreground">
                {{ prop.description }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Examples -->
    <div class="space-y-8">
      <h2 class="text-2xl font-bold">Examples</h2>
      <div
        v-for="example in examples"
        :key="example.title"
        class="space-y-4 border rounded-lg p-6"
      >
        <div>
          <h3 class="text-lg font-semibold">{{ example.title }}</h3>
          <p class="text-sm text-muted-foreground">
            {{ example.description }}
          </p>
        </div>

        <!-- Live Example -->
        <div class="p-4 border rounded-md bg-muted/50">
          <div v-if="example.title === 'Basic Usage'">
            <Avatar :profile="profile" />
          </div>

          <div
            v-else-if="example.title === 'Sizes'"
            class="flex items-center gap-4"
          >
            <Avatar :profile="profile" size="sm" />
            <Avatar :profile="profile" size="md" />
            <Avatar :profile="profile" size="lg" />
            <Avatar :profile="profile" size="xl" />
          </div>

          <div
            v-else-if="example.title === 'Fallbacks'"
            class="flex items-center gap-4"
          >
            <Avatar :profile="{ name: 'John Doe' }" />
            <Avatar :profile="{}" />
            <Avatar
              :profile="{}"
              fallback="https://api.dicebear.com/7.x/avataaars/svg?seed=fallback"
            />
          </div>
        </div>

        <!-- Code -->
        <div class="relative">
          <pre
            class="p-4 rounded-md bg-muted font-mono text-sm overflow-x-auto"
          ><code>{{ example.code }}</code></pre>
        </div>
      </div>
    </div>
  </div>
</template>
