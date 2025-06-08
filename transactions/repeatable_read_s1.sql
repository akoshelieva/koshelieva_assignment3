use netflix_films;

set session transaction isolation level repeatable read;
start transaction;
select description from titles where title="Taxi Driver";

select description from titles where title="Taxi Driver";

commit;