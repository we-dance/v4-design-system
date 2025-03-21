<script setup lang="ts">
import { ref } from 'vue'
</script>

<template>
  <DesignLayout
    title="Course Editor"
    description="A powerful editor for creating and managing course content."
  >
    <template #preview>
      <CourseEditor @cancel="() => {}" />
    </template>

    <h2
      id="introduction"
      class="scroll-m-20 text-2xl font-semibold tracking-tight mt-12"
    >
      Introduction
    </h2>
    <p class="leading-7">
      The Course Editor component provides a user-friendly interface for
      creating and editing courses in the WeDance platform. It allows
      instructors to define course details, structure content into modules and
      lessons, and set pricing options.
    </p>

    <h2
      id="usage"
      class="scroll-m-20 text-2xl font-semibold tracking-tight mt-12"
    >
      Usage
    </h2>
    <p class="leading-7">
      The Course Editor is designed to be used in any page where instructors
      need to create or edit course content. It handles form validation, module
      and lesson organization, and pricing configuration.
    </p>

    <h3
      id="basic-usage"
      class="scroll-m-20 text-xl font-semibold tracking-tight mt-8"
    >
      Basic Usage
    </h3>
    <p class="leading-7">
      To use the Course Editor component, simply include it in your template and
      provide an event handler for the cancel action:
    </p>

    <h2
      id="features"
      class="scroll-m-20 text-2xl font-semibold tracking-tight mt-12"
    >
      Features
    </h2>

    <h3
      id="course-details"
      class="scroll-m-20 text-xl font-semibold tracking-tight mt-8"
    >
      Course Details
    </h3>
    <p class="leading-7">
      The first section allows instructors to set basic course information:
    </p>
    <ul class="list-disc pl-6 my-4 space-y-2">
      <li>Course Name - The title of the course</li>
      <li>Description - A detailed explanation of what the course covers</li>
      <li>
        Level - The difficulty level (Beginner, Intermediate, Advanced, or All
        Levels)
      </li>
    </ul>

    <h3
      id="course-structure"
      class="scroll-m-20 text-xl font-semibold tracking-tight mt-8"
    >
      Course Structure
    </h3>
    <p class="leading-7">
      The Course Structure section enables instructors to organize content
      hierarchically:
    </p>
    <ul class="list-disc pl-6 my-4 space-y-2">
      <li>Modules - Top-level organization units for related lessons</li>
      <li>
        Lessons - Individual learning resources with duration and video content
      </li>
      <li>Drag-and-drop reordering (planned feature)</li>
    </ul>

    <h3
      id="pricing"
      class="scroll-m-20 text-xl font-semibold tracking-tight mt-8"
    >
      Pricing
    </h3>
    <p class="leading-7">
      The Pricing section allows instructors to set subscription options:
    </p>
    <ul class="list-disc pl-6 my-4 space-y-2">
      <li>Monthly price - Set the recurring subscription fee</li>
      <li>Currency - Choose between EUR and USD</li>
      <li>
        Additional plan types (premium, trial) are planned for future releases
      </li>
    </ul>

    <h2
      id="user-flow"
      class="scroll-m-20 text-2xl font-semibold tracking-tight mt-12"
    >
      User Flow
    </h2>
    <CourseEditorFlow />

    <div class="mt-8 space-y-4">
      <p class="text-muted-foreground">
        The course editing flow begins from the Teacher Dashboard where an
        instructor can create a new course or edit an existing one. The Course
        Editor interface consists of three main sections:
      </p>

      <ol class="list-decimal pl-5 space-y-2">
        <li>
          <span class="font-medium">Course Details</span> – Where instructors
          enter basic information like course name, description, and difficulty
          level.
        </li>
        <li>
          <span class="font-medium">Course Structure</span> – For organizing
          content into modules and lessons:
          <ul class="list-disc pl-5 mt-1">
            <li>Instructors can add, edit, or remove modules</li>
            <li>Within each module, they can add, edit, or remove lessons</li>
            <li>Lessons include title and duration settings</li>
          </ul>
        </li>
        <li>
          <span class="font-medium">Pricing</span> – For setting subscription
          options:
          <ul class="list-disc pl-5 mt-1">
            <li>Monthly price and currency selection</li>
          </ul>
        </li>
      </ol>

      <p class="text-muted-foreground">
        When saving a course, validation checks ensure all required information
        is provided. If validation fails, the instructor is returned to the
        editor with error messages. Upon successful validation, a success
        message is displayed and the course is saved as a draft. From the drafts
        section, instructors can return to edit their courses or publish them
        when ready.
      </p>

      <p class="text-muted-foreground">
        The Cancel action allows instructors to exit the editor and return to
        the dashboard without saving changes.
      </p>
    </div>

    <h2
      id="events"
      class="scroll-m-20 text-2xl font-semibold tracking-tight mt-12"
    >
      Events
    </h2>
    <div class="my-6 w-full overflow-y-auto">
      <table class="w-full border-collapse">
        <thead>
          <tr>
            <th class="border px-4 py-2 text-left">Event</th>
            <th class="border px-4 py-2 text-left">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="border px-4 py-2 font-mono text-sm">cancel</td>
            <td class="border px-4 py-2">
              Emitted when the user clicks the Cancel button
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <h2
      id="accessibility"
      class="scroll-m-20 text-2xl font-semibold tracking-tight mt-12"
    >
      Accessibility
    </h2>
    <p class="leading-7">
      The Course Editor follows accessibility best practices:
    </p>
    <ul class="list-disc pl-6 my-4 space-y-2">
      <li>Proper labeling of form controls</li>
      <li>Clear error messages for validation issues</li>
      <li>Keyboard navigation support</li>
      <li>Semantic HTML structure</li>
    </ul>

    <h2
      id="future-enhancements"
      class="scroll-m-20 text-2xl font-semibold tracking-tight mt-12"
    >
      Future Enhancements
    </h2>
    <ul class="list-disc pl-6 my-4 space-y-2">
      <li>Drag-and-drop reordering of modules and lessons</li>
      <li>Rich text editor for course descriptions</li>
      <li>Video upload and thumbnail selection</li>
      <li>
        Preview mode for instructors to see how their course will appear to
        students
      </li>
      <li>Additional pricing options and subscription tiers</li>
    </ul>
  </DesignLayout>
</template>
