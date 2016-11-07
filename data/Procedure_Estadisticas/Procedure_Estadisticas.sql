------ ----------------Especialidades Bonos ---------------
/*GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE TRIGGER_EXPLOSION.EspecialidadesBonos (@Semestre int, @Mes int, @Año int)
AS
BEGIN

		DECLARE @parametros varchar(5)

		IF (@Mes = 0)
			IF (@Semestre = 1)
				SET @Parametros = '< 6'
			ELSE
				SET @Parametros = '> 6'
		ELSE
			SET @Parametros = '= ' + CAST(@Mes AS varchar(2))

		EXEC('SELECT TOP 5 Especialidad AS ''Especialidad'', COUNT(*) AS ''Cantidad''

		FROM TRIGGER_EXPLOSION.Agenda
			JOIN TRIGGER_EXPLOSION.Turno ON Turn_Agenda = Agen_Id
			JOIN TRIGGER_EXPLOSION.Bono ON Bono_Turno_Uso = Turn_Numero
			JOIN TRIGGER_EXPLOSION.Especialidades ON Especialidad = Id_especialidad
		WHERE YEAR(Fecha_inicio) = '+@Año+'
			AND MONTH(Fecha_inicio) '+@Parametros+'

		GROUP BY Especialidad
		ORDER BY COUNT(*) DESC')
END*/


-----AFILIADOS BONOS ---------------


----ESPECIALIDADES CANCELADAS--------


---- PROFESIONALES HORAS --------

----- ------------------------------ PROFESIONALES CONSULTADOS -------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE TRIGGER_EXPLOSION.ProfesionalesConsultados (@Plan numeric(18,0), @Especialidad numeric(18,0), @Semestre int, @Mes int, @Año int)
AS
BEGIN

		DECLARE @parametros varchar(5)
		DECLARE @parametrosPlan varchar(20)
		DECLARE @parametrosEspecialidad varchar(20)

		IF (@Mes = 0)
			IF (@Semestre = 1)
				SET @Parametros = '< 6'
			ELSE
				SET @Parametros = '> 6'
		ELSE
			SET @Parametros = '= ' + CAST(@Mes AS varchar(2))

		IF (@Plan = 0)
			SET @ParametrosPlan = ''
		ELSE
			SET @ParametrosPlan = ' AND Paci_Plan = ' + CAST(@Plan AS varchar(18))
	
		IF (@Especialidad = 0)
			SET @ParametrosEspecialidad = ''
		ELSE
			SET @ParametrosEspecialidad = ' AND Espe_Codigo = ' + CAST(@Especialidad AS varchar(18))


		EXEC('SELECT TOP 5 prof.Nombre + '' '' + prof.Apellido AS ''Profesional'', plan.Descripcion as ''Plan'',esp.Descripcion AS ''Especialidad'', COUNT(*) AS ''Cantidad'' 

		FROM TRIGGER_EXPLOSION.Agenda agen
			JOIN TRIGGER_EXPLOSION.Turno t ON Agen_Id = Turn_Agenda
			JOIN TRIGGER_EXPLOSION.ConsultaMedica ON Cons_Turno = Turn_Numero
			JOIN TRIGGER_EXPLOSION.Profesional prof ON a.Id_profesional = prof.Id_profesional
			JOIN TRIGGER_EXPLOSION.Afiliado af ON t.Id_afiliado = af.Id_afiliado
			JOIN TRIGGER_EXPLOSION.Especialidad esp ON Agen_Especialidad = esp.Id_especialidad
			JOIN TRIGGER_EXPLOSION.PlanMedico plan ON Id_plan = af.Plan_id
		WHERE 
			YEAR(Agen_Fecha) = '+@Año+'
			AND MONTH(Agen_Fecha) '+@Parametros+'
			'+@ParametrosPlan+@ParametrosEspecialidad+'


		GROUP BY Usua_Nombre + '' '' + Usua_Apellido, Espe_Descripcion, Plan_Descripcion
		ORDER BY COUNT(*) DESC')
				
	
END
