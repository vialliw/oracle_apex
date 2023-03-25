-- @C:\Users\edvw\Documents\trade\pt_analy.sql
--@ON
--SET LINESIZE 1000;
--SET TRIMSPOOL OFF;
--SET FEEDBACK ON;
--SET TIME ON;
--SPOOL C:\Intel\tmp\pt_analy.txt
BEGIN
   --pa_pt.run_back_test_set('CDNS','SNPS');
   --pa_pt.run_back_test_set('ACN','XLK');
   --pa_pt.run_back_test_set('BRK-B','VTV');
   --pa_pt.run_back_test_set('CDNS','MSFT');
   --pa_pt.run_back_test_set('ICE','IHI');
   --pa_pt.run_back_test_set('ADP','WM');
   --pa_pt.run_back_test_set('AEP','XLU');
   --pa_pt.run_back_test_set('AON','WM');
   --pa_pt.run_back_test_set('CPRT','ZTS');
   --pa_pt.run_back_test_set('CSX','NSC');
   --pa_pt.run_back_test_set('DIA','HON');
   --pa_pt.run_back_test_set('DUK','XLU');
   --pa_pt.run_back_test_set('ELV','UNH');
   --pa_pt.run_back_test_set('KLAC','SMH');
   --pa_pt.run_back_test_set('LRCX','SMH');
   --pa_pt.run_back_test_set('MDLZ','XLP');
   --pa_pt.run_back_test_set('MMC','RSG');
   pa_pt.run_back_test_set('NKE','VOT');
   --pa_pt.run_back_test_set('IFF','XLB');
   --pa_pt.run_back_test_set('DHI','ITB');
   --pa_pt.run_back_test_set('CCL','NCLH');
   --pa_pt.run_back_test_set('DPZ','MCO');
END;
/
--SPOOL OFF;
--select * from pt_analysis3;