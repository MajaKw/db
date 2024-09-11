CREATE TABLE IF NOT EXISTS "courses_problems" (
	"id_lesson" uuid,
	"id_problem" uuid,
	CONSTRAINT "id_lessons_problems" PRIMARY KEY("id_lesson","id_problem")
);
--> statement-breakpoint
DROP TABLE "xxxx";--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses_problems" ADD CONSTRAINT "courses_problems_id_lesson_lessons_id_lesson_fk" FOREIGN KEY ("id_lesson") REFERENCES "public"."lessons"("id_lesson") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "courses_problems" ADD CONSTRAINT "courses_problems_id_problem_problems_id_problem_fk" FOREIGN KEY ("id_problem") REFERENCES "public"."problems"("id_problem") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
