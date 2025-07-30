### f_join >>> z_review_question ###

/*
	문제 1
	모든 회원의 이름, 등급, 구매한 상품 코드, 구매일, 구매 금액(amount)을 조회하세요.
	구매 기록이 없는 회원도 모두 포함되도록 하세요.
	단, 구매일이 오래된 순으로 정렬하세요.

	문제 2
	2023년 이후 가입한 회원 중 구매 총액이 30000원 이상인 
    회원의 이름, 지역코드, 총 구매금액을 조회하세요.

	문제 3
	회원 등급별로 구매 총액 평균을 구하고,
	회원 등급(grade), 구매건수(COUNT), 구매총액합계(SUM), 구매평균(AVG)을 모두 출력하세요.
	단, 구매가 한 건도 없는 등급은 제외하세요.
*/
USE `korea_db`;

select * from `members`;
select * from `purchases`;

-- 문제1
select
	M.name '회원 이름', 
    M.grade '회원 등급', 
    P.product_code '상품 코드', 
    P.purchase_date '구매일', 
    P.amount '구매 금액'
from 
	`members` M
	left join `purchases` P
    on M.member_id = P.member_id
order by P.purchase_date;

-- 문제2
select 
	M.name '회원 이름', M.area_code '지역 코드', sum(P.amount) '총 구매금액'
from
	`members` M
    join `purchases` P
    on M.member_id = P.member_id
where
	year(M.join_date) >= 2023
group by
	M.member_id, M.name, M.area_code
having
	sum(P.amount) >= 30000;
    
-- 문제3
select 
	M.grade '회원 등급', 
    count(P.purchase_id) '구매 건수', 
    sum(P.amount) '구매 총액 합계', 
    avg(P.amount)'구매 평균'
from
	`members` M
    join `purchases` P
    on M.member_id = P.member_id
group by
	M.grade;