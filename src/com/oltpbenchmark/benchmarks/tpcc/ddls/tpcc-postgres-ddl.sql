-- TODO: c_since ON UPDATE CURRENT_TIMESTAMP,

DROP TABLE IF EXISTS order_line;
CREATE TABLE order_line (
  ol_w_id int NOT NULL,
  ol_d_id int NOT NULL,
  ol_o_id int NOT NULL,
  ol_number int NOT NULL,
  ol_i_id int NOT NULL,
  ol_delivery_d timestamp,
  ol_amount float NOT NULL,
  ol_supply_w_id int NOT NULL,
  ol_quantity float NOT NULL,
  ol_dist_info char(24) NOT NULL,
  PRIMARY KEY (ol_w_id,ol_d_id,ol_o_id,ol_number)
) WITH "BACKUPS=2,ATOMICITY=TRANSACTIONAL_SNAPSHOT";
ALTER TABLE order_line LOGGING;

DROP TABLE IF EXISTS new_order;
CREATE TABLE new_order (
  no_w_id int NOT NULL,
  no_d_id int NOT NULL,
  no_o_id int NOT NULL,
  tmp int,
  PRIMARY KEY (no_w_id,no_d_id,no_o_id)
) WITH "BACKUPS=2,ATOMICITY=TRANSACTIONAL_SNAPSHOT";
ALTER TABLE new_order LOGGING;

DROP TABLE IF EXISTS stock;
CREATE TABLE stock (
  s_w_id int NOT NULL,
  s_i_id int NOT NULL,
  s_quantity float NOT NULL,
  s_ytd float NOT NULL,
  s_order_cnt int NOT NULL,
  s_remote_cnt int NOT NULL,
  s_data varchar(50) NOT NULL,
  s_dist_01 char(24) NOT NULL,
  s_dist_02 char(24) NOT NULL,
  s_dist_03 char(24) NOT NULL,
  s_dist_04 char(24) NOT NULL,
  s_dist_05 char(24) NOT NULL,
  s_dist_06 char(24) NOT NULL,
  s_dist_07 char(24) NOT NULL,
  s_dist_08 char(24) NOT NULL,
  s_dist_09 char(24) NOT NULL,
  s_dist_10 char(24) NOT NULL,
  PRIMARY KEY (s_w_id,s_i_id)
) WITH "BACKUPS=2,ATOMICITY=TRANSACTIONAL_SNAPSHOT";
ALTER TABLE stock LOGGING;

-- TODO: o_entry_d  ON UPDATE CURRENT_TIMESTAMP
DROP TABLE IF EXISTS oorder;
CREATE TABLE oorder (
  o_w_id int NOT NULL,
  o_d_id int NOT NULL,
  o_id int NOT NULL,
  o_c_id int NOT NULL,
  o_carrier_id int,
  o_ol_cnt float NOT NULL,
  o_all_local float NOT NULL,
  o_entry_d timestamp,
  PRIMARY KEY (o_w_id,o_d_id,o_id),
) WITH "BACKUPS=2,ATOMICITY=TRANSACTIONAL_SNAPSHOT";
ALTER TABLE oorder LOGGING;

DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
  c_w_id int NOT NULL,
  c_d_id int NOT NULL,
  c_id int NOT NULL,
  c_discount float NOT NULL,
  c_credit char(2) NOT NULL,
  c_last varchar(16) NOT NULL,
  c_first varchar(16) NOT NULL,
  c_credit_lim float NOT NULL,
  c_balance float NOT NULL,
  c_ytd_payment float NOT NULL,
  c_payment_cnt int NOT NULL,
  c_delivery_cnt int NOT NULL,
  c_street_1 varchar(20) NOT NULL,
  c_street_2 varchar(20) NOT NULL,
  c_city varchar(20) NOT NULL,
  c_state char(2) NOT NULL,
  c_zip char(9) NOT NULL,
  c_phone char(16) NOT NULL,
  c_since timestamp,
  c_middle char(2) NOT NULL,
  c_data varchar(500) NOT NULL,
  PRIMARY KEY (c_w_id,c_d_id,c_id)
) WITH "BACKUPS=2,ATOMICITY=TRANSACTIONAL_SNAPSHOT";
ALTER TABLE customer LOGGING;

DROP TABLE IF EXISTS district;
CREATE TABLE district (
  d_w_id int NOT NULL,
  d_id int NOT NULL,
  d_ytd float NOT NULL,
  d_tax float NOT NULL,
  d_next_o_id int NOT NULL,
  d_name varchar(10) NOT NULL,
  d_street_1 varchar(20) NOT NULL,
  d_street_2 varchar(20) NOT NULL,
  d_city varchar(20) NOT NULL,
  d_state char(2) NOT NULL,
  d_zip char(9) NOT NULL,
  PRIMARY KEY (d_w_id,d_id)
) WITH "BACKUPS=2,ATOMICITY=TRANSACTIONAL_SNAPSHOT";
ALTER TABLE district LOGGING;


DROP TABLE IF EXISTS item;
CREATE TABLE item (
  i_id int NOT NULL,
  i_name varchar(24) NOT NULL,
  i_price float NOT NULL,
  i_data varchar(50) NOT NULL,
  i_im_id int NOT NULL,
  PRIMARY KEY (i_id)
) WITH "BACKUPS=2,ATOMICITY=TRANSACTIONAL_SNAPSHOT";
ALTER TABLE item LOGGING;

DROP TABLE IF EXISTS warehouse;
CREATE TABLE warehouse (
  w_id int NOT NULL,
  w_ytd float NOT NULL,
  w_tax float NOT NULL,
  w_name varchar(10) NOT NULL,
  w_street_1 varchar(20) NOT NULL,
  w_street_2 varchar(20) NOT NULL,
  w_city varchar(20) NOT NULL,
  w_state char(2) NOT NULL,
  w_zip char(9) NOT NULL,
  PRIMARY KEY (w_id)  
) WITH "BACKUPS=2,ATOMICITY=TRANSACTIONAL_SNAPSHOT";
ALTER TABLE warehouse LOGGING;



--add constraints and indexes
CREATE INDEX idx_customer_name ON customer (c_w_id,c_d_id,c_last,c_first);
CREATE INDEX idx_order ON oorder (o_w_id,o_d_id,o_c_id,o_id);
-- tpcc-mysql create two indexes for the foreign key constraints, Is it really necessary?
-- CREATE INDEX FKEY_STOCK_2 ON STOCK (S_I_ID);
-- CREATE INDEX FKEY_ORDER_LINE_2 ON ORDER_LINE (OL_SUPPLY_W_ID,OL_I_ID);

--add 'ON DELETE CASCADE'  to clear table work correctly

