import { boolean, serial, text, primaryKey, timestamp, pgTable, uuid, varchar, numeric, integer, customType } from "drizzle-orm/pg-core";

const bytea = customType<{ data: Buffer; notNull: true; default: false }>({
    dataType() {
      return "bytea";
    },
  });

export const course_ = pgTable("course_", {
  courseId: uuid("course_id").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  price: numeric("price", {precision: 6, scale:2} ),
  maxStudents: integer("max_students"),
  dicord: text("discord"),
  youtube: text("youtube"),
  courseTypeId: uuid("course_type_id").references(() => courseVisibility_.courseVisibilityId),
  // review ?
});


export const courseVisibility_ = pgTable("course_visibility_", {
    courseVisibilityId: uuid("course_visibility_id").primaryKey(),
    name: text("name").notNull(),
    // description: text("description") // opis dla userów
})


export const user_ = pgTable("user_", {
    userId: uuid("user_id").primaryKey()
})


// contraint: tylko member z rolą teacher
// raczej nei chcemy defaultowych wartości
export const courseUser_ = pgTable("course_user_", {
    courseId: uuid("course_id").references(() => course_.courseId),
    userId: uuid("user_id").references(() => user_.userId),
    isStudent: boolean("is_student").notNull()
    // isTeaching: boolean

  }, (table) => {
    return {
        pk: primaryKey({ name: 'course_user_id', columns: [table.courseId, table.userId] }),
    }
  }
);


// //  ############### REVIEW alternatywa
// export const review_ = pgTable("review", {
//     idReview: uuid("review").primaryKey(),
//     review: text("review"),
//     // review moze dac tylko stuent, ktory nalezy do kursu
//     idStudentCourse: uuid("course_user_id").references(() => (courseUser_.userId, courseUser_.courseId))
//     // idCourse
// })







export const lesson_ = pgTable("lesson_", {
    lessonId: uuid("lesson_id").primaryKey(),
    name: text("name").notNull(),
    description: text("description")
})

export const lessonAttachment_ = pgTable("lesson_attachment_", {
    idLessonAttachment: uuid("lesson_attachment_id").primaryKey(),
    idLesson: uuid("lesson_id").references(() => lesson_.lessonId),
    attachment: bytea("attachment")
})
export const courseLesson_ = pgTable("course_lesson_", {
    idLesson: uuid("lesson_id").references(() => lesson_.lessonId),
    idCourse: uuid("course_id").references(() => course_.courseId)
    },
    (table) => {
        return {
            pk: primaryKey({ name: 'lesson_course_id', columns: [table.idLesson, table.idCourse] }),
        }
})


export const problem_ = pgTable("problem", {
    problemId: uuid("problem_id").primaryKey(),
    name: text("name").notNull(),
    // link lub treść
    content: text("content")
})

// export const lessonProblem_ = pgTable("lesson_problem_", {
//     lessonId: uuid("lesson_id").references(() => lesson_.lessonId),
//     problemId: uuid("problem_id").references(() => problem_.problemId)
//     },
//     (table) => {
//         return {
//             pk: primaryKey({ name: 'lesson_problem_id', columns: [table.lessonId, table.problemId] }),
//         }
// })




export const problemsAttachments = pgTable("problem_attachment_", {
    problemAttachmentId: uuid("problem_attachment_id").primaryKey(),
    problemId: uuid("problem_id").references(() => problem_.problemId),
    attachment: bytea("attachment")
})

export const goal_ = pgTable("goal_", {
    goalId: uuid("goal_id").primaryKey(),
    name: text("goal").notNull()
})

// pojedyncza liczba w nazwie tabeli
// wada postgres ma reserved duzo slow kluczowych
// slowa kluczowe postgresa nie moga sie konczyc _, wiec kazda nazwe tabeli konczymy _
// id na końcu problemId
export const problemGoalRating_ = pgTable("problem_goal_rating", {
    problemId: uuid("problem_id").references(() => problem_.problemId),
    goalId: uuid("goal_id").references(() => goal_.goalId),
    // zmienic nama tabeli
    quality: numeric("quality", { precision: 5, scale: 2 }),
    difficulty: numeric("difficulty", { precision: 5, scale: 2 }),   
}, (table) => {
    return {
        pk: primaryKey({ name: 'problem_goal_rating_id', columns: [table.problemId, table.goalId] }),
    }
}
)

    
export const status_ = pgTable("status_", {
    statusId: uuid("status_id").primaryKey(),
    name: text("name").notNull()
})


// export const submissions = pgTable("submissions", {
//     idProblem: uuid("id_problem").references(() => lessonProblem_.problemId),
//     idStudent: uuid("id_student").references(()=> courseUser_.userId),
//     idSubmission: uuid("id_submission").primaryKey(), 
//     submissionContent: text("content"),
//     assessment: text("assessment"),
// })

