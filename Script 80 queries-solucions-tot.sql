-- Solucions: autor Oriol Boix Anfosso <orboan@gmail.com>

-- DML no funciona en linux ja que les taules 
-- han estat creades en majúscula
-- Cal afegir 
-- lower_case_table_names=1
-- a my.cnf perquè aquest script funcioni en linux

/*create database queries_mysql;
use queries_mysql;*/

/*==============================================================*/
/* Table: DEPARTAMENTOS                                         */
/*==============================================================*/

/*create table DEPARTAMENTOS (
   DEPTNO               int                  not null,
   DNAME                varchar(15)          not null,
   LOC                  varchar(10)          not null,
   constraint PK_DEPARTAMENTOS primary key nonclustered (DEPTNO)
);
*/

/*==============================================================*/
/* Table: EMPLEADOS                                             */
/*==============================================================*/
/*create table EMPLEADOS(
   EMPNO                int                  not null,
   DEPTNO               int                  null,
   ENAME                varchar(10)          not null,
   JOB                  varchar(20)          not null,
   MGR                  int                  null,
   HIREDATE             datetime             not null,
   SAL                  int                  not null,
   COMM                 int                  null,
   constraint PK_EMPLEADOS primary key nonclustered (EMPNO)
);
*/
/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
/*create index TIENE_FK on EMPLEADOS (
DEPTNO ASC
);

alter table EMPLEADOS
   add constraint FK_EMPLEADO_TIENE_DEPARTAM foreign key (DEPTNO)
      references DEPARTAMENTOS (DEPTNO);


insert into departamentos values 
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS','BOSTON');

insert into empleados (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values
(7369, 'SMITH', 'CLERK', 7902, '1980/12/17', 800, null, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981/02/20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981/02/22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981/04/02', 2975, null, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981/09/28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981/05/01', 2850, null, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981/06/09', 2450, null, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982/12/09', 3000, null, 20),
(7839, 'KING', 'PRESIDENT', null, '1981/11/17', 5000, null, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981/09/08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1983/01/12', 1100, null, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981/12/03', 950, null, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981/12/03', 3000, null, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982/01/23', 1300, null, 10);
*/

/*En todas las consultas se muestran el resultado en datos de la consulta que se deberia obtener
La consulta mysql debería de obtener la maxima similitud con el resultado propuesto  
Para la visualizacion de la columna HIREDATE usar la funcion Date_format() para obtener el resultado indicado
Para la visualizacion de la columna COMM usar la funcion ifnull() para que no aparezcan los valores null*/

/* 1. Obtener todos los datos de todos los empleados. 

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7499 ALLEN      SALESMAN        7698 20/02/81       1600        300         30
      7521 WARD       SALESMAN        7698 22/02/81       1250        500         30
      7566 JONES      MANAGER         7839 02/04/81       2975                    20
      7654 MARTIN     SALESMAN        7698 28/09/81       1250       1400         30
      7698 BLAKE      MANAGER         7839 01/05/81       2850                    30
      7782 CLARK      MANAGER         7839 09/06/81       2450                    10
      7788 SCOTT      ANALYST         7566 09/12/82       3000                    20
      7839 KING       PRESIDENT            17/11/81       5000                    10
      7844 TURNER     SALESMAN        7698 08/09/81       1500          0         30
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7902 FORD       ANALYST         7566 03/12/81       3000                    20
      7934 MILLER     CLERK           7782 23/01/82       1300                    10

14 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS;

-- amb select * no surten les columnes en l'ordre esperat segons enunciat, sino en l'ordre del create table

/* 2. Obtener todos los datos de todos los departamentos.

    DEPTNO DNAME          LOC
---------- -------------- -------------
        10 ACCOUNTING     NEW YORK
        20 RESEARCH       DALLAS
        30 SALES          CHICAGO
        40 OPERATIONS     BOSTON
        
4 filas seleccionadas.*/

select DEPTNO, DNAME, LOC from departamentos; -- o select * from departamentos;

/* 3. Obtener todos los datos de los administrativos (su trabajo es, en ingles, 'CLERK').

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7934 MILLER     CLERK           7782 23/01/82       1300                    10
4 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where JOB = 'CLERK';

/* 4. Idem, pero ordenado por el nombre.
     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7934 MILLER     CLERK           7782 23/01/82       1300                    10
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      
4 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where JOB = 'CLERK'
order by ename;

/* 5. Obten el mismo resultado de la pregunta anterior, pero ahora ordenando sólo por deptno en sentido descendente:

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      7934 MILLER     CLERK           7782 23/01/82       1300                    10
      
4 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where JOB = 'CLERK'
order by deptno DESC;

/* 6. Obten el Obten (codigo), nombre y salario de los empleados.

     EMPNO ENAME             SAL
---------- ---------- ----------
      7369 SMITH             800
      7499 ALLEN            1600
      7521 WARD             1250
      7566 JONES            2975
      7654 MARTIN           1250
      7698 BLAKE            2850
      7782 CLARK            2450
      7788 SCOTT            3000
      7839 KING             5000
      7844 TURNER           1500
      7876 ADAMS            1100
      7900 JAMES             950
      7902 FORD             3000
      7934 MILLER           1300

14 filas seleccionadas.*/

select EMPNO,ENAME,SAL 
from EMPLEADOS;

/* 7. Lista los nombres de todos los departamentos.

DNAME
--------------
ACCOUNTING
RESEARCH
SALES
OPERATIONS

4 filas seleccionadas.*/

select dname from departamentos;

/* 8. Idem, pero ordenandolos por nombre.

DNAME
--------------
ACCOUNTING
OPERATIONS
RESEARCH
SALES

4 filas seleccionadas.*/

select dname from departamentos
order by dname;


/* 9. Idem, pero ordenandolo por la ciudad (no se debe seleccionar la ciudad en el resultado).

DNAME
--------------
OPERATIONS
SALES
RESEARCH
ACCOUNTING

4 filas seleccionadas.*/

select dname from departamentos
order by loc;


/* 10. Idem, pero el resultado debe mostrarse ordenado por la ciudad en orden inverso.

DNAME
--------------
ACCOUNTING
RESEARCH
SALES
OPERATIONS

4 filas seleccionadas.*/

select dname from departamentos
order by loc desc;


/* 11. Obtener el nombre y empleo de todos los empleados, ordenado por salario.

ENAME      JOB
---------- ---------
SMITH      CLERK
JAMES      CLERK
ADAMS      CLERK
WARD       SALESMAN
MARTIN     SALESMAN
MILLER     CLERK
TURNER     SALESMAN
ALLEN      SALESMAN
CLARK      MANAGER
BLAKE      MANAGER
JONES      MANAGER
SCOTT      ANALYST
FORD       ANALYST
KING       PRESIDENT

14 filas seleccionadas.*/

select ename,job from empleados order by sal;


/* 12. Obtener el nombre y empleo de todos los empleados, ordenado primero por su trabajo y luego por su salario.

ENAME      JOB
---------- ---------
SCOTT      ANALYST
FORD       ANALYST
SMITH      CLERK
JAMES      CLERK
ADAMS      CLERK
MILLER     CLERK
CLARK      MANAGER
BLAKE      MANAGER
JONES      MANAGER
KING       PRESIDENT
WARD       SALESMAN
MARTIN     SALESMAN
TURNER     SALESMAN
ALLEN      SALESMAN

14 filas seleccionadas.*/

select ename,job from empleados order by job,sal;

/* 13. Idem, pero ordenando inversamente por empleo y normalmente por salario.

ENAME      JOB
---------- ---------
WARD       SALESMAN
MARTIN     SALESMAN
TURNER     SALESMAN
ALLEN      SALESMAN
KING       PRESIDENT
CLARK      MANAGER
BLAKE      MANAGER
JONES      MANAGER
SMITH      CLERK
JAMES      CLERK
ADAMS      CLERK
MILLER     CLERK
SCOTT      ANALYST
FORD       ANALYST

14 filas seleccionadas.*/

select ename,job from empleados order by job desc,sal;

/* 14. Obten los salarios y las comisiones de los empleados del departamento 30.

       SAL       COMM
---------- ----------
      1600        300
      1250        500
      1250       1400
      2850
      1500          0
       950

6 filas seleccionadas.*/

select sal,ifnull(comm,'') as comm from empleados where deptno = 30;

/* 15. Idem, pero ordenado por comision.

       SAL       COMM
---------- ----------
      1500          0
      1600        300
      1250        500
      1250       1400
      2850
       950

6 filas seleccionadas.*/
select sal,ifnull(comm,'') as comm from empleados
where deptno = 30
order by -comm desc;

/* 16. (a) Obten las comisiones de todos los empleados.

      COMM
----------

       300
       500

      1400




         0





14 filas seleccionadas.*/

select ifnull(comm,'') as comm from empleados;


/* 16. (b) Obten las comisiones de los empleados de forma que no se repitan.

      COMM
----------
         0
       300
       500
      1400
      
4 filas seleccionadas.*/

select DISTINCT ifnull(comm,'') as comm from empleados order by -comm desc;


/* 17. Obten el nombre de empleado y su comision SIN FILAS repetidas.

ENAME            COMM
---------- ----------
ADAMS
ALLEN             300
BLAKE
CLARK
FORD
JAMES
JONES
KING
MARTIN           1400
MILLER
SCOTT
SMITH
TURNER              0
WARD              500

14 filas seleccionadas.*/

select DISTINCT ename,ifnull(comm,'') as comm from empleados order by ename;

/* 18. Obten los nombres de los empleados y sus salarios, de forma que no se repitan filas.

ENAME             SAL
---------- ----------
ADAMS            1100
ALLEN            1600
BLAKE            2850
CLARK            2450
FORD             3000
JAMES             950
JONES            2975
KING             5000
MARTIN           1250
MILLER           1300
SCOTT            3000
SMITH             800
TURNER           1500
WARD             1250

14 filas seleccionadas.*/

select DISTINCT ename,sal from empleados order by ename;

/* 19. Obten las comisiones de los empleados y sus Obtens de departamento, de forma que no serepitan filas.

COMMISSION     DEPTNO
---------- ----------
                   10
                   20
                   30
         0         30
       300         30
       500         30
      1400         30

7 filas seleccionadas.*/

select distinct ifnull(comm,'') as commission, deptno from empleados order by comm;


/* 20. Obten los nuevos salarios de los empleados del departamento 30, que resultar³an 
de sumar a su salario una gratificacion de 1000. Muestra tambien los nombres de los empleados.

ENAME        SAL+1000
---------- ----------
ALLEN            2600
WARD             2250
MARTIN           2250
BLAKE            3850
TURNER           2500
JAMES            1950

6 filas seleccionadas.*/

select ename, sal+1000 from empleados
where deptno = 30;

/* 21. Lo mismo que la anterior, pero mostrando tambien su salario original, y 
haz que la columna que almacena el nuevo salario se denomine NUEVO SALARIO.

ENAME             SAL NUEVO_SALARIO
---------- ---------- -------------
ALLEN            1600          2600
WARD             1250          2250
MARTIN           1250          2250
BLAKE            2850          3850
TURNER           1500          2500
JAMES             950          1950

6 filas seleccionadas.*/

select ename, sal, sal+1000 as 'NOU SALARI' from empleados
where deptno = 30;

/* 22. Halla los empleados que tienen una comision superior a la mitad de su salario.

ENAME
----------
MARTIN

1 fila seleccionada.*/

select ename from empleados
where comm > sal/2;

/* 23. Halla los empleados que no tienen comision, o que la tengan menor o igual que el 25% de su salario.

ENAME
----------
SMITH
ALLEN
JONES
BLAKE
CLARK
SCOTT
KING
TURNER
ADAMS
JAMES
FORD
MILLER

12 filas seleccionadas.*/

select ename from empleados
where comm IS NULL OR comm <= sal/4;

/* 24. Obten una lista de nombres de empleados y sus salarios, de forma que en 
la salida aparezca en todas las filas \Nombre:" y \Salario:" antes del respectivo campo. 

		 NOMBRE     SALARIO
---------------     -------------------------------------------------
Nombre:  SMITH      Salario: 800
Nombre:  ALLEN      Salario: 1600
Nombre:  WARD       Salario: 1250
Nombre:  JONES      Salario: 2975
Nombre:  MARTIN     Salario: 1250
Nombre:  BLAKE      Salario: 2850
Nombre:  CLARK      Salario: 2450
Nombre:  SCOTT      Salario: 3000
Nombre:  KING       Salario: 5000
Nombre:  TURNER     Salario: 1500
Nombre:  ADAMS      Salario: 1100
Nombre:  JAMES      Salario: 950
Nombre:  FORD       Salario: 3000
Nombre:  MILLER     Salario: 1300

14 filas seleccionadas.*/

select concat('Nom: ', ename) as NOM, concat('Salari: ', sal) as SALARI from empleados;


/* 25. Hallar el codigo, salario y comision de los empleados cuyo codigo sea mayor que 7500.

     EMPNO        SAL       COMM
---------- ---------- ----------
      7521       1250        500
      7566       2975
      7654       1250       1400
      7698       2850
      7782       2450
      7788       3000
      7839       5000
      7844       1500          0
      7876       1100
      7900        950
      7902       3000
      7934       1300

12 filas seleccionadas.*/

select empno, sal, ifnull(comm,'') as comm from empleados where empno > 7500;


/* 26. Obten todos los datos de los empleados que esten a partir de la J, inclusive.
NOTA: Para ello usa la funcion left de PLMySql   

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7521 WARD       SALESMAN        7698 22/02/81       1250        500         30
      7566 JONES      MANAGER         7839 02/04/81       2975                    20
      7654 MARTIN     SALESMAN        7698 28/09/81       1250       1400         30
      7788 SCOTT      ANALYST         7566 09/12/82       3000                    20
      7839 KING       PRESIDENT            17/11/81       5000                    10
      7844 TURNER     SALESMAN        7698 08/09/81       1500          0         30
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7934 MILLER     CLERK           7782 23/01/82       1300                    10

9 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where left(ename,1) >= 'J'; 


/* 27. Obten el salario, comision y salario total (salario+comision) de los empleados 
con comision, ordenando el resultado por numero de empleado.

       SAL       COMM SALARIO_TOTAL
---------- ---------- -------------
      1600        300          1900
      1250        500          1750
      1250       1400          2650
      1500          0          1500
      
5 filas seleccionadas.*/

select sal, comm, sal + comm as 'Salari_total' from empleados
where COMM is not null
order by empno;

/* 28. Lista la misma informacion, pero para los empleados que no tienen comision.

       SAL       COMM SALARIO_TOTAL
---------- ---------- -------------
       800
      2975
      2850
      2450
      3000
      5000
      1100
       950
      3000
      1300

10 filas seleccionadas.*/

select sal, ifnull(comm,'') as comm, sal + ifnull(comm,0) as 'Salari_total' from empleados
where COMM is null
order by empno;


/* 29. Muestra el nombre de los empleados que, teniendo un salario superior 
a 1000, tengan como jefe al empleado cuyo codigo es 7698.

ENAME
----------
ALLEN
WARD
MARTIN
TURNER

4 filas seleccionadas.*/

select ename from empleados
where sal > 1000 and mgr = 7698;

/* 30. Muestra el nombre de los empleados que, teniendo un salario inferior 
a 1000, no tengan como jefe al empleado cuyo codigo es 7698.


ENAME
----------
SMITH

1 fila seleccionada.*/

select ename from empleados
where sal < 1000 and mgr <> 7698;

/* 31. Indica para cada empleado el porcentaje que supone su comision sobre su 
salario, ordenando el resultado por el nombre del mismo.

PORCENTAJE
----------

15,7894737






52,8301887



0
28,5714286

14 filas seleccionadas.*/

select ifnull(comm,0)/sal * 100 as percentatge from empleados
order by ename;

/* 32. Hallar los empleados del departamento 10 cuyo nombre no contiene la cadena LA.

ENAME
----------
KING
MILLER

2 filas seleccionadas.*/

select ename from empleados
where deptno = 10 and
ename NOT LIKE '%LA%';


/* 33. Obten los empleados que no son supervisados por ningun otro.

ENAME
----------
KING

1 fila seleccionada.*/

select ename from empleados
where mgr is null;

/* 34. Obten los nombres de los departamentos que no sean Ventas (SALES) ni 
investigacion (RESEARCH). Ordena el resultado por la localidad del departamento.

DNAME
--------------
OPERATIONS
ACCOUNTING

2 filas seleccionadas.*/

select dname from departamentos
where dname != 'SALES' AND
dname != 'RESEARCH'
order by LOC;

/* 35. Deseamos conocer el nombre de los empleados y el codigo del departamento 
de los administrativos(CLERK) que no trabajan en el departamento 10, y cuyo 
salario es superior a 800, ordenado por fecha de contratacion.

ENAME          DEPTNO
---------- ----------
JAMES              30
ADAMS              20

2 filas seleccionadas.*/

select ename, deptno from empleados
where job = 'CLERK' and deptno != 10 
and sal > 800
order by hiredate;


/* 36. Para los empleados que tengan comision, obten sus nombres y el cociente entre 
su salario y su comision (excepto cuando la comision sea cero), ordenando el resultado por nombre.

ENAME        COCIENTE
---------- ----------
ALLEN      5,33333333
MARTIN     ,892857143
WARD              2,5

3 filas seleccionadas.*/

select ename, sal/comm as quocient
from empleados
where comm is not null and
comm <> 0
order by ename;


/* 37. Lista toda la informacion sobre los empleados cuyo nombre completo tenga exactamente 5 caracteres.

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7499 ALLEN      SALESMAN        7698 20/02/81       1600        300         30
      7566 JONES      MANAGER         7839 02/04/81       2975                    20
      7698 BLAKE      MANAGER         7839 01/05/81       2850                    30
      7782 CLARK      MANAGER         7839 09/06/81       2450                    10
      7788 SCOTT      ANALYST         7566 09/12/82       3000                    20
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      7900 JAMES      CLERK           7698 03/12/81        950                    30

8 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where length(ename) = 5; 


/* 38. Lo mismo, pero para los empleados cuyo nombre tenga al menos cinco letras.

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7499 ALLEN      SALESMAN        7698 20/02/81       1600        300         30
      7566 JONES      MANAGER         7839 02/04/81       2975                    20
      7654 MARTIN     SALESMAN        7698 28/09/81       1250       1400         30
      7698 BLAKE      MANAGER         7839 01/05/81       2850                    30
      7782 CLARK      MANAGER         7839 09/06/81       2450                    10
      7788 SCOTT      ANALYST         7566 09/12/82       3000                    20
      7844 TURNER     SALESMAN        7698 08/09/81       1500          0         30
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7934 MILLER     CLERK           7782 23/01/82       1300                    10

11 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where length(ename) >= 5; 



/* 39. Halla los datos de los empleados que, o bien su nombre empieza por A y su 
salario es superior a 1000, o bien reciben comision y trabajan en el departamento 30.

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7499 ALLEN      SALESMAN        7698 20/02/81       1600        300         30
      7521 WARD       SALESMAN        7698 22/02/81       1250        500         30
      7654 MARTIN     SALESMAN        7698 28/09/81       1250       1400         30
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      
4 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where ename like 'A%' and sal > 1000
or comm <> 0 and deptno = 30;


/* 40. Halla el nombre, el salario y el sueldo total de todos los empleados, ordenando 
el resultado primero por salario y luego por el sueldo total. En el caso de que no 
tenga comision, el sueldo total debe reflejar solo el salario.

ENAME             SAL SALARIO_TOTAL
---------- ---------- -------------
SMITH             800           800
JAMES             950           950
ADAMS            1100          1100
WARD             1250          1750
MARTIN           1250          2650
MILLER           1300          1300
TURNER           1500          1500
ALLEN            1600          1900
CLARK            2450          2450
BLAKE            2850          2850
JONES            2975          2975
SCOTT            3000          3000
FORD             3000          3000
KING             5000          5000

14 filas seleccionadas.*/

select ename, sal, sal + ifnull(comm,0) as 'salari_total' 
from empleados
order by sal, salari_total;


/* 41. Obten el nombre, salario y la comision de los empleados que perciben 
un salario que esta entre la mitad de la comision y la propia comision.

ENAME             SAL       COMM
---------- ---------- ----------
MARTIN           1250       1400

1 fila seleccionada.*/

select ename, sal, comm from empleados
where sal between comm/2 and comm;


/* 42. Obten el nombre, salario y la comision de los empleados que perciben 
un salario complementario al caso 41: que sea superior a la comision o inferior a la mitad de la comision.


ENAME             SAL       COMM
---------- ---------- ----------
ALLEN            1600        300
WARD             1250        500
TURNER           1500          0

3 filas seleccionadas.*/

select ename, sal, comm from empleados
where sal not between comm/2 and comm;


/* 43. Lista los nombres y empleos de aquellos empleados cuyo empleo acaba 
en MAN y cuyo nombre empieza por A.

ENAME      JOB
---------- ---------
ALLEN      SALESMAN

1 fila seleccionada.*/

select ename, job from empleados
where job like '%MAN'
and ename like 'A%';


/* 44. Intenta resolver la pregunta anterior con un predicado simple, es decir, 
de forma que en la clausula WHERE no haya conectores logicos como AND, OR, etc. 
Si ayuda a resolver la pregunta, se puede suponer que el nombre del empleado tiene al menos cinco letras.

ENAME      JOB
---------- ---------
ALLEN      SALESMAN

1 fila seleccionada.*/

select ename, job from empleados
where concat(ename,job) like 'A%MAN';

/* 45. Halla los nombres de los empleados cuyo nombre tiene como maximo cinco caracteres.

ENAME
----------
SMITH
ALLEN
WARD
JONES
BLAKE
CLARK
SCOTT
KING
ADAMS
JAMES
FORD

11 filas seleccionadas.*/

select ename from empleados
where length(ename) < 6;


/* 46. Suponiendo que el anyo proximo la subida del sueldo total de cada empleado sera del 60 %, 
y el siguiente del 70 %, halla los nombres y el salario total actual, del anyo proximo y del 
siguiente, de cada empleado. Indique ademas con SI o NO, si el empleado tiene comision. 

ENAME      COMM     SALARIO_TOTAL SALARIO_DEL_PROXIMO_ANYO SALARIO_DEL_SIGUIENTE_ANYO
---------- -------- ------------- ----------------------- ---------------------------
ADAMS      NOSESABE          1100                    1760                      2992
ALLEN      SI                1900                    3040                      5168
BLAKE      NOSESABE          2850                    4560                      7752
CLARK      NOSESABE          2450                    3920                      6664
FORD       NOSESABE          3000                    4800                      8160
JAMES      NOSESABE           950                    1520                      2584
JONES      NOSESABE          2975                    4760                      8092
KING       NOSESABE          5000                    8000                     13600
MARTIN     SI                2650                    4240                      7208
MILLER     NOSESABE          1300                    2080                      3536
SCOTT      NOSESABE          3000                    4800                      8160
SMITH      NOSESABE           800                    1280                      2176
TURNER     NO                1500                    2400                      4080
WARD       SI                1750                    2800                      4760

14 filas seleccionadas.*/

select ename, if(comm is null, 'desconegut', if(comm != 0, 'si', 'no')) as comm, 
sal + ifnull(comm,0) as salari_total,
(sal + ifnull(comm,0)) * 1.6 as salari_proper_any, 
((sal + ifnull(comm,0)) * 1.6) * 1.7 as salari_seguent_any
from empleados
order by ename;


/* 47. Lista los nombres y fecha de contratacion de aquellos empleados que no son vendedores (SALESMAN).

ENAME      HIREDATE
---------- --------
SMITH      17/12/80
JONES      02/04/81
BLAKE      01/05/81
CLARK      09/06/81
SCOTT      09/12/82
KING       17/11/81
ADAMS      12/01/83
JAMES      03/12/81
FORD       03/12/81
MILLER     23/01/82

10 filas seleccionadas.*/

select ename, 
date_format(HIREDATE, "%d/%m/%y") as HIREDATE
from empleados
where job <> 'SALESMAN';


/* 48. Obten la informacion disponible de los empleados cuyo numero es uno de los 
siguientes: 7844, 7900, 7521, 7521, 7782, 7934, 7678 y 7369, pero que no sea uno 
de los siguientes: 7902, 7839, 7499 ni 7878. La sentencia no debe complicarse 
innecesariamente, y debe dar el resultado correcto independientemente de lo 
empleados almacenados en la base de datos.

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7521 WARD       SALESMAN        7698 22/02/81       1250        500         30
      7782 CLARK      MANAGER         7839 09/06/81       2450                    10
      7844 TURNER     SALESMAN        7698 08/09/81       1500          0         30
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7934 MILLER     CLERK           7782 23/01/82       1300                    10

6 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%Y") as HIREDATE,SAL,
ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where empno in (7844, 7900, 7521, 7521, 7782, 7934, 7678, 7369)
and empno not in (7902, 7839, 7499, 7878);


/* 49. Ordena los empleados por su codigo de departamento, y luego de manera descendente por su numero de empleado.

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7934 MILLER     CLERK           7782 23/01/82       1300                    10
      7839 KING       PRESIDENT            17/11/81       5000                    10
      7782 CLARK      MANAGER         7839 09/06/81       2450                    10
      7902 FORD       ANALYST         7566 03/12/81       3000                    20
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      7788 SCOTT      ANALYST         7566 09/12/82       3000                    20
      7566 JONES      MANAGER         7839 02/04/81       2975                    20
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7844 TURNER     SALESMAN        7698 08/09/81       1500          0         30
      7698 BLAKE      MANAGER         7839 01/05/81       2850                    30
      7654 MARTIN     SALESMAN        7698 28/09/81       1250       1400         30
      7521 WARD       SALESMAN        7698 22/02/81       1250        500         30
      7499 ALLEN      SALESMAN        7698 20/02/81       1600        300         30

14 filas seleccionadas.*/

select EMPNO,ENAME,JOB,MGR,date_format(HIREDATE, "%d/%m/%y") as HIREDATE,SAL,
ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
order by deptno, empno desc;


/* 50. Para los empleados que tengan como jefe a un empleado con codigo mayor que 
el suyo, obten los que reciben de salario mas de 1000 y menos de 2000, o que estan en el departamento 30.

ENAME
----------
ALLEN
WARD
MARTIN
BLAKE

4 filas seleccionadas.*/

select ename from empleados
where mgr > empno and
(sal between 1000 and 2000 
or deptno = 30);


/* 51. Obten el salario mas alto de la empresa, el total destinado a 
comisiones y el numero de empleados.

  MAX(SAL)  SUM(COMM)   COUNT(*)
---------- ---------- ----------
      5000       2200         14
      
1 fila seleccionada.*/

select max(sal), sum(comm), count(*)
from empleados;


/* 52. Halla los datos de los empleados cuyo salario es mayor que el del empleado de codigo 7934, ordenando por el salario.

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7844 TURNER     SALESMAN        7698 08/09/81       1500          0         30
      7499 ALLEN      SALESMAN        7698 20/02/81       1600        300         30
      7782 CLARK      MANAGER         7839 09/06/81       2450                    10
      7698 BLAKE      MANAGER         7839 01/05/81       2850                    30
      7566 JONES      MANAGER         7839 02/04/81       2975                    20
      7788 SCOTT      ANALYST         7566 09/12/82       3000                    20
      7902 FORD       ANALYST         7566 03/12/81       3000                    20
      7839 KING       PRESIDENT            17/11/81       5000                    10

8 filas seleccionadas.*/

select EMPNO,ENAME,JOB,ifnull(MGR,'') as MGR,date_format(HIREDATE, "%d/%m/%y") as HIREDATE,SAL,
ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where sal > (
select sal from empleados
where empno = 7934)
order by sal;


/* 53. Obten informacion en la que se reflejen los nombres, empleos y salarios tanto de 
los empleados que superan en salario a Allen como del propio Allen.

ENAME      JOB              SAL
---------- --------- ----------
ALLEN      SALESMAN        1600
JONES      MANAGER         2975
BLAKE      MANAGER         2850
CLARK      MANAGER         2450
SCOTT      ANALYST         3000
KING       PRESIDENT       5000
FORD       ANALYST         3000

7 filas seleccionadas.*/

select ename, job, sal
from empleados
where empno = (
select empno from empleados where ename = 'ALLEN')
or
sal > (
select sal from empleados where ename = 'ALLEN');


/* 54. Halla el nombre el ultimo empleado por orden alfabetico.

MAX(ENAME)
----------
WARD

1 fila seleccionada.*/

select max(ename) from empleados;


/* 55. Halla el salario mas alto, el mas bajo, y la diferencia entre ellos.

SAL_MAS_ALTO SAL_MAS_BAJO DIFERNECIA
------------ ------------ ----------
        5000          800       4200
        
1 fila seleccionada.*/

select max(sal) as 'SAL_MES_ALT', min(sal) as 'SAL_MES_BAIX', max(sal) - min(sal) as 'DIFF'
from empleados; 


/* 56. Sin conocer los resultados del ejercicio anterior, Â¿quienes reciben el 
salario mas alto y el mas bajo, y a cuanto ascienden estos salarios?

ENAME             SAL
---------- ----------
KING             5000
SMITH             800

2 filas seleccionadas.*/

select ename, sal from empleados
where sal = (select max(sal) from empleados)
or sal = (select min(sal) from empleados)
order by sal desc;

/* 57. Considerando empleados con salario menor de 5000, halla la media de los salarios 
de los departamentos cuyo salario minimo supera a 900. Muestra tambien el codigo y 
el nombre de los departamentos.

DNAME          AVG(A.SAL)
-------------- ----------
ACCOUNTING           1875
SALES          1566,66667

2 filas seleccionadas.*/

select d.dname, t.avgsal from (
select min(sal) as minsal, avg(sal) as avgsal, deptno from empleados
where sal < 5000 group by deptno) as t,
departamentos d
where minsal > 900 and
t.deptno = d.deptno;


/* 58. Â¿Que empleados trabajan en ciudades de mas de cinco letras? Ordena el resultado 
inversamente por ciudades y normalmente por los nombres de los empleados.

ENAME
----------
CLARK
KING
MILLER
ADAMS
FORD
JONES
SCOTT
SMITH
ALLEN
BLAKE
JAMES
MARTIN
TURNER
WARD

14 filas seleccionadas.*/

select e.ename from empleados e, departamentos d
where e.deptno = d.deptno 
and length(d.loc) > 5
order by d.loc desc, e.ename;

/* 59. Halla los empleados cuyo salario supera o coincide con la media del salario de la empresa.

ENAME
----------
JONES
BLAKE
CLARK
SCOTT
KING
FORD

6 filas seleccionadas.*/

select ename from empleados 
where sal >= (
select avg(sal) from empleados);


/* 60. Obten los empleados cuyo salario supera al de sus compa~neros de departamento.

ENAME
----------
BLAKE
SCOTT
KING
FORD

4 filas seleccionadas.*/

select ename from empleados
where sal IN (select max(sal) from empleados
group by deptno)


/* 61. Â¿Cuantos empleos diferentes, cuantos empleados, y cuantos salarios diferentes 
encontramos en el departamento 30, y a cuanto asciende la suma de salarios de dicho departamento?

   NUM_JOB    NUM_EMP    NUM_SAL   SUM(SAL)
---------- ---------- ---------- ----------
         3          6          5       9400
         
1 fila seleccionada.*/

select num_job, num_emp, num_sal, sum_sal
from (select count(t1.job) as num_job
from (select distinct job from empleados
where deptno = 30) t1) tc1,
(select count(t2.empno) as num_emp from 
(select empno from empleados
where deptno = 30) t2) tc2,
(select count(t3.sal) as num_sal from 
(select distinct sal from empleados
where deptno = 30) t3) tc3,
(select sum(sal) as sum_sal from empleados
where deptno = 30) tc4;

/* 62. Â¿Cuantos empleados tienen comision?

  COUNT(*)
----------
         3
         
1 fila seleccionada.*/

select count(*) from (
select empno from empleados
where comm != 0 and comm is not null) t;

/* 63. Â¿Cuantos empleados tiene el departamento 20?

   NUM_EMP
----------
         5
         
1 fila seleccionada.*/

select count(*) as num_emp from (
select empno from empleados
where deptno = 30) t;


/* 64. Halla los departamentos que tienen mas de tres empleados, y el numero de empleados de los mismos.

    DEPTNO    NUM_EMP
---------- ----------
        20          5
        30          6
        
2 filas seleccionadas.*/

select deptno, num_emp as num_emp
from (select count(empno) as num_emp, deptno from empleados group by deptno) t
where num_emp > 3;


/* 65. Obten los empleados del departamento 10 que tienen el mismo empleo que 
alguien del departamento de Ventas. Desconocemos el codigo de dicho departamento.

ENAME
----------
CLARK
MILLER

2 filas seleccionadas.*/

select ename from empleados 
where deptno = 10 
and job in (select distinct job from empleados 
where deptno = (select deptno from departamentos where dname = 'SALES'));


/* 66. Halla los empleados que tienen por lo menos un empleado a su mando, ordenados inversamente por nombre.

ENAME
----------
SCOTT
KING
JONES
FORD
CLARK
BLAKE

6 filas seleccionadas.*/

select ENAME from empleados where empno in (
select mgr from (
select mgr, count(mgr) as c from empleados group by mgr) t
where c >= 1)
order by ename desc;


/* 67. Obten informacion sobre los empleados que tienen el mismo trabajo que 
algun empleado que trabaje en Chicago.

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17/12/80        800                    20
      7876 ADAMS      CLERK           7788 12/01/83       1100                    20
      7934 MILLER     CLERK           7782 23/01/82       1300                    10
      7900 JAMES      CLERK           7698 03/12/81        950                    30
      7566 JONES      MANAGER         7839 02/04/81       2975                    20
      7782 CLARK      MANAGER         7839 09/06/81       2450                    10
      7698 BLAKE      MANAGER         7839 01/05/81       2850                    30
      7499 ALLEN      SALESMAN        7698 20/02/81       1600        300         30
      7654 MARTIN     SALESMAN        7698 28/09/81       1250       1400         30
      7844 TURNER     SALESMAN        7698 08/09/81       1500          0         30
      7521 WARD       SALESMAN        7698 22/02/81       1250        500         30

11 filas seleccionadas.*/

select EMPNO,ENAME,JOB,ifnull(MGR,'') as MGR,date_format(HIREDATE, "%d/%m/%y") as HIREDATE,SAL,
ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where JOB in (select job from empleados e, departamentos d
where d.loc = 'CHICAGO' and e.deptno = d.deptno)
order by job;

/* 68. Â¿Que empleos distintos encontramos en la empresa, y cuantos empleados desempeÃ±an cada uno de ellos?

JOB         COUNT(*)
--------- ----------
ANALYST            2
CLERK              4
MANAGER            3
PRESIDENT          1
SALESMAN           4

5 filas seleccionadas.*/

select job, count(*) from empleados group by job;



/* 69. Halla la suma de salarios de cada departamento.

DNAME            SUM(SAL)
-------------- ----------
ACCOUNTING           8750
RESEARCH            10875
SALES                9400

3 filas seleccionadas.*/

select d.dname, sum(e.sal) from empleados e, departamentos d
where d.deptno = e.DEPTNO 
group by e.deptno;


/* 70. Obten todos los departamentos sin empleados.

DNAME
--------------
OPERATIONS

1 fila seleccionada.*/

select dname from departamentos
where deptno not in (select distinct deptno from empleados);


/* 71. Halla los empleados que no tienen a otro empleado a sus ordenes.

ENAME
----------
SMITH
ALLEN
WARD
MARTIN
TURNER
ADAMS
JAMES
MILLER

8 filas seleccionadas.*/

select ename from empleados
where empno not in (
select distinct mgr from empleados where mgr is not null);

/* 72. Â¿Cuantos empleados hay en cada departamento, y cual es la media anual 
del salario de cada uno (el salario almacenado es mensual)? 
Indique el nombre del departamento para clarificar el resultado.

DNAME             AVG(SAL)   COUNT(*)
-------------- ---------- ----------
ACCOUNTING     2916,66667          3
RESEARCH             2175          5
SALES          1566,66667          6

3 filas seleccionadas.*/

select dname, avg_sal, num_emp
from
(select dname, deptno from departamentos d) t1,
(select avg(sal) as avg_sal, count(*) as num_emp, deptno from empleados e group by deptno) t2
where t1.deptno = t2.deptno;

-- Una altra solució:

select  d.dname, avg(e.sal), count(*)
from empleados e,
departamentos d
where e.deptno = d.deptno
group by e.deptno;

/* 73. Halla los empleados del departamento 30, por orden descendente de comision

ENAME
----------
BLAKE
JAMES
MARTIN
WARD
ALLEN
TURNER

6 filas seleccionadas.*/

select ename from empleados
where deptno = 30
order by comm is not null, comm desc;


/* 74. Obten los empleados que trabajan en Dallas o New York.

ENAME
----------
CLARK
KING
MILLER
SMITH
ADAMS
FORD
SCOTT
JONES

8 filas seleccionadas.*/

select ename from empleados e natural join departamentos d
where d.loc in ('DALLAS', 'NEW YORK')
order by d.deptno;


/* 75. Obten un listado en el que se reflejen los empleados y los nombres 
de sus jefes. En el listado deben aparecer todos los empleados, aunque no 
tengan jefe, poniendo un nulo el nombre de este.

ENAME      ENAME
---------- ----------
FORD       JONES
SCOTT      JONES
JAMES      BLAKE
TURNER     BLAKE
MARTIN     BLAKE
WARD       BLAKE
ALLEN      BLAKE
MILLER     CLARK
ADAMS      SCOTT
CLARK      KING
BLAKE      KING
JONES      KING
SMITH      FORD
KING

14 filas seleccionadas.*/

select e1.ename, ifnull(e2.ename,'NULL') as ename from empleados e1
left outer join empleados e2 on (e1.mgr = e2.EMPNO) 
order by e1.mgr is null, e1.mgr, e1.empno desc;


/* 76. Lista los empleados que tengan el mayor salario de su departamento, 
mostrando el nombre del empleado, su salario y el nombre del departamento.

ENAME             SAL DNAME
---------- ---------- --------------
BLAKE            2850 SALES
FORD             3000 RESEARCH
SCOTT            3000 RESEARCH
KING             5000 ACCOUNTING

4 filas seleccionadas.*/

select ename, sal, d.dname from empleados e1, departamentos d
where sal = (select max(sal) from empleados e2 where e1.deptno = e2.deptno group by deptno)
and e1.deptno = d.DEPTNO
order by sal;


/* 77. Deseamos saber cuantos empleados supervisa cada jefe. Para ello, obten un listado 
en el que se reflejen el codigo y el nombre de cada jefe, junto al numero de empleados 
que supervisa directamente. Como puede haber empleados sin jefe, para estos se indicara 
solo el numero de ellos, y los valores restantes (codigo y nombre del jefe) se dejaran como nulos.

ENAME           EMPNO NUM_EMPLEADOS
---------- ---------- -------------
                                  1
FORD             7902             1
KING             7839             3
BLAKE            7698             5
CLARK            7782             1
JONES            7566             2
SCOTT            7788             1

7 filas seleccionadas.*/

select ifnull(e2.ename,'') as ename,ifnull(e1.mgr,'') as empno,
count(e1.empno) as num_emp from empleados e1 
left outer join empleados e2 on(e1.MGR = e2.EMPNO) 
group by e1.mgr order by e2.ename is not null, num_emp;


/* 78. Hallar el departamento cuya suma de salarios sea la mas alta, mostrando esta 
suma de salarios y el nombre del departamento

DNAME             SUM(SAL)
-------------- ----------
RESEARCH            10875

1 fila seleccionada.*/

set @maxSal = (select max(t.sum_sal) from (
select sum(e.sal) as sum_sal from empleados e
group by deptno) as t);

select d.dname, sum(e.sal) as sum_sal  
from empleados e
natural join departamentos d
group by deptno
having sum_sal = @maxSal
;

-- Es pot fer en una sola sentència, però amb variable queda més clar

/* 79. Obten los datos de los empleados que cobren los dos mayores salarios de la empresa. 
(Nota: Procure hacer la consulta de forma que sea facil obtener los empleados de los N mayores salarios)

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17/11/81       5000                    10
      7788 SCOTT      ANALYST         7566 09/12/82       3000                    20
      7902 FORD       ANALYST         7566 03/12/81       3000                    20
      
3 filas seleccionadas.*/

-- Número de salaris més grans.
set @N := 2;

select EMPNO,ENAME,JOB,ifnull(MGR,'') as MGR,date_format(HIREDATE, "%d/%m/%y") as HIREDATE,SAL,
ifnull(COMM,'') as COMM,DEPTNO 
from EMPLEADOS
where sal in (
select sal from empleados e1
WHERE (
SELECT COUNT(*)
FROM empleados e2
WHERE  e1.sal < e2.sal) < @N
) order by sal desc;


/* 80. Obten las localidades que no tienen departamentos sin empleados y en las que 
trabajen al menos cuatro empleados. Indica tambien el numero de empleados que trabajan 
en esas localidades. (Nota: Por ejemplo, puede que en A Coru~na existan dos departamentos, 
uno con mas de cuatro empleados y otro sin empleados, en tal caso, A Coru~na no debe 
aparecer en el resultado, puesto que tiene un departamento SIN EMPLEADOS, a pesar de tener 
otro con empleados Y tener mas de cuatro empleados EN TOTAL. 
ATENCION, la restriccion de que tienen que ser cuatro empleados se refiere a la totalidad 
de los departamentos de la localidad.)

LOC           NUMERO_EMPLEADOS
------------- ----------------
DALLAS                       5
CHICAGO                      6

2 filas seleccionadas.*/

-- aquesta variable guarda totes les localitats
-- que no tenen departaments sense empleats
set @loc := (select group_concat(loc) from departamentos 
where deptno not in (
-- departaments sense empleats (DEPTNO 40):
select deptno from departamentos
where deptno not in (select deptno from empleados)
));

select d.loc, count(e.empno) as num_emp from empleados e natural join departamentos d 
where FIND_IN_SET(d.loc, @loc)
group by d.loc
having num_emp > 4
order by num_emp;