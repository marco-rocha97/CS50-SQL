-- write a set of SQL statements that create indexes which will speed up typical queries on the harvard.db database. 
-- The number of indexes you create, as well as the columns they include, is entirely up to you. 
-- Be sure to balance speed with disk space, only creating indexes you need.
CREATE INDEX "student_index"
ON "students"("name");

CREATE INDEX "courses_index"
ON "courses"("department", "number", "semester", "title");

CREATE INDEX "enrollments_index"
ON "enrollments"("student_id", "course_id");

CREATE INDEX "requirements_index"
ON "requirements"("name");

CREATE INDEX "satisfies_index"
ON "satisfies"("course_id", "requirement_id");
