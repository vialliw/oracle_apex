-- https://oracle-base.com/articles/9i/associative-arrays-9i
SET SERVEROUTPUT ON
DECLARE
  TYPE country_type IS RECORD (
    iso_code  VARCHAR2(5),
    name      VARCHAR2(50)
  );
  
  TYPE country_tab IS TABLE OF country_type
    INDEX BY BINARY_INTEGER;

  t_country country_tab;
BEGIN

  -- Populate lookup
  t_country(1).iso_code := 'UK';
  t_country(1).name     := 'United Kingdom';
  t_country(2).iso_code := 'US';
  t_country(2).name     := 'United States of America';
  t_country(3).iso_code := 'FR';
  t_country(3).name     := 'France';
  t_country(4).iso_code := 'DE';
  t_country(4).name     := 'Germany';
  
  -- Find country name for ISO code "DE"
  << lookup >>
  FOR i IN 1 .. 4 LOOP
    IF t_country(i).iso_code = 'DE' THEN
      DBMS_OUTPUT.PUT_LINE('ISO code "DE" = ' || t_country(i).name);
      EXIT lookup;
    END IF;
  END LOOP;

END;
/
