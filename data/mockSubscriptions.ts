export interface SubscriptionFeature {
  name: string
  description: string
  included: boolean
}

export interface SubscriptionPlan {
  id: string
  name: string
  description: string
  price: {
    monthly: number
    annually: number
  }
  features: SubscriptionFeature[]
  popular?: boolean
}

export interface UserSubscription {
  planId: string
  currentPeriodStart: string
  currentPeriodEnd: string
  status: 'active' | 'canceled' | 'inactive'
  cancelAtPeriodEnd: boolean
  downgradeToId?: string
}

export const mockSubscriptionPlans: SubscriptionPlan[] = [
  {
    id: 'free',
    name: 'Free',
    description: 'Basic features for casual dancers',
    price: {
      monthly: 0,
      annually: 0,
    },
    features: [
      {
        name: 'Create a profile',
        description: 'Setup your dance profile',
        included: true,
      },
      {
        name: 'Discover events',
        description: 'Browse dance events in your area',
        included: true,
      },
      {
        name: 'Join communities',
        description: 'Connect with local dance communities',
        included: true,
      },
      {
        name: 'Advanced search filters',
        description: 'Filter events by style, level, and more',
        included: false,
      },
      {
        name: 'Featured profile',
        description: 'Get highlighted in search results',
        included: false,
      },
      {
        name: 'Unlimited messages',
        description: 'Connect with unlimited dancers',
        included: false,
      },
    ],
  },
  {
    id: 'basic',
    name: 'Basic',
    description: 'Essential features for active dancers',
    price: {
      monthly: 9.99,
      annually: 99.99,
    },
    features: [
      {
        name: 'Create a profile',
        description: 'Setup your dance profile',
        included: true,
      },
      {
        name: 'Discover events',
        description: 'Browse dance events in your area',
        included: true,
      },
      {
        name: 'Join communities',
        description: 'Connect with local dance communities',
        included: true,
      },
      {
        name: 'Advanced search filters',
        description: 'Filter events by style, level, and more',
        included: true,
      },
      {
        name: 'Featured profile',
        description: 'Get highlighted in search results',
        included: false,
      },
      {
        name: 'Unlimited messages',
        description: 'Connect with unlimited dancers',
        included: false,
      },
    ],
  },
  {
    id: 'pro',
    name: 'Pro',
    description: 'Advanced features for dedicated dancers',
    price: {
      monthly: 19.99,
      annually: 199.99,
    },
    popular: true,
    features: [
      {
        name: 'Create a profile',
        description: 'Setup your dance profile',
        included: true,
      },
      {
        name: 'Discover events',
        description: 'Browse dance events in your area',
        included: true,
      },
      {
        name: 'Join communities',
        description: 'Connect with local dance communities',
        included: true,
      },
      {
        name: 'Advanced search filters',
        description: 'Filter events by style, level, and more',
        included: true,
      },
      {
        name: 'Featured profile',
        description: 'Get highlighted in search results',
        included: true,
      },
      {
        name: 'Unlimited messages',
        description: 'Connect with unlimited dancers',
        included: true,
      },
    ],
  },
]

// Regular active subscription with no pending changes
export const mockUserSubscription: UserSubscription = {
  planId: 'basic',
  currentPeriodStart: '2023-12-01T00:00:00Z',
  currentPeriodEnd: '2024-01-01T00:00:00Z',
  status: 'active',
  cancelAtPeriodEnd: false,
}

// Example of subscription with pending downgrade
export const mockUserSubscriptionWithDowngrade: UserSubscription = {
  planId: 'pro',
  currentPeriodStart: '2023-12-01T00:00:00Z',
  currentPeriodEnd: '2024-01-01T00:00:00Z',
  status: 'active',
  cancelAtPeriodEnd: true,
  downgradeToId: 'basic',
} 