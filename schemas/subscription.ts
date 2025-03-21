import { z } from 'zod'

export const subscriptionUpdateSchema = z.object({
  planId: z.string({
    required_error: 'Subscription plan is required',
  }),
  billingCycle: z.enum(['monthly', 'annually'], {
    required_error: 'Billing cycle is required',
  }),
  termsAccepted: z.boolean().refine((val) => val === true, {
    message: 'You must accept the terms and conditions',
  }),
}) 