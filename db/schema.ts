import { boolean, serial, text, primaryKey, timestamp, pgTable, uuid, varchar, numeric, integer, customType } from "drizzle-orm/pg-core";

const bytea = customType<{ data: Buffer; notNull: true; default: false }>({
    dataType() {
      return "bytea";
    },
  });

//
export const course_ = pgTable("course_", {
  id: uuid("id").primaryKey(),
  name: text("name").notNull(),
  price: numeric("price", {precision: 6, scale:2} ),
  maxStudents: integer("max_students"),
  courseVisibilityId: uuid("course_type_id").references(() => courseVisibility_.id).notNull(),
  markdownId: uuid("markdown_id").references(() => markdown_.id)
});

//
export const courseVisibility_ = pgTable("course_visibility_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull(),
})

//
export const user_ = pgTable("user_", {
    id: uuid("id").primaryKey()
})

//
export const courseUser_ = pgTable("course_user_", {
    courseId: uuid("course_id").references(() => course_.id),
    userId: uuid("user_id").references(() => user_.id),
    isStudent: boolean("is_student").notNull()
  }, (table) => {
    return {
        pk: primaryKey({ name: 'course_user_pk', columns: [table.courseId, table.userId] }),
    }
  }
);

//
export const lesson_ = pgTable("lesson_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull(),
    markdownId: uuid("markdown_id").references(() => markdown_.id)
})

//
export const courseLesson_ = pgTable("course_lesson_", {
    lessonId: uuid("lesson_id").references(() => lesson_.id),
    lessonOrder: integer("lesson_order").notNull(),
    courseId: uuid("course_id").references(() => course_.id)
    },
    (table) => {
        return {
            pk: primaryKey({ name: 'course_lesson_pk', columns: [table.lessonId, table.courseId] }),
        }
})

export const problemType_ = pgTable("problem_type_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull()
})

//
export const problem_ = pgTable("problem_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull(),
    typeId: uuid("type_id").references(() => problemType_.id)
})

export const casualProblem_ = pgTable("casual_problem_", {
    id: uuid("id").references(() => problem_.id).primaryKey(),
    markdownId: uuid("markdown_id").references(() => markdown_.id).notNull()
})

//
export const courseProblem_ = pgTable("course_problem_", {
    courseId: uuid("course_id").references(() => course_.id),
    problemId: uuid("problem_id").references(() => problem_.id),
    lessonId: uuid("lesson_id").references(() => lesson_.id), // can be null
    // FK: terminID
    },
    (table) => {
        return {
            pk: primaryKey({ name: 'course_problem_pk', columns: [table.courseId, table.problemId] }),
        }
})


//
export const attachment_ = pgTable("attachment_", {
    id: uuid("id").primaryKey(), // nie powtarzamy plików
    attachment: bytea("attachment"),
})

//
export const markdown_ = pgTable("markdown_", {
    id: uuid("id").primaryKey(),
    markdown: text("markdown")
})

//
export const markdown_attachment_ = pgTable("markdown_attachment_", {
   markdownId: uuid("markdown_id").references(() => markdown_.id),
   attachmentId: uuid("attachment_id").references(() => attachment_.id),
    }, (table) => {
        return {
            pk: primaryKey({ name: 'markdown_attachment_pk', columns: [table.markdownId, table.attachmentId] }),
        }  
    }
)

//
export const goal_ = pgTable("goal_", {
    id: uuid("id").primaryKey(),
    name: text("goal").notNull()
})

export const problemGoalRatingTotal_ = pgTable("problem_goal_rating_total_", {
    problemId: uuid("problem_id").references(() => problem_.id),
    goalId: uuid("goal_id").references(() => goal_.id),
    qualityTotal: numeric("quality", { precision: 5, scale: 2 }),
    difficultyTotal: numeric("difficulty", { precision: 5, scale: 2 }),   
}, (table) => {
    return {
        pk: primaryKey({ name: 'problem_goal_rating_total_pk', columns: [table.problemId, table.goalId] }),
    }
    })

//
export const problemGoalRating_  = pgTable("problem_goal_rating_", {
    problemId: uuid("problem_id").references(() => problem_.id),
    goalId: uuid("goal_id").references(() => goal_.id),
    // user towrzacy zadania tez moze ocenic
    userId: uuid("user_id").references(() => user_.id),
    // ?? czy muszą być obie oceny not null?
    quality: integer("quality"),
    difficulty: integer("difficulty"),

}, (table) => {
    return {
        pk: primaryKey({ name: 'problem_goal_rating_pk', columns: [table.problemId, table.goalId, table.userId] }),
    }
    }
)

//   
export const status_ = pgTable("status_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull(),
    priority: integer("priority").notNull()
})

// chyba nie msui mieć type, bo wiemy jakiego typu powinna byc z problemu do ktorego jest robiona
export const submission_ = pgTable("submission_", {
    id: uuid("id").primaryKey(),
    // submission można robić tylko do problemów w kursie
    problemId: uuid("problem_id").references(() => problem_.id).notNull(),
    // i moze tylko user zapisany na kurs
    studentId: uuid("user_id").references(()=> user_.id).notNull(),
    // beda rozne rodzaje submission
    // submissionMarkdown: uuid("submission_markdown_id").references(() => markdown_.id).notNull(),
    idStatus: uuid("status_id").references(()=> status_.id).notNull(),
})

export const casualSubmission_ = pgTable("casual_submission_", {
    id: uuid("id").references(() => submission_.id).primaryKey(),
    submissionMarkdown: uuid("submission_markdown_id").references(() => markdown_.id).notNull(),
})
// ???
export const submissionAssessment_ = pgTable("submission_", {
    submissionId: uuid("submission_id").references(() => submission_.id).primaryKey(),
    assessmentMarkdwon: uuid("assessment_markdown_id").references(() => markdown_.id).notNull(),
    teacherId: uuid("teacher_id").references(() => user_.id)
})

// ???
export const review_ = pgTable("review_", {
    review: text("review").notNull(),
    studentId: uuid("student_id").references(() => user_.id),
    courseId: uuid("course_id").references(() => course_.id),
}, (table) => {
    return {
        pk: primaryKey({ name: 'review_pk', columns: [table.studentId, table.courseId] }),
    }
})

