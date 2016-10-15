create table cliente(
  cli_codigo number(5),
  cli_nome varchar2(50)
);

insert into cliente values(1,'Oi');
insert into cliente values(1,'B');
insert into cliente values(2,'hey');

select * from cliente;
drop table cliente;


--Exemplo de cursor implícito (1)
VARIABLE resultado VARCHAR2(30)
DECLARE
 v_cli_codigo NUMBER:=1;
BEGIN
 DELETE FROM cliente
 WHERE cli_codigo=v_cli_codigo;
 :resultado:=(SQL%ROWCOUNT ||'LINHAS APAGADAS');
END;
/
print resultado;

--Exemplo de cursor implícito (2)
VARIABLE resultado varchar2(30)
DECLARE
 v_cli_codigo NUMBER:=1;
BEGIN
 DELETE FROM cliente
 WHERE cli_codigo=v_cli_codigo;
 if SQL%FOUND then
 :resultado:=(SQL%ROWCOUNT ||'LINHAS APAGADAS');
 else
 :resultado:=('Nenhuma linha foi apagada');
 end if;
END;
/
print resultado;

