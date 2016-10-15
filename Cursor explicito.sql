--Começo de Criação da tabela emp
create table emp(
  job varchar2(50),
  ename varchar(50),
  sal number(9,2),
  deptno number(5)
);

insert into emp values('CLERK', 'SMITH', 1000,1);
insert into emp values('CLERK', 'HOMER', 1000,2);
insert into emp values('ANALYST', 'JOHN', 2000,2);
insert into emp values('CLERK', 'BART', 1500,1);
insert into emp values('SELLER', 'LISA', 800,3);

CREATE TABLE SAL_TOT(
  nome_func VARCHAR2(50),
  sal_ano NUMBER(9,2)
);

-- Exemplo de cursor explícito (1)
ACCEPT p_cargo_func PROMPT 'Digite o CARGO do funcionário'
VARIABLE g_n_ocorrencias NUMBER;
DECLARE
   v_cargo_func emp.job%TYPE := '&p_cargo_func';
   v_nome_func emp.ename%TYPE;
   v_sal_mes emp.sal%TYPE;
   v_sal_ano number(9,2);
   CURSOR sal_func_cursor IS
     SELECT ename, sal, sal * 12
     FROM emp
     WHERE job = v_cargo_func;
 BEGIN
  OPEN sal_func_cursor;
   LOOP
    FETCH sal_func_cursor INTO v_nome_func, v_sal_mes, v_sal_ano;
    EXIT WHEN sal_func_cursor%NOTFOUND;
    INSERT INTO sal_tot VALUES(v_nome_func, v_sal_ano);
  END LOOP;
  :g_n_ocorrencias := sal_func_cursor%ROWCOUNT;
  CLOSE sal_func_cursor;
END;
/
PRINT g_n_ocorrencias 

cl scr();

-- Exemplo de cursor explícito com abertura de cursor implícita
SET SERVEROUTPUT ON
DECLARE
   CURSOR emp_cursor IS
   SELECT ename, job
   FROM emp;
BEGIN
   FOR emp_record IN emp_cursor LOOP
     IF emp_record.job = 'CLERK' THEN
       DBMS_OUTPUT.PUT_LINE ('Funcionário ' || emp_record.ename || ' IS CLERK.');
     END IF;
   END LOOP; --implicit close occurs
 END ;
 /
 
-- Exemplo anterior sem a declaração do cursor
SET SERVEROUTPUT ON
BEGIN
   FOR emp_record IN (SELECT * FROM EMP) LOOP
     IF emp_record.job = 'CLERK' THEN
       DBMS_OUTPUT.PUT_LINE ('Funcionário ' || emp_record.ename || ' IS CLERK.');
     END IF;
   END LOOP; --implicit close occurs
 END ;
 /