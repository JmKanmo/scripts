create table product (
  product_id bigint auto_increment primary key, 
  name varchar(128) not null, 
  description mediumtext not null,
  tag varchar(50),  
  price bigint,
  shipping_fee int, 
  discount int,
  static_file_uuid text, 
  created_date datetime not null,
  modified_date datetime not null,
  seller_id bigint,
  category_id bigint,
  delivery_id bigint,
  FOREIGN KEY(category_id) REFERENCES category(category_id),
  FOREIGN KEY(seller_id) REFERENCES seller(seller_id),
  FOREIGN KEY(delivery_id) REFERENCES delivery(delivery_id)
);   
 

create table category (
	category_id bigint auto_increment primary key, 
  name varchar(50) not null,
  created_date datetime not null,
  modified_date datetime not null
);

create table seller(
  seller_id bigint auto_increment primary key, 
  c_name varchar(128) not null,  
  u_name varchar(128) not null,  
  business_type varchar(10) not null, 
  address varchar(128) not null,
  email varchar(128) not null, 
  homepage varchar(128),
  call_number varchar(20) not null,
  business_number bigint not null,
  created_date datetime not null,
  modified_date datetime not null
);

create table coupon (
	coupon_id bigint auto_increment primary key,
  name varchar(128) not null,
  category_id int,
  description varchar(256) not null,
  price_limit bigint, 
  max_discount_price int, 
  discount_percent int,
  created_date datetime not null,
  modified_date datetime not null,
  expiration_date datetime not null
);

create table delivery (
  delivery_id bigint auto_increment primary key, 
  name varchar(128) not null,
  address varchar(128) not null,
  email varchar(128) not null, 
  homepage varchar(128),
  call_number varchar(20) not null,
  created_date datetime not null,
  modified_date datetime not null
);