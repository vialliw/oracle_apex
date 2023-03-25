DROP TABLE price_data CASCADE CONSTRAINTS;

CREATE TABLE price_data
(
  DATA_DATE  DATE,
  OPEN       NUMBER,
  HIGH       NUMBER,
  LOW        NUMBER,
  CLOSE      NUMBER,
  ADJ_CLOSE  NUMBER,
  VOLUME     NUMBER,
  TICKER     VARCHAR2(50)
)
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          4M
            NEXT             256K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCACHE
NOPARALLEL;

CREATE UNIQUE INDEX PRICE_DATA_PK ON price_data
(TICKER, DATA_DATE)
LOGGING
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             256K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

ALTER TABLE price_data ADD (
  CONSTRAINT PRICE_DATA_PK PRIMARY KEY (TICKER, DATA_DATE)
    USING INDEX 
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          2M
                NEXT             256K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
               ));

