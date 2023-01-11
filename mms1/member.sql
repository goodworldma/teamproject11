
CREATE TABLE tbl_attach(
id NUMBER,
bno NUMBER,
uploadedFilename VARCHAR2(300) NOT NULL,
regdate DATE DEFAULT SYSDATE,
CONSTRAINT fk_attach_bno FOREIGN KEY(bno) REFERENCES tbl_board(bno) ON DELETE CASCADE,
CONSTRAINT pk_attach_id PRIMARY KEY(id)
)

CREATE SEQUENCE seq_attach_id

select * from tbl_attach where bno = 238

delete from tbl_attach



CREATE TABLE tbl_reply(
rno	NUMBER,
bno NUMBER,
id VARCHAR2(6),
pw VARCHAR2(60) NOT NULL,
reply VARCHAR2(1000) NOT NULL,
regdate DATE DEFAULT SYSDATE,
updatedate DATE DEFAULT SYSDATE,
CONSTRAINT pk_reply_rno PRIMARY KEY(rno),
CONSTRAINT fk_reply_bno FOREIGN KEY(bno) REFERENCES tbl_board(bno) 
ON DELETE CASCADE,
CONSTRAINT fk_reply_id FOREIGN KEY(id) REFERENCES tbl_member(id)
ON DELETE CASCADE
)



CREATE SEQUENCE seq_reply_rno

SELECT * FROM tbl_reply





CREATE TABLE tbl_board(
bno NUMBER,
title VARCHAR2(45) NOT NULL,
content VARCHAR2(3000) NOT NULL,
pw VARCHAR2(60) NOT NULL,
id VARCHAR2(6),
readcnt NUMBER DEFAULT 0,
regdate DATE DEFAULT SYSDATE,
updatedate DATE DEFAULT SYSDATE,
CONSTRAINT pk_board_bno PRIMARY KEY(bno),
CONSTRAINT fk_board_id FOREIGN KEY(id) REFERENCES tbl_member(id)
ON DELETE CASCADE
)

ALTER TABLE tbl_board ADD pw VARCHAR2(60) NOT NULL


SELECT MAX(bno) FROM tbl_board

SELECT NVL2(MAX(bno), MAX(bno)+1, 1) FROM tbl_board

select * from TBL_BOARD















CREATE TABLE tbl_member(
id VARCHAR2(6),
name VARCHAR2(15) NOT NULL,
birth DATE NOT NULL,
address VARCHAR2(300) NOT NULL,
pw VARCHAR2(300) NOT NULL,
email VARCHAR2(300),
grade CHAR(1) DEFAULT 'A',
CONSTRAINT pk_member_id PRIMARY KEY(id)
)

select * from tbl_member
DELETE FROM tbl_member WHERE id = 'good'