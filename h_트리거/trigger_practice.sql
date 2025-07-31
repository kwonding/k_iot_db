### h_트리거 >>> trigger_practice ###
/*
	문제1
	선수(players)가 삭제될 때, 
	해당 선수의 이름과 삭제 시각을 player_delete_logs 테이블에 기록하는 트리거를 생성
	>> 로그 테이블이 없으면 먼저 생성하고, 트리거명: after_player_delete

	문제2
	선수(players)의 포지션(position)이 변경될 경우
		, 이전 포지션과 변경된 포지션, 선수 이름을 player_position_logs에 기록하는 트리거를 생성
	>> 로그 테이블이 없으면 먼저 생성하고,트리거명: after_player_position_update

문제3
	선수가 추가되거나 삭제될 때마다 해당 팀의 선수 수(player_count)를 자동으로 업데이트하는 트리거 2개	
    (after_player_insert_count, after_player_delete_count)
	
    >> ※ teams 테이블에 player_count 컬럼이 이미 존재한다고 가정함
	
    ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;
*/
use `baseball_league`;
select * from `players`;
select * from `teams`;

drop table player_delete_logs;

-- 1
create table if not exists player_delete_logs (
	log_id int auto_increment primary key,
    player_name varchar(50),
    deleted_time datetime
);

drop trigger if exists after_player_delete; -- 트리거 삭제

-- 트리거 생성
delimiter $$
create trigger after_player_delete
	after delete
    on `players`
    for each row
begin
	insert into player_delete_logs(player_name, deleted_time)
    values
		(OLD.name, now()); -- players있는 컬럼명
end $$
delimiter ;


-- 2
create table if not exists player_position_logs (
	log_id int auto_increment primary key,
    player_name varchar(50),
    old_position varchar(20),
    new_position varchar(20),
    changed_time datetime
);
drop trigger if exists after_player_position_update; -- 트리거 삭제

-- 트리거 생성
delimiter $$
create trigger after_player_position_update
	after update
    on `players`
    for each row
begin
	if Old.position != New.position then
		insert into player_position_logs(player_name, old_position, new_position, changed_time)
		values
			(OLD.name, OLD.position, NEW.position, now());
	end if;
end $$
delimiter ;

select * from player_position_logs;

-- 3 선수 삭제 시 팀의 선수 수 감소 트리거
ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;

DROP TRIGGER IF EXISTS after_player_insert_count;

delimiter $$
create trigger after_player_insert_count
	after insert
    on `players`
    for each row
begin
	UPDATE teams
    SET player_count = player_count + 1
    WHERE team_id = NEW.team_id;
END $$
delimiter ;

DROP TRIGGER IF EXISTS after_player_delete_count;

delimiter $$
create trigger if not exists after_player_delete_count
	after delete
    on players
    for each row
begin
	update teams
    set player_count = player_count - 1
    where team_id = OLD.team_id;
END $$
delimiter ;