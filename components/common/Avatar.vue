<script setup lang="ts">
interface Profile {
  id?: string
  photo?: string
  image?: string
  name?: string
}

interface Props {
  profile?: Profile
  size?: 'sm' | 'md' | 'lg' | 'xl'
  fallback?: string
}

const props = withDefaults(defineProps<Props>(), {
  size: 'md',
  fallback: null,
})

const sizeClasses = {
  sm: 'h-8 w-8',
  md: 'h-10 w-10',
  lg: 'h-12 w-12',
  xl: 'h-16 w-16',
}

const avatarUrl = computed(() => {
  if (props?.profile?.photo) {
    return props.profile.photo
  }

  if (props?.profile?.image) {
    return props.profile.image
  }

  if (props?.profile?.id) {
    return 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + props.profile.id
  }

  if (props.fallback) {
    return props.fallback
  }

  return null
})

const initials = computed(() => {
  if (!props.profile?.name) return null
  return props.profile.name
    .split(' ')
    .map((n) => n[0])
    .join('')
    .toUpperCase()
    .slice(0, 2)
})
</script>

<template>
  <div
    :class="[
      'relative inline-flex items-center justify-center rounded-full bg-muted overflow-hidden',
      sizeClasses[size],
    ]"
  >
    <img
      v-if="avatarUrl"
      :src="avatarUrl"
      :alt="profile?.name || 'profile avatar'"
      class="h-full w-full object-cover"
    />
    <span
      v-else-if="initials"
      class="text-sm font-medium text-muted-foreground"
    >
      {{ initials }}
    </span>
    <Icon v-else name="ph:user" class="h-1/2 w-1/2 text-muted-foreground" />
  </div>
</template>
