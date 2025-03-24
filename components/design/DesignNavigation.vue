<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { designConfig } from '~/config/design'

const route = useRoute()
const expandedSections = ref<string[]>(['ui', 'domain']) // Default expanded sections

// Compute active route for highlighting
const activeRoute = computed(() => route.path)

// Toggle section expansion
const toggleSection = (section: string) => {
  const index = expandedSections.value.indexOf(section)
  if (index === -1) {
    expandedSections.value.push(section)
  } else {
    expandedSections.value.splice(index, 1)
  }
}

// Check if a route is active
const isActive = (path: string) => activeRoute.value === path

// Check if a section contains the active route
const isSectionActive = (items: Array<{ to: string }>) => {
  return items.some(item => isActive(item.to))
}
</script>

<template>
  <nav class="w-full space-y-6 lg:max-w-xs" aria-label="Design System Navigation">
    <!-- Foundation Section -->
    <div class="space-y-4">
      <div class="flex items-center justify-between">
        <h2 class="text-lg font-semibold tracking-tight">{{ designConfig.foundation.label }}</h2>
      </div>
      <div class="space-y-1">
        <NuxtLink
          v-for="item in designConfig.foundation.items"
          :key="item.to"
          :to="item.to"
          :class="[
            'group flex w-full items-center rounded-md border border-transparent px-3 py-2 hover:bg-muted/50 transition-colors',
            'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary',
            isActive(item.to) ? 'bg-muted font-medium text-foreground' : 'text-muted-foreground'
          ]"
        >
          <span>{{ item.label }}</span>
        </NuxtLink>
      </div>
    </div>

    <!-- Components Section -->
    <div class="space-y-4">
      <div class="flex items-center justify-between">
        <h2 class="text-lg font-semibold tracking-tight">{{ designConfig.components.label }}</h2>
      </div>
      
      <!-- UI Components -->
      <div class="space-y-1">
        <button
          class="flex w-full items-center justify-between rounded-md px-3 py-2 text-left text-sm font-medium hover:bg-muted/50 transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary"
          :class="[
            isSectionActive(designConfig.components.sections.ui.items) ? 'text-foreground' : 'text-muted-foreground',
            expandedSections.includes('ui') ? 'bg-muted/50' : ''
          ]"
          @click="toggleSection('ui')"
          :aria-expanded="expandedSections.includes('ui')"
        >
          <span>{{ designConfig.components.sections.ui.label }}</span>
          <Icon
            :name="expandedSections.includes('ui') ? 'i-heroicons-chevron-up' : 'i-heroicons-chevron-down'"
            class="h-4 w-4"
          />
        </button>
        <div v-show="expandedSections.includes('ui')" class="mt-1 space-y-1 pl-4">
          <NuxtLink
            v-for="item in designConfig.components.sections.ui.items"
            :key="item.to"
            :to="item.to"
            :class="[
              'group flex w-full items-center rounded-md border border-transparent px-3 py-2 text-sm transition-colors',
              'hover:bg-muted/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary',
              isActive(item.to) ? 'bg-muted font-medium text-foreground' : 'text-muted-foreground'
            ]"
          >
            <span>{{ item.label }}</span>
            <span class="ml-2 text-xs text-muted-foreground">{{ item.description }}</span>
          </NuxtLink>
        </div>
      </div>

      <!-- Domain Components -->
      <div class="space-y-1">
        <button
          class="flex w-full items-center justify-between rounded-md px-3 py-2 text-left text-sm font-medium hover:bg-muted/50 transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary"
          :class="[
            isSectionActive(designConfig.components.sections.domain.items) ? 'text-foreground' : 'text-muted-foreground',
            expandedSections.includes('domain') ? 'bg-muted/50' : ''
          ]"
          @click="toggleSection('domain')"
          :aria-expanded="expandedSections.includes('domain')"
        >
          <span>{{ designConfig.components.sections.domain.label }}</span>
          <Icon
            :name="expandedSections.includes('domain') ? 'i-heroicons-chevron-up' : 'i-heroicons-chevron-down'"
            class="h-4 w-4"
          />
        </button>
        <div v-show="expandedSections.includes('domain')" class="mt-1 space-y-1 pl-4">
          <NuxtLink
            v-for="item in designConfig.components.sections.domain.items"
            :key="item.to"
            :to="item.to"
            :class="[
              'group flex w-full items-center rounded-md border border-transparent px-3 py-2 text-sm transition-colors',
              'hover:bg-muted/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary',
              isActive(item.to) ? 'bg-muted font-medium text-foreground' : 'text-muted-foreground'
            ]"
          >
            <span>{{ item.label }}</span>
            <span class="ml-2 text-xs text-muted-foreground">{{ item.description }}</span>
          </NuxtLink>
        </div>
      </div>
    </div>

    <!-- Patterns Section -->
    <div class="space-y-4">
      <div class="flex items-center justify-between">
        <h2 class="text-lg font-semibold tracking-tight">{{ designConfig.patterns.label }}</h2>
      </div>
      <div class="space-y-1">
        <NuxtLink
          v-for="item in designConfig.patterns.items"
          :key="item.to"
          :to="item.to"
          :class="[
            'group flex w-full items-center rounded-md border border-transparent px-3 py-2 hover:bg-muted/50 transition-colors',
            'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary',
            isActive(item.to) ? 'bg-muted font-medium text-foreground' : 'text-muted-foreground'
          ]"
        >
          <span>{{ item.label }}</span>
          <span class="ml-2 text-xs text-muted-foreground">{{ item.description }}</span>
        </NuxtLink>
      </div>
    </div>

    <!-- Emails Section -->
    <div class="space-y-4">
      <div class="flex items-center justify-between">
        <h2 class="text-lg font-semibold tracking-tight">{{ designConfig.emails.label }}</h2>
      </div>
      <div class="space-y-1">
        <NuxtLink
          v-for="item in designConfig.emails.items"
          :key="item.to"
          :to="item.to"
          :class="[
            'group flex w-full items-center rounded-md border border-transparent px-3 py-2 hover:bg-muted/50 transition-colors',
            'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary',
            isActive(item.to) ? 'bg-muted font-medium text-foreground' : 'text-muted-foreground'
          ]"
        >
          <span>{{ item.label }}</span>
          <span class="ml-2 text-xs text-muted-foreground">{{ item.description }}</span>
        </NuxtLink>
      </div>
    </div>
  </nav>
</template>

<style scoped>
/* Ensure focus styles are visible in Windows High Contrast mode */
@media (forced-colors: active) {
  a:focus-visible,
  button:focus-visible {
    outline: 2px solid CanvasText;
  }
}
</style> 