#jmservice postgresql DB 테이블  스크립트 


#category 테이블 생성 

CREATE TABLE category (
  id              SERIAL PRIMARY KEY,
  title           VARCHAR(100) NOT NULL,
  link  VARCHAR(100) NOT NULL
);


#데이터 생성 

INSERT INTO CATEGORY(TITLE, LINK) VALUES('JmShop', 'http://localhost:8000');
INSERT INTO CATEGORY(TITLE, LINK)  VALUES('JmVideo', 'http://localhost:7000');
INSERT INTO CATEGORY(TITLE, LINK)  VALUES('JmBook', 'http://localhost:6000');
INSERT INTO CATEGORY(TITLE, LINK)  VALUES('JmDelivery', 'http://localhost:5000');

