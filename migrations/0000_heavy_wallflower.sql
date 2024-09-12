CREATE TABLE IF NOT EXISTS "course_lesson_" (
	"lesson_id" uuid,
	"course_id" uuid,
	CONSTRAINT "lesson_course_id" PRIMARY KEY("lesson_id","course_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "course_user_" (
	"course_id" uuid,
	"user_id" uuid,
	"is_student" boolean NOT NULL,
	CONSTRAINT "course_user_id" PRIMARY KEY("course_id","user_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "course_visibility_" (
	"course_visibility_id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "course_" (
	"course_id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"price" numeric(6, 2),
	"max_students" integer,
	"discord" text,
	"youtube" text,
	"course_type_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "goal_" (
	"goal_id" uuid PRIMARY KEY NOT NULL,
	"goal" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "lesson_attachment_" (
	"lesson_attachment_id" uuid PRIMARY KEY NOT NULL,
	"lesson_id" uuid,
	"attachment" "bytea"
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "lesson_" (
	"lesson_id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "problem_goal_rating" (
	"problem_id" uuid,
	"goal_id" uuid,
	"quality" numeric(5, 2),
	"difficulty" numeric(5, 2),
	CONSTRAINT "problem_goal_rating_id" PRIMARY KEY("problem_id","goal_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "problem" (
	"problem_id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"content" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "problem_attachment_" (
	"problem_attachment_id" uuid PRIMARY KEY NOT NULL,
	"problem_id" uuid,
	"attachment" "bytea"
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "status_" (
	"status_id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_" (
	"user_id" uuid PRIMARY KEY NOT NULL
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_lesson_" ADD CONSTRAINT "course_lesson__lesson_id_lesson__lesson_id_fk" FOREIGN KEY ("lesson_id") REFERENCES "public"."lesson_"("lesson_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_lesson_" ADD CONSTRAINT "course_lesson__course_id_course__course_id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."course_"("course_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_user_" ADD CONSTRAINT "course_user__course_id_course__course_id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."course_"("course_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_user_" ADD CONSTRAINT "course_user__user_id_user__user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user_"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "course_" ADD CONSTRAINT "course__course_type_id_course_visibility__course_visibility_id_fk" FOREIGN KEY ("course_type_id") REFERENCES "public"."course_visibility_"("course_visibility_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "lesson_attachment_" ADD CONSTRAINT "lesson_attachment__lesson_id_lesson__lesson_id_fk" FOREIGN KEY ("lesson_id") REFERENCES "public"."lesson_"("lesson_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problem_goal_rating" ADD CONSTRAINT "problem_goal_rating_problem_id_problem_problem_id_fk" FOREIGN KEY ("problem_id") REFERENCES "public"."problem"("problem_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problem_goal_rating" ADD CONSTRAINT "problem_goal_rating_goal_id_goal__goal_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."goal_"("goal_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "problem_attachment_" ADD CONSTRAINT "problem_attachment__problem_id_problem_problem_id_fk" FOREIGN KEY ("problem_id") REFERENCES "public"."problem"("problem_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
