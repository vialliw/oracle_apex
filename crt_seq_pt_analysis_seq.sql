CREATE SEQUENCE LISO.PT_ANALYSIS_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 99999999999999999999
NOCACHE 
CYCLE 
ORDER
/

CREATE PUBLIC SYNONYM PT_ANALYSIS_SEQ FOR PT_ANALYSIS_SEQ;

GRANT SELECT ON PT_ANALYSIS_SEQ TO PUBLIC;
