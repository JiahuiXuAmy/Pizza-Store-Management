Drop DATABASE pizza;
CREATE DATABASE pizza;

USE pizza;
Create database testaaa;
use testaaa;
drop table orders;

/* create rota table*/
CREATE TABLE rota (
    row_id int NOT NULL ,
    rota_id varchar(20) NOT NULL ,
    da_te date  NOT NULL ,
    shift_id varchar(20) NOT NULL ,
    staff_id varchar(20) NOT NULL ,
    CONSTRAINT rota_pk PRIMARY KEY (row_id)
    );

/* create item table*/

CREATE TABLE item (
    item_id varchar(10) NOT NULL ,
    sku varchar(20) NOT NULL ,
    item_name varchar(50) NOT NULL ,
    item_cat varchar(50) NOT NULL ,
    item_size varchar(20) NOT NULL ,
    item_price decimal(10,2) NOT NULL ,
    Constraint item_pk PRIMARY KEY (item_id));
    
    
/*Create staff table*/
CREATE TABLE staff (
    staff_id varchar(20) NOT NULL ,
    first_name varchar(50) NOT NULL ,
    last_name varchar(50) NOT NULL ,
    position varchar(100) NOT NULL ,
    hourly_rate decimal(5,2) NOT NULL ,
    PRIMARY KEY (staff_id)
);

/* add foreign key constraint*/
CREATE INDEX idx_staff_id ON staff (staff_id);
ALTER TABLE rota ADD CONSTRAINT fk_rota_staff_i FOREIGN KEY(staff_id)
REFERENCES staff (staff_id);

/* create shift table */
CREATE TABLE shift (
    shift_id varchar(20) NOT NULL ,
    day_of_week varchar(10) NOT NULL ,
    start_time time NOT NULL ,
    end_time time NOT NULL ,
    PRIMARY KEY (shift_id));

/* add foreign key constraint*/
CREATE INDEX idx_shift_id ON shift (shift_id);
ALTER TABLE rota ADD CONSTRAINT fk_rota_shift_i FOREIGN KEY(shift_id)
REFERENCES shift (shift_id);

/* create orders table*/
CREATE INDEX idx_rota_id ON rota (da_te);
CREATE TABLE orders (
    row_id int NOT NULL ,
    order_id varchar(10) NOT NULL ,
    created_at date NOT NULL ,
    item_id varchar(10) NOT NULL ,
    quantity int NOT NULL ,
    cust_id int NOT NULL ,
    delivery boolean NOT NULL ,
    add_id int NOT NULL ,
    CONSTRAINT orders_pk PRIMARY KEY (row_id),
    CONSTRAINT orders_fk FOREIGN KEY (created_at)
    REFERENCES rota (da_te))
    ENGINE=INNODB;

/* add foreign key constraint */
CREATE INDEX idx_item_id ON item (item_id);
ALTER TABLE orders ADD CONSTRAINT orders_fk2 FOREIGN KEY(item_id)
REFERENCES item (item_id);

/* create customer table*/
CREATE INDEX idx_cust_id ON orders (cust_id);
CREATE TABLE customers (
    cust_id int NOT NULL ,
    cust_firstname varchar(50) NOT NULL ,
    cust_lastname varchar(50) NOT NULL ,
    CONSTRAINT customers_pk PRIMARY KEY (cust_id),
    CONSTRAINT customers_fk FOREIGN KEY (cust_id)
    REFERENCES orders (cust_id)
    ON UPDATE CASCADE ON DELETE RESTRICT);

/* create address table */
CREATE INDEX idx_add_id ON orders (add_id);
CREATE TABLE address (
    add_id int NOT NULL ,
    delivery_address1 varchar(200) NOT NULL ,
    delivery_address2 varchar(200) NULL ,
    delivery_city varchar(50) NOT NULL ,
    delivery_zipcode varchar(20) NOT NULL ,
    CONSTRAINT address_pk PRIMARY KEY (add_id),
    CONSTRAINT address_fk FOREIGN KEY (add_id)
    REFERENCES orders (add_id)
    ON UPDATE CASCADE ON DELETE RESTRICT);


/* create ingredient table*/
CREATE TABLE ingredient (
    ing_id varchar(10) NOT NULL ,
    ing_name varchar(200) NOT NULL ,
    ing_weight int NOT NULL ,
    ing_meas varchar(20) NOT NULL ,
    ing_price decimal(5,2) NOT NULL ,
    constraint ingredient_pk PRIMARY KEY (ing_id));

/* create recipe table*/
CREATE INDEX idx_item_sku ON item (sku);
CREATE TABLE recipe (
    row_id int NOT NULL ,
    recipe_id varchar(20) NOT NULL ,
    ing_id varchar(10) NOT NULL ,
    quantity int NOT NULL ,
    Constraint recipe_pk PRIMARY KEY (row_id),
    constraint recipe_fk1 foreign key (ing_id)
    references ingredient (ing_id),
    constraint recipe_fk2 foreign key (recipe_id)
    references item (sku));

/* create inventory table*/
CREATE INDEX idx_recipe_ing ON recipe (ing_id);
CREATE TABLE inventory (
    inv_id int NOT NULL ,
    item_id varchar(10) NOT NULL ,
    quantity int NOT NULL ,
    PRIMARY KEY (inv_id),
    constraint inventory_fk foreign key(item_id)
    references recipe (ing_id));




















