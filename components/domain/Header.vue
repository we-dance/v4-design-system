<script setup lang="ts">
import { ref, computed } from 'vue'
import { useI18n } from 'vue-i18n'

const { locale, availableLocales } = useI18n()

const languageOptions = computed(() => {
  return availableLocales.map((lang) => ({
    value: lang,
    label: getLanguageLabel(lang),
  }))
})

const selectedLanguage = computed({
  get: () => locale.value,
  set: (value) => {
    locale.value = value
    localStorage.setItem('preferred-language', value)
  },
})

function getLanguageLabel(lang: string): string {
  const labels: Record<string, string> = {
    en: 'English',
    es: 'Español',
    fr: 'Français',
    de: 'Deutsch',
    it: 'Italiano',
    ru: 'Русский',
    zh: '中文',
    ja: '日本語',
    ko: '한국어',
  }
  return labels[lang] || lang
}

// Initialize language from localStorage or browser preference
onMounted(() => {
  const savedLanguage = localStorage.getItem('preferred-language')
  if (savedLanguage && availableLocales.includes(savedLanguage)) {
    locale.value = savedLanguage
  } else {
    const browserLang = navigator.language.split('-')[0]
    if (availableLocales.includes(browserLang)) {
      locale.value = browserLang
    }
  }
})
</script>

<template>
  <header class="bg-background/80 backdrop-blur-sm shadow-sm fixed w-full z-50 border-b border-border">
    <div class="max-w-[87%] mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between items-center h-16">
        <!-- Logo -->
        <div class="flex">
          <div class="flex-shrink-0 flex items-center">
            <NuxtLink to="/" id="logo">
              <WeDanceLogo class="h-10" />
            </NuxtLink>
          </div>
        </div>

        <!-- Right side controls -->
        <div class="flex items-center gap-4">
          <!-- Language Selector -->
          <Select v-model="selectedLanguage">
            <SelectTrigger class="w-[140px]">
              <SelectValue :placeholder="getLanguageLabel(selectedLanguage)" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem
                v-for="option in languageOptions"
                :key="option.value"
                :value="option.value"
              >
                {{ option.label }}
              </SelectItem>
            </SelectContent>
          </Select>

          <!-- Search Button -->
          <Button variant="ghost" size="icon">
            <Icon name="lucide:search" class="h-4 w-4" />
          </Button>

          <!-- User Menu -->
          <template v-if="isLoggedIn">
            <DropdownMenu>
              <DropdownMenuTrigger as-child>
                <Button variant="ghost" size="icon">
                  <Avatar :profile="data?.profile" class="h-4 w-4" />
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                <DropdownMenuItem as-child>
                  <NuxtLink :to="`/@${data?.profile?.username}`">
                    <Icon name="lucide:user" class="mr-2 h-4 w-4" />
                    {{ data?.profile?.username }}
                  </NuxtLink>
                </DropdownMenuItem>
                <DropdownMenuItem as-child>
                  <NuxtLink to="/settings">
                    <Icon name="lucide:settings" class="mr-2 h-4 w-4" />
                    Settings
                  </NuxtLink>
                </DropdownMenuItem>
                <DropdownMenuSeparator />
                <DropdownMenuItem @click="handleSignOut">
                  <Icon name="lucide:log-out" class="mr-2 h-4 w-4" />
                  Sign Out
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </template>
          <template v-else>
            <Button as-child>
              <NuxtLink to="/login">Sign In</NuxtLink>
            </Button>
          </template>
        </div>
      </div>
    </div>
  </header>
  <div class="h-16 bg-background"></div>
</template> 