drop table IB_HH_PRICE;

CREATE TABLE IB_HH_PRICE
   (TICKER VARCHAR2(50),
   DATA_DATE DATE, 
	PRICE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS;
  
  CREATE UNIQUE INDEX LISO.IB_HH_PRICE_PK ON LISO.IB_HH_PRICE (TICKER, DATA_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;
  
ALTER TABLE LISO.IB_HH_PRICE ADD CONSTRAINT IB_HH_PRICE_PK PRIMARY KEY (TICKER, DATA_DATE)
  USING INDEX LISO.IB_HH_PRICE_PK  ENABLE;

  CREATE INDEX LISO.IB_HH_PRICE_I ON LISO.IB_HH_PRICE (DATA_DATE, TICKER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;

