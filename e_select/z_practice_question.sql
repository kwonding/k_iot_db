### c_select 폴더 >>> z_practice_question 파일 ###

use `korea_db`;
# members, purchases 테이블 사용
select * from `members`;
select * from `purchases`;
-- 1. 모든 회원의 이름, 연락처, 회원등급을 조회하시오.
select 
	name, contact, grade
from 
	`members`;

-- 2. 'SEOUL'에 거주하는 회원의 이름과 회원등급을 조회하시오.
select
	name, grade
from
	`members`
where
	area_code = 'SEOUL';
    
-- 3. 회원등급이 'Gold' 이상인 회원의 이름과 가입일을 조회하시오.
select 
	name, join_date
from 
	`members`
where
	grade >= 'Gold';

-- 4. 2023년도에 가입한 회원의 이름과 가입일을 조회하시오.
select 
	name, join_date
from
	`members`
where
	year(join_date) = 2023;

-- 5. 100포인트 이상을 가진 회원의 이름과 포인트를 조회하시오.
select 
	name, points
from
	`members`
where
	points >= 100;

-- 6. 'Male' 성별의 회원 중에서 'Gold' 등급 이상의 회원을 조회하시오.
select * from `members`
where
	gender = 'Male' and grade >= 'Gold';
	
-- 7. 최근에 구매한 회원과 구매일을 조회하시오. (가장 최근 구매일 기준 상위 3명)
-- group by, 집계함수, order by, limit
select member_id, join_date
from `purchases`
group by
	member_id
order by
	join_date
limit 3;
	

-- 8. 회원별로 구매한 총 금액(amount의 합)을 조회하시오.
-- group by, 집계함수