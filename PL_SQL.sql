SET SERVEROUTPUT ON SIZE 1000000;

DECLARE
   TYPE numbers_t IS TABLE OF NUMBER;
   l_numbers numbers_t := numbers_t (1, 2, 8);
BEGIN
   DBMS_OUTPUT.put_line (l_numbers.COUNT);
END;
/

DECLARE
   TYPE numbers_t IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
   l_numbers numbers_t;
BEGIN
   l_numbers (1) := 100;
   l_numbers (2) := 1000;
   l_numbers (3) := 10000;
END;
/

DECLARE
   TYPE person_rt IS 
      RECORD (last_name VARCHAR2(100), hair_color VARCHAR2(100));
   l_person person_rt;
BEGIN
   l_person.last_name := 'Feuerstein';
   l_person.hair_color := 'Not Applicable';
END;
/

DECLARE 
   TYPE species_rt IS RECORD ( 
      species_name           VARCHAR2 (100), 
      habitat_type           VARCHAR2 (100), 
      surviving_population   INTEGER); 
 
   l_elephant   species_rt 
      := species_rt (species_name           => 'Elephant', 
                     surviving_population   => '10000', 
                     habitat_type           => 'Savannah'); 
BEGIN 
   DBMS_OUTPUT.put_line ('Species: ' || l_elephant.species_name); 
END;
/

DESC user_statements;
