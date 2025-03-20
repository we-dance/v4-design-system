<script setup lang="ts">
interface Props {
  title: string
  description?: string
}

defineProps<Props>()
</script>

<template>
  <div class="max-w-4xl">
    <div class="space-y-4 bg-muted p-4 rounded-lg">
      <h1 class="text-3xl font-bold">{{ title }}</h1>
      <p v-if="description" class="text-lg text-muted-foreground">
        {{ description }}
      </p>
    </div>

    <!-- Preview Section -->
    <div v-if="$slots.preview" class="my-10">
      <div>
        <div class="flex flex-col gap-4">
          <!-- Preview -->
          <div class="flex flex-col gap-4">
            <slot name="preview" />
          </div>
        </div>
      </div>
    </div>

    <!-- Documentation Content -->
    <div class="prose prose-slate dark:prose-invert max-w-none">
      <slot />
    </div>

    <!-- Navigation Links -->
    <div class="flex justify-between items-center mt-12 pt-6 border-t">
      <div>
        <NuxtLink to="/components">
          <Button variant="outline" class="flex items-center">
            <Icon name="ph:arrow-left" class="mr-2 h-4 w-4" />
            Back to Components
          </Button>
        </NuxtLink>
      </div>
      <div>
        <a
          href="https://github.com/WeDance/v4-design-system"
          target="_blank"
          rel="noopener noreferrer"
        >
          <Button variant="outline" class="flex items-center">
            <Icon name="ph:github-logo" class="mr-2 h-4 w-4" />
            Edit on GitHub
          </Button>
        </a>
      </div>
    </div>
  </div>
</template>
