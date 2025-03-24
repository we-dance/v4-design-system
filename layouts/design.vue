<template>
  <div class="min-h-screen bg-background">
    <header class="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div class="container flex h-14 items-center">
        <div class="mr-4 flex">
          <NuxtLink to="/" class="mr-6 flex items-center space-x-2">
            <span class="font-bold">Design System</span>
          </NuxtLink>
        </div>
      </div>
    </header>

    <div class="container flex-1 items-start md:grid md:grid-cols-[220px_minmax(0,1fr)] md:gap-6 lg:grid-cols-[240px_minmax(0,1fr)] lg:gap-10">
      <aside class="fixed top-14 z-30 -ml-2 hidden h-[calc(100vh-3.5rem)] w-full shrink-0 overflow-y-auto border-r md:sticky md:block">
        <div class="relative overflow-hidden py-6 pr-6 lg:py-8">
          <DesignNavigation />
        </div>
      </aside>
      <main class="relative py-6 lg:gap-10 lg:py-8">
        <slot />
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
// The navigation is now handled by the DesignNavigation component
</script> 