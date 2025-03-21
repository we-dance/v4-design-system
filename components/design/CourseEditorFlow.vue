<script setup lang="ts">
// User flow diagram for course editing process
</script>

<template>
  <div class="overflow-auto p-4 bg-card">
    <div class="min-w-[1000px]">
      <!-- User Flow Diagram -->
      <svg
        width="100%"
        height="700"
        viewBox="0 0 1000 700"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        class="text-foreground"
      >
        <!-- Start -->
        <g>
          <circle cx="120" cy="90" r="40" fill="hsl(var(--primary))" />
          <text
            x="120"
            y="95"
            text-anchor="middle"
            fill="white"
            class="text-sm font-medium"
          >
            Start
          </text>
        </g>

        <!-- Teacher Dashboard -->
        <g>
          <rect
            x="70"
            y="180"
            width="120"
            height="60"
            rx="4"
            fill="hsl(var(--muted))"
          />
          <text
            x="130"
            y="215"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Teacher Dashboard
          </text>
        </g>

        <!-- Create Course Button -->
        <g>
          <rect
            x="70"
            y="290"
            width="120"
            height="60"
            rx="4"
            fill="hsl(var(--accent))"
          />
          <text
            x="130"
            y="325"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Create Course
          </text>
        </g>

        <!-- Course Editor -->
        <g>
          <rect
            x="300"
            y="180"
            width="120"
            height="60"
            rx="4"
            fill="hsl(var(--primary))"
          />
          <text
            x="360"
            y="215"
            text-anchor="middle"
            fill="white"
            class="text-sm font-medium"
          >
            Course Editor
          </text>
        </g>

        <!-- Course Details Section -->
        <g>
          <rect
            x="250"
            y="290"
            width="100"
            height="60"
            rx="4"
            fill="hsl(var(--muted))"
          />
          <text
            x="300"
            y="315"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Course
          </text>
          <text
            x="300"
            y="335"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Details
          </text>
        </g>

        <!-- Course Structure Section -->
        <g>
          <rect
            x="370"
            y="290"
            width="100"
            height="60"
            rx="4"
            fill="hsl(var(--muted))"
          />
          <text
            x="420"
            y="315"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Course
          </text>
          <text
            x="420"
            y="335"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Structure
          </text>
        </g>

        <!-- Add Module -->
        <g>
          <rect
            x="250"
            y="400"
            width="100"
            height="50"
            rx="4"
            fill="hsl(var(--accent))"
            stroke="hsl(var(--border))"
          />
          <text
            x="300"
            y="430"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Add Module
          </text>
        </g>

        <!-- Edit Module -->
        <g>
          <rect
            x="370"
            y="400"
            width="100"
            height="50"
            rx="4"
            fill="hsl(var(--accent))"
            stroke="hsl(var(--border))"
          />
          <text
            x="420"
            y="430"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Edit Module
          </text>
        </g>

        <!-- Add Lesson -->
        <g>
          <rect
            x="250"
            y="500"
            width="100"
            height="50"
            rx="4"
            fill="hsl(var(--accent))"
            stroke="hsl(var(--border))"
          />
          <text
            x="300"
            y="530"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Add Lesson
          </text>
        </g>

        <!-- Edit Lesson -->
        <g>
          <rect
            x="370"
            y="500"
            width="100"
            height="50"
            rx="4"
            fill="hsl(var(--accent))"
            stroke="hsl(var(--border))"
          />
          <text
            x="420"
            y="530"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Edit Lesson
          </text>
        </g>

        <!-- Pricing Section -->
        <g>
          <rect
            x="520"
            y="290"
            width="100"
            height="60"
            rx="4"
            fill="hsl(var(--muted))"
          />
          <text
            x="570"
            y="325"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Pricing
          </text>
        </g>

        <!-- Save Course -->
        <g>
          <rect
            x="520"
            y="400"
            width="100"
            height="50"
            rx="4"
            fill="hsl(var(--success))"
          />
          <text
            x="570"
            y="430"
            text-anchor="middle"
            fill="white"
            class="text-sm font-medium"
          >
            Save Course
          </text>
        </g>

        <!-- Validation -->
        <g>
          <rect
            x="700"
            y="290"
            width="120"
            height="60"
            rx="4"
            fill="hsl(var(--warning))"
          />
          <text
            x="760"
            y="315"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Validation
          </text>
          <text
            x="760"
            y="335"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Checks
          </text>
        </g>

        <!-- Success State -->
        <g>
          <rect
            x="700"
            y="400"
            width="120"
            height="50"
            rx="4"
            fill="hsl(var(--success))"
          />
          <text
            x="760"
            y="430"
            text-anchor="middle"
            fill="white"
            class="text-sm font-medium"
          >
            Success Message
          </text>
        </g>

        <!-- Draft Courses -->
        <g>
          <rect
            x="700"
            y="500"
            width="120"
            height="50"
            rx="4"
            fill="hsl(var(--muted))"
          />
          <text
            x="760"
            y="530"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Draft Courses
          </text>
        </g>

        <!-- Cancel / Exit -->
        <g>
          <rect
            x="520"
            y="500"
            width="100"
            height="50"
            rx="4"
            fill="hsl(var(--destructive))"
          />
          <text
            x="570"
            y="530"
            text-anchor="middle"
            fill="white"
            class="text-sm font-medium"
          >
            Cancel
          </text>
        </g>

        <!-- Edit Existing Course -->
        <g>
          <rect
            x="300"
            y="600"
            width="120"
            height="50"
            rx="4"
            fill="hsl(var(--muted))"
          />
          <text
            x="360"
            y="630"
            text-anchor="middle"
            fill="currentColor"
            class="text-sm font-medium"
          >
            Edit Course
          </text>
        </g>

        <!-- Connections -->
        <!-- Start to Dashboard -->
        <line
          x1="120"
          y1="130"
          x2="120"
          y2="180"
          stroke="currentColor"
          stroke-width="2"
        />

        <!-- Dashboard to Create Course -->
        <line
          x1="130"
          y1="240"
          x2="130"
          y2="290"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="130,290 125,280 135,280" fill="currentColor" />

        <!-- Create Course to Editor -->
        <line
          x1="190"
          y1="320"
          x2="300"
          y2="320"
          stroke="currentColor"
          stroke-width="2"
        />
        <line
          x1="300"
          y1="320"
          x2="300"
          y2="240"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="300,240 295,250 305,250" fill="currentColor" />

        <!-- Editor to Sections -->
        <line
          x1="350"
          y1="240"
          x2="300"
          y2="290"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="300,290 305,280 295,285" fill="currentColor" />

        <line
          x1="370"
          y1="240"
          x2="420"
          y2="290"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="420,290 415,280 425,285" fill="currentColor" />

        <line
          x1="400"
          y1="210"
          x2="570"
          y2="290"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="570,290 560,285 565,280" fill="currentColor" />

        <!-- Structure to Module Operations -->
        <line
          x1="300"
          y1="350"
          x2="300"
          y2="400"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="300,400 295,390 305,390" fill="currentColor" />

        <line
          x1="420"
          y1="350"
          x2="420"
          y2="400"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="420,400 415,390 425,390" fill="currentColor" />

        <!-- Module to Lesson Operations -->
        <line
          x1="300"
          y1="450"
          x2="300"
          y2="500"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="300,500 295,490 305,490" fill="currentColor" />

        <line
          x1="420"
          y1="450"
          x2="420"
          y2="500"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="420,500 415,490 425,490" fill="currentColor" />

        <!-- Pricing to Save -->
        <line
          x1="570"
          y1="350"
          x2="570"
          y2="400"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="570,400 565,390 575,390" fill="currentColor" />

        <!-- Save to Validation -->
        <line
          x1="620"
          y1="425"
          x2="700"
          y2="425"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="700,425 690,420 690,430" fill="currentColor" />

        <!-- Validation to Course Editor (if fail) -->
        <line
          x1="760"
          y1="290"
          x2="760"
          y2="210"
          stroke="currentColor"
          stroke-width="2"
        />
        <line
          x1="760"
          y1="210"
          x2="420"
          y2="210"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="420,210 430,205 430,215" fill="currentColor" />
        <text x="590" y="200" fill="currentColor" class="text-xs">
          Validation Fails
        </text>

        <!-- Validation to Success -->
        <line
          x1="760"
          y1="350"
          x2="760"
          y2="400"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="760,400 755,390 765,390" fill="currentColor" />
        <text x="780" y="380" fill="currentColor" class="text-xs">Valid</text>

        <!-- Success to Draft Courses -->
        <line
          x1="760"
          y1="450"
          x2="760"
          y2="500"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="760,500 755,490 765,490" fill="currentColor" />

        <!-- Draft Courses to Edit Course -->
        <line
          x1="700"
          y1="525"
          x2="360"
          y2="525"
          stroke="currentColor"
          stroke-width="2"
        />
        <line
          x1="360"
          y1="525"
          x2="360"
          y2="600"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="360,600 355,590 365,590" fill="currentColor" />

        <!-- Edit Course back to Editor -->
        <line
          x1="300"
          y1="625"
          x2="210"
          y2="625"
          stroke="currentColor"
          stroke-width="2"
        />
        <line
          x1="210"
          y1="625"
          x2="210"
          y2="210"
          stroke="currentColor"
          stroke-width="2"
        />
        <line
          x1="210"
          y1="210"
          x2="300"
          y2="210"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="300,210 290,205 290,215" fill="currentColor" />

        <!-- Cancel to Dashboard -->
        <line
          x1="520"
          y1="525"
          x2="50"
          y2="525"
          stroke="currentColor"
          stroke-width="2"
        />
        <line
          x1="50"
          y1="525"
          x2="50"
          y2="210"
          stroke="currentColor"
          stroke-width="2"
        />
        <line
          x1="50"
          y1="210"
          x2="70"
          y2="210"
          stroke="currentColor"
          stroke-width="2"
        />
        <polygon points="70,210 60,205 60,215" fill="currentColor" />
      </svg>
    </div>
  </div>
</template>
