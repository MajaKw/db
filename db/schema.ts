import { boolean, serial, text, primaryKey, timestamp, pgTable, uuid, varchar, numeric, integer, customType } from "drizzle-orm/pg-core";

const bytea = customType<{ data: Buffer; notNull: true; default: false }>({
    dataType() {
      return "bytea";
    },
  });

export const course_ = pgTable("course_", {
  id: uuid("id").primaryKey(),
  name: text("name").notNull(),
  price: numeric("price", {precision: 6, scale:2} ),
  maxStudents: integer("max_students"),
//   dicord: text("discord"),
//   youtube: text("youtube"),
  courseVisibilityId: uuid("course_type_id").references(() => courseVisibility_.id),
  markdownId: uuid("markdown_id").references(() => markdown_.id)
  // review ?
});


export const courseVisibility_ = pgTable("course_visibility_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull(),
    // description: text("description") // opis dla userów
})


export const user_ = pgTable("user_", {
    id: uuid("id").primaryKey()
})


// contraint: tylko member z rolą teacher
// raczej nei chcemy defaultowych wartości
export const courseUser_ = pgTable("course_user_", {
    courseId: uuid("course_id").references(() => course_.id),
    userId: uuid("user_id").references(() => user_.id),
    isStudent: boolean("is_student").notNull()
    // isTeaching: boolean

  }, (table) => {
    return {
        pk: primaryKey({ name: 'course_user_pk', columns: [table.courseId, table.userId] }),
    }
  }
);


export const lesson_ = pgTable("lesson_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull(),
    markdownId: uuid("markdown_id").references(() => markdown_.id)
})


export const courseLesson_ = pgTable("course_lesson_", {
    lessonId: uuid("lesson_id").references(() => lesson_.id),
    courseId: uuid("course_id").references(() => course_.id)
    },
    (table) => {
        return {
            pk: primaryKey({ name: 'course_lesson_pk', columns: [table.lessonId, table.courseId] }),
        }
})


export const problem_ = pgTable("problem_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull(),
    markdownId: uuid("markdown_id").references(() => markdown_.id)
})

export const courseProblem_ = pgTable("course_problem_", {
    courseId: uuid("course_id").references(() => course_.id),
    problemId: uuid("problem_id").references(() => problem_.id),
    lessonId: uuid("lesson_id").references(() => lesson_.id), // can be null
    },
    (table) => {
        return {
            pk: primaryKey({ name: 'course_problem_pk', columns: [table.courseId, table.problemId] }),
        }
})



export const attachment_ = pgTable("attachment_", {
    id: uuid("id").primaryKey(), // nie powtarzamy plików
    attachment: bytea("attachment"),
})

export const markdown_ = pgTable("markdown_", {
    id: uuid("id").primaryKey(),
    markdown: text("markdown")
})
export const markdown_attachment_ = pgTable("markdown_attachment_", {
   markdownId: uuid("markdown_id").references(() => markdown_.id),
   attachmentId: uuid("attachment_id").references(() => attachment_.id),
    }, (table) => {
        return {
            pk: primaryKey({ name: 'markdown_attachment_pk', columns: [table.markdownId, table.attachmentId] }),
        }  
    }
)



export const goal_ = pgTable("goal_", {
    id: uuid("id").primaryKey(),
    name: text("goal").notNull()
})

// pojedyncza liczba w nazwie tabeli
// wada postgres ma reserved duzo slow kluczowych
// slowa kluczowe postgresa nie moga sie konczyc _, wiec kazda nazwe tabeli konczymy _
// id na końcu problemId
// tutaj total
export const problemGoalRating_ = pgTable("problem_goal_rating", {
    problemId: uuid("problem_id").references(() => problem_.id),
    goalId: uuid("goal_id").references(() => goal_.id),
    // zmienic nama tabeli
    quality: numeric("quality", { precision: 5, scale: 2 }),
    difficulty: numeric("difficulty", { precision: 5, scale: 2 }),   
}, (table) => {
    return {
        pk: primaryKey({ name: 'problem_goal_rating_pk', columns: [table.problemId, table.goalId] }),
    }
}
)

    
export const status_ = pgTable("status_", {
    id: uuid("id").primaryKey(),
    name: text("name").notNull()
})


export const student_assignment_ = pgTable("student_assignment_", {
    id: uuid("id").primaryKey(), 
    problemId: uuid("problem_id").references(() => problem_.id),
    studentId: uuid("user_id").references(()=> user_.id),

    
    // jako contraint, że (problem, student) should be unique not null 
    // }, (table) => {
//     return {
//         pk: primaryKey({ name: 'student_assignment_pk', columns: [table.problemId, table.studentId] }),
//     }
})

export const submission_ = pgTable("submission_", {
    id: uuid("submission").primaryKey(),
    assignmentId: uuid("assignment_id").references(() => student_assignment_.id).notNull(),
    submissionMarkdown: uuid("submission_markdown_id").references(() => markdown_.id),
    assessmentMarkdwon: uuid("assessment_markdown_id").references(() => markdown_.id),
    idStatus: uuid("status_id").references(()=> status_.id).notNull(),
    teacherId: uuid("teacher_id").references(() => courseUser_.userId)
})





export const review_ = pgTable("review_", {
    id: uuid("id").primaryKey(),
    review: text("review").notNull(),
    studentId: uuid("student_id").references(() => user_.id),
    courseId: uuid("course_id").references(() => course_.id)
})

