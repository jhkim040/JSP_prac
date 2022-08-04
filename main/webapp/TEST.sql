SELECT * FROM USER_TABLES;

CREATE TABLE MEMBER(
	MPK INT PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL,
	SCORE INT DEFAULT 0
);

INSERT INTO MEMBER VALUES((SELECT NVL(MAX(MPK),0)+1 FROM MEMBER),'BOB', 51);
INSERT INTO MEMBER VALUES((SELECT NVL(MAX(MPK),0)+1 FROM MEMBER),'ALICE', 78);
INSERT INTO MEMBER VALUES((SELECT NVL(MAX(MPK),0)+1 FROM MEMBER),'CAROL', 93);

SELECT * FROM MEMBER;

DROP TABLE MEMBER;