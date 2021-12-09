﻿DROP TABLE COMMENTS;
DROP TABLE FILES;
DROP TABLE SERVICE;
DROP TABLE REVIEW;
DROP TABLE PAYMENT;
DROP TABLE RESERVE;
DROP TABLE ROOM;
DROP TABLE HLOGIN;
DROP TABLE ADMIN;

CREATE TABLE HLOGIN (
	HLOGIN_ID varchar2(15) PRIMARY KEY,
	PWD varchar2(15) NOT NULL,
	NAME varchar2(15) NOT NULL,
	JNUM varchar2(20) NOT NULL,
	AGE number(5),
	AREA varchar2(15),
	REGDATE date NOT NULL
	NUM number(5) default 1 NOT NULL -- 1: 정상회원, 2: 탈퇴회원
);

CREATE TABLE ADMIN (
	ADMIN_ID varchar2(15) NOT NULL,
	PWD varchar2(15) NOT NULL
);

CREATE TABLE ROOM (
	ROOM_ID	number(5) PRIMARY KEY,
	KIND varchar2(15),
	CAPACITY number(5),
	PRICE number(10),
	SRC_NAME varchar2(30)
);


CREATE TABLE RESERVE (
	RESERVE_ID	number(10) PRIMARY KEY,
	HLOGIN_ID varchar2(15) NOT NULL,
	ROOM_ID number(5) NOT NULL,
	START_DAY varchar2(30) NOT NULL,
	END_DAY varchar2(30) NOT NULL,
	STATEMENT number(1) default 1 NOT NULL, -- 1: 결제대기, 2:결제완료, 3:예약취소 
	CONSTRAINT FK_RESERVE_HLOGINID FOREIGN KEY(HLOGIN_ID) REFERENCES HLOGIN(HLOGIN_ID)
);

CREATE TABLE PAYMENT (
	PAYMENT_ID number(10) PRIMARY KEY,
	RESERVE_ID number(10) NOT NULL,
	METHOD varchar2(30) NOT NULL,
	PAYMENT number(10) NOT NULL,
	STATEMENT number(1)	NOT NULL,
	CONSTRAINT FK_PAYMENT_RESERVEID FOREIGN KEY(RESERVE_ID) REFERENCES RESERVE(RESERVE_ID)
);

CREATE TABLE REVIEW (
	REVIEW_ID number(10) PRIMARY KEY,
	ROOM_ID	number(5) NOT NULL,
	HLOGIN_ID varchar2(15) NOT NULL,
	CONTENT varchar2(4000),
	RATE number(5) NOT NULL,
	CREATED_DAY date NOT NULL,
	UPDATED_DAY date,
	CONSTRAINT FK_REVIEW_ROOMID FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID),
	CONSTRAINT FK_REVIEW_HLOGINID FOREIGN KEY(HLOGIN_ID) REFERENCES HLOGIN(HLOGIN_ID)
);

CREATE TABLE SERVICE (
	SERVICE_ID number(10) PRIMARY KEY,
	HLOGIN_ID varchar2(15) NOT NULL,
	CONTENT	varchar2(4000) NOT NULL,
	PWD	varchar2(15) NOT NULL,
	REF number(10) NOT NULL,
	LEV number(10) NOT NULL,
	STEP number(10) NOT NULL,
	CREATED_DAY date NOT NULL,
	UPDATED_DAY date,
	CONSTRAINT FK_SERVICE_HLOGINID FOREIGN KEY(HLOGIN_ID) REFERENCES HLOGIN(HLOGIN_ID)
);

CREATE TABLE COMMENTS (
	COMMENT_ID number(10) PRIMARY KEY,
	REVIEW_ID number(10) NOT NULL,
	HLOGIN_ID varchar2(15) NOT NULL,
	CONTENT	varchar2(1000) NOT NULL,
	READ number(1) default 2 NOT NULL, -- 1: 읽음 , 2: 읽지 않음
	CONSTRAINT FK_COMMENT_REVIEWID FOREIGN KEY(REVIEW_ID) REFERENCES REVIEW(REVIEW_ID),
	CONSTRAINT FK_COMMENT_HLOGINID FOREIGN KEY(HLOGIN_ID) REFERENCES HLOGIN(HLOGIN_ID)
);


CREATE TABLE FILES (
	FILE_ID NUMBER(10) PRIMARY KEY,
	REVIEW_ID number(10) NOT NULL,
	TYPE varchar2(20) NOT NULL,
	ORG_NAME varchar2(30) NOT NULL,
	SRC_NAME varchar2(30) NOT NULL,
	CONSTRAINT FK_FILE_REVIEWID FOREIGN KEY(REVIEW_ID) REFERENCES REVIEW(REVIEW_ID)
);

