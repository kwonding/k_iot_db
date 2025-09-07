### _ranking_practice ###

CREATE DATABASE IF NOT EXISTS ranking_db;
USE ranking_db;

CREATE TABLE brands (
	brand_id bigint auto_increment primary key,
    brand_name varchar(100) not null
);

CREATE TABLE products (
	product_id bigint auto_increment primary key,
    product_name varchar(100) not null,
    price int not null,
    brand_id bigint,
    foreign key (brand_id) references brands(brand_id) ON DELETE CASCADE
);

-- 브랜드 데이터
INSERT INTO brands (brand_name)
VALUES
	('삼성전자'),
	('애플'),
	('LG전자');

INSERT INTO products (product_name, price, brand_id)
VALUES
	-- 삼성 전자 제품
    ('갤럭시 S24 Ultra', 1500000, 1),
    ('갤럭시 Z Fold 5', 3000000, 1),
    ('갤럭시 Watch 6', 450000, 1),
    ('갤럭시 Buds 3 Pro', 180000, 1),
    ('갤럭시 Tab S10', 1900000, 1),
    ('갤럭시 Book 4 Pro', 3500000, 1),
    
    -- 애플 제품
    ('iPhone 15 Pro Max', 1890000, 2),
    ('iPhone 15 mini', 1300000, 2),
    ('MacBook Pro 17', 3890000, 2),
    ('AirPods Pro 3', 300000, 2),
    ('Apple Watch 3', 109000, 2),
    ('Mac Mini M2', 890000, 2),
    
    -- LG 전자 제품
    ('LG Gram 18', 2300000, 3),
    ('LG OLED TV', 5000000, 3),
    ('LG 퓨리케어 공기청전기', 850000, 3),
    ('LG 코드제로 청소기', 1100000, 3),
    ('LG 스탠바이미', 530000, 3),
    ('LG 트롬 오브제 컬렉션', 2850000, 3);
    
    SELECT * FROM brands;
    SELECT * FROM products;
    ### 브랜드별 최고가 Top 3 상품 추출 ###
    
    # 서브쿼리 #
    SELECT
		# 각 브랜드 그룹 내에서 
        ROW_NUMBER() OVER(PARTITION BY B.brand_id ORDER BY P.price desc) AS `number`,
        B.brand_id,
        B.brand_name,
        P.product_name,
        P.price
    FROM
		brands B
			JOIN products P
            ON B.brand_id = P.brand_id; # 어떤 브랜드가 어떤 상품을 보유하고 있는지 연결
            
### 전체 쿼리 ###
SELECT *
FROM (
	SELECT
		# 각 브랜드 그룹 내에서 
        ROW_NUMBER() OVER(PARTITION BY B.brand_id ORDER BY P.price desc) AS `number`,
        B.brand_id,
        B.brand_name,
        P.product_name,
        P.price
    FROM
		brands B
			JOIN products P
            ON B.brand_id = P.brand_id
) ranked_products
WHERE
	ranked_products.number <= 3
ORDER BY
	ranked_products.brand_id, ranked_products.number;
    