select* from Duy..udemy_courses
--1. Tìm ra subject nào được học nhiều nhất
select top 1
Duy..udemy_courses.subject as Subject,
count(Subject) SLĐK
from Duy..udemy_courses
group by Duy..udemy_courses.subject
--2. Tìm ra khóa học nào thu tiền nhiều nhất
select
Duy..udemy_courses.course_id,
max(DUy..udemy_courses.price) as "Giá cao nhất"
from Duy..udemy_courses
group by Duy..udemy_courses.course_id

--3. Tìm ra giá của 10 khóa học có số lượng đánh giá cao nhất
select top 10
UC.course_id,
UC.price,
UC.num_reviews
from Duy..udemy_courses as UC
order by UC.num_reviews DESC
--4. Tìm ra số lượng subscribe 10 khóa học có lượng đánh giá thấp nhất
select top 10
UC.course_id,
UC.num_subscribers,
UC.num_reviews
from Duy..udemy_courses as UC
order by UC.num_reviews ASC
--5. Tìm ra 5 khóa học có doanh thu cao nhất trong 10 khóa học nhiều subscribe nhất
with A_Table as (select top 10
UC.course_id as Course_ID,
UC.course_title as Title,
UC.price as Price,
UC. num_subscribers as Subrscribers
from Duy..udemy_courses as UC
order by UC.num_subscribers DESC)
Select top 5
Course_ID,
Title,
Price,
Subrscribers
from A_Table
order by Price DESC


