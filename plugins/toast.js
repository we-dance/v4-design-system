import { Toaster } from 'vue-sonner'

export default defineNuxtPlugin((nuxtApp) => {
  // Only register it if it's not already registered
  if (!nuxtApp.vueApp._context.components['Toaster']) {
    nuxtApp.vueApp.component('Toaster', Toaster)
  }
}) 