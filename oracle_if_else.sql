--creacion de Tablespace y usuarios:
SQL> conn system/12345678
Conectado.

SQL> create tablespace home logging
  2  datafile 'E:\Trabajos\Oracle\home\hometable.dbf'
  3  size 5g autoextend on next 512m maxsize 10g
  4  extent management local;

Tablespace creado.

SQL> create user oneseven
  2  identified by Cruzemg95
  3  default tablespace home temporary tablespace temp;

Usuario creado.

SQL>

SQL> grant resource to oneseven;

Concesi¾n terminada correctamente.

SQL> grant connect to oneseven;

Concesi¾n terminada correctamente.

SQL> grant datapump_imp_full_database to oneseven;

Concesi¾n terminada correctamente.

SQL> revoke unlimited tablespace from oneseven;

Revocaci¾n terminada correctamente.

SQL> alter user oneseven quota unlimited on home;

Usuario modificado.

SQL> commit;

Confirmaci¾n terminada.

SQL> conn oneseven/Cruzemg95
Conectado.
SQL>

SQL> create table clientes(
  2  idcliente number(8),
  3  nomcliente varchar2(30),
  4  apecliente varchar2(30),
  5  fecing date,
  6  estado varchar2(30),
  7  constraint PK_CLIENTE primary key (idcliente));

Tabla creada.

SQL> create table prestamo(
  2  numop int,
  3  idcliente number(8),
  4  fecpago date,
  5  cuota number(7,2),
  6  constraint PK_PRESTAMO primary key (numop),
  7  constraint FK_CLIPRE foreign key(idcliente)
  8  references clientes(idcliente));

Tabla creada.

SQL> alter table clientes modify (fecing default sysdate);

Tabla modificada.

SQL> alter table clientes add identificacion number(38);

Tabla modificada.

SQL> create unique index cli_unique_index on clientes(identificacion) tablespace home;

═ndice creado.

SQL> INSERT INTO clientes(idcliente,nomcliente,fecing,estado,identificacion)
  2  values
  3  (1,'manuel','17/11/2013','activo','1854508');

1 fila creada.

SQL> INSERT INTO clientes(idcliente,nomcliente,fecing,estado,identificacion)
  2  values
  3  (2,'newton','06/07/1995','activo','71857928');

1 fila creada.

SQL> INSERT INTO clientes(idcliente,nomcliente,fecing,estado,identificacion)
  2  values
  3  (3,'vanessa','03/08/1998','activo','74875691');

1 fila creada.

SQL> select seq_cliente.nextval from clientes;

   NEXTVAL
----------
         1
         2
         3
         4
    	 
SQL> select seq_cliente.currval from clientes;

   CURRVAL
----------
         4
         4
         4

SQL> alter sequence seq_cliente
  2  increment by 10
  3  maxvalue 10000
  4  cycle;

Secuencia modificada.

SQL> drop sequence seq_cliente;

Secuencia borrada.

SQL> create public synonym caserito for system.clientes;

Sin¾nimo creado.

SQL> select * from caserito;

 IDCLIENTE NOMCLIENTE                     APECLIENTE
---------- ------------------------------ ---------------------
FECING   ESTADO
-------- ------------------------------
         1 Manuel
17/11/14 activo

         2 Jualin
09/08/13 activo

         3 rala
17/11/13 activo
 
 IDCLIENTE NOMCLIENTE                     APECLIENTE 
---------- ------------------------------ ---------------------
FECING   ESTADO
-------- ------------------------------
         4 frio
17/06/15 activo

         5 truco
02/07/15 activo

SQL> create public synonym chochera for oneseven.clientes;

Sin¾nimo creado.

SQL> select * from chochera;

 IDCLIENTE NOMCLIENTE                     APECLIENTE
---------- ------------------------------ ----------------------
FECING   ESTADO                         IDENTIFICACION
-------- ------------------------------ --------------
         1 manuel
17/11/13 activo                                1854508

         2 newton
06/07/95 activo                               71857928

         3 vanessa
03/08/98 activo                               74875691

SQL> update clientes set identificacion = 71854508 where idcliente = 1;

1 fila actualizada.

SQL> select idcliente, nomcliente, identificacion from clientes;

 IDCLIENTE NOMCLIENTE                     IDENTIFICACION
---------- ------------------------------ --------------
         1 manuel                               71854508
         2 newton                               71857928
         3 vanessa                              74875691

-- SIEMPRE ESCRIBIR ESTA INSTRUCCION ANTES DE CUALQUIEN MODIFICACION
-- EN LA BASE DE DATOS.
-- SIRVE PARA MOSTRAR LAS EJECUCIONES REALIZADAS POR EJEMPLO:
-- -> output.putline("");
SQL> SET SERVEROUTPUT on size unlimited;
SQL> DECLARE
  2  a number(4):=100;
  3  b number(4):=200;
  4  BEGIN
  5  IF (a<b) THEN
  6  dbms_output.put_line('A menos a B');
  7  ELSE
  8  dbms_output.put_line('A mayor a B');
  9  END IF;
 10  END;
 11  /
A menos a B

Procedimiento PL/SQL terminado correctamente.

SQL> SET SERVEROUTPUT on size unlimited;
SQL> DECLARE
  2  a number(4):=100;
  3  b number(4):=200;
  4  BEGIN
  5  IF (a<b) THEN
  6  dbms_output.put_line('A menos a B');
  7  ELSIF (a>b) THEN
  8  dbms_output.put_line('A mayor a B');
  9  ELSE
 10  dbms_output.put_line('A igual a B');
 11  END IF;
 12  END;
 13  /
A menos a B

Procedimiento PL/SQL terminado correctamente.

--COMPARACIONES ENTRE 3 VARIABLES.. 

SQL> SET SERVEROUTPUT on size unlimited;
SQL> DECLARE
  2     a number(4):=100;
  3     b number(4):=200;
  4     c number(4):=100;
  5  BEGIN
  6     IF (a<b) THEN
  7             dbms_output.put_line('A menos a B');
  8     ELSIF (a>b) THEN
  9             dbms_output.put_line('A mayor a B');
 10     ELSE
 11             dbms_output.put_line('A igual a B');
 12     END IF;
 13     IF (b=c) THEN
 14             dbms_output.put_line('B igual a C');
 15     END IF;
 16             a:=a+10;
 17             dbms_output.put_line('A: ' || to_char(a));
 18             b:=b*20;
 19             dbms_output.put_line('B: ' || to_char(b));
 20             c:=a-b;
 21             dbms_output.put_line('C: ' || to_char(c));
 22  END;
 23  /
A menos a B
A: 110
B: 4000
C: -3890

Procedimiento PL/SQL terminado correctamente.

--CREANDO UN CICLICO DE NUMERON DEL 1 AL 10 (LOOP)

SQL> DECLARE
  2     n number(4):=0;
  3  BEGIN
  4     LOOP
  5             dbms_output.put_line('n: ' || to_char(n));
  6             n:=n+1;
  7             EXIT WHEN n>10;
  8     END LOOP;
  9  END;
 10  /
n: 0
n: 1
n: 2
n: 3
n: 4
n: 5
n: 6
n: 7
n: 8
n: 9
n: 10

Procedimiento PL/SQL terminado correctamente.

--USANDO FOR - LOOP

SQL> DECLARE
  2     n number(4):=0;
  3  BEGIN
  4     FOR i IN 1..10  LOOP -- DEL 1 AL 10 VECES
  5             n:=n+i;
  6             dbms_output.put_line('n: ' || to_char(n));
  7     END LOOP;
  8             dbms_output.put_line('-----------------');
  9     FOR j IN 2..2   LOOP -- DEL 2 AL 2 (SOLO SE EJECUTA UNA SOLA VEZ)
 10             n:=n+j;
 11             dbms_output.put_line('n: ' || to_char(n));
 12     END LOOP;
 13
 14             dbms_output.put_line('-----------------');
 15     FOR k IN REVERSE 1..10  LOOP -- DE RETROCESO (DEL 10 AL 1 VECES)
 16             n:=n+k;
 17             dbms_output.put_line('n: ' || to_char(n));
 18     END LOOP;
 19  END;
 20  /
n: 1
n: 3
n: 6
n: 10
n: 15
n: 21
n: 28
n: 36
n: 45
n: 55
-----------------
n: 57
-----------------
n: 67
n: 76
n: 84
n: 91
n: 97
n: 102
n: 106
n: 109
n: 111
n: 112

Procedimiento PL/SQL terminado correctamente.

--PEQUEÑO EJEMPLO
--TENIENDO EN CUENTA LA TABLAS CLIENTES Y PRESTAMO
--INGRESAS ALGUNOSDATOS Y REALIZAS LA SIGUIENTE CONSULTA
--1.- Crear un programa SQL que actualice las cuotas de los clientes
--      activos con el criterio:
-- a. antiguedad menor a 2 meses a 10%
-- b. antiguedad menor a 3 meses y mayor a 2 meses a 8%
-- c. antiguedad mayor a 3 meses a 5%
--DEBERA INGRESAR EL ID DEL CLIENTE
SQL> create table clientes( 
  2  idcliente number(8),
  3  nomcliente varchar2(30),
  4  apecliente varchar2(30),
  5  fecing date,
  6  estado varchar2(30),
  7  CONSTRAINT PK_CLIENTE primary key (idcliente));

Tabla creada.

SQL> create table prestamo(
  2  numop int,
  3  idcliente number(8),
  4  fecpago date,
  5  cuota number(7,2),
  6  CONSTRAINT PK_PRESTAMO primary key(numop),
  7  CONSTRAINT FK_CLIPRE foreign key (idcliente)
  8  REFERENCES clientes(idcliente));

Tabla creada.

SQL> INSERT INTO clientes(idcliente,nomcliente,fecing,estado)
  2  VALUES(00000001,'Manuel','17/11/2014','activo');

1 fila creada.

SQL> INSERT INTO clientes(idcliente,nomcliente,fecing,estado)
  2  VALUES(00000002,'Jualin','09/08/2013','activo');

1 fila creada.

SQL> INSERT INTO prestamo(numop,idcliente,fecpago,cuota)
  2  VALUES(1,00000001,'26/05/2015',158.25);

1 fila creada.

SQL> INSERT INTO prestamo(numop,idcliente,fecpago,cuota)
  2  VALUES(2,00000001,'26/04/2015',587.10); 

1 fila creada.


SQL> DECLARE
  2     v_id int:=&id;
  3     v_mes int;
  4  BEGIN
  5     SELECT DISTINCT round(months_between(sysdate, c.fecing)) into v_mes
  6     FROM clientes c, prestamo p
  7     WHERE c.idcliente = v_id and c.estado='activo';
  8     IF(v_mes < 2 and v_mes > 0) THEN
  9             UPDATE prestamo
 10             SET cuota=cuota-1.1
 11             WHERE idcliente=v_id;
 12     ELSIF(v_mes<3 and v_mes >0) THEN
 13             UPDATE prestamo
 14             SET cuota=cuota*1.08
 15             WHERE idcliente=v_id;
 16     ELSE
 17             UPDATE prestamo
 18             SET cuota=cuota*1.05
 19             WHERE idcliente=v_id;
 20     END IF;
 21  END;
 22  /
Introduzca un valor para id: 00000001
antiguo   2:    v_id int:=&id;
nuevo   2:      v_id int:=00000001;

Procedimiento PL/SQL terminado correctamente.

--RESULTADOS:

SQL> select * from prestamo;

     NUMOP  IDCLIENTE FECPAGO       CUOTA
---------- ---------- -------- ----------
         1          1 26/05/15     166,16 -- -> CUOTA INICIAL: 158.25
         2          1 26/04/15     616,46 -- -> CUOTA INICIAL: 587.10


SQL> DECLARE
  2     v_id int:=&id;
  3     v_idc int;
  4  BEGIN
  5     SELECT COUNT(*) into v_idc
  6     FROM clientes
  7     WHERE idcliente = v_id;
  8     IF(v_idc>0) THEN
  9             dbms_output.put_line('Cliente ya existe');
 10     ELSE
 11             BEGIN
 12                     INSERT INTO clientes(idcliente,nomcliente,apecliente,fecign,estado) 
 13                     VALUES(v_id,'&nom','&ape','&fec','&est');
 14                     dbms_output.put_line('Cliente grabado');
 15             END;
 16     END IF;
 17  END;
 18  /
Introduzca un valor para id: 00000001 --CODIGO EXISTENTE SIGUE ADMITIENDOLO
antiguo   2:    v_id int:=&id;
nuevo   2:      v_id int:=00000001;
Introduzca un valor para nom: asd --COMPROBACION DE SU ADMISION.. IF IGNORADO O ERRADO

--OTRA OPCION

SQL> DECLARE
  2     v_id int:=&id;
  3     v_idc int;
  4  BEGIN
  5     SELECT COUNT(*) into v_idc
  6     FROM clientes
  7     WHERE idcliente = v_id;
  8     IF(v_idc>0) THEN
  9             dbms_output.put_line('Cliente ya existe');
 10     ELSIF (v_idc=0) THEN
 11             INSERT INTO clientes(idcliente,nomcliente,apecliente,fecign,estado)
 12             VALUES(v_id,'&nom','&ape','&fec','&est');
 13             dbms_output.put_line('Cliente grabado');
 14     END IF;
 15  END;
 16  /
 Introduzca un valor para id: 00000001 --CODIGO EXISTENTE SIGUE ADMITIENDOLO
antiguo   2:    v_id int:=&id;
nuevo   2:      v_id int:=00000001;
Introduzca un valor para nom: --COMPROBACION DE SU ADMISION.. IF IGNORADO O ERRADO / DATOS VACIOS
Introduzca un valor para ape: --COMPROBACION DE SU ADMISION.. IF IGNORADO O ERRADO / DATOS VACIOS
Introduzca un valor para fec: --COMPROBACION DE SU ADMISION.. IF IGNORADO O ERRADO / DATOS VACIOS

--NUEVOS DATOS PARA LOS SIGUIENTES EJEMPLOS

SQL> INSERT INTO clientes(idcliente,nomcliente,fecing,estado)
  2  VALUES(00000003,'Martin','09/08/2008','activo');

1 fila creada.

SQL> INSERT INTO clientes(idcliente,nomcliente,fecing,estado)
  2  VALUES(00000004,'Benito','09/08/2002','activo');

1 fila creada.

SQL> INSERT INTO clientes(idcliente,nomcliente,fecing,estado)
  2  VALUES(00000005,'Mario','09/08/2011','activo');

1 fila creada.

SQL> INSERT INTO prestamo(numop,idcliente,fecpago,cuota)
  2  VALUES(3,00000004,'12/03/2014',758.12);

1 fila creada.

SQL> INSERT INTO prestamo(numop,idcliente,fecpago,cuota)
  2  VALUES(4,00000004,'12/04/2014',757.22);

1 fila creada.

SQL> INSERT INTO prestamo(numop,idcliente,fecpago,cuota)
  2  VALUES(5,00000004,'12/05/2014',758.80);

1 fila creada.

SQL> INSERT INTO prestamo(numop,idcliente,fecpago,cuota)
  2  VALUES(6,00000005,'12/12/2014',1548.36);

1 fila creada.


SQL> SELECT * FROM CLIENTES;

     IDCLIENTE NOMCLIENTE     APECLIENTE    FECING    ESTADO
    ---------- -------------- ----------    --------  -----------------
             1 Manuel                       17/11/14 activo
             2 Jualin                       09/08/13 activo
             3 Martin                       09/08/08 activo
             4 Benito                       09/08/02 activo
             5 Mario                        09/08/11 activo
    
SQL> SELECT * FROM PRESTAMO;

     NUMOP  IDCLIENTE FECPAGO       CUOTA
---------- ---------- -------- ----------
         1          1 26/05/15     166,16
         2          1 26/04/15     616,46
         3          4 12/03/14     758,12
         4          4 12/04/14     757,22
         5          4 12/05/14      758,8
         6          5 12/12/14    1548,36

6 filas seleccionadas.

--ELIMINA LOS CLIENTES CON ANTIGUEDAD MAYORES A 5 AÑOS (CAMBIAR ESTADO A INACTIVO)
--INGRESE EL ID DEL CLIENTE


SQL> DECLARE
  2     v_id int:=&id;
  3     ant int;
  4  BEGIN
  5     SELECT round(months_between(sysdate, fecing)/12) into ant
  6     FROM clientes
  7     WHERE idcliente = v_id and estado='activo';
  8     IF(ant > 5 ) THEN
  9             UPDATE clientes
 10             SET estado='inactivo'
 11             WHERE idcliente=v_id;
 12             dbms_output.put_line('El Cliente Eliminado');
 13     ELSE
 14             dbms_output.put_line('El Cliente no tiene mas de 5 años');
 15     END IF;
 16  END;
 17  /
 
 --EJEMPLO CON UN CLIENTE MENOR A 5 AÑOS : 17/11/2014

Introduzca un valor para id: 00000001
antiguo   2:    v_id int:=&id;
nuevo   2:    v_id int:=00000001;
El Cliente no tiene mas de 5 años

Procedimiento PL/SQL terminado correctamente.

--EJEMPLO CON UN CLIENTE MAYOR A 5 AÑOS: 09/08/08

Introduzca un valor para id: 00000003
antiguo   2:    v_id int:=&id;
nuevo   2:    v_id int:=00000003;
El Cliente Eliminado

Procedimiento PL/SQL terminado correctamente.

SQL> select * from clientes;

IDCLIENTE   NOMCLIENTE   APECLIENTE FECING   ESTADO 
---------- ------------- ---------- -------- ---------
         1 Manuel                   17/11/14 activo 
         2 Jualin                   09/08/13 activo 
         3 Martin                   09/08/08 inactivo 
         4 Benito                   09/08/02 activo
         5 Mario                    09/08/11 activo
         
--ELIMINA LOS CLIENTES CON ANTIGUEDAD MAYORES A 5 AÑOS (ELIMINADO PERMANENTE)
--INGRESE EL ID DEL CLIENTE

SQL> DECLARE
  2     v_id int:=&id;
  3     ant int;
  4  BEGIN
  5     SELECT round(months_between(sysdate, fecing)/12) into ant
  6     FROM clientes
  7     WHERE idcliente = v_id ;
  8     IF(ant > 5 ) THEN
  9             DELETE FROM prestamo where idcliente = v_id;
 10             DELETE FROM clientes where idcliente = v_id;
 11             dbms_output.put_line('El Cliente Eliminado');
 12     ELSE
 13             dbms_output.put_line('El Cliente no tiene mas de 5 años');
 14     END IF;
 15  END;
 16  /
 
 --ELIMINA LOS CLIENTES CUYA FECHA DE INGRESO NO SEA MAYORES A 2 AÑOS (ELIMINADO PERMANENTE)
--INGRESE EL ID DEL CLIENTE

SQL> DECLARE
  2     v_id int:=&id;
  3     ant int;
  4  BEGIN
  5     SELECT round(months_between(sysdate, fecing)/12) into ant
  6     FROM clientes
  7     WHERE idcliente = v_id ;
  8     IF(ant < 2 ) THEN
  9             DELETE FROM prestamo where idcliente = v_id;
 10             DELETE FROM clientes where idcliente = v_id;
 11             dbms_output.put_line('El Cliente Eliminado');
 12     ELSE
 13             dbms_output.put_line('El Cliente menos de 2 años');
 14     END IF;
 15  END;
 16  /
 
 --MOSTRAR LA CANTIDAD DE CLIENTES QUE NO HAN SOLICITADO UN PRESTAMO
 --UTILIZAR ESTRUCTURA REPETITIVA 
 --MANERA 1: (SOLO VALIDO PARA ID CORRELATIVOS) => 1,2,3,4,...,n
 
SQL> DECLARE
  2    total int; c int;
  3     npre int:=0;
  4  BEGIN
  5     SELECT count(*) into total
  6     FROM clientes;
  7     FOR i IN 1..total LOOP
  8         SELECT count(*) into c
  9         FROM prestamo
 10         WHERE idcliente=i;
 11         IF (c = 0) THEN
 12             npre:=npre+1;
 13         END IF;
 14     END LOOP;
 15         dbms_output.put_line('Total: '||to_char(npre));
 16  END;
 17  /
Total: 2

Procedimiento PL/SQL terminado correctamente.

 --MANERA 1: (PARA CUALQUIER ORDEN DEL ID) => 12,3,7,1,32,...,n
 
SQL> DECLARE
  2      temp int; total int:=0; aux int;
  3      CURSOR cursorId IS SELECT idcliente FROM clientes;
  4  BEGIN
  5      OPEN cursorId;
  6          LOOP
  7              FETCH cursorId INTO aux;
  8                  SELECT count(*) INTO temp
  9                  FROM prestamo
 10                  WHERE idcliente=aux;
 11                  IF (temp=0) THEN
 12                      total:=total+1;
 13                  END IF;
 14              EXIT WHEN cursorId%NOTFOUND;
 15          END LOOP;
 16          dbms_output.put_line('Total: '||to_char(total));
 17      CLOSE cursorId;
 18  END;
 19  /
Total: 2

Procedimiento PL/SQL terminado correctamente.

--MOSTRAR EL CLIENTE MAS Y MENOS ANTIGUO (ERROR CUANDO 2 CLIENTES TIENEN LA MISMA FECHA)


SQL> DECLARE
  2      antiguo varchar2(30);
  3      reciente varchar2(30);
  4  BEGIN
  5      SELECT nomcliente || ' ' || apecliente INTO antiguo
  6      FROM clientes
  7      WHERE fecing=(select max(fecing) FROM clientes);
  8      dbms_output.put_line('Reciente: '||reciente);
  9      SELECT nomcliente || ' ' || apecliente INTO reciente
 10      FROM clientes
 11      WHERE fecing=(SELECT min(fecing) FROM clientes);
 12      dbms_output.put_line('Antiguo: '||antiguo);
 13  END;
 14  /
Reciente: Manuel
Antiguo: Benito

Procedimiento PL/SQL terminado correctamente.

SQL> create table personal(
  2  id number(4),
  3  apellidos varchar2(25),
  4  nombres varchar2(25),
  5  domicilio varchar2(30),
  6  correo varchar2(25),
  7  edad number(2),
  8  estado char(1),
  9  cargo varchar2(25),
 10  CONSTRAINT PK_PER PRIMARY KEY (id));
 
Tabla creada. 

SQL> create table oficina(
  2  codigo number(4),
  3  nombre varchar2(20),
  4  local varchar2(25),
  5  estado char(1),
  6  id number(4),
  7  CONSTRAINT PK_OFI PRIMARY KEY (codigo),
  8  CONSTRAINT FK_PER_OFI FOREIGN KEY (id)
  9  REFERENCES personal(id)
 10  ON DELETE SET NULL);

Tabla creada.

SQL> INSERT INTO personal(id,apellidos,nombres,edad,estado)
  2  VALUES
  3  (1,'Guarniz','Manuel',20,'A');

1 fila creada.

SQL> INSERT INTO personal(id,apellidos,nombres,edad,estado)
  2  VALUES
  3  (2,'Jobian','Lucho',24,'A');

1 fila creada.

SQL> INSERT INTO personal(id,apellidos,nombres,edad,estado)
  2  VALUES
  3  (3,'Vargas','Axel',31,'I');

1 fila creada.

SQL> INSERT INTO personal(id,apellidos,nombres,edad,estado)
  2  VALUES
  3  (4,'Martel','Luis',18,'I');

1 fila creada.

SQL> INSERT INTO personal(id,apellidos,nombres,edad,estado)
  2  VALUES
  3  (5,'Silen','Invano',21,'A');

1 fila creada.


SQL> SELECT id,apellidos,nombres,edad,estado FROM personal;

        ID APELLIDOS                 NOMBRES                         EDAD E
---------- ------------------------- ------------------------- ---------- -
         1 Guarniz                   Manuel                            20 A
         2 Jobian                    Lucho                             24 A
         3 Vargas                    Axel                              31 I
         4 Martel                    Luis                              18 I
         5 Silen                     Invano                            21 A
         

SQL> INSERT INTO oficina(codigo,nombre,local,estado,id)
  2  VALUES (1,'recursos','principal','A',1);

1 fila creada.

SQL> INSERT INTO oficina(codigo,nombre,local,estado,id)
  2  VALUES (2,'patrimonio','sucursal','A',2);

1 fila creada.

SQL> INSERT INTO oficina(codigo,nombre,local,estado,id)
  2  VALUES (3,'direccion','principal','A',3);

1 fila creada.

SQL> INSERT INTO oficina(codigo,nombre,local,estado,id)
  2  VALUES (4,'patrimonio','sucursal','A',4);

1 fila creada.


SQL> SELECT codigo,nombre,local,estado,id FROM oficina;

    CODIGO NOMBRE               LOCAL                     E         ID
---------- -------------------- ------------------------- - ----------
         1 recursos             principal                 A          1
         2 patrimonio           sucursal                  A          2
         3 direccion            principal                 A          3
         4 patrimonio           sucursal                  A          4

--MOSTRAR TODO LOS PERSONAL DE LA OFICINA DEL LOCAL "PRINCIPAL"
 

SQL> DECLARE
  2      pers varchar2(60); temp int; v int:=0;
  3      CURSOR abc IS SELECT id FROM personal;
  4  BEGIN
  5      OPEN abc;
  6      LOOP
  7          FETCH abc INTO temp;
  8              SELECT count(v) into v
  9              FROM personal p join oficina o ON (p.id=o.id)
 10              WHERE p.id=temp AND o.local = 'principal';
 11              IF (v = 1) THEN
 12                  SELECT p.apellidos || ' ' || p.nombres into pers
 13                  FROM personal p join oficina o ON (p.id=o.id)
 14                  WHERE p.id=temp AND o.local='principal';
 15                  dbms_output.put_line(pers);
 16              END IF;
 17          EXIT WHEN abc%NOTFOUND;
 18      END LOOP;
 19      CLOSE abc;
 20  END;
 21  /
Guarniz Manuel
Vargas Axel

Procedimiento PL/SQL terminado correctamente.

--ACTUALIZAR A TODO EL PERSONAL AL ESTADO "A"

SQL> DECLARE
  2      pers varchar2(21); temp int;
  3      CURSOR abc IS SELECT id FROM personal;
  4  BEGIN
  5      UPDATE personal
  6      SET estado='A';
  7      OPEN abc;
  8      LOOP
  9          FETCH abc INTO temp;
 10              SELECT p.apellidos || ' ' || p.nombres || ' ' || p.estado INTO pers
 11              FROM personal p
 12              WHERE p.id=temp;
 13              dbms_output.put_line(pers);
 14          EXIT WHEN abc%NOTFOUND;
 15      END LOOP;
 16      CLOSE abc;
 17  END;
 18  /
Vargas Axel A
Martel Luis A

Procedimiento PL/SQL terminado correctamente.


SQL> SELECT id,apellidos,nombres,edad,estado FROM personal;

        ID APELLIDOS                 NOMBRES                         EDAD E
---------- ------------------------- ------------------------- ---------- -
         1 Guarniz                   Manuel                            20 A
         2 Jobian                    Lucho                             24 A
         3 Vargas                    Axel                              31 A --> MODIFICADO
         4 Martel                    Luis                              18 A --> MODIFICADO
         5 Silen                     Invano                            21 A

--BORRAR LAS OFICINAS QUE NO TIENEN PERSONAL ASIGNADO
SQL> DECLARE
  2      ofic varchar2(60); temp int;
  3      CURSOR abc IS SELECT codigo FROM oficina;
  4  BEGIN
  5      DELETE FROM oficina
  6      WHERE id is null;
  7      OPEN abc;
  8      LOOP
  9          FETCH abc INTO temp;
 10              SELECT nombre || ' ' || local INTO ofic
 11              FROM oficina
 12              WHERE codigo = temp;
 13              dbms_output.put_line(ofic || CHR(13));
 14          EXIT WHEN abc%NOTFOUND;
 15      END LOOP;
 16      CLOSE abc;
 17  END;
 18  /
recursos principal
patrimonio sucursal
direccion principal
patrimonio sucursal
patrimonio sucursal

Procedimiento PL/SQL terminado correctamente.

SQL>
 
--INSERTAR UN PERSONAL A UNA OFICINA. INGRESAR LOS DATOS MEDIANTE LA ESTRUCTURA DE CONTROL
DECLARE 
BEGIN
    INSERT INTO personal(id,apellidos,nombres,domicilio,correo,edad,estado,cargo)
    VALUES ('&idp','&ape','&nom','&dom','&cor','&eda','&est','&car');
    INSERT INTO oficina(codigo,nombre,local,estado,id)
    VALUES ('&cod','&nob','&loc','&est','&id');
END;
/

--PROCEDIMIENTOS ALMACENADOS CON LAS SIGUIENTES TABLAS

SQL> CREATE TABLE DEPT(
  2  deptno NUMBER(2) PRIMARY KEY,
  3  dname VARCHAR2(14),
  4  loc VARCHAR2(13))
  5  ;

Tabla creada.

SQL> CREATE TABLE EMP(
  2  empno NUMBER (4) PRIMARY KEY,
  3  ename VARCHAR2(10),
  4  job VARCHAR2(9),
  5  mgr NUMBER(4),
  6  hiredate DATE,
  7  sal NUMBER(7,2),
  8  comm NUMBER(7,2),
  9  deptno NUMBER(2) REFERENCES DEPT);

Tabla creada.

SQL> INSERT INTO DEPT(deptno,dname,loc)
  2  VALUES
  3  (1,'gerencia','Trujillo');

1 fila creada.

SQL> INSERT INTO DEPT(deptno,dname,loc)
  2  VALUES
  3  (2,'contabilidad','Chimbote');

1 fila creada.

SQL> INSERT INTO DEPT(deptno,dname,loc)
  2  VALUES
  3  (3,'produccion','Chiclayo');

1 fila creada.
SQL> INSERT INTO EMP(empno,ename,job,mgr,hiredate,sal,comm,deptno)
  2  VALUES
  3  (1,'Carlos','Admin',10,'10/10/15',3000,'150',1);

1 fila creada.

SQL> INSERT INTO EMP(empno,ename,job,mgr,hiredate,sal,comm,deptno)
  2  VALUES
  3  (2,'Juan','Conta',20,'10/11/14',2000,'100',1);

1 fila creada.

SQL> INSERT INTO EMP(empno,ename,job,mgr,hiredate,sal,comm,deptno)
  2  VALUES
  3  (3,'Maria','secre',20,'10/12/13',1500,'50',2);

1 fila creada.

SQL> select * from dept;

    DEPTNO DNAME          LOC
---------- -------------- -------------
         1 gerencia       Trujillo
         2 contabilidad   Chimbote
         3 produccion     Chiclayo

SQL> select * from emp;

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM      DEPTNO 
---------- ---------- --------- ---------- -------- ---------- ----------   --------- 
         1 Carlos     Admin             10 10/10/15       3000        150           1 
 
         2 Juan       Conta             20 10/11/14       2000        100           1 

         3 Maria      secre             20 10/12/13       1500         50           2 


--Procedimiento
SQL> create or replace procedure prueba IS
  2  begin
  3     dbms_output.put_line('PRUEBA');
  4  end;
  5  /

Procedimiento creado.

SQL> exec prueba;
PRUEBA

--SEGUNDA PRUEBA
SQL> CREATE OR REPLACE PROCEDURE prueba1 IS
  2  begin
  3     dbms_output.put_line('prueba'||'\n');
  4  end;
  5  /

Procedimiento creado.

SQL> exec prueba1;
prueba\n

Procedimiento PL/SQL terminado correctamente.

--TERCERA PRUEBA
SQL> CREATE OR REPLACE PROCEDURE prueba2 IS
  2  begin
  3     dbms_output.put_line('prueba');
  4     dbms_output.put_line('texto');
  5  end;
  6  /

Procedimiento creado.

SQL> exec prueba2;
prueba
texto

Procedimiento PL/SQL terminado correctamente.

--CUARTA PRUEBA

SQL> CREATE OR REPLACE PROCEDURE prueba3(var IN number) IS
  2  begin
  3     dbms_output.put_line('Variable: '|| to_char(var));
  4  end;
  5  /

Procedimiento creado.

SQL> exec prueba3(100);
Variable: 100

Procedimiento PL/SQL terminado correctamente.

--EJEMPLO 1 : INSERTAR NUEVO DEPARTAMENTO
SQL> CREATE OR REPLACE PROCEDURE grabar_departamento(
  2  codigo IN number, nombre IN varchar2, local IN varchar2) IS
  3  begin
  4     insert into dept(deptno,dname,loc)
  5     values(codigo,nombre,local);
  6  end;
  7  /

Procedimiento creado.

SQL> exec grabar_departamento(4,'sistemas','Lima');

Procedimiento PL/SQL terminado correctamente.

SQL> select * from dept;

    DEPTNO DNAME          LOC
---------- -------------- -------------
         1 gerencia       Trujillo
         2 contabilidad   Chimbote
         3 produccion     Chiclayo
         4 sistemas       Lima

--EJERCICIO 2: LISTAR MEDIANTE CURSORES
SQL> CREATE OR REPLACE PROCEDURE listar_departamentos IS
  2     CURSOR lista IS SELECT deptno, dname,loc FROM dept;
  3     registro lista%ROWTYPE;
  4  begin
  5     open lista;
  6     loop
  7             fetch lista into registro;
  8             exit when lista%NOTFOUND;
  9                     dbms_output.put_line(registro.deptno||' '||registro.dname||' '||registro.loc); 
 10     end loop;
 11     close lista;
 12  end;
 13  /

Procedimiento creado.

SQL> exec listar_departamentos;
1 gerencia Trujillo
2 contabilidad Chimbote
3 produccion Chiclayo
4 sistemas Lima

Procedimiento PL/SQL terminado correctamente.

--NUEVO EMPLEADO 
SQL> CREATE OR REPLACE PROCEDURE grabar_empleado(
  2     codigo IN number, nombre IN varchar2, cargo IN varchar2,
  3     mgre IN number, fecha IN date, sali IN number, coome IN number,
  4     codref IN number) IS
  5  begin
  6     insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
  7     values (codigo, nombre, cargo, mgre, fecha, sali, coome, codref);
  8     begin
  9         listar_empleados;
 10     end;
 11  end;
 12  /

Procedimiento creado.
 
SQL> exec grabar_empleado(4,'Manuel','Gerente','30','17/11/14',5000,170,1);
1 Carlos Admin 10 10/10/15 3000 150 1
2 Juan Conta 20 10/11/14 2000 100 1
3 Maria secre 20 10/12/13 1500 50 2
4 Manuel Gerente 30 17/11/14 5000 170 1

Procedimiento PL/SQL terminado correctamente.
 
SQL> select * from emp; 

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM      DEPTNO 
---------- ---------- --------- ---------- -------- ---------- ----------   --------- 
         1 Carlos     Admin             10 10/10/15       3000        150           1 
 
         2 Juan       Conta             20 10/11/14       2000        100           1 

         3 Maria      secre             20 10/12/13       1500         50           2 
         
         4 Manuel     Gerente           30 17/11/14       5000        170           1

--LISTAR EMPLEADOS
SQL> CREATE OR REPLACE PROCEDURE listar_empleados IS
  2     CURSOR lista IS SELECT * FROM emp;
  3     r lista%ROWTYPE;
  4  begin
  5     open lista;
  6     loop
  7             fetch lista into r;
  8             exit when lista%NOTFOUND;
  9                     dbms_output.put_line(r.empno||' '||r.ename||' '||r.job||' '||r.mgr||' '||r.hiredate||' '||r.sal||' '||r.comm||' '||r.deptno); 
 10     end loop;
 11     close lista;
 12  end;
 13  /

Procedimiento creado.

SQL> exec listar_empleados;
1 Carlos Admin 10 10/10/15 3000 150 1
2 Juan Conta 20 10/11/14 2000 100 1
3 Maria secre 20 10/12/13 1500 50 2
4 Manuel Gerente 30 17/11/14 5000 170 1

Procedimiento PL/SQL terminado correctamente.

--INGRESAR UN DEPARTAMENTO Y MOSTRAR SUS EMPLEADOS
--MI MANERA CON NOMBRE DEL DEPARTAMENTO
CREATE OR REPLACE PROCEDURE mostrar_empleadoxdep(departamento IN varchar2) IS 
    CURSOR lista IS SELECT e.ename FROM emp e join dept d on (e.deptno=d.deptno )
    where d.dname = 'departamento'; 
    r lista%ROWTYPE;
begin
    open lista;
    loop
        fetch lista into r;
        exit when lista%NOTFOUND;
            dbms_output.put_line(r.empno||' '||r.ename||' '||r.job||' '||r.mgr||' '||r.hiredate||' '||r.sal||' '||r.comm||' '||r.deptno);
    end loop;
    close lista;
end;
/
--MANERA DEL PROFESOR CON CODIGO

SQL> CREATE OR REPLACE PROCEDURE mostrar_empleadoxdep(
  2      id IN number) IS
  3      CURSOR lista IS SELECT empno, ename FROM emp where deptno = id;
  4      r lista%ROWTYPE;
  5  begin
  6      open lista;
  7      loop
  8          fetch lista into r;
  9          exit when lista%NOTFOUND;
 10              dbms_output.put_line(r.empno||' '||r.ename);
 11      end loop;
 12      close lista;
 13  end;
 14  /

Procedimiento creado.

SQL> exec  mostrar_empleadoxdep(1);
1 Carlos
2 Juan
4 Manuel

Procedimiento PL/SQL terminado correctamente.

SQL> exec  mostrar_empleadoxdep(2);
3 Maria

Procedimiento PL/SQL terminado correctamente.

CREATE TABLE empleado(
idempleado number(4),
nomempleado varchar2(30),
fechanacimiento date,
fecharegistro date,
sueldo number(5),
idproyecto number(4) references proyecto,
constraint PK_EMP primary key (idempleado));

CREATE TABLE proyecto(
idproyecto number(4),
nombre varchar2(3),
inversion number(8),
constraint PK_PRO primary key (idproyecto));


CREATE OR REPLACE PROCEDURE grabar_empleado(
    ide IN number,nome IN varchar2,fecnac IN date,fecreg IN date,sueldo IN number,idp IN number) IS
    begin
        insert into empleado (idempleado,nomempleado,fechanacimiento,fecharegistro,sueldo,idproyecto)
        values (ide,nome,fecnac,fecreg,sueldo,idp);
        commit;
        dbms_output.put_line('GRABADO');
        EXCEPTION
            WHEN dup_val_on_index THEN
            dbms_output.put_line('codigo ya existe');
            when others THEN
            dbms_output.put_line('ERROR CON ORACLE'||substr(SQLERRM,1,110));
    end;
/

CREATE OR REPLACE PROCEDURE grabar_proyecto(
    idp IN number,nomp IN varchar2,inv IN number) IS
    begin
        insert into proyecto(idproyecto,nombre,inversion)
        values (idp,nomp,inv);
        commit;
        dbms_output.put_line('GRABADO');
        EXCEPTION
            WHEN dup_val_on_index THEN
            dbms_output.put_line('codigo ya existe');
            when others THEN
            dbms_output.put_line('ERROR CON ORACLE'||substr(SQLERRM,1,110));
    end;
/

CREATE OR REPLACE PROCEDURE eliminar_proyecto(
    nomp IN varchar2) IS
    CURSOR np is select idproyecto from proyecto where nombre = nomp;
    r np%ROWTYPE;
    begin
    open np;
        loop
        fetch np into r;
        exit when np%NOTFOUND;
            delete from proyecto where idproyecto = r.idproyecto;
        end loop;
        close np;
    end;
/
CREATE OR REPLACE PROCEDURE modificar_emp_pro(
    ide IN varchar2) IS
    CURSOR curemp is select sueldo from empleado where idempleado = ide;
    r curemp%ROWTYPE;
    begin
    open curemp;
        loop
        fetch curemp into r;
        exit when curemp%NOTFOUND;
            update empleado set sueldo
        end loop;
        close curemp;
    end;
/