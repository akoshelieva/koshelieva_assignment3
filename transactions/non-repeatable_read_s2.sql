use netflix_films;

set session transaction isolation level read committed;
start transaction;
update titles
set description="This collection includes 12 World War II-era propaganda films"
where title="Taxi Driver";

commit;