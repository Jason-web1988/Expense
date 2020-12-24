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
	receipt varchar(255),						-- 영수증
	process_date timestamp,						-- 처리일시
	remark varchar(100)							-- 비고
);

create sequence expense_seq
	start with 01
	increment by 01
	minvalue 01;

INSERT INTO expense values(expense_seq.nextval, '2019-12-24', '식대(야근)', 8000, 7000, '승인', '2019-12-26', '영수증1.jpg', '2019-12-31 14:00', '야근식대는 7천원까지 지원됩니다.');	
INSERT INTO expense values(expense_seq.nextval, '2019-12-20', '택시비(야근)', 15000, 0, '접수', '2019-12-21', '영수증2.jpg', '2019-12-31 15:00', '택시비 지원은 1만원까지 지원됩니다.');	
INSERT INTO expense values(expense_seq.nextval, '2020-12-24', '교육비', 15000, 0, '접수', SYSDATE, '영수증3.jpg', null, null);	
	
select expense_no, use_date, name, use_price, approve_price, process_status, registration_date, receipt, process_date, remark 
from expense order by expense_no desc;

select expense_no, use_date, name, use_price, approve_price, process_status, registration_date, receipt, process_date, remark 
from expense where use_date='2019-12-24' and process_status='승인' and name='식대(야근)' order by expense_no desc;



select count(expense_no) from EXPENSE;