--alter materialized view "LISO"."MV_CORR_RPT" refresh COMPLETE;

--BEGIN DBMS_SNAPSHOT.REFRESH( '"LISO"."MV_CORR_RPT"','F'); end;

EXEC DBMS_MVIEW.refresh('MV_CORR_RPT');
