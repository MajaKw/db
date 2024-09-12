CREATE TABLE IF NOT EXISTS "attachment_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"attachment" "bytea"
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "course_lesson_" (
	"lesson_id" uuid,
	"course_id" uuid,
	CONSTRAINT "course_lesson_pk" PRIMARY KEY("lesson_id","course_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "course_problem_" (
	"course_id" uuid,
	"problem_id" uuid,
	"lesson_id" uuid,
	CONSTRAINT "course_problem_pk" PRIMARY KEY("course_id","problem_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "course_user_" (
	"course_id" uuid,
	"user_id" uuid,
	"is_student" boolean NOT NULL,
	CONSTRAINT "course_user_pk" PRIMARY KEY("course_id","user_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "course_visibility_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "course_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"price" numeric(6, 2),
	"max_students" integer,
	"course_type_id" uuid,
	"markdown_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "goal_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"goal" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "lesson_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"markdown_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "markdown_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"markdown" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "markdown_attachment_" (
	"markdown_id" uuid,
	"attachment_id" uuid,
	CONSTRAINT "markdown_attachment_pk" PRIMARY KEY("markdown_id","attachment_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "problem_goal_rating" (
	"problem_id" uuid,
	"goal_id" uuid,
	"quality" numeric(5, 2),
	"difficulty" numeric(5, 2),
	CONSTRAINT "problem_goal_rating_pk" PRIMARY KEY("problem_id","goal_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "problem_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"markdown_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "review_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"review" text NOT NULL,
	"student_id" uuid,
	"course_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "status_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "student_assignment_" (
	"id" uuid PRIMARY KEY NOT NULL,
	"problem_id" uuid,
	"user_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "submission_" (
	"submission" uuid PRIMARY KEY NOT NULL,
	"assignment_id" uuid NOT NULL,
	"submission_markdown_id" uuid,
	"assessment_markdown_id" uuid,
	"status_id" uuid NOT NULL,
	"teacher_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_" (
	"id" uuid PRIMARY KEY NOT NULL
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_lesson_" ADD CONSTRAINT "course_lesson__lesson_id_lesson__id_fk" FOREIGN KEY ("lesson_id") REFERENCES "public"."lesson_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_lesson_" ADD CONSTRAINT "course_lesson__course_id_course__id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."course_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_problem_" ADD CONSTRAINT "course_problem__course_id_course__id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."course_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_problem_" ADD CONSTRAINT "course_problem__problem_id_problem__id_fk" FOREIGN KEY ("problem_id") REFERENCES "public"."problem_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_problem_" ADD CONSTRAINT "course_problem__lesson_id_lesson__id_fk" FOREIGN KEY ("lesson_id") REFERENCES "public"."lesson_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_user_" ADD CONSTRAINT "course_user__course_id_course__id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."course_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_user_" ADD CONSTRAINT "course_user__user_id_user__id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_" ADD CONSTRAINT "course__course_type_id_course_visibility__id_fk" FOREIGN KEY ("course_type_id") REFERENCES "public"."course_visibility_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_" ADD CONSTRAINT "course__markdown_id_markdown__id_fk" FOREIGN KEY ("markdown_id") REFERENCES "public"."markdown_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "lesson_" ADD CONSTRAINT "lesson__markdown_id_markdown__id_fk" FOREIGN KEY ("markdown_id") REFERENCES "public"."markdown_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "markdown_attachment_" ADD CONSTRAINT "markdown_attachment__markdown_id_markdown__id_fk" FOREIGN KEY ("markdown_id") REFERENCES "public"."markdown_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "markdown_attachment_" ADD CONSTRAINT "markdown_attachment__attachment_id_attachment__id_fk" FOREIGN KEY ("attachment_id") REFERENCES "public"."attachment_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problem_goal_rating" ADD CONSTRAINT "problem_goal_rating_problem_id_problem__id_fk" FOREIGN KEY ("problem_id") REFERENCES "public"."problem_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problem_goal_rating" ADD CONSTRAINT "problem_goal_rating_goal_id_goal__id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."goal_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problem_" ADD CONSTRAINT "problem__markdown_id_markdown__id_fk" FOREIGN KEY ("markdown_id") REFERENCES "public"."markdown_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "review_" ADD CONSTRAINT "review__student_id_user__id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."user_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "review_" ADD CONSTRAINT "review__course_id_course__id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."course_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "student_assignment_" ADD CONSTRAINT "student_assignment__problem_id_course_problem__problem_id_fk" FOREIGN KEY ("problem_id") REFERENCES "public"."course_problem_"("problem_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "student_assignment_" ADD CONSTRAINT "student_assignment__user_id_course_user__user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."course_user_"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "submission_" ADD CONSTRAINT "submission__assignment_id_student_assignment__id_fk" FOREIGN KEY ("assignment_id") REFERENCES "public"."student_assignment_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "submission_" ADD CONSTRAINT "submission__submission_markdown_id_markdown__id_fk" FOREIGN KEY ("submission_markdown_id") REFERENCES "public"."markdown_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "submission_" ADD CONSTRAINT "submission__assessment_markdown_id_markdown__id_fk" FOREIGN KEY ("assessment_markdown_id") REFERENCES "public"."markdown_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "submission_" ADD CONSTRAINT "submission__status_id_status__id_fk" FOREIGN KEY ("status_id") REFERENCES "public"."status_"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "submission_" ADD CONSTRAINT "submission__teacher_id_course_user__user_id_fk" FOREIGN KEY ("teacher_id") REFERENCES "public"."course_user_"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
