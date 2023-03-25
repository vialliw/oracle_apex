SET SERVEROUTPUT ON SIZE 1000000;
SET TIME ON;
SPOOL c:\intel\tmp\runlog2.txt
begin
   /*pa_pt.run_back_test_set('CDNS','SNPS');
   pa_pt.run_back_test_set('RSG','WM');
   pa_pt.run_back_test_set('AON','MMC');
   pa_pt.run_back_test_set('IYT','XTN');
   pa_pt.run_back_test_set('SPY','XLY');
   pa_pt.run_back_test_set('VBR','VOE');
   pa_pt.run_back_test_set('VOE','VTV');
   pa_pt.run_back_test_set('VOT','VUG');
   pa_pt.run_back_test_set('VOT','XLY');
   pa_pt.run_back_test_set('VTV','XLI');
   pa_pt.run_back_test_set('ADI','TXN');
   pa_pt.run_back_test_set('IYF','VTV');
   pa_pt.run_back_test_set('IYF','XLI');
   pa_pt.run_back_test_set('MA','V');
   pa_pt.run_back_test_set('MSFT','XLK');
   pa_pt.run_back_test_set('SMH','XLK');
   pa_pt.run_back_test_set('SPY','VT');
   pa_pt.run_back_test_set('TMO','XLK');
   pa_pt.run_back_test_set('VUG','XLK');
   pa_pt.run_back_test_set('DHI','ITB');
   pa_pt.run_back_test_set('ACN','XLK');
   pa_pt.run_back_test_set('BRK-B','VTV');
   pa_pt.run_back_test_set('CDNS','MSFT');
   pa_pt.run_back_test_set('ICE','IHI');
   pa_pt.run_back_test_set('ADP','WM');
   pa_pt.run_back_test_set('AEP','XLU');
   pa_pt.run_back_test_set('AON','WM');
   pa_pt.run_back_test_set('CPRT','ZTS');
   pa_pt.run_back_test_set('CSX','NSC');
   pa_pt.run_back_test_set('DIA','HON');
   pa_pt.run_back_test_set('DUK','XLU');
   pa_pt.run_back_test_set('ELV','UNH');
   pa_pt.run_back_test_set('KLAC','SMH');
   pa_pt.run_back_test_set('LRCX','SMH');
   pa_pt.run_back_test_set('MDLZ','XLP');
   pa_pt.run_back_test_set('MMC','RSG');*/
   pa_pt.run_back_test_set('MSFT','SNPS');
   COMMIT;
END;
/
SPOOL OFF;
