import { serial, text, primaryKey, timestamp, pgTable, uuid, varchar, numeric, integer, customType } from "drizzle-orm/pg-core";

const bytea = customType<{ data: Buffer; notNull: true; default: false }>({
    dataType() {
      return "bytea";
    },
  });

export const courses = pgTable("courses", {
  idCourse: uuid("id_course").primaryKey(),
  name: text("name").notNull(),
  description: text("description"),
  price: numeric("price", {precision: 6, scale:2} ),
  maxStudents: integer("max_students"),
  dicord: text("discord"),
  youtube: text("youtube"),
  idCourseType: uuid("id_course_type").references(() => courseType.idCourseType)
});

export const users = pgTable("user", {
    idUser: uuid("id_user").primaryKey()
})

// contraint: tylko member z rolą teacher
export const coursesTeachers = pgTable("courses_teachers", {
    idCourse: uuid("id_course").references(() => courses.idCourse),
    idTeacher: uuid("id_teacher").references(() => users.idUser)
  }, (table) => {
    return {
        pk: primaryKey({ name: 'id_courses_teachers', columns: [table.idCourse, table.idTeacher] }),
    }
  }
);

export const courseType = pgTable("course_type", {
    idCourseType: uuid("course_type").primaryKey(),
    name: text("name").notNull()
})

export const coursesStudents = pgTable("courses_students", {
    idCourse: uuid("id_course").references(() => courses.idCourse),
    idStudent: uuid("id_student").references(() => users.idUser)
  }, (table) => {
    return {
        pk: primaryKey({ name: 'id_courses_students', columns: [table.idCourse, table.idStudent] }),
    }
})

export const lessons = pgTable("lessons", {
    idLesson: uuid("id_lesson").primaryKey(),
    name: text("name").notNull(),
    description: text("description")
})

export const lessonsAttachments = pgTable("lessons_attachments", {
    idLessonAttachment: uuid("id_lesson_attachment").primaryKey(),
    idLesson: uuid("id_lesson").references(() => lessons.idLesson),
    attachment: bytea("attachment")
})
export const coursesLessons = pgTable("courses_lessons", {
    idLesson: uuid("id_lesson").references(() => lessons.idLesson),
    idCourse: uuid("id_course").references(() => courses.idCourse)
    },
    (table) => {
        return {
            pk: primaryKey({ name: 'id_lessons_courses', columns: [table.idLesson, table.idCourse] }),
        }
})

export const lessonsProblems = pgTable("lessons_problems", {
    idLesson: uuid("id_lesson").references(() => lessons.idLesson),
    idProblem: uuid("id_problem").references(() => problems.idProblem)
    },
    (table) => {
        return {
            pk: primaryKey({ name: 'id_lessons_problems', columns: [table.idLesson, table.idProblem] }),
        }
})

export const quality = pgTable("quality", {
    idQuality: uuid("id_quality").primaryKey(),
    name: text("name").notNull()
})
export const difficulty = pgTable("difficulty", {
    idDifficulty: uuid("id_difficulty").primaryKey(),
    name: text("name").notNull()
})

export const problems = pgTable("problems", {
    idProblem: uuid("id_problem").primaryKey(),
    name: text("name").notNull(),
    // link lub treść
    content: text("content"),
    quality: uuid("quality").references(() => quality.idQuality),
})


export const problemsAttachments = pgTable("problems_attachments", {
    idProblemAttachment: uuid("id_problem_attachment").primaryKey(),
    idProblem: uuid("id_problem").references(() => problems.idProblem),
    attachment: bytea("attachment")
})

export const goals = pgTable("goals", {
    idGoal: uuid("id_goal").primaryKey(),
    name: text("goal").notNull()
})

export const problemsGoalsDifficulty = pgTable("problems_goals_difficulty", {
    idProblem: uuid("id_problem").references(() => problems.idProblem),
    idGoal: uuid("id_goal").references(() => goals.idGoal),
    idDifficulty: uuid("id_difficulty").references(() => difficulty.idDifficulty),   
}, (table) => {
    return {
        pk: primaryKey({ name: 'id_problem_goal_difficulty', columns: [table.idProblem, table.idGoal, table.idDifficulty] }),
    }
}
)
    
export const status = pgTable("status", {
    idStatus: uuid("status").primaryKey(),
    name: text("name").notNull()
})



export const submissionsAttachments = pgTable("submissionsAttachments", {
    idSubmissionAttachment: uuid("id_submission_attachment").primaryKey(),
    idSubmission: uuid("id_submission").references(()=> submissions.idSubmission),
    attachment: bytea("attachment"),
})

export const submissions = pgTable("submissions", {
    idProblem: uuid("id_problem").references(() => lessonsProblems.idProblem),
    idStudent: uuid("id_student").references(()=> coursesStudents.idStudent),
    idSubmission: uuid("id_submission").primaryKey(), 
    submissionContent: text("content"),
    assessment: text("assessment"),
    
})

// export const submissions = pgTable("submissions", {
//     idSubmission: uuid("id_submission").primaryKey(),
//     content: text("content"),
// })

// export const assessments = pgTable("mentors_assessments", {
//     idSubmission: uuid("submission").references(() => submissions.idSubmission),
//     idStatus: uuid("id_status").references(() => status.idStatus),
// })



