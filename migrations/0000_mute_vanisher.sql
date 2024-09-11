CREATE TABLE IF NOT EXISTS "course_type" (
	"course_type" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "courses" (
	"id_course" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"price" numeric(6, 2),
	"max_students" integer,
	"discord" text,
	"youtube" text,
	"id_course_type" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "courses_lessons" (
	"id_lesson" uuid,
	"id_course" uuid,
	CONSTRAINT "id_lessons_courses" PRIMARY KEY("id_lesson","id_course")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "courses_students" (
	"id_course" uuid,
	"id_student" uuid,
	CONSTRAINT "id_courses_students" PRIMARY KEY("id_course","id_student")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "courses_teachers" (
	"id_course" uuid,
	"id_teacher" uuid,
	CONSTRAINT "id_courses_teachers" PRIMARY KEY("id_course","id_teacher")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "difficulty" (
	"id_difficulty" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "goals" (
	"id_goal" uuid PRIMARY KEY NOT NULL,
	"goal" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "lessons" (
	"id_lesson" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "lessons_attachments" (
	"id_lesson" uuid,
	"attachment" "bytea"
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "problems" (
	"id_problem" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"content" text,
	"quality" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "problems_attachments" (
	"id_problem" uuid,
	"attachment" "bytea"
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "problems_goals_difficulty" (
	"id_problem" uuid,
	"id_goal" uuid,
	"id_difficulty" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "quality" (
	"id_quality" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user" (
	"id_user" uuid PRIMARY KEY NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "xxxx" (
	"id_xxxx" uuid PRIMARY KEY NOT NULL
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses" ADD CONSTRAINT "courses_id_course_type_course_type_course_type_fk" FOREIGN KEY ("id_course_type") REFERENCES "public"."course_type"("course_type") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses_lessons" ADD CONSTRAINT "courses_lessons_id_lesson_lessons_id_lesson_fk" FOREIGN KEY ("id_lesson") REFERENCES "public"."lessons"("id_lesson") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses_lessons" ADD CONSTRAINT "courses_lessons_id_course_courses_id_course_fk" FOREIGN KEY ("id_course") REFERENCES "public"."courses"("id_course") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses_students" ADD CONSTRAINT "courses_students_id_course_courses_id_course_fk" FOREIGN KEY ("id_course") REFERENCES "public"."courses"("id_course") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses_students" ADD CONSTRAINT "courses_students_id_student_user_id_user_fk" FOREIGN KEY ("id_student") REFERENCES "public"."user"("id_user") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses_teachers" ADD CONSTRAINT "courses_teachers_id_course_courses_id_course_fk" FOREIGN KEY ("id_course") REFERENCES "public"."courses"("id_course") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses_teachers" ADD CONSTRAINT "courses_teachers_id_teacher_user_id_user_fk" FOREIGN KEY ("id_teacher") REFERENCES "public"."user"("id_user") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "lessons_attachments" ADD CONSTRAINT "lessons_attachments_id_lesson_problems_id_problem_fk" FOREIGN KEY ("id_lesson") REFERENCES "public"."problems"("id_problem") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problems" ADD CONSTRAINT "problems_quality_quality_id_quality_fk" FOREIGN KEY ("quality") REFERENCES "public"."quality"("id_quality") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problems_attachments" ADD CONSTRAINT "problems_attachments_id_problem_problems_id_problem_fk" FOREIGN KEY ("id_problem") REFERENCES "public"."problems"("id_problem") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problems_goals_difficulty" ADD CONSTRAINT "problems_goals_difficulty_id_problem_problems_id_problem_fk" FOREIGN KEY ("id_problem") REFERENCES "public"."problems"("id_problem") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problems_goals_difficulty" ADD CONSTRAINT "problems_goals_difficulty_id_goal_goals_id_goal_fk" FOREIGN KEY ("id_goal") REFERENCES "public"."goals"("id_goal") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problems_goals_difficulty" ADD CONSTRAINT "problems_goals_difficulty_id_difficulty_difficulty_id_difficulty_fk" FOREIGN KEY ("id_difficulty") REFERENCES "public"."difficulty"("id_difficulty") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
