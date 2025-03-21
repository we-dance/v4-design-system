export const designConfig = {
  foundation: {
    label: 'Foundation',
    description: 'Core design tokens and primitives',
    items: [
      {
        to: '/colors',
        label: 'Colors',
        description: 'Color system and semantic tokens',
      },
      {
        to: '/typography',
        label: 'Typography',
        description: 'Font families, sizes, and weights',
      },
    ],
  },
  components: {
    label: 'Components',
    description: 'Building blocks of the interface',
    sections: {
      ui: {
        label: 'UI Components',
        items: [
          {
            to: '/components/button',
            label: 'Button',
            description: 'Actions and links',
          },
          {
            to: '/components/input',
            label: 'Input',
            description: 'Form controls and fields',
          },
          {
            to: '/components/dialog',
            label: 'Dialog',
            description: 'Modal windows and overlays',
          },
          {
            to: '/components/subscription-plan',
            label: 'Subscription Plan',
            description: 'Plan comparison and management',
          },
        ],
      },
      domain: {
        label: 'Domain Components',
        items: [
          {
            to: '/components/post',
            label: 'Post',
            description: 'Content display for events and social posts',
          },
          {
            to: '/components/profile',
            label: 'Profile',
            description: 'User profiles and cards',
          },
          {
            to: '/components/event',
            label: 'Event',
            description: 'Dance event details and actions',
          },
          {
            to: '/components/venue',
            label: 'Venue',
            description: 'Dance venue information',
          },
          {
            to: '/components/course-editor',
            label: 'Course Editor',
            description: 'Create and manage dance courses',
          },
        ],
      },
    },
  },
  patterns: {
    label: 'Patterns',
    description: 'Common UI patterns and solutions',
    items: [
      {
        to: '/patterns/forms',
        label: 'Forms',
        description: 'Form layouts and validation',
      },
      {
        to: '/patterns/navigation',
        label: 'Navigation',
        description: 'Navigation patterns and menus',
      },
      {
        to: '/patterns/loading',
        label: 'Loading States',
        description: 'Loading and error states',
      },
    ],
  },
  emails: {
    label: 'Emails',
    description: 'Email templates and components',
    items: [
      {
        to: '/emails/welcome',
        label: 'Welcome Email',
        description: 'Welcome email template and components',
      },
    ],
  },
}
