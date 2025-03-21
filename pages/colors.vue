<script setup lang="ts">
/* Safelist:
bg-background bg-foreground text-background text-foreground
bg-primary bg-primary-foreground text-primary text-primary-foreground
bg-secondary bg-secondary-foreground text-secondary text-secondary-foreground
bg-accent bg-accent-foreground text-accent text-accent-foreground
bg-muted bg-muted-foreground text-muted text-muted-foreground
bg-destructive bg-destructive-foreground text-destructive text-destructive-foreground
bg-success bg-success-foreground text-success text-success-foreground
bg-warning bg-warning-foreground text-warning text-warning-foreground
bg-info bg-info-foreground text-info text-info-foreground
bg-card bg-card-foreground text-card text-card-foreground
bg-popover bg-popover-foreground text-popover text-popover-foreground
bg-border bg-input bg-ring text-border text-input text-ring
bg-gradient-base bg-gradient-1 bg-gradient-2 bg-gradient-3
*/

const colorGroups = [
  {
    name: 'Base Colors',
    description: 'Core colors that form the foundation of our design system.',
    colors: [
      {
        name: 'primary',
        description: 'Main brand color used for primary actions and key visual elements',
        variants: ['DEFAULT', 'foreground'],
      },
      {
        name: 'secondary',
        description: 'Secondary brand color for less prominent elements',
        variants: ['DEFAULT', 'foreground'],
      },
      {
        name: 'accent',
        description: 'Accent color for highlights and emphasis',
        variants: ['DEFAULT', 'foreground'],
      },
    ],
  },
  {
    name: 'Semantic Colors',
    description: 'Colors that carry specific meaning and purpose.',
    colors: [
      {
        name: 'background',
        description: 'Page and component background color',
        variants: ['DEFAULT'],
      },
      {
        name: 'foreground',
        description: 'Default text color',
        variants: ['DEFAULT'],
      },
      {
        name: 'muted',
        description: 'Subtle background and text colors',
        variants: ['DEFAULT', 'foreground'],
      },
    ],
  },
  {
    name: 'Status Colors',
    description: 'Colors that communicate state and feedback.',
    colors: [
      {
        name: 'success',
        description: 'Positive actions and success states',
        variants: ['DEFAULT', 'foreground'],
      },
      {
        name: 'warning',
        description: 'Cautionary actions and warning states',
        variants: ['DEFAULT', 'foreground'],
      },
      {
        name: 'destructive',
        description: 'Dangerous actions and error states',
        variants: ['DEFAULT', 'foreground'],
      },
      {
        name: 'info',
        description: 'Informational states and help content',
        variants: ['DEFAULT', 'foreground'],
      },
    ],
  },
  {
    name: 'Component Colors',
    description: 'Specific colors for UI components and patterns.',
    colors: [
      {
        name: 'card',
        description: 'Colors for card components',
        variants: ['DEFAULT', 'foreground'],
      },
      {
        name: 'popover',
        description: 'Colors for floating elements like popovers and dropdowns',
        variants: ['DEFAULT', 'foreground'],
      },
      {
        name: 'border',
        description: 'Color for borders and dividers',
        variants: ['DEFAULT'],
      },
      {
        name: 'input',
        description: 'Color for form inputs',
        variants: ['DEFAULT'],
      },
      {
        name: 'ring',
        description: 'Color for focus rings and outlines',
        variants: ['DEFAULT'],
      },
    ],
  },
  {
    name: 'Data Visualization',
    description: 'Colors specifically designed for charts and data visualization.',
    colors: [
      {
        name: 'chart',
        description: 'Colors for data visualization',
        variants: ['1', '2', '3', '4', '5'],
      },
    ],
  },
]
</script>

<template>
  <div class="max-w-[1200px] mx-auto px-6">
    <h1 class="text-4xl font-bold mb-6">Color System</h1>
    
    <!-- Introduction -->
    <section class="mb-12">
      <p class="text-lg text-muted-foreground leading-relaxed">
        Our color system follows atomic design principles, organizing colors from fundamental atoms to complete page-level applications. 
        Each color is designed to be accessible and maintain consistency across light and dark modes through semantic naming conventions.
      </p>
    </section>

    <!-- Color Groups -->
    <div class="space-y-20">
      <section v-for="group in colorGroups" :key="group.name" class="rounded-lg p-6 bg-card">
        <div class="mb-6">
          <h2 class="text-2xl font-semibold mb-2">{{ group.name }}</h2>
          <p class="text-muted-foreground">{{ group.description }}</p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div
            v-for="color in group.colors"
            :key="color.name"
            class="space-y-4"
          >
            <h3 class="text-lg font-medium capitalize">{{ color.name }}</h3>
            <p class="text-sm text-muted-foreground">{{ color.description }}</p>
            <div class="space-y-2">
              <ColorSwatch
                v-for="variant in color.variants"
                :key="`${color.name}-${variant}`"
                :name="`${color.name}${variant !== 'DEFAULT' ? `-${variant}` : ''}`"
                :description="`${color.name} ${variant !== 'DEFAULT' ? variant : ''}`"
                class="mb-2"
              />
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>
