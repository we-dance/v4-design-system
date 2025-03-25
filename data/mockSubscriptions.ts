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
  }
  features: SubscriptionFeature[]
  popular?: boolean
}

export interface CourseSubscription {
  id: string
  courseId: string
  courseName: string
  planId: string
  price: number
  currentPeriodStart: string
  currentPeriodEnd: string
  status: 'active' | 'canceled' | 'inactive'
  cancelAtPeriodEnd: boolean
  downgradeToId?: string
}

export const mockSubscriptionPlans: SubscriptionPlan[] = [
  {
    id: 'regular',
    name: 'Regular Plan',
    description: 'Essential course content',
    price: {
      monthly: 14.99
    },
    features: [
      {
        name: 'Full course access',
        description: 'Access to all course lessons',
        included: true,
      },
      {
        name: 'Downloadable resources',
        description: 'PDF guides and worksheets',
        included: true,
      },
      {
        name: 'Community forum access',
        description: 'Join discussions with other students',
        included: true,
      },
      {
        name: 'Live Q&A sessions',
        description: 'Weekly group sessions with instructors',
        included: false,
      },
      {
        name: 'Personalized feedback',
        description: 'Get instructor feedback on your progress',
        included: false,
      },
      {
        name: 'Practice videos',
        description: 'Additional practice material',
        included: false,
      },
    ],
  },
  {
    id: 'premium',
    name: 'Premium Plan',
    description: 'Full access including practice videos',
    price: {
      monthly: 19.99
    },
    popular: true,
    features: [
      {
        name: 'Full course access',
        description: 'Access to all course lessons',
        included: true,
      },
      {
        name: 'Downloadable resources',
        description: 'PDF guides and worksheets',
        included: true,
      },
      {
        name: 'Community forum access',
        description: 'Join discussions with other students',
        included: true,
      },
      {
        name: 'Live Q&A sessions',
        description: 'Weekly group sessions with instructors',
        included: true,
      },
      {
        name: 'Personalized feedback',
        description: 'Get instructor feedback on your progress',
        included: true,
      },
      {
        name: 'Practice videos',
        description: 'Additional practice material',
        included: true,
      },
    ],
  },
]

// Example course subscriptions
export const mockCourseSubscriptions: CourseSubscription[] = [
  {
    id: 'sub_123',
    courseId: 'course_abc',
    courseName: 'Intermediate Salsa',
    planId: 'regular',
    price: 14.99,
    currentPeriodStart: '2023-12-01T00:00:00Z',
    currentPeriodEnd: '2024-01-01T00:00:00Z',
    status: 'active',
    cancelAtPeriodEnd: false
  },
  {
    id: 'sub_456',
    courseId: 'course_def',
    courseName: 'Advanced Bachata',
    planId: 'premium',
    price: 19.99,
    currentPeriodStart: '2023-12-15T00:00:00Z',
    currentPeriodEnd: '2024-01-15T00:00:00Z',
    status: 'active',
    cancelAtPeriodEnd: false
  }
]

// Legacy exports for backward compatibility
export const mockUserSubscription = mockCourseSubscriptions[0];
export const mockUserSubscriptionWithDowngrade: CourseSubscription = {
  ...mockCourseSubscriptions[1],
  cancelAtPeriodEnd: true,
  downgradeToId: 'regular'
} 