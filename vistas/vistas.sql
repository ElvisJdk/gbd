/*
Ejercicio 1: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos los libros de la tabla sales
 por cada tienda, tipo de libro, año de publicación y mes de publicación.

*/
create view vista_1
as
select  ti.title titulo,
		au.au_fname nombre,
        ti.price precio,
        sum(sa.qty) cantidad,
        ti.type tipo,
        year(ti.pubdate) anio,
        month(ti.pubdate) mes

from	stores st
join	sales sa
on 		st.stor_id = sa.stor_id
join	titles ti
on		sa.title_id = ti.title_id
join	titleauthor th
on		ti.title_id = th.title_id
join	authors au
on 		th.au_id = au.au_id
group by ti.title,
		au.au_fname,
        ti.price,
        st.stor_name,
        ti.type,
        year(ti.pubdate),
        month(ti.pubdate);
        
select * from vista_1;

/*
   Ejercicio 2: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos los libros 
   e la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las ventas que superaron los 10 libros.
*/
create view vista_2
as
select  ti.title titulo,
		au.au_fname nombre,
        ti.price precio,
        sum(sa.qty) cantidad,
        ti.type tipo,
        year(ti.pubdate) anio
from	stores st
join	sales sa
on 		st.stor_id = sa.stor_id
join	titles ti
on		sa.title_id = ti.title_id
join	titleauthor th
on		ti.title_id = th.title_id
join	authors au
on 		th.au_id = au.au_id
where	sa.qty > 10
group by ti.title,
		au.au_fname,
        ti.price,
        st.stor_name,
        ti.type,
        year(ti.pubdate);
        
select * from vista_2;


/*
Ejercicio 3: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos los libros
 de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las ventas que se realizaron en el año 1990.

*/
create view vista_3
as
select  ti.title titulo,
		au.au_fname nombre,
        ti.price precio,
        sum(sa.qty) cantidad,
        ti.type tipo,
        year(ti.pubdate) anio
from	stores st
join	sales sa
on 		st.stor_id = sa.stor_id
join	titles ti
on		sa.title_id = ti.title_id
join	titleauthor th
on		ti.title_id = th.title_id
join	authors au
on 		th.au_id = au.au_id
where	year(ti.pubdate) = 1990 
group by ti.title,
		au.au_fname,
        ti.price,
        st.stor_name,
        ti.type,
        year(ti.pubdate);
        
select * from vista_3;

/*
 Ejercicio 4: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos los libros
 de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las ventas que se realizaron entre 1990 y 1994.

*/

create view vista_4
as
select  ti.title titulo,
		au.au_fname autor,
        ti.price precio,
        sum(sa.qty) cantidad,
        ti.type tipo,
        year(ti.pubdate) anio
from	stores st
join	sales sa
on 		st.stor_id = sa.stor_id
join	titles ti
on		sa.title_id = ti.title_id
join	titleauthor th
on		ti.title_id = th.title_id
join	authors au
on 		th.au_id = au.au_id
where	year(ti.pubdate) between 1990 and 1994
group by ti.title,
		au.au_fname,
        ti.price,
        st.stor_name,
        ti.type,
        year(ti.pubdate);
drop view vista_4;

select * from vista_4;
select * from titles;

/*

 Ejercicio 5: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos los
 libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las ventas que se realizaron en la tienda con el ID 7066.

*/
	
create view vista_5
as
select  ti.title titulo,
		au.au_fname autor,
        ti.price precio,
        sum(sa.qty) cantidad,
        ti.type tipo,
        year(ti.pubdate) anio,
        st.stor_name 'nombre tienda'

from	stores st
join	sales sa
on 		st.stor_id = sa.stor_id
join	titles ti
on		sa.title_id = ti.title_id
join	titleauthor th
on		ti.title_id = th.title_id
join	authors au
on 		th.au_id = au.au_id
where	st.stor_id = 7067
group by ti.title,
		au.au_fname,
        ti.price,
        st.stor_name,
        ti.type,
        year(ti.pubdate);
drop view vista_5;
select * from vista_5;
select * from stores;

/*
 Ejercicio 6: Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos los 
 libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las ventas que se realizaron por el autor con el ID 172.

*/

create view vista_6
as
select  ti.title titulo,
		au.au_fname autor,
        ti.price precio,
        sum(sa.qty) cantidad,
        ti.type tipo,
        year(ti.pubdate) anio,
        st.stor_name 'nombre tienda'

from	stores st
join	sales sa
on 		st.stor_id = sa.stor_id
join	titles ti
on		sa.title_id = ti.title_id
join	titleauthor th
on		ti.title_id = th.title_id
join	authors au
on 		th.au_id = au.au_id
where	au.au_id = 172
group by ti.title,
		au.au_fname,
        ti.price,
        st.stor_name,
        ti.type,
        year(ti.pubdate);
select * from vista_6;
select * from authors;

/*
Ejercicio 7: Crea una vista que permita actualizar el precio de un libro en la tabla titles.

*/

create view vista_7
as
select title_id, title, price
from  titles;

update vista_7
set price =30.00
where title_id= 4;

/*
 Ejercicio 8: Crea una vista que permita actualizar el nombre de un autor en la tabla authors.

*/
drop view vista_8;
create view vista_8
as
select au_id, au_fname,au_lname
from authors;

update vista_8
set au_fname = 'elvis', au_lname ='morales'
where au_id = 172;
SET SQL_SAFE_UPDATES = 0;
select  * from authors;

/*

 Ejercicio 9: Crea una vista que permita actualizar la cantidad vendida de un libro en la tabla sales.
*/
create view vista_9
as
select stor_id, qty,title_id
from  sales;
drop view vista_9;

update vista_9
set qty = 100
where title_id = 2 and	stor_id = 6380;
select * from sales;

/*

 Ejercicio 10: Crea una vista que permita actualizar la fecha de publicación de un libro en la tabla titles.
*/
create view vista_10
as
select pubdate, title, title_id
from titles;

update vista_10
set pubdate = '1991-01-01'
where  title_id =2;


select * from titles;