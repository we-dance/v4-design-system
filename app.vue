<script setup lang="ts">
import { Toaster } from '@/components/ui/sonner'

const runtimeConfig = useRuntimeConfig()
const baseUrl = runtimeConfig.public.baseUrl
</script>

<template>
  <NuxtLayout>
    <ClientOnly>
      <Toaster />
    </ClientOnly>
    <NuxtPage />
  </NuxtLayout>
</template>
