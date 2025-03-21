import { useState } from '#app'

export const useAuth = () => {
  // Mock user for testing the review components
  const user = useState('user', () => ({
    id: 'current-user-id', 
    name: 'Current User',
    avatar: ''
  }))
  
  // Simplified auth for demo purposes
  return {
    user,
    // Add other auth methods as needed
  }
} 