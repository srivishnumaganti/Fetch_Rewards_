-- Top 5 brands by receipt scanned for most recent month.
select brands.name, month(receipts.date_scanned) as max_mnth, count(brands.name) as c from Receipts
 join Receipts_list on Receipts._id=Receipts_list.receipts_id 
 join brands on brands.barcode= Receipts_list.brands_barcode
 where receipts.date_scanned >= CURRENTDATE() - interval 1 month
 group by brands._id order by c desc limit 5;
 
-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
Select 
 
 
 -- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater
 
select avg(totalspent) as average, rewardsReceiptStatus from Receipts where rewardsReceiptStatus= 'Accepted' or 'Rejected' 
group by rewardsReceiptStatus order by average limit 1;
 
 
 
 -- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
 
 
select count(purchaseditemCount) as cnt, rewardsReceiptStatus from Receipts where rewardsReceiptStatus= 'Accepted' or 'Rejected' 
group by rewardsReceiptStatus order by cnt limit 1;
 
 
--  Which brand has the most spend among users who were created within the past 6 months?

Select tab1.d, tab1.t_s,tab1.Bcode, brands.name from  ( select users.created_date as d, sum(receipts.total_spent) as t_s, 
receipts_list.brands_barcode as Bcode from receipts join users on users._id= receipts.userID 
join receipts_list on receipts_list.receipt_id=receipts._id) as tab1
join brands on brands.barcode= tab1.Bcode where tab1.d >= CURRENTDATE() - interval 6 month group by tab1.barcode 
order by tab1.t_s limit 1;
 
-- Which brand has the most transactions among users who were created within the past 6 months?

Select tab1.d, tab1.t_s,tab1.Bcode, brands.name from  ( select users.created_date as d, count(receipts.pointsAwardedDate) as t_s, 
receipts_list.brands_barcode as Bcode from receipts join users on users._id= receipts.userID 
join receipts_list on receipts_list.receipt_id=receipts._id) as tab1
join brands on brands.barcode= tab1.Bcode where tab1.d >= CURRENTDATE() - interval 6 month group by tab1.barcode 
order by tab1.t_s limit 1;


 
 