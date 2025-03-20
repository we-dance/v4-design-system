<script setup lang="ts">
import { ref, computed } from 'vue'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import { toast } from 'vue-sonner'
import { z } from 'zod'
import { courseSchema } from '~/schemas/course'

// Define a simpler schema for just the initial course creation
const courseEditorSchema = z.object({
  name: z.string().min(3, 'Course name must be at least 3 characters'),
  description: z.string().min(10, 'Please provide a meaningful description'),
  educationalLevel: z.enum(
    ['Beginner', 'Intermediate', 'Advanced', 'AllLevels'],
    {
      required_error: 'Please select a level',
    }
  ),
})

type Module = {
  '@type': 'Chapter'
  identifier: number
  name: string
  learningResourceType: 'Module'
  hasPart: Lesson[]
}

type Lesson = {
  '@type': 'LearningResource'
  identifier: number
  name: string
  timeRequired: string
  video: {
    '@type': 'VideoObject'
    identifier: string
    duration: string
    provider: 'youtube' | 'mux'
  }
  completed: boolean
  locked: boolean
}

// Form is a subset of the full course schema for simplicity
const form = useForm({
  validationSchema: toTypedSchema(courseEditorSchema),
  initialValues: {
    name: '',
    description: '',
    educationalLevel: 'Beginner',
  },
})

// Modules and lessons
const modules = ref<Module[]>([])
const nextModuleId = ref(1)
const nextLessonId = ref(1)

// Pricing
const pricingPlan = ref({
  price: 19.99,
  priceCurrency: 'EUR',
  duration: 'P1M', // 1 month in ISO 8601
  name: 'regular',
})

// Add a new module
const addModule = () => {
  modules.value.push({
    '@type': 'Chapter',
    identifier: nextModuleId.value,
    name: `Module ${nextModuleId.value}`,
    learningResourceType: 'Module',
    hasPart: [],
  })
  nextModuleId.value++
}

// Edit module name
const editModuleName = (moduleId: number, newName: string) => {
  const module = modules.value.find((m) => m.identifier === moduleId)
  if (module) {
    module.name = newName
  }
}

// Add a lesson to a module
const addLesson = (moduleId: number) => {
  const module = modules.value.find((m) => m.identifier === moduleId)
  if (!module) return

  module.hasPart.push({
    '@type': 'LearningResource',
    identifier: nextLessonId.value,
    name: `Lesson ${nextLessonId.value}`,
    timeRequired: 'PT15M', // 15 minutes in ISO 8601
    video: {
      '@type': 'VideoObject',
      identifier: '',
      duration: 'PT15M',
      provider: 'youtube',
    },
    completed: false,
    locked: false,
  })
  nextLessonId.value++
}

// Edit lesson
const editLesson = (
  moduleId: number,
  lessonId: number,
  updates: Partial<Lesson>
) => {
  const module = modules.value.find((m) => m.identifier === moduleId)
  if (!module) return

  const lesson = module.hasPart.find((l) => l.identifier === lessonId)
  if (!lesson) return

  Object.assign(lesson, updates)

  // Update video duration to match lesson timeRequired
  if (updates.timeRequired) {
    lesson.video.duration = updates.timeRequired
  }
}

// Remove module
const removeModule = (moduleId: number) => {
  const index = modules.value.findIndex((m) => m.identifier === moduleId)
  if (index !== -1) {
    modules.value.splice(index, 1)
  }
}

// Remove lesson
const removeLesson = (moduleId: number, lessonId: number) => {
  const module = modules.value.find((m) => m.identifier === moduleId)
  if (!module) return

  const index = module.hasPart.findIndex((l) => l.identifier === lessonId)
  if (index !== -1) {
    module.hasPart.splice(index, 1)
  }
}

// Convert duration in minutes to ISO 8601 format
const minutesToISO8601 = (minutes: number) => {
  return `PT${minutes}M`
}

// Convert ISO 8601 format to minutes
const ISO8601ToMinutes = (duration: string) => {
  const match = duration.match(/PT(\d+)M/)
  return match ? parseInt(match[1]) : 15
}

// Count total lessons
const totalLessons = computed(() => {
  return modules.value.reduce(
    (count, module) => count + module.hasPart.length,
    0
  )
})

// Save course
const saving = ref(false)
const saveCourse = async () => {
  const { valid } = await form.validate()
  if (!valid) {
    toast.error('Please fix the errors in the form before saving')
    return
  }

  if (modules.value.length === 0) {
    toast.error('Please add at least one module to your course')
    return
  }

  saving.value = true
  try {
    // In a real app, this would be an API call
    // For now, we'll just simulate a successful save
    await new Promise((resolve) => setTimeout(resolve, 1000))

    // Here you would construct the full course object from the form values, modules, and other data
    toast.success('Course saved successfully!')
  } catch (error) {
    toast.error('Failed to save course')
    console.error('Error saving course:', error)
  } finally {
    saving.value = false
  }
}
</script>

<template>
  <div class="space-y-8">
    <div class="flex justify-between items-center">
      <h2 class="text-2xl font-bold">Create New Course</h2>
      <div class="flex gap-2">
        <Button variant="outline" @click="$emit('cancel')">Cancel</Button>
        <Button :loading="saving" @click="saveCourse">
          <Icon v-if="!saving" name="ph:floppy-disk" class="mr-2 h-4 w-4" />
          Save Course
        </Button>
      </div>
    </div>

    <!-- Course Basic Info Section -->
    <Card>
      <CardHeader>
        <CardTitle>Course Details</CardTitle>
        <CardDescription>Basic information about your course</CardDescription>
      </CardHeader>
      <CardContent>
        <div class="space-y-4">
          <FormField v-slot="{ componentField }" name="name">
            <FormItem>
              <FormLabel>Course Name</FormLabel>
              <FormControl>
                <Input
                  v-bind="componentField"
                  placeholder="e.g. Bachata Sensual Fundamentals"
                />
              </FormControl>
              <FormDescription>
                Choose a clear, specific title that describes what students will
                learn
              </FormDescription>
              <FormMessage />
            </FormItem>
          </FormField>

          <FormField v-slot="{ componentField }" name="description">
            <FormItem>
              <FormLabel>Description</FormLabel>
              <FormControl>
                <Textarea
                  v-bind="componentField"
                  placeholder="Describe what your course covers and what students will learn..."
                  rows="4"
                />
              </FormControl>
              <FormDescription>
                Write a compelling description that highlights the value of your
                course
              </FormDescription>
              <FormMessage />
            </FormItem>
          </FormField>

          <FormField v-slot="{ value, handleChange }" name="educationalLevel">
            <FormItem>
              <FormLabel>Level</FormLabel>
              <FormControl>
                <Select :value="value" @update:modelValue="handleChange">
                  <option value="Beginner">Beginner</option>
                  <option value="Intermediate">Intermediate</option>
                  <option value="Advanced">Advanced</option>
                  <option value="AllLevels">All Levels</option>
                </Select>
              </FormControl>
              <FormDescription>
                Select the appropriate level for your course
              </FormDescription>
              <FormMessage />
            </FormItem>
          </FormField>
        </div>
      </CardContent>
    </Card>

    <!-- Course Structure Section -->
    <Card>
      <CardHeader
        class="flex flex-row items-center justify-between space-y-0 pb-2"
      >
        <div>
          <CardTitle>Course Structure</CardTitle>
          <CardDescription
            >Organize your course into modules and lessons</CardDescription
          >
        </div>
        <Button variant="outline" size="sm" @click="addModule">
          <Icon name="ph:folder-plus" class="mr-2 h-4 w-4" />
          Add Module
        </Button>
      </CardHeader>
      <CardContent>
        <div
          v-if="modules.length === 0"
          class="text-center py-8 border rounded-md bg-muted/20"
        >
          <div class="mb-2 text-4xl">📚</div>
          <h3 class="text-lg font-medium">No modules yet</h3>
          <p class="text-muted-foreground mb-4">
            Start by adding a module to your course
          </p>
          <Button @click="addModule">
            <Icon name="ph:folder-plus" class="mr-2 h-4 w-4" />
            Add First Module
          </Button>
        </div>

        <div v-else class="space-y-6">
          <div
            v-for="module in modules"
            :key="module.identifier"
            class="border rounded-md p-4"
          >
            <div class="flex items-center justify-between mb-4">
              <div class="flex-1">
                <Input
                  v-model="module.name"
                  class="text-lg font-medium border-none bg-transparent p-0 h-auto focus-visible:ring-0 focus-visible:ring-offset-0"
                  @blur="editModuleName(module.identifier, module.name)"
                />
              </div>
              <div class="flex items-center gap-2">
                <Button
                  variant="ghost"
                  size="sm"
                  @click="addLesson(module.identifier)"
                >
                  <Icon name="ph:plus" class="h-4 w-4" /> Add Lesson
                </Button>
                <Button
                  variant="ghost"
                  size="icon"
                  @click="removeModule(module.identifier)"
                >
                  <Icon name="ph:trash" class="h-4 w-4 text-destructive" />
                </Button>
              </div>
            </div>

            <div
              v-if="module.hasPart.length === 0"
              class="text-center py-4 border rounded-md bg-muted/20"
            >
              <p class="text-muted-foreground">
                No lessons yet. Click "Add Lesson" to get started.
              </p>
            </div>

            <div v-else class="space-y-2">
              <div
                v-for="lesson in module.hasPart"
                :key="lesson.identifier"
                class="border rounded-md p-3 flex items-center justify-between"
              >
                <div class="flex items-center gap-2 flex-1">
                  <Icon name="ph:video" class="h-4 w-4 text-muted-foreground" />
                  <Input
                    v-model="lesson.name"
                    class="border-none bg-transparent p-0 h-auto focus-visible:ring-0 focus-visible:ring-offset-0"
                    placeholder="Lesson title"
                    @blur="
                      editLesson(module.identifier, lesson.identifier, {
                        name: lesson.name,
                      })
                    "
                  />
                </div>
                <div class="flex items-center gap-2">
                  <div class="flex items-center gap-1">
                    <Icon
                      name="ph:clock"
                      class="h-4 w-4 text-muted-foreground"
                    />
                    <Select
                      :value="ISO8601ToMinutes(lesson.timeRequired)"
                      @update:modelValue="
                        (val) =>
                          editLesson(module.identifier, lesson.identifier, {
                            timeRequired: minutesToISO8601(val),
                          })
                      "
                      class="w-24 h-8"
                    >
                      <option value="5">5 min</option>
                      <option value="10">10 min</option>
                      <option value="15">15 min</option>
                      <option value="20">20 min</option>
                      <option value="25">25 min</option>
                      <option value="30">30 min</option>
                    </Select>
                  </div>
                  <Button
                    variant="ghost"
                    size="icon"
                    @click="removeLesson(module.identifier, lesson.identifier)"
                  >
                    <Icon name="ph:trash" class="h-4 w-4 text-destructive" />
                  </Button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>

    <!-- Pricing Section -->
    <Card>
      <CardHeader>
        <CardTitle>Pricing</CardTitle>
        <CardDescription>Set up your pricing plans</CardDescription>
      </CardHeader>
      <CardContent>
        <div class="space-y-4">
          <div class="flex items-end gap-4">
            <FormField v-slot="{ componentField }" name="price" class="flex-1">
              <FormItem>
                <FormLabel>Monthly Price</FormLabel>
                <FormControl>
                  <div class="relative">
                    <span class="absolute left-3 top-1/2 -translate-y-1/2">{{
                      pricingPlan.priceCurrency === 'EUR' ? '€' : '$'
                    }}</span>
                    <Input
                      v-model.number="pricingPlan.price"
                      type="number"
                      min="0"
                      step="0.01"
                      class="pl-8"
                    />
                  </div>
                </FormControl>
                <FormDescription>
                  Set the monthly subscription price for your course
                </FormDescription>
              </FormItem>
            </FormField>

            <FormField v-slot="{ componentField }" name="currency" class="w-32">
              <FormItem>
                <FormLabel>Currency</FormLabel>
                <FormControl>
                  <Select v-model="pricingPlan.priceCurrency">
                    <option value="EUR">EUR (€)</option>
                    <option value="USD">USD ($)</option>
                  </Select>
                </FormControl>
              </FormItem>
            </FormField>
          </div>
        </div>
      </CardContent>
    </Card>

    <!-- Action Buttons -->
    <div class="flex justify-end gap-2">
      <Button variant="outline" @click="$emit('cancel')">Cancel</Button>
      <Button :loading="saving" @click="saveCourse">
        <Icon v-if="!saving" name="ph:floppy-disk" class="mr-2 h-4 w-4" />
        Save Course
      </Button>
    </div>
  </div>
</template>
