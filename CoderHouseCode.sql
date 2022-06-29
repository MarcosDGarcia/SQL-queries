--CoderHouse project examples excersices--

select count (Nombre) as cant_asignaturas, Tipo from Asignaturas where Area = 5 group by Tipo --1--
select Nombre, Documento, Telefono from Estudiantes where Profesion='6' and [Fecha de Nacimiento] between '1970-01-01' and '2000-12-31' --2--
select upper (concat (Nombre,'-',Apellido)) Nombres_Apellidos from Staff where year ([Fecha Ingreso])=2021 --3--
select count (Encargado_ID) CantEncargados, replace (Tipo, 'Encargado','') NuevoTipo from Encargado group by Tipo --4--
select avg (Costo) as Promedio, Nombre from Asignaturas group by Nombre order by Promedio desc --5--
select Nombre, Apellido, datediff(year, [Fecha de Nacimiento], GETDATE()) as Edad from Estudiantes
where datediff(year,[Fecha de Nacimiento],GETDATE())>=18 order by Edad desc --6-- getdate es la fecha actual
select Nombre, Correo, Camada, [Fecha Ingreso] from Staff where Correo like '%.edu' and DocentesID>=100 --7--
select Documento, Domicilio, [Codigo Postal], Nombre, [Fecha Ingreso] from Estudiantes order by [Fecha Ingreso] --8--
select Nombre, Apellido, Documento from Staff where Asignatura in (select AsignaturasID from Asignaturas where Nombre like '%UX%') --9-- Select sobre select
select *, (Costo*1.25)-Costo as Aumento, Cast (Costo*1.25 as decimal (18,3)) as [Nuevo Costo] from Asignaturas
where Nombre like '%Marketing%' and Jornada='Manana' --10--

--CoderHouse project examples excersices--

--ejemplos mios de join y union--
select Estudiantes.Nombre, Estudiantes.Documento, Profesiones.Profesiones from Estudiantes join Profesiones on Estudiantes.Profesion=Profesiones.ProfesionesID
select Area.Nombre Area, Asignaturas.Nombre Asignatura from Area right join Asignaturas on Area.AreaID=Asignaturas.Area

--Ejercicios Join y Union--Cuando trabajo con dos tablas, me conviene y ES REQUERIDO aclarar de donde es cada campo, osea aclarar siempre la tabla--
select Asignaturas.Jornada, count (Staff.DocentesID) cant_docentes, SUM(Asignaturas.Costo) suma_total from Staff
join Asignaturas on Staff.Asignatura=Asignaturas.AsignaturasID where Asignaturas.Nombre like '%web%' group by Asignaturas.Jornada --1--

select Encargado.Encargado_ID, Encargado.Nombre, Encargado.Apellido, count (Staff.DocentesID) Cant_Docentes from Encargado --2--
left join Staff on Staff.Encargado=Encargado.Encargado_ID group by Encargado.Encargado_ID, Encargado.Nombre, Encargado.Apellido having count(Staff.DocentesID)!=0

select t2.* from Staff t1 right join Asignaturas t2 on t2.AsignaturasID=t1.Asignatura where t1.Encargado is null --3--
group by t1.Encargado, t2.AsignaturasID, t2.Area, t2.Costo, t2.Tipo, t2.Jornada, t2.Nombre --Se puede escribir .* para llamar toda la tabla--
--en group by deben estar todas las columnas de la tabla que ponemos en from--

select concat (t1.Nombre,t1.Apellido) NombresCompletos, t1.Documento, datediff (month,t1.[Fecha Ingreso], getdate()) meses_ingreso, --4--
t2.Nombre NombreEncargado, t2.Telefono TelefonoEncargado, t3.Nombre, t3.Jornada, t4.Nombre
from Staff t1 inner join Encargado t2 on t1.Encargado=t2.Encargado_ID inner join Asignaturas t3 on t1.Asignatura=t3.AsignaturasID
inner join Area t4 on t3.Area=t4.AreaID
group by t1.Documento, t1.Nombre, t1.Apellido, t1.[Fecha Ingreso], t2.Nombre, t2.Telefono, t3.Nombre, t3.Jornada, t4.Nombre
having datediff (month,t1.[Fecha Ingreso], getdate())>=3 order by meses_ingreso desc
--datediff meses: month suma los años de diferencia con x12 para pasarlos a meses--
--se pueden hacer joins uno seguido al otro siempre con su correspondiente on y la condicion--
--where va antes de group by, having va despues de group by--

select Nombre, Apellido, Documento, 'Encargado' Marca from Encargado union select Nombre, Apellido, Documento, 'Staff' Marca from Staff
union select Nombre, Apellido, Documento, 'Estudiante' Marca from Estudiantes order by Marca --5--

--consignas de Workshop--

--1,1+1,2--
select Documento, concat(Nombre,' ',Apellido) Docente, Replace (Camada,'camada','') NumCamada, [Fecha Ingreso],
case when (year([Fecha Ingreso])=2021 and month([Fecha Ingreso])=05) then 'Mayo 2021'
when (year([Fecha Ingreso])<2021 or (year([Fecha Ingreso])=2021 and month([Fecha Ingreso])<05)) then 'Menor'
when ((year([Fecha Ingreso])>=2021 and month([Fecha Ingreso])>05) or year([Fecha Ingreso])=2021) then 'Mayor'
end Indicador
from Staff
where Camada=(select max(Camada) from Staff) or (year([Fecha Ingreso])=2021 and month([Fecha Ingreso])=05)
union
select Documento, concat(Nombre,' ',Apellido) Docente, Replace (Camada,'camada','') NumCamada, [Fecha Ingreso],
case when (year([Fecha Ingreso])=2021 and month([Fecha Ingreso])=05) then 'Mayo 2021'
when (year([Fecha Ingreso])<2021 or (year([Fecha Ingreso])=2021 and month([Fecha Ingreso])<05)) then 'Menor'
when ((year([Fecha Ingreso])>=2021 and month([Fecha Ingreso])>05) or year([Fecha Ingreso])=2021) then 'Mayor'
end Indicador
from Staff
where Camada=(select min(Camada) from Staff) or (year([Fecha Ingreso])=2021 and month([Fecha Ingreso])=05)
order by NumCamada desc

--2--
select count ([Fecha Ingreso])IngresosFecha, year([Fecha Ingreso])Año, month([Fecha Ingreso])Mes, day([Fecha Ingreso])Dia from Estudiantes
group by [Fecha Ingreso] order by IngresosFecha desc

--3--
select top (10) t1.Encargado, count(t1.Encargado)CantDocentes, concat (t2.Nombre,' ',t2.Apellido)Encargado from Staff t1 inner join Encargado t2
on t1.Encargado=t2.Encargado_ID group by t1.Encargado, t2.Nombre, t2.Apellido order by count(t1.Encargado) desc

--4--
select t1.Profesiones, count(t2.EstudiantesID)CantEstudiante from Profesiones t1 inner join Estudiantes t2
on t1.ProfesionesID=t2.Profesion group by t1.Profesiones having count(t2.EstudiantesID)>5 order by count(t2.EstudiantesID) desc

--5--
select t1.Nombre, t2.Tipo, t2.Jornada, count(t4.EstudiantesID)CantEstudiantes, t2.Costo*(count(t4.EstudiantesID)) MontoTotal from Area t1 inner join Asignaturas t2 on t1.AreaID=t2.Area
inner join Staff t3 on t3.Asignatura=t2.AsignaturasID inner join Estudiantes t4 on t4.Docente=t3.DocentesID
group by t1.Nombre, t2.Tipo, t2.Jornada, t2.Costo order by t2.Costo desc

--Indicadores tacticos--

select * from Area
select * from Asignaturas
select * from Encargado
select * from Estudiantes
select * from Profesiones
select * from Staff

--ejercicio where y in--
select Nombre, Apellido, Documento, [Fecha Ingreso], Docente from Estudiantes where year([Fecha Ingreso])=2020 and Docente in (11,141,110)

--1--consigna poco clara, fecha de que? falta tambien reducir a que devuelva una fecha por area
select t1.Nombre, concat (year(t3.[Fecha Ingreso]), left (month(t3.[Fecha Ingreso]), 2)) Ingreso,
count (t4.EstudiantesID) Estudiantes, count (t2.AsignaturasID) Asignaturas from Area t1
left join Asignaturas t2 on t1.AreaID=t2.Area inner join Staff t3 on t2.AsignaturasID=t3.Asignatura inner join Estudiantes t4 on t3.DocentesID=t4.Docente
group by t1.Nombre, t3.[Fecha Ingreso], t4.EstudiantesID, t2.AsignaturasID
order by t1.Nombre, datediff (month,t3.[Fecha Ingreso], getdate()),count(t4.EstudiantesID) desc

--2--
select t1.Nombre, t2.Documento, replace(t2.Camada,'camada ','') Camada, t2.[Fecha Ingreso]
from Encargado t1 inner join Staff t2 on t1.Encargado_ID=t2.Encargado inner join Asignaturas t3 on t2.Asignatura=t3.AsignaturasID where t3.Jornada='Noche'
order by Camada desc

--3--
select t1.Nombre, t1.Tipo, t1.Jornada, count (t1.Area)Cant_Areas, count (t1.AsignaturasID)Cant_Asig
from Asignaturas t1 inner join Staff t2 on t1.AsignaturasID=t2.Asignatura
where t2.Asignatura is null group by t1.Nombre, t1.Tipo, t1.Jornada

--4--
