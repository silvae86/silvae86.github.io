--will present the results in a neat organized table, but will take more horizontal space. Default mode is 'list', which is more compact but harder to read
.mode columns
--shows headers at the top of the columns when running queries
.headers on 
-- delete table T if it exists (good for testing purposes)
drop table if exists T;
--create table T
create table T (A text, B text);
-- Insert Hello World into table T
insert into T values ('Hello,', 'world!');
-- Get all rows of table T
select * from T;