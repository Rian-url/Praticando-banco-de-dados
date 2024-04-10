create database db_school;
use db_school;

create table tb_students(
id_ra int primary key,
nm_student varchar(50) not null,
dt_birth date not null
);

create table tb_courses(
cd_course int auto_increment primary key,
nm_course varchar(20) not null,
vl_hr int not null,
dt_start date not null,
dt_end date not null
);

create table tb_registration(
cd_registration int auto_increment primary key,
fk_cd_course int not null,
fk_id_ra int not null,
dt_registration date not null,
vl_registration decimal(10,2) not null,
foreign key (fk_cd_course) references tb_courses (cd_course),
foreign key (fk_id_ra) references tb_students (id_ra) 
);

insert into tb_students values
(123456, "Ana", "1972-01-10" ),
(123457, "Bianca", "1973-02-11"),
(123458, "Carla", "1987-12-12"),
(123459, "Danilo", "1990-10-02"),
(123460, "Eliana", "1987-01-01");

insert into tb_courses values
(null, "JAVA",      360,  "2007-12-01",  "2008-10-10"),
(null, "AUTO CAD",  60,   "2008-01-10",  "2008-05-10"),
(null, "PHP",       90,   "2008-02-15",  "2008-07-10"),
(null, "REDES",     60,   "2008-01-20",  "2008-03-20");

insert into tb_registration values
(null, 1, 123456, "2007-09-10", 100.00),
(null, 3, 123456, "2007-10-01", 60.00),
(null, 1, 123457, "2007-09-01", 100.00),
(null, 2, 123458, "2008-01-11", 50.00),
(null, 2, 123459, "2007-07-20", 50.00),
(null, 1, 123460, "2007-08-10", 80.00);

-- 1. Listar RA, nome do aluno e nome do curso em que o aluno está matriculado.
select nm_student as "NOME",
id_ra as "RA",
nm_course as "CURSO"
from tb_students S, tb_courses C
inner join tb_registration R
on R.fk_cd_course = C.cd_course 
where R.fk_id_ra = S.id_ra;

-- 2. Listar RA, nome do aluno e nome do curso em que o aluno está matriculado, ordenado por nome do curso. 
select nm_student as "NOME",
id_ra as "RA",
nm_course as "CURSO",
fk_id_ra
from tb_students S, tb_courses C
inner join tb_registration R
on R.fk_cd_course = C.cd_course 
where R.fk_id_ra = S.id_ra
order by C.nm_course;

-- 3.Exibir o nome de cada curso que teve matriculas e quantos alunos tem matriculados em cada um deles 
-- (Obs. Usar apelido para o campo do número de alunos). 
select nm_course, count(fk_id_ra) as "QTD ALUNOS"
from  tb_courses C
inner join tb_registration
on C.cd_course = fk_cd_course 
inner join tb_students
on fk_id_ra = id_ra
GROUP BY nm_course; 

-- 4.Exibir o nome de todos os cursos e quantos alunos tem matriculados em cada um
-- (Obs. Caso algum curso não tenha matrículas, exibir número de alunos =0). 
select nm_course, count(fk_id_ra) as "QTD ALUNOS"
from  tb_courses C
left join tb_registration
on fk_cd_course = C.cd_course 
GROUP BY nm_course; 

-- 5. Exibir o nome do curso e o valor total recebido das matrículas em cada um deles 
select nm_course, 
sum(vl_registration)  as "valor"
from  tb_courses C
inner join tb_registration
on C.cd_course = fk_cd_course 
inner join tb_students
on fk_id_ra = id_ra
GROUP BY nm_course;  

-- 6. Exibir o nome do curso, o valor total recebido das matrículas em cada um deles e o total arrecadado em matrículas pela escola. 
select nm_course,
 sum(vl_registration) as "valor"
from  tb_courses C
inner join tb_registration
on C.cd_course = fk_cd_course 
inner join tb_students
on fk_id_ra = id_ra
GROUP BY nm_course; 

select sum(vl_registration)  as "valor"
from  tb_registration
inner join tb_students
on fk_id_ra = id_ra;

-- 7. Exibir o valor médio pago em matrícula na escola. Chamar a coluna que exibirá a média
-- de valor médio e seu conteúdo deve ser exibido com 2 casas decimais
select Round(sum(vl_registration) / count(fk_id_ra), 2 ) as Média
from  tb_registration
inner join tb_students
on fk_id_ra = id_ra;

-- 8. Exibir o nome e o valor médio de matrícula de cada curso. Chamar a coluna que exibirá a média de valor médio e seu conteúdo exibido com 2 casas decimais
select nm_course, Round(sum(vl_registration) / count(fk_id_ra), 2 ) as Média
from  tb_registration
inner join tb_students
on fk_id_ra = id_ra
inner join tb_courses
on fk_cd_course = cd_course
GROUP BY nm_course;

-- 9. Exibir nome dos cursos que não são VIP ( ou seja que tenha pelo menos 2 alunos) e a quantidade de alunos matriculados em cada um deles.

select nm_course, count(fk_id_ra) as "QTD ALUNOS"
from  tb_courses C
inner join tb_registration
on C.cd_course = fk_cd_course 
inner join tb_students
on fk_id_ra = id_ra
GROUP BY nm_course
having count(fk_id_ra) >= 2;

-- 10 Exiba o nome dos cursos com mesma carga horária do curso de auto cad
select nm_course
from tb_courses
where vl_hr = 60;

-- 11. Exiba nome de todos os alunos que fazem aniversário no mesmo mês que Ana. 
select nm_student
from tb_students
where MONTH(dt_birth) = 01; 

-- 12 Exiba todos os cursos com início em janeiro de 2008 que tenham alunos matriculados. 
select nm_course 
from tb_courses
inner join tb_registration
on fk_cd_course = cd_course
where dt_start like "2008-01%"
GROUP BY nm_course;

-- 13 Exiba todos os cursos com início em janeiro de 2008 independente de ter alunos matriculados ou não. 
select nm_course 
from tb_courses
where dt_start like "2008-01%";

-- 14. Exiba o nome do aluno e do curso de todos os alunos que fizeram matrícula antes da data de início do curso no qual se matriculou,
-- pois esses vão ganhar um brinde. Observe que a Carla se matriculou no curso de auto cad após o inicio do curso, portanto ela 
-- não foi listada e não receberá brinde. 
select nm_student, nm_course
from tb_registration R
inner join tb_students S
on fk_id_ra = id_ra
inner join tb_courses C
on fk_cd_course = cd_course
where C.dt_start > R.dt_registration;
-- group by nm_student;


-- 15. Listar os cursos que ainda não iniciaram
select nm_course
from tb_courses
where dt_start > current_date();

-- 16. Listar os alunos que fizeram matrícula de Sábado pois eles também receberão brindes
select nm_student
from tb_students
inner join tb_registration
on fk_id_ra = id_ra
where dayname(dt_registration) = 'saturday';

-- 17. Os alunos que fizeram matrícula de Sábado receberão 50% do valor pago na matrícula de volta, para incentivar 
-- essa prática de ir se matricular em cursos sempre aos sábados pois é o dia que a escola tem um plantão de matrícula. 
-- Exibir o nome do aluno e o valor a restituir (apelidar a coluna com esse nome, e exibir o valor com 2 casas decimais) 
update tb_registration 
set vl_registration = vl_registration - (vl_registration * 0.5)
where dayname(dt_registration) = 'saturday';

select * from tb_registration where fk_id_ra = 123457;

SET SQL_SAFE_UPDATES=1;



select nm_student, vl_registration as "VALOR A RESTITUIR"
from tb_students
inner join tb_registration
on fk_id_ra = id_ra
where dayname(dt_registration) = 'saturday';



-- 18. Exibir o nome e a idade dos alunos 
select nm_student as NOME,
year(current_date()) - year(dt_birth) as IDADE
from tb_students;
 
