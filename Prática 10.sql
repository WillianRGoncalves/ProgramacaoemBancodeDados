
-- CRIAÇÃO DO PACKAGE E PACKAGE BODY
CREATE OR REPLACE PACKAGE JOB_PACK
IS

  PROCEDURE add_job (p_jobid    IN jobs.empno%TYPE, p_jobtitle IN jobs.job%TYPE);
  PROCEDURE upd_job (p_jobid    IN jobs.empno%TYPE, p_jobtitle IN jobs.job%TYPE);
  PROCEDURE del_job (p_jobid IN jobs.empno%TYPE);
  FUNCTION q_job (p_jobid IN jobs.empno%TYPE) RETURN VARCHAR2;
  
END JOB_PACK;

create or replace PACKAGE BODY JOB_PACK
IS

  PROCEDURE add_job
  (p_jobid    IN jobs.empno%TYPE,
   p_jobtitle IN jobs.job%TYPE)
  IS
  BEGIN
  INSERT INTO jobs (empno, job)
  VALUES (p_jobid, p_jobtitle);
  END add_job;
  
  PROCEDURE upd_job
  (p_jobid    IN jobs.empno%TYPE,
   p_jobtitle IN jobs.job%TYPE)
  IS
    BEGIN
    UPDATE jobs
       SET job = p_jobtitle
     WHERE empno = p_jobid;
    IF SQL%NOTFOUND THEN
    RAISE_APPLICATION_ERROR(-20202,'No job updated.');
    END IF;
    END upd_job;
  
  PROCEDURE del_job
  (p_jobid IN jobs.empno%TYPE)
  IS
  BEGIN
  DELETE FROM jobs
   WHERE empno = p_jobid;
  IF SQL%NOTFOUND THEN
  RAISE_APPLICATION_ERROR (-20203,'No job deleted.');
  END IF;
  END del_job;
  
  FUNCTION q_job
  (p_jobid IN jobs.empno%TYPE)
  RETURN VARCHAR2
  IS
  v_jobtitle jobs.job%TYPE;
  BEGIN
  SELECT job
    INTO v_jobtitle
    FROM jobs
   WHERE empno = p_jobid;
  RETURN (v_jobtitle);
  END q_job;

END JOB_PACK;

-- Teste da procedure add_job
EXECUTE JOB_PACK.ADD_JOB(1,'CLERK');
SELECT * FROM JOBS;

--Teste da procedure upd_job
EXECUTE JOB_PACK.UPD_JOB(1,'ANALYST');
SELECT * FROM JOBS;

--Teste da procedure del_job
EXECUTE JOB_PACK.DEL_JOB(1);
SELECT * FROM JOBS;

--Teste da procedure q_job
SET SERVEROUTPUT ON
DECLARE
  BEGIN
    DBMS_OUTPUT.PUT_LINE (JOB_PACK.Q_JOB(1));
END;
/

-- Drop package
DROP PACKAGE JOB_PACK;
 