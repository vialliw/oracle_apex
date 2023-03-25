ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
set serveroutput on size 1000000;
SPOOL C:\INTEL\TMP\import_yf_HH_price_job.txt
declare
   l_retval PLS_INTEGER;
begin
   l_retval := pa_zfcc_07.import_yf_price('A.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('A.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AAL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AAL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AAP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AAP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AAPL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AAPL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ABBV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ABBV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ABC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ABC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ABMD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ABMD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ABNB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ABNB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ABT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ABT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ACN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ACN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ADBE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ADBE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ADI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ADI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ADM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ADM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ADP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ADP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ADSK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ADSK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AEE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AEE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AEP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AEP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AES.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AES.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AFL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AFL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AIG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AIG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AIZ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AIZ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AJG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AJG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AKAM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AKAM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ALB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ALB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ALGN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ALGN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ALK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ALK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ALL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ALL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ALLE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ALLE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AMAT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AMAT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AMCR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AMCR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AMD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AMD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AME.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AME.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AMGN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AMGN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AMLP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AMLP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AMP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AMP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AMT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AMT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AMZN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AMZN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ANET.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ANET.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ANSS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ANSS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AON.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AON.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AOS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AOS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('APA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('APA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('APD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('APD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('APH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('APH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('APTV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('APTV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ARE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ARE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ARKF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ARKF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ARKG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ARKG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ARKK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ARKK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ARKQ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ARKQ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ARKX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ARKX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ASML.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ASML.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ATO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ATO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ATVI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ATVI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AVB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AVB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AVGO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AVGO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AVY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AVY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AWAY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AWAY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AWK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AWK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AXP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AXP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AZN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AZN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('AZO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('AZO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BAC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BAC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BAL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BAL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BALL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BALL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BATT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BATT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BAX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BAX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BBWI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BBWI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BBY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BBY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BCD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BCD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BDX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BDX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BEN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BEN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BIDU.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BIDU.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BIIB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BIIB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BIO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BIO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BKNG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BKNG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BKR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BKR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BLK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BLK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BMY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BMY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BRK-B.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BRK-B.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BRO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BRO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BSX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BSX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BWA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BWA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('BXP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('BXP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('C.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('C.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CAG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CAG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CAH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CAH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CANE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CANE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CARR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CARR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CAT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CAT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CBOE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CBOE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CBRE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CBRE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CCI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CCI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CCL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CCL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CDAY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CDAY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CDNS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CDNS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CDW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CDW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CEG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CEG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CFG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CFG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CHD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CHD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CHRW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CHRW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CHTR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CHTR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CIBR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CIBR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CINF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CINF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CLOU.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CLOU.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CLX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CLX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CMA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CMA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CMCSA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CMCSA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CME.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CME.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CMG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CMG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CMI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CMI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CMS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CMS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CNC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CNC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CNP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CNP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CNRG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CNRG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('COF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('COF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('COMT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('COMT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('COO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('COO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('COP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('COP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('COPX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('COPX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CORN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CORN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('COST.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('COST.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CPB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CPB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CPER.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CPER.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CPRT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CPRT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CPT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CPT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CRL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CRL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CRM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CRM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CRWD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CRWD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CSCO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CSCO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CSX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CSX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CTAS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CTAS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CTLT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CTLT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CTRA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CTRA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CTSH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CTSH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CTVA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CTVA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CTXS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CTXS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CVS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CVS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CVX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CVX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CWH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CWH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('CZR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('CZR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('D.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('D.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DAL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DAL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DBB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DBB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DDOG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DDOG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DFS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DFS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DGX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DGX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DHI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DHI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DHR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DHR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DIA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DIA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DIS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DIS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DISH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DISH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DLR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DLR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DLTR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DLTR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DOCU.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DOCU.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DOV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DOV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DOW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DOW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DPZ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DPZ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   --l_retval := pa_zfcc_07.import_yf_price('DRE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   --l_retval := pa_zfcc_07.import_yf_price('DRE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DRI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DRI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DTE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DTE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DUK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DUK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DVA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DVA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DVN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DVN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DXC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DXC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('DXCM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('DXCM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EBAY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EBAY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ECL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ECL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ED.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ED.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EFA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EFA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EFX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EFX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EIX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EIX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ELV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ELV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EMBC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EMBC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EMN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EMN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EMR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EMR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ENPH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ENPH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EOG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EOG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EPAM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EPAM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EQIX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EQIX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EQR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EQR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ES.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ES.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ESS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ESS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ETN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ETN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ETR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ETR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ETSY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ETSY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EVRG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EVRG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EWA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EWA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EWC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EWC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EWZ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EWZ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EXC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EXC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EXPD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EXPD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EXPE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EXPE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('EXR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('EXR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('F.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('F.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FANG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FANG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FAST.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FAST.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FBHS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FBHS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FCG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FCG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FCX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FCX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FDS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FDS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FDX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FDX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FFIV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FFIV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FIS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FIS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FISV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FISV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FITB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FITB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FLT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FLT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FMC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FMC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FOX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FOX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FOXA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FOXA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FRC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FRC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FRT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FRT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FTGC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FTGC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FTNT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FTNT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('FTV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('FTV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GILD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GILD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GIS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GIS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GLD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GLD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GLW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GLW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GNRC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GNRC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GOOG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GOOG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GOOGL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GOOGL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GPC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GPC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GPN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GPN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GRID.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GRID.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GRMN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GRMN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('GWW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('GWW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HAL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HAL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HAS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HAS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HBAN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HBAN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HCA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HCA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HERO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HERO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HES.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HES.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HIG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HIG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HII.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HII.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HLT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HLT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HOLX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HOLX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HON.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HON.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HPE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HPE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HPQ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HPQ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HRL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HRL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HSIC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HSIC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HST.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HST.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HSY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HSY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HUM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HUM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HWM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HWM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('HYG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('HYG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IAI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IAI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IBB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IBB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IBM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IBM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ICE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ICE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ICLN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ICLN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IDXX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IDXX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IEO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IEO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IEX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IEX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IFF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IFF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IFRA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IFRA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IHI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IHI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ILMN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ILMN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('INCY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('INCY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('INDA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('INDA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('INTC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('INTC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('INTU.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('INTU.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IPG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IPG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IQV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IQV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IRM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IRM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ISRG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ISRG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ITB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ITB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ITEQ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ITEQ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ITW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ITW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IVZ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IVZ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IYF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IYF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('IYT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('IYT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('J.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('J.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JBHT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JBHT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JCI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JCI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JETS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JETS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JKHY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JKHY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JNJ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JNJ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JNK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JNK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JNPR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JNPR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('JPM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('JPM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('K.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('K.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KDP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KDP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KEY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KEY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KEYS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KEYS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KHC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KHC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KIM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KIM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KLAC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KLAC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KMB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KMB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KMI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KMI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KMX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KMX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('KRE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('KRE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('L.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('L.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LCID.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LCID.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LCII.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LCII.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LDOS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LDOS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LEN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LEN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LHX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LHX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LIN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LIN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LIT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LIT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LKQ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LKQ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LLY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LLY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LMT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LMT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LNC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LNC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LNT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LNT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LOW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LOW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LRCX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LRCX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LULU.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LULU.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LUMN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LUMN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LUV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LUV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LVS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LVS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LYB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LYB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('LYV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('LYV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MAA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MAA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MAR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MAR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MAS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MAS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MCD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MCD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MCHP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MCHP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MCK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MCK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MCO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MCO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MDLZ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MDLZ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MDT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MDT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MELI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MELI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MET.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MET.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('META.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('META.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MGM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MGM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MHK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MHK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MJ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MJ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MKC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MKC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MKTX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MKTX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MLM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MLM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MMC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MMC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MMM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MMM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MNST.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MNST.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MOH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MOH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MOS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MOS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MPC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MPC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MPWR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MPWR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MRK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MRK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MRNA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MRNA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MRO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MRO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MRVL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MRVL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MSCI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MSCI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MSFT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MSFT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MSI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MSI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MTB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MTB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MTCH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MTCH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MTD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MTD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('MU.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('MU.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NANR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NANR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NCLH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NCLH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NDAQ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NDAQ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NDSN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NDSN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NEE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NEE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NEM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NEM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NFLX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NFLX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NKE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NKE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NLOK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NLOK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NLSN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NLSN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NOC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NOC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NOW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NOW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NRG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NRG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NSC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NSC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NTAP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NTAP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NTES.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NTES.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NTRS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NTRS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NUE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NUE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NVDA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NVDA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NVR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NVR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NWL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NWL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NWS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NWS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NWSA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NWSA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('NXPI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('NXPI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('O.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('O.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ODFL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ODFL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('OGN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('OGN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('OKE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('OKE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('OKTA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('OKTA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('OMC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('OMC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ON.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ON.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ORCL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ORCL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ORLY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ORLY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('OTIS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('OTIS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('OXY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('OXY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PALL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PALL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PANW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PANW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PARA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PARA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PAYC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PAYC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PAYX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PAYX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PBW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PBW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PCAR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PCAR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PDD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PDD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PEAK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PEAK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PEG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PEG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PENN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PENN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PEP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PEP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PFE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PFE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PFG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PFG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PGR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PGR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PHM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PHM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PKG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PKG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PKI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PKI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PLD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PLD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PLTM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PLTM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PNC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PNC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PNR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PNR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PNW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PNW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('POOL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('POOL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PPG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PPG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PPL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PPL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PRU.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PRU.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PSA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PSA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PSX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PSX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PTC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PTC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PVH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PVH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PWR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PWR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PXD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PXD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('PYPL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('PYPL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('QCLN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('QCLN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('QCOM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('QCOM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('QRVO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('QRVO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RCL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RCL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('REG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('REG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('REGN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('REGN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('REMX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('REMX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RHI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RHI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RJF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RJF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RMD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RMD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ROK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ROK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ROL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ROL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ROP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ROP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ROST.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ROST.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RSG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RSG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('RTX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('RTX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SBAC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SBAC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SBNY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SBNY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SBUX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SBUX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SCHH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SCHH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SCHW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SCHW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SEDG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SEDG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SEE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SEE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SGEN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SGEN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SHW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SHW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SIRI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SIRI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SIVB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SIVB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SJM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SJM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SLB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SLB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SLV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SLV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SLX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SLX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SMH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SMH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SMOG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SMOG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SNA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SNA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SNPS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SNPS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SOYB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SOYB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SPCX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SPCX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SPG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SPG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SPGI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SPGI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SPLK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SPLK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SPY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SPY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SRE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SRE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('STE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('STE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('STT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('STT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('STX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('STX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('STZ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('STZ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SWK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SWK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SWKS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SWKS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SYF.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SYF.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SYK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SYK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('SYY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('SYY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('T.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('T.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TAN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TAN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TAP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TAP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TDG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TDG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TDY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TDY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TEAM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TEAM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TECH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TECH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TEL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TEL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TER.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TER.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TFC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TFC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TFX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TFX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TGT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TGT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('THO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('THO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TJX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TJX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TMO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TMO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TMUS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TMUS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TPR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TPR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TRMB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TRMB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TROW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TROW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TRV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TRV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TSCO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TSCO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TSLA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TSLA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TSM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TSM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TSN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TSN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TTWO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TTWO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TWTR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TWTR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TXN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TXN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TXT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TXT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('TYL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('TYL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('UAL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('UAL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('UDR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('UDR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('UHS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('UHS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ULTA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ULTA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('UNG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('UNG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('UNH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('UNH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('UNP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('UNP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('UPS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('UPS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('URI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('URI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('USB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('USB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('USO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('USO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('V.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('V.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VBK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VBK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VBR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VBR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VDE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VDE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VFC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VFC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VHT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VHT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VICI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VICI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VLO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VLO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VMC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VMC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VNM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VNM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VNO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VNO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VOE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VOE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VOT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VOT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VRSK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VRSK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VRSN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VRSN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VRTX.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VRTX.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VTR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VTR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VTRS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VTRS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VTV.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VTV.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VUG.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VUG.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('VZ.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('VZ.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WAB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WAB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WAT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WAT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WBA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WBA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WBD.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WBD.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WDAY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WDAY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WDC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WDC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WEAT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WEAT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WEC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WEC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WELL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WELL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WFC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WFC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WGO.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WGO.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WHR.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WHR.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WMB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WMB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WMT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WMT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WPC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WPC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WRB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WRB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WRK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WRK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WST.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WST.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WTW.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WTW.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('WYNN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('WYNN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XBI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XBI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XEL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XEL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XES.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XES.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XLB.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XLB.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XLC.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XLC.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XLI.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XLI.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XLK.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XLK.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XLP.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XLP.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XLRE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XLRE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XLU.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XLU.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XLY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XLY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XME.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XME.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XOM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XOM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XPH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XPH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XRAY.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XRAY.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XRT.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XRT.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XTN.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XTN.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('XYL.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('XYL.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('YUM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('YUM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ZBH.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ZBH.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ZBRA.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ZBRA.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ZION.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ZION.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ZM.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ZM.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ZS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ZS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   l_retval := pa_zfcc_07.import_yf_price('ZTS.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR');
   l_retval := pa_zfcc_07.import_yf_price('ZTS.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD');

   DBMS_OUTPUT.PUT_LINE( 'l_retval = ' || l_retval);
end;
/
SPOOL OFF;
