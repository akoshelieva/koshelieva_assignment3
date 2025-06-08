use netflix_films;

update titles
set description="This collection includes propaganda films"
where title="Taxi Driver";

commit;
select description from titles where title="Taxi Driver";