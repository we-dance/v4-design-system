import { z } from 'zod'

export const subscriptionUpdateSchema = z.object({
  planId: z.string({
    required_error: 'Subscription plan is required',
  }),
  courseId: z.string({
    required_error: 'Course ID is required',
  }),
  termsAccepted: z.boolean().refine((val) => val === true, {
    message: 'You must accept the terms and conditions',
  }),
}) 