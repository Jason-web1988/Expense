--삭제
drop table expense;
drop sequence expense_seq;

create table expense(
	expense_no	number(6) not null primary key,	-- 순번
	use_date timestamp,								--사용일
	name varchar(50),							-- 사용내역
	use_price number(30),						-- 사용금액
	approve_price number(30),					-- 승인금액
	process_status varchar(30),					-- 처리상태
	registration_date timestamp default current_date,-- 등록일
	receipt blob,						-- 영수증
	process_date timestamp,						-- 처리일시
	remark varchar(100)							-- 비고
);

create sequence expense_seq
	start with 01
	increment by 01
	minvalue 01;
	
select dbms_LOB.SUBSTR(receipt, 3000)
from expense;

INSERT INTO expense values(expense_seq.nextval, '2019-12-24', '식대(야근)', 8000, 7000, '승인', '2019-12-26', '영수증1.jpg', '2019-12-31 14:00', '야근식대는 7천원까지 지원됩니다.');	
INSERT INTO expense values(expense_seq.nextval, '2019-12-20', '택시비(야근)', 15000, 0, '접수', '2019-12-21', '영수증2.jpg', '2019-12-31 15:00', '택시비 지원은 1만원까지 지원됩니다.');	
INSERT INTO expense values(expense_seq.nextval, '2020-12-24', '교육비', 15000, 0, '접수', SYSDATE, '영수증3.jpg', null, null);	
	
select expense_no, TO_CHAR(use_date, 'yyyy-MM-dd') as use_date, name, use_price, approve_price, process_status, TO_CHAR(registration_date, 'yyyy-MM-dd') as registration_date, 
		TO_CHAR(process_date, 'yyyy-MM-dd') as process_date, remark 
		from expense order by expense_no desc;

select expense_no, TO_CHAR(use_date, 'yyyy-MM-dd') as use_date, name, use_price, approve_price, process_status, TO_CHAR(registration_date, 'yyyy-MM-dd') as registration_date, 
		receipt, TO_CHAR(process_date, 'yyyy-MM-dd') as process_date, remark 
		from expense order by expense_no desc;

select expense_no, use_date, name, use_price, approve_price, process_status, registration_date, receipt, process_date, remark 
		from expense 
		where registration_date between to_date('2020-12-24', 'YYYY-MM-DD') 
			and to_date('2020-12-24', 'YYYY-MM-DD')+0.99999  and process_status='접수' 
			and name='교육비' 
		order by expense_no desc;

-- p_name LIKE '%프린터%;

select count(expense_no) from EXPENSE;
select * from EXPENSE;
SELECT COLUMN_NAME, DATA_TYPE FROM all_tab_columns where table_name='EXPENSE'; 

commit;

UPDATE EXPENSE SET USE_DATE='2019-12-12', NAME='교육비', USE_PRICE='10000', APPROVE_PRICE= '5000', PROCESS_STATUS='승인', RECEIPT='영수증.jpg', PROCESS_DATE='2020-12-27', REMARK='테스트입니다.' WHERE EXPENSE_NO=7;

INSERT INTO expense	values(expense_seq.nextval, '2020-12-24', '택시비(야근)', 20000, null, '접수', SYSDATE, '영수증.jpg', null, null);