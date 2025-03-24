<script setup>
import { ref } from 'vue'
import { mockReviews } from '~/data/reviews'

// Filter only example reviews for the demo
const exampleReviews = mockReviews.filter(review => review.profileId === 'example')

const starRatingValue = ref(3)
</script>

<template>
  <div>
    <h1 class="text-4xl font-bold mb-6">Review Components</h1>
    
    <p class="text-lg mb-8">
      A set of components for collecting and displaying user reviews for artists, organizers, venues, and other roles.
    </p>
    
    <section class="mb-12">
      <h2 class="text-2xl font-semibold mb-4">StarRating</h2>
      <p class="mb-4">A reusable star rating component that can be used for both input and display.</p>
      
      <div class="p-4 border rounded-lg mb-6">
        <h3 class="font-medium mb-2">Interactive Example:</h3>
        <div class="bg-card p-4 rounded">
          <p>Selected Rating: {{ starRatingValue }}</p>
          <StarRating
            :initial-rating="starRatingValue"
            @update:rating="starRatingValue = $event"
          />
        </div>
      </div>
      
      <div class="p-4 border rounded-lg mb-6">
        <h3 class="font-medium mb-2">Read-only Example (with different sizes):</h3>
        <div class="bg-card p-4 rounded flex flex-col gap-4">
          <div class="flex items-center">
            <span class="w-10">sm:</span>
            <StarRating :initial-rating="3.5" size="sm" :read-only="true" />
          </div>
          <div class="flex items-center">
            <span class="w-10">md:</span>
            <StarRating :initial-rating="4" size="md" :read-only="true" />
          </div>
          <div class="flex items-center">
            <span class="w-10">lg:</span>
            <StarRating :initial-rating="5" size="lg" :read-only="true" />
          </div>
        </div>
      </div>
      
      <h3 class="font-medium mb-2">Props:</h3>
      <table class="w-full border-collapse mb-6">
        <thead>
          <tr class="bg-muted">
            <th class="border p-2 text-left">Prop</th>
            <th class="border p-2 text-left">Type</th>
            <th class="border p-2 text-left">Default</th>
            <th class="border p-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border p-2">initialRating</td>
            <td class="border p-2">Number</td>
            <td class="border p-2">0</td>
            <td class="border p-2">The initial rating value (1-5)</td>
          </tr>
          <tr>
            <td class="border p-2">size</td>
            <td class="border p-2">String</td>
            <td class="border p-2">md</td>
            <td class="border p-2">Size of stars ('sm', 'md', or 'lg')</td>
          </tr>
          <tr>
            <td class="border p-2">readOnly</td>
            <td class="border p-2">Boolean</td>
            <td class="border p-2">false</td>
            <td class="border p-2">If true, rating cannot be changed</td>
          </tr>
        </tbody>
      </table>
      
      <h3 class="font-medium mb-2">Events:</h3>
      <table class="w-full border-collapse">
        <thead>
          <tr class="bg-muted">
            <th class="border p-2 text-left">Event</th>
            <th class="border p-2 text-left">Payload</th>
            <th class="border p-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border p-2">update:rating</td>
            <td class="border p-2">Number</td>
            <td class="border p-2">Emitted when rating changes (1-5)</td>
          </tr>
        </tbody>
      </table>
    </section>
    
    <section class="mb-12">
      <h2 class="text-2xl font-semibold mb-4">ReviewForm</h2>
      <p class="mb-4">Form component for submitting or editing reviews.</p>
      
      <div class="p-4 border rounded-lg mb-6">
        <h3 class="font-medium mb-2">Example:</h3>
        <div class="bg-card p-4 rounded">
          <ReviewForm
            profile-id="example"
            profile-type="teacher"
            @submitted="() => {}"
            @cancelled="() => {}"
          />
        </div>
      </div>
      
      <h3 class="font-medium mb-2">Props:</h3>
      <table class="w-full border-collapse mb-6">
        <thead>
          <tr class="bg-muted">
            <th class="border p-2 text-left">Prop</th>
            <th class="border p-2 text-left">Type</th>
            <th class="border p-2 text-left">Default</th>
            <th class="border p-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border p-2">profileId</td>
            <td class="border p-2">String</td>
            <td class="border p-2">Required</td>
            <td class="border p-2">ID of the profile being reviewed</td>
          </tr>
          <tr>
            <td class="border p-2">profileType</td>
            <td class="border p-2">String</td>
            <td class="border p-2">Required</td>
            <td class="border p-2">Type of profile ('organizer', 'venue', 'teacher', 'assistant')</td>
          </tr>
          <tr>
            <td class="border p-2">initialRating</td>
            <td class="border p-2">Number</td>
            <td class="border p-2">0</td>
            <td class="border p-2">Initial rating for edit mode</td>
          </tr>
          <tr>
            <td class="border p-2">initialComment</td>
            <td class="border p-2">String</td>
            <td class="border p-2">''</td>
            <td class="border p-2">Initial comment for edit mode</td>
          </tr>
          <tr>
            <td class="border p-2">isEdit</td>
            <td class="border p-2">Boolean</td>
            <td class="border p-2">false</td>
            <td class="border p-2">Whether form is in edit mode</td>
          </tr>
        </tbody>
      </table>
      
      <h3 class="font-medium mb-2">Events:</h3>
      <table class="w-full border-collapse">
        <thead>
          <tr class="bg-muted">
            <th class="border p-2 text-left">Event</th>
            <th class="border p-2 text-left">Payload</th>
            <th class="border p-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border p-2">submitted</td>
            <td class="border p-2">Object</td>
            <td class="border p-2">Contains profileId, profileType, rating, and comment</td>
          </tr>
          <tr>
            <td class="border p-2">cancelled</td>
            <td class="border p-2">None</td>
            <td class="border p-2">Emitted when form is cancelled</td>
          </tr>
        </tbody>
      </table>
    </section>
    
    <section class="mb-12">
      <h2 class="text-2xl font-semibold mb-4">ReviewCard</h2>
      <p class="mb-4">Card component for displaying a single review with edit/delete options.</p>
      
      <div class="p-4 border rounded-lg mb-6">
        <h3 class="font-medium mb-2">Example:</h3>
        <div class="bg-card p-4 rounded">
          <ReviewCard
            :review="exampleReviews[0]"
            @edit="() => {}"
            @delete="() => {}"
          />
        </div>
      </div>
      
      <h3 class="font-medium mb-2">Props:</h3>
      <table class="w-full border-collapse mb-6">
        <thead>
          <tr class="bg-muted">
            <th class="border p-2 text-left">Prop</th>
            <th class="border p-2 text-left">Type</th>
            <th class="border p-2 text-left">Default</th>
            <th class="border p-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border p-2">review</td>
            <td class="border p-2">Object</td>
            <td class="border p-2">Required</td>
            <td class="border p-2">Review object containing id, userId, user, rating, comment, etc.</td>
          </tr>
        </tbody>
      </table>
      
      <h3 class="font-medium mb-2">Events:</h3>
      <table class="w-full border-collapse">
        <thead>
          <tr class="bg-muted">
            <th class="border p-2 text-left">Event</th>
            <th class="border p-2 text-left">Payload</th>
            <th class="border p-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border p-2">edit</td>
            <td class="border p-2">Object</td>
            <td class="border p-2">The review object to edit</td>
          </tr>
          <tr>
            <td class="border p-2">delete</td>
            <td class="border p-2">String</td>
            <td class="border p-2">ID of the review to delete</td>
          </tr>
        </tbody>
      </table>
    </section>
    
    <section class="mb-12">
      <h2 class="text-2xl font-semibold mb-4">ReviewList</h2>
      <p class="mb-4">Component for displaying a list of reviews with management capabilities.</p>
      
      <div class="p-4 border rounded-lg mb-6">
        <h3 class="font-medium mb-2">Example:</h3>
        <div class="bg-card p-4 rounded">
          <ReviewList
            profile-id="example"
            profile-type="teacher"
          />
        </div>
      </div>
      
      <h3 class="font-medium mb-2">Props:</h3>
      <table class="w-full border-collapse">
        <thead>
          <tr class="bg-muted">
            <th class="border p-2 text-left">Prop</th>
            <th class="border p-2 text-left">Type</th>
            <th class="border p-2 text-left">Default</th>
            <th class="border p-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border p-2">profileId</td>
            <td class="border p-2">String</td>
            <td class="border p-2">Required</td>
            <td class="border p-2">ID of the profile whose reviews are being displayed</td>
          </tr>
          <tr>
            <td class="border p-2">profileType</td>
            <td class="border p-2">String</td>
            <td class="border p-2">Required</td>
            <td class="border p-2">Type of profile ('organizer', 'venue', 'teacher', 'assistant')</td>
          </tr>
        </tbody>
      </table>
    </section>
    
    <section class="mb-12">
      <h2 class="text-2xl font-semibold mb-4">ReviewStatistics</h2>
      <p class="mb-4">Component for displaying rating statistics.</p>
      
      <div class="p-4 border rounded-lg mb-6">
        <h3 class="font-medium mb-2">Example:</h3>
        <div class="bg-card p-4 rounded">
          <ReviewStatistics :reviews="exampleReviews" />
        </div>
      </div>
      
      <h3 class="font-medium mb-2">Props:</h3>
      <table class="w-full border-collapse">
        <thead>
          <tr class="bg-muted">
            <th class="border p-2 text-left">Prop</th>
            <th class="border p-2 text-left">Type</th>
            <th class="border p-2 text-left">Default</th>
            <th class="border p-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border p-2">reviews</td>
            <td class="border p-2">Array</td>
            <td class="border p-2">Required</td>
            <td class="border p-2">Array of review objects</td>
          </tr>
        </tbody>
      </table>
    </section>
    
    <section class="mb-12">
      <h2 class="text-2xl font-semibold mb-4">Example Usage</h2>
      <p class="mb-4">
        Here's how you might use these components on a profile page:
      </p>
      
      <pre class="p-4 bg-muted rounded-lg overflow-x-auto">
&lt;template&gt;
  &lt;div&gt;
    &lt;!-- Other profile information --&gt;
    
    &lt;ReviewStatistics :reviews="profileReviews" /&gt;
    
    &lt;ReviewList
      :profile-id="profileId"
      :profile-type="profileType"
    /&gt;
  &lt;/div&gt;
&lt;/template&gt;

&lt;script setup&gt;
const profileId = 'artist-123'
const profileType = 'teacher'
const profileReviews = [...] // Reviews fetched from API
&lt;/script&gt;
      </pre>
    </section>
  </div>
</template>
