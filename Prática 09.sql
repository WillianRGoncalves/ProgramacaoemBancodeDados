create table Empregado(
cpf number(11) primary key,
nome varchar2(50),
dptno number(2),
salario number(7,2));

create table Departamento(
cod number(2) primary key,
nome VARCHAR2(50),
total_sal number(10,2)
);
insert into Departamento values(1, 'Vendas',0); 
insert into Departamento values(2, 'rh',0); 
insert into Departamento values(3,'adm',0);
insert into Empregado values(1,'Random Guy',1,500.00);
insert into Empregado values (2,'Filho da mae',2,600.00);
update Empregado set dptno = 3 where cpf = 1;
delete from Empregado;
update Departamento set total_sal = 0;

select * from Departamento;

create or replace trigger total_salario1
after insert or update or delete on Empregado
for each row when (NEW.dptno is not null)
  begin
  if deleting then
      update Departamento set total_sal  = total_sal - :old.salario where cod = :old.dptno;
    end if;
    if inserting then
      update Departamento set total_sal = total_sal + :new.salario where cod = :new.dptno;
    end if;
    if updating then
      if :old.salario <> :new.salario then
        update Departamento set total_sal  = total_sal - :old.salario + :new.salario where cod = :new.dptno;
      end if;
      if :old.dptno <> :new.dptno then
        update Departamento set total_sal  = total_sal - :old.salario where cod = :old.dptno;
        update Departamento set total_sal  = total_sal + :new.salario where cod = :new.dptno;
      end if;
    end if;
end;
