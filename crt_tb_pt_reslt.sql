DROP TABLE pt_reslt;

CREATE TABLE pt_reslt (
id_no NUMBER(20)
, ticker_a VARCHAR2(30)
, ticker_b  VARCHAR2(30)
, period_from DATE
, period_to DATE
, ma NUMBER(3)
, preset_stop_loss NUMBER(20)
, preset_take_profit NUMBER(20)
, preset_lot_amt NUMBER(15,2)
, profit_loss_acc NUMBER(15,2)
, max_loss  NUMBER(15,2)
, max_profit  NUMBER(15,2)
, max_drawdown  NUMBER(15,2)
, profit_cnt  NUMBER(20)
, loss_cnt  NUMBER(20)
, CONSTRAINT pt_reslt_pk PRIMARY KEY (
   id_no
   , ticker_a
   , ticker_b
   , period_from
   , period_to
   , ma
   , preset_stop_loss
   , preset_take_profit
   )
);

