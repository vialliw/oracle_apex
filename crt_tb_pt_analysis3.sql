--DROP TABLE pt_analysis3;

CREATE GLOBAL TEMPORARY TABLE pt_analysis3
(
  ID_NO            NUMBER(20),
  SEQ_NO           NUMBER(20),
  DATA_TIME        DATE,
  TICKER_A         VARCHAR2(30),
  TICKER_B         VARCHAR2(30),
  OPEN_A           NUMBER(20,5),
  HIGH_A           NUMBER(20,5),
  LOW_A            NUMBER(20,5),
  CLOSE_A          NUMBER(20,5),
  ADJ_CLOSE_A      NUMBER(20,5),
  VOL_A            NUMBER(20),
  OPEN_B           NUMBER(20,5),
  HIGH_B           NUMBER(20,5),
  LOW_B            NUMBER(20,5),
  CLOSE_B          NUMBER(20,5),
  ADJ_CLOSE_B      NUMBER(20,5),
  VOL_B            NUMBER(20),
  L_IDX            NUMBER,
  L_IDX_AVG        NUMBER,
  L_IDX_STDEV      NUMBER,
  Z_SCORE          NUMBER,
  SIGNAL           VARCHAR2(10),
  TX_PRICE_A       NUMBER(20,5),
  TX_VOL_A         NUMBER(20),
  TX_AMT_A         NUMBER(20,5),
  TX_PRICE_B       NUMBER(20,5),
  TX_VOL_B         NUMBER(20),
  TX_AMT_B         NUMBER(20,5),
  MTM              NUMBER(20,5),
  STS              VARCHAR2(30),
  PROFIT_LOSS      NUMBER(20,5),
  PROFIT_LOSS_ACC  NUMBER(20,5),
  CONSTRAINT pt_analysis3_pk PRIMARY KEY (id_no, seq_no)
)
ON COMMIT PRESERVE ROWS;

--DROP PUBLIC SYNONYM pt_analysis3;

CREATE PUBLIC SYNONYM pt_analysis3 FOR pt_analysis3;

--GRANT SELECT, UPDATE, DELETE, INSERT ON pt_analysis3 TO LISO_DA_RW;

--GRANT SELECT ON pt_analysis3 TO LISO_DA_R;
