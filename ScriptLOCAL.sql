SET SERVEROUTPUT ON;

SELECT * FROM EMPLEADOS;

DECLARE
    CURSOR C_EMPLEADO IS SELECT * FROM EMPLEADOS;
    ROW_EMPLEADO EMPLEADOS%ROWTYPE;
    
    
    PROCEDURE PRINT_SALARIO_EMPLEADO (
        EMPLEADO EMPLEADOS%ROWTYPE
    )
    IS
        SALARIODIARIO NUMBER(8, 2) := 0;
    BEGIN
        SALARIODIARIO := ROW_EMPLEADO.SALARIO/30;
        dbms_output.put_line('========================');
        dbms_output.put_line('Empleado: '||ROW_EMPLEADO.NOMBRE);
        dbms_output.put_line('Salario diario: '||SALARIODIARIO);
        dbms_output.put_line('Dias Trabajados: '||ROW_EMPLEADO.DIASTRABAJADOS);
        dbms_output.put_line('Salario a Paga: '||(SALARIODIARIO * ROW_EMPLEADO.DIASTRABAJADOS));
        dbms_output.put_line('========================');
    END;
BEGIN
    OPEN C_EMPLEADO;
    LOOP
        FETCH C_EMPLEADO INTO ROW_EMPLEADO;
        EXIT WHEN C_EMPLEADO%NOTFOUND;
        
        PRINT_SALARIO_EMPLEADO(ROW_EMPLEADO);
            
    END LOOP;
    CLOSE C_EMPLEADO;
END;

/* RESULTADO
========================
Empleado: Nombre empleado
Salario diario: 999.99
DiasTrabajados: 99
Salario a Pagar: (Salario diario * dias trabajados)
========================
*/

DECLARE
    TYPE CARRO IS RECORD (
        MARCA NVARCHAR2(100),
        MODELO NVARCHAR2(100),
        PUERTAS NUMBER
    );
    MAZDA CARRO;
    TOYOTA CARRO;
    
    PROCEDURE  IMPRIMIR_CARRO(
        CAR CARRO
    )
    IS
    BEGIN
        dbms_output.put_line('MARCA: ' || CAR.MARCA || ', MODELO: ' || CAR.MODELO);
    END;
BEGIN
    MAZDA.MARCA := 'MAZDA';
    MAZDA.MODELO := 'MAZDA 3';
    MAZDA.PUERTAS := 4;
    
    TOYOTA.MARCA := 'TOYOTA';
    TOYOTA.MODELO := 'PRADO';
    TOYOTA.PUERTAS := 5;
    
    IMPRIMIR_CARRO(MAZDA);
    IMPRIMIR_CARRO(TOYOTA);
END;


DECLARE
    REG_EMPLEADO EMPLEADOS%ROWTYPE;
BEGIN
    SELECT * INTO REG_EMPLEADO FROM EMPLEADOS WHERE ID = 5;
    dbms_output.put_line('NOMBRE: ' || REG_EMPLEADO.NOMBRE || ', SALARIO: $' || REG_EMPLEADO.SALARIO);
END;

DECLARE
    NOMBRE NVARCHAR2(200);
    SALARIO NUMBER;
    CURSOR C_EMPLEADO IS SELECT NOMBRE, SALARIO FROM EMPLEADOS ORDER BY NOMBRE ASC;
BEGIN
    OPEN C_EMPLEADO;
    LOOP
        FETCH C_EMPLEADO INTO NOMBRE, SALARIO;
        EXIT WHEN C_EMPLEADO%NOTFOUND;
        -- START CODE
        dbms_output.put_line('NOMBRE: ' || NOMBRE || ', SALARIO: $' || SALARIO);
        -- END CODE     
    END LOOP;
    CLOSE C_EMPLEADO;
END;
-- CURSORES IMPLICITOS

DECLARE
BEGIN
    UPDATE EMPLEADOS SET ACTUALIZADO = SYSDATE WHERE SALARIO > 1500;
    dbms_output.put_line('Filas afectadas: '||SQL%ROWCOUNT);
    IF SQL%FOUND THEN
        dbms_output.put_line('Afecto registros');
    ELSE
        dbms_output.put_line('No afecto registros');
    END IF;
    
    COMMIT;
END;

SELECT * FROM EMPLEADOS;

-- CURSORES

DECLARE
    PROMEDIO NUMBER(18, 2) := 0;
BEGIN
    FOR FILA IN ( SELECT NOMBRE, NOTA1, NOTA2, NOTA3, NOTA4 FROM NOTAS ORDER BY NOMBRE ASC) LOOP
        PROMEDIO := (FILA.NOTA1 + FILA.NOTA2 + FILA.NOTA3 + FILA.NOTA4) / 4;
        dbms_output.put_line('El alumno: '||FILA.NOMBRE||' tiene '||PROMEDIO||' de promedio.');
    END LOOP;
END;


SELECT N.*, PROPEDIO_NOTAS(NOTA1, NOTA2, NOTA3, NOTA4) AS PROMEDIO FROM NOTAS N;

CREATE OR REPLACE FUNCTION PROPEDIO_NOTAS (
    NOTA1 NUMBER,
    NOTA2 NUMBER,
    NOTA3 NUMBER,
    NOTA4 NUMBER
) RETURN NUMBER
IS
    PROMEDIO NUMBER(18, 2) := 0;
BEGIN
    PROMEDIO := (NOTA1 + NOTA2 + NOTA3 + NOTA4) / 4;
    RETURN PROMEDIO;
END;


-- ==================================
-- =========== ACTIVIDAD 5 ==========
-- ==================================

CREATE TABLE NOTAS ("NOMBRE" VARCHAR2(100), "NOTA1" NUMBER(3,0), "NOTA2"
NUMBER, "NOTA3" NUMBER, "NOTA4" NUMBER);
SET DEFINE OFF;
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Tonya
Vazquez','100','80','99','77');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Mathews
Robbins','88','56','100','89');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Walton
Vincent','77','38','50','100');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Audra
Wade','92','93','93','80');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Susanne
Moody','70','67','78','83');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Stevenson
Dickson','45','90','70','89');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Hinton
Cooper','76','80','60','78');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Hahn
Brown','70','88','73','93');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Bennett
Brady','90','95','100','99');
Insert into NOTAS (NOMBRE,NOTA1,NOTA2,NOTA3,NOTA4) values ('Mueller
Jimenez','65','70','85','96');





-- ==================================



DECLARE
	A NUMBER := 5;
	B NUMBER := 6;
	C NUMBER;
BEGIN
	MENOR_ENTRE(A, B, C);
	dbms_output.put_line('El menos es: '||C);
END;

SELECT SYSDATE FROM DUAL;


CREATE OR REPLACE PROCEDURE MENOR_ENTRE (
	X IN NUMBER,
	Y IN NUMBER,
	Z OUT NUMBER
)
IS
BEGIN
	IF X > Y THEN
		Z := X;
	ELSE
		Z := Y;
	END IF;
END MENOR_ENTRE;


CALL ACTUALIZA_FECHA_EMPLEADO();
-- DROP PROCEDURE ACTUALIZA_FECHA_EMPLEADO;
CREATE OR REPLACE PROCEDURE ACTUALIZA_FECHA_EMPLEADO
IS
BEGIN
	UPDATE EMPLEADOS SET ACTUALIZADO = SYSDATE;
END;

SELECT * FROM EMPLEADOS e ;

DECLARE
	SALARIO NUMBER := 0;

	/**
	 * Obtener Promedio
	 */
	FUNCTION OBTENER_PROMEDIO
	RETURN NUMBER
	IS
		PROMEDIO NUMBER := 0;
	BEGIN
		SELECT AVG(SALARIO) INTO PROMEDIO FROM EMPLEADOS e;
		RETURN PROMEDIO;
	END;
	-- Fin Obtener Promedio
BEGIN
	
	SALARIO := OBTENER_PROMEDIO();

	dbms_output.put_line('El salario promedio es: '||SALARIO);
END;


SELECT AVG(SALARIO) FROM EMPLEADOS e;


CREATE OR REPLACE FUNCTION EDAD_ACTUAL(
	FECHA_NACIMIENTO IN DATE
) RETURN NUMBER
IS
BEGIN
	RETURN TRUNC(
		(
			TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMMDD'))
			- TO_NUMBER(TO_CHAR(FECHA_NACIMIENTO, 'YYYYMMDD'))
		)/ 10000);
END;

SELECT EDAD_ACTUAL(DATE '1995-03-05') AS EDAD FROM DUAL;

SELECT
	TO_CHAR(SYSDATE, 'YYYYMMDD') AS HOY
	, TO_CHAR(DATE '1995-03-31', 'YYYYMMDD') AS FEC_NAC
	, TO_CHAR(SYSDATE, 'YYYYMMDD')
		- TO_CHAR(DATE '1995-03-05', 'YYYYMMDD') AS EDAD
FROM DUAL;


SELECT
	FECHANACI AS FECHA_NACIMIENTO
	, TRUNC(SYSDATE) AS HOY
	, EDAD_ACTUAL(FECHANACI) AS EDAD
FROM EMPLEADOS e
WHERE EDAD_ACTUAL(FECHANACI) >= 35;

CREATE OR REPLACE FUNCTION CALCULA_EDAD(
	FECHA_NACIMIENTO IN DATE
) RETURN NUMBER
IS
EDAD NUMBER := 0;
BEGIN
	EDAD := TO_NUMBER(TRUNC(SYSDATE) - FECHA_NACIMIENTO);
	RETURN EDAD;
END;

SELECT CALCULA_EDAD(DATE '1995-03-05') AS EDAD FROM DUAL;

SELECT TRUNC(SYSDATE) FROM DUAL;
SELECT DATE '1995-03-08' FROM DUAL;
SELECT TRUNC(SYSDATE) - (DATE '1995-03-05') FROM DUAL;

SELECT MAYOR_ENTRE(1, 2) AS MAYOR FROM DUAL;

CREATE OR REPLACE FUNCTION MAYOR_ENTRE(
	X IN NUMBER,
	Y IN NUMBER
) RETURN NUMBER
IS
BEGIN
	IF X > Y THEN
		RETURN X;
	ELSE
		RETURN Y;
	END IF;
END;



SELECT * FROM EMPLEADOS e ;

CREATE OR REPLACE FUNCTION TOTAL_EMPLEADOS
RETURN NUMBER
IS
	-- DECLARAR VARIABLES
	TOTAL NUMBER := 0;
BEGIN
	SELECT COUNT(*) INTO TOTAL
	FROM EMPLEADOS e;
	RETURN TOTAL;
END;

SELECT TOTAL_EMPLEADOS() AS TOTAL_EMPLEADOS FROM DUAL;


DECLARE
NUMERO NUMBER := 5;
FACTORIAL NUMBER := 1;
BEGIN
	<< WHILE_FACTORIAL >>
	WHILE (NUMERO > 0) LOOP
		FACTORIAL := FACTORIAL * NUMERO;
		NUMERO := NUMERO - 1;
	END LOOP WHILE_FACTORIAL;
	dbms_output.put_line(FACTORIAL);
END;


declare
 type notasArray is varray(4) of number;
 notas notasArray := notasArray(95,60,75,85);
 promedio number(6,2) := 0;
begin
 FOR I IN 1..(NOTAS.COUNT) LOOP
 	PROMEDIO := PROMEDIO + NOTAS(I);
 END LOOP;
PROMEDIO := PROMEDIO/NOTAS.COUNT;
dbms_output.put_line( PROMEDIO ); -- 78.75

end;


DECLARE
Y NUMBER := 20;
BEGIN
WHILE Y < 100 LOOP
dbms_output.put_line(Y);
Y := Y + 20;
END LOOP;
END;



DECLARE
X NUMBER := 10;
BEGIN
LOOP
dbms_output.put_line(x);
x := x + 10;
IF (X > 120) THEN
	EXIT;
END IF;
END LOOP;
END;



DECLARE
BEGIN
<< CICLO_TABLA_2 >>
FOR I IN 0..20 LOOP

	IF (MOD(I, 2) <> 0) THEN
		CONTINUE;
	END IF;
	IF (I = 6) THEN
		CONTINUE;
	END IF;
	IF (I = 14) THEN
		EXIT;
	END IF;
	dbms_output.put(I);
	dbms_output.put(' * 5 = ');
	dbms_output.put_line(I*5);
END LOOP CICLO_TABLA_2;
END;


DECLARE
SALARIO NUMBER := ROUND(DBMS_RANDOM.VALUE(600,2000));
AUMENTO NUMBER;
BEGIN
CASE
	WHEN (SALARIO <= 600) THEN
		dbms_output.put_line('Se aumento el 15%');
		AUMENTO := SALARIO * 0.15;
	WHEN (SALARIO BETWEEN 601 AND 950) THEN
		dbms_output.put_line('Se aumento el 13.5%');
		AUMENTO := SALARIO * 0.135;
	WHEN (SALARIO BETWEEN 951 AND 1400) THEN
		dbms_output.put_line('Se aumento el 10%');
		AUMENTO := SALARIO * 0.1;
	WHEN (SALARIO >= 1400) THEN
		dbms_output.put_line('Se aumento el 5%');
		AUMENTO := SALARIO * 0.05;
END CASE;
dbms_output.put_line('Salario base: ' || SALARIO);
dbms_output.put_line('Aumento: ' || AUMENTO);
dbms_output.put_line('Nuevo Salario: ' || (SALARIO + AUMENTO));
END;



-- OPERADORES
DECLARE
A NUMBER := 5;
B NUMBER := 10;
NOMBRE1 NVARCHAR2(100) := 'Fernando';
NOMBRE2 NVARCHAR2(100);
BEGIN
	
	IF (NOMBRE2 IS NULL) THEN
		dbms_output.put_line('El valor de NOMBRE2 es nulo');
	END IF;
		
	
	IF (B IN (8,9,10,11)) THEN
		dbms_output.put_line('El valor de B esta entre los valores de: 8,9,10,11');
	END IF;
		
	IF (A BETWEEN 1 AND 8) THEN
		dbms_output.put_line('El valor de A esta entre 1 y 8');
	END IF;
		
	IF (NOMBRE1 LIKE '_e%') THEN
		dbms_output.put_line('El nombre su segunda letra es E');
	END IF;
	
	IF (NOMBRE1 LIKE '%nan%') THEN
		dbms_output.put_line('El nombre contiene "nan"');
	END IF;
	
	IF (NOMBRE1 LIKE 'F%') THEN
		dbms_output.put_line('El nombre contiene F');
	END IF;

	-- >, <, <=, >=, =, <>
	IF ( A < B) THEN
		dbms_output.put_line('B es mayor que A');
	END IF;
END;

-- NUMEROS RANDOM
DECLARE
RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(0,5));
BEGIN

CASE
	WHEN RAN = 0 THEN
		dbms_output.put_line('Cero');
	WHEN RAN = 1 THEN
		dbms_output.put_line('Uno');
	WHEN RAN = 2 THEN
		dbms_output.put_line('Dos');
	WHEN RAN = 3 THEN
		dbms_output.put_line('Tres');
	WHEN RAN = 4 THEN
		dbms_output.put_line('Cuadro');
	ELSE
		dbms_output.put_line('Cinco');
END CASE;

END;


DECLARE
NOTA NUMBER := 55;
BEGIN

IF  (NOTA >= 90) THEN
dbms_output.put_line('Excelente');
ELSIF (NOTA >= 80) THEN
dbms_output.put_line('Muy bien');
ELSIF (NOTA >= 70) THEN
dbms_output.put_line('Bien');
ELSE
dbms_output.put_line('Necesita mejorar');	
END IF;
	
END;



DECLARE
NOTA NUMBER := 66;
BEGIN
	
dbms_output.put_line('Nota original: ' || NOTA);
--IF (NOTA = 69 OR NOTA = 68) THEN
IF (NOTA BETWEEN  67 AND 68) THEN
	NOTA := 70;
END IF;
	
dbms_output.put_line('Nota: ' || NOTA);

IF (NOTA >= 70) THEN
dbms_output.put_line('Aprovado');
ELSE
dbms_output.put_line('Jalo la clase');
END IF;

END;


-- PRACTICA UDEMY
DECLARE
NCAMISETAS NUMBER := 15;
MONTO NUMBER := 34.9;
SUBTOTAL NUMBER;
IMPUESTO NUMBER;
TOTAL NUMBER;
BEGIN
SUBTOTAL := NCAMISETAS * MONTO;
IMPUESTO := SUBTOTAL * 0.15;
TOTAL := SUBTOTAL + IMPUESTO;
dbms_output.put_line('Subtotal: ' || SUBTOTAL);
dbms_output.put_line('Impuesto: ' || IMPUESTO);
dbms_output.put_line('Total: ' || TOTAL);
END;


DECLARE
-- DEFINIR ARREGLOS
TYPE ALUMNOS_ARRAY IS VARRAY(5) OF NVARCHAR2(100);
TYPE NOTAS_ARRAY IS VARRAY(5) OF NUMBER;

ALUMNOS ALUMNOS_ARRAY;
NOTAS NOTAS_ARRAY;
BEGIN
	
ALUMNOS := ALUMNOS_ARRAY('Fernando','Maria','Jose','Luis','Juana');
NOTAS := NOTAS_ARRAY(18, 17, 10, 06, 19);

dbms_output.put_line(ALUMNOS(2));
dbms_output.put_line(NOTAS(2));

NOTAS(2) := 17.5;

dbms_output.put_line(NOTAS(2));

END;


DECLARE
NOMBRE NVARCHAR2(100) := ' Fernando ';
APELLIDOS NVARCHAR2(100);
HOY DATE := SYSDATE;
BEGIN
	-- funciones con textos
dbms_output.put_line('LARGO: '||LENGTH(NOMBRE));
dbms_output.put_line('NORMAL: '||NOMBRE||';');
dbms_output.put_line('TRIM: '||TRIM(NOMBRE)||';');
dbms_output.put_line('LOWER: '||LOWER(NOMBRE)||';');
dbms_output.put_line('UPPER: '||UPPER(NOMBRE)||';');
NOMBRE := TRIM(NOMBRE);
dbms_output.put_line('SUBSTR: '||SUBSTR(NOMBRE, 1, 3)||';');
dbms_output.put_line('REPLACE: '||REPLACE(NOMBRE, 'F', 'H')||';');
	-- funciones con fechas
dbms_output.put_line('Agregar mes: '||ADD_MONTHS(HOY, 1));
dbms_output.put_line('Agregar d�a: '||(HOY + 1));
dbms_output.put_line('D�a: '||TO_CHAR(HOY, 'dd'));
dbms_output.put_line('Mes: '||TO_CHAR(HOY, 'mm'));
dbms_output.put_line('A�o: '||TO_CHAR(HOY, 'yyyy'));

-- Is Null
dbms_output.put_line('NVL: '||NVL(APELLIDOS, '-'));

END;



DECLARE
CANTIDAD NUMBER;
USUARIO NVARCHAR2(100);
BEGIN
	SELECT USER INTO USUARIO FROM DUAL;
	SELECT COUNT(USER) INTO CANTIDAD FROM DUAL;
	dbms_output.put_line('Usuario: '||USUARIO);
	dbms_output.put_line('Cantidad: '||CANTIDAD);

	USUARIO := '-';
	CANTIDAD := 0;

	dbms_output.put_line('Usuario Reset: '||USUARIO);
	dbms_output.put_line('Cantidad Reset: '||CANTIDAD);

-- Simpleficado
	SELECT USER, COUNT(USER) INTO USUARIO, CANTIDAD FROM DUAL;
	dbms_output.put_line('Usuario Simple: '||USUARIO);
	dbms_output.put_line('Cantidad Simple: '||CANTIDAD);
	
END;




DECLARE
PI CONSTANT NUMBER := 3.141559;
area NUMBER;
radio NUMBER;
BEGIN
	radio := 8;
	area := PI * (radio * radio);
	dbms_output.put_line('Area: '||round(area, 2));
	dbms_output.put_line('Area: '||round(area, 3));
	dbms_output.put_line('Area: '||round(area, 4));
END;




-- imprimir en consola
DECLARE
-- Declarar variables

salario NUMBER := 4000;
nombreEmpleado NVARCHAR2(100);
activo BOOLEAN;
fecha DATE;

BEGIN
	
nombreEmpleado := 'Manuel Guarniz';
activo := TRUE;
fecha := TO_DATE('28/03/2020', 'dd/mm/yyyy');

dbms_output.put_line('Nombre: '||nombreEmpleado);
dbms_output.put_line('Salario: '||salario);
dbms_output.put_line('Fecha: '||fecha);
dbms_output.put_line('Activo: '||CASE WHEN activo THEN '1' ELSE '0' END);

END;



SELECT * FROM DUAL;

-- Crear usuario
CREATE USER mguarniz
IDENTIFIED BY 12345678;

-- Asignar Roles
GRANT CONNECT, RESOURCE, DBA TO mguarniz;

-- Asignar Session
GRANT CREATE SESSION TO mguarniz;

-- Asignar todos los privilegios
GRANT ALL PRIVILEGES TO mguarniz;

-- Asignar espacio de trabajo
GRANT UNLIMITED TABLESPACE TO mguarniz;


