use netflix_films;

set session transaction isolation level read uncommitted;
start transaction;
select runtime from titles
where type="SHOW" and release_year=1945;
update titles 
set runtime=80
where type="SHOW" and release_year=1945;
select runtime from titles
where type="SHOW" and release_year=1945;

rollback;

select runtime from titles
where type="SHOW" and release_year=1945;
