-- 1
SELECT current_inventory FROM books where title = '?' and current_inventory > 0;

-- 2
select first_name, last_name from customer Order BY join_date limit 1;

-- 3
select distinct supplies_book.title 
from supplies, supplies_book, books 
where full_date = (select min(full_date) from supplies) and books.current_inventory > 0 
order by full_date limit 1;

-- 4
SELECT * 
FROM order_book 
where _status = 'in proccess' 
order by order_date;

-- 5
select sum(deal_book._sum) from deal_book where title = '?';

-- 6
SELECT _name, MAX(themax) 
from (select ba._name, db.num_deal, d.date_deal, db.title, SUM(db._sum) themax 
from book_authers ba 
inner join deal_book db 
on ba.title = db.title 
inner join deal d 
on d.num_deal = db.num_deal 
WHERE d.date_deal >= '?' and d.date_deal < '?'
group by ba._name)  _max; 

-- 7
select id 
from (select id, SUM(_sum) 
FROM(SELECT deal_book._sum, deal.id 
FROM deal_book 
INNER JOIN deal 
ON deal_book.num_deal = deal.num_deal) test 
GROUP BY id 
order by SUM(_sum) DESC) try 
limit 3;

-- 8
select distinct  e.title, count(e.title) _count 
from edition e 
inner join edition_translating et 
on et.edition_id = e.edition_id 
group by title 
order by  _count DESC LIMIT 1;

-- 9
select books.title, date_deal, price 
from books 
inner join deal_book 
On books.title = deal_book.title 
inner join deal 
on deal_book.num_deal = deal.num_deal 
where id = '?';

-- 10
select id, order_book.order_id, title, _sum, order_date, _status 
from order_book 
inner join ordervbook 
On order_book.order_id=ordervbook.order_id and id='?';

-- 11
select 10*sum(weight) 
from books 
where title = '?';

-- 12
select deal.id, count(deal.num_deal), delivery_id, deal.num_deal , weight, _status, type_delivery 
from delivery, deal 
where deal.num_deal = delivery.num_deal and deal.id='?';

-- 13
select _status from delivery where delivery_id='?';

-- 14
select 10*sum(delivery.weight)+20, month(date_deal) 
from delivery, deal, delivery_type 
where delivery.num_deal=deal.num_deal and MONTH(date_deal) = '?' AND YEAR(date_deal) = '?' 
and delivery_type.name_company='Xpress';

-- 15
select SUM(payment_sum) from deal 
where payment_way = 'Bit' and MONTH(date_deal) = '?' and YEAR(date_deal) = '?';

-- 16
SELECT deal.num_deal 
FROM deal 
WHERE payment_sum > (SELECT AVG(payment_sum) FROM deal) 
AND date_deal >= DATE_ADD(CURDATE(), INTERVAL - 1 YEAR);

-- 17
select count(delivery_id), name_company 
from delivery, deal, delivery_type 
WHERE deal.date_deal>= DATE_ADD(CURDATE(), INTERVAL -12 month) and delivery.num_deal=deal.num_deal 
group by name_company;

-- 18
select delivery.delivery_id, delivery._status, delivery.weight, count(delivery_edition.delivery_id) 
from delivery 
inner join delivery_edition 
On delivery.delivery_id=delivery_edition.delivery_id 
group by delivery_edition.delivery_id 
having count(delivery_edition.delivery_id)>1;

-- 19
select distinct customer.id, first_name, last_name 
from customer, deal 
where customer.id=deal.id and deal.date_deal<= DATE_ADD(CURDATE(), INTERVAL -24 month);

-- 20
select id, _status, closed_date 
from order_book 
WHERE closed_date>= DATE_ADD(CURDATE(), INTERVAL -14 DAY) and _status='send message';

-- 21
select supplies_book._sum, year(full_date), month(full_date) 
from books, supplies, supplies_book 
where books.title=supplies_book.title and location='Storage' and supplies.supply_id=supplies_book.supply_id 
group by books.title 
order by year(full_date), month(full_date);

-- 22
select sum(_sum), sum(_sum*price_store) 
from supplies, books, supplies_book  
where supplies_book.supply_id = supplies.supply_id and books.title=supplies_book.title and full_date between '?' and '?';

-- 23
select sum(payment_sum)- sum(_sum*price_store) 
from deal,supplies, books, supplies_book 
where MONTH(date_deal) = '?' AND YEAR(date_deal) ='?'
and supplies_book.supply_id = supplies.supply_id and books.title=supplies_book.title 
and MONTH(full_date) = '?' AND YEAR(full_date) = '?';

-- 24
select AVG(payment_sum), month(date_deal) 
from deal 
where deal.date_deal >= DATE_ADD(CURDATE(), INTERVAL - 1 YEAR) 
GROUP BY MONTH(date_deal);

-- 25
select hours*50, num_worker, MONTH(month_year), YEAR(month_year) 
from worker_salary 
WHERE MONTH(month_year) = '?' AND YEAR(month_year) = '?' AND num_worker = '?';

-- 26
select worker.first_name, worker.last_name, deal.num_worker 
from deal, worker 
where MONTH(date_deal) = '?' AND YEAR(date_deal) = '?'
group by num_worker 
order by count(num_deal) desc 
limit 1;