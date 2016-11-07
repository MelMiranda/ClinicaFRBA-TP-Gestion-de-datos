CREATE SCHEMA [TRIGGER_EXPLOSION] AUTHORIZATION [gd];
	GO

BEGIN TRY
	
	BEGIN TRANSACTION TRANSACCION_INICIAL

	--ACA VA TODA LA QUERY PROPIAMENTE DICHA *****************************************

	
	--COMIENZA CREACION DE TABLAS------------------------------------
	CREATE TABLE TRIGGER_EXPLOSION.Usuario
	(
	Id_usuario				numeric(18,0) IDENTITY(1,1),
	Habilitado				bit DEFAULT 1,
	Username				varchar(255),
	Contrasenia				varchar(255),
	Primer_login			bit DEFAULT 1,
	Intentos_fallidos		numeric(18,0) DEFAULT 0,

	CONSTRAINT PK_Usuario PRIMARY KEY (Id_usuario),
	)

	CREATE TABLE TRIGGER_EXPLOSION.PlanMedico
	(
	Id_plan						numeric(18,0) IDENTITY(1,1),
	Precio_bono_consulta		numeric(18,0),
	Costo						numeric(18,0),
	Descripcion					varchar(255),
	Precio_bono_farmacia		numeric(18,0),
	PRIMARY KEY(Id_plan)
	)


	CREATE TABLE TRIGGER_EXPLOSION.Rol
	(
	Id_rol					numeric(18,0) IDENTITY(1,1),
	Nombre					varchar(255), --Vamos a usarlo para diferenciar el tipo de rol
	Habilitado				bit DEFAULT 1,
	PRIMARY KEY (Id_rol)

	)


	CREATE TABLE TRIGGER_EXPLOSION.Funcionalidad
	(
	Id_funcionalidad			numeric(18,0) IDENTITY(1,1),
	Nombre						varchar(255),
	PRIMARY KEY(Id_funcionalidad)
	)

	CREATE TABLE TRIGGER_EXPLOSION.RolXFuncionalidad
	(
	Id_funcionalidad			numeric(18,0),
	Id_rol						numeric(18,0),
	CONSTRAINT PK_RolXFuncionalidad PRIMARY KEY (Id_funcionalidad,Id_rol)
	)

	CREATE TABLE TRIGGER_EXPLOSION.UsuarioXRol
	(
	Id_usuario					numeric(18,0),
	Id_rol						numeric(18,0),
	CONSTRAINT PK_UsuarioXRol PRIMARY KEY (Id_usuario,Id_rol),
	CONSTRAINT FK_UsuarioXRol_Usuario FOREIGN KEY (Id_usuario) REFERENCES TRIGGER_EXPLOSION.Usuario(Id_usuario),
	CONSTRAINT FK_UsuarioXRol_Rol FOREIGN KEY (Id_rol) REFERENCES TRIGGER_EXPLOSION.Rol(Id_rol)
	) 


	CREATE TABLE TRIGGER_EXPLOSION.EstadoCivil
	(
	Id_estado_civil				numeric(18,0) IDENTITY(1,1),
	Descripcion					varchar(255),
	CONSTRAINT PK_EstadoCivil PRIMARY KEY (Id_estado_civil)
	)


	CREATE TABLE TRIGGER_EXPLOSION.TipoDocumento
	(
	Id_tipo_documento			numeric(18,0) IDENTITY(1,1),
	Descripcion					varchar(255)

	CONSTRAINT PK_TipoDocumento PRIMARY KEY (Id_tipo_documento)
	)

	CREATE TABLE TRIGGER_EXPLOSION.Afiliado
	(
	Id_afiliado					numeric(18,0) IDENTITY(001,100),
	Id_usuario					numeric(18,0),
	Plan_id						numeric(18,0),
	Total_consultas_medicas		numeric(18,0) DEFAULT 0,
	Familiares_a_cargo			numeric(18,0),
	Conyuge						numeric(18,0),
	Id_estado_civil				numeric(18,0) DEFAULT 1,
	Nombre						varchar(255),
	Apellido					varchar(255),
	Numero_documento			numeric(18,0),
	Direccion					varchar(255),
	Telefono					numeric(18,0),
	Mail						varchar(255),
	Fecha_nacimiento			datetime,
	Id_tipo_documento			numeric(18,0)  DEFAULT 1, --el tipo de documento default es DNI, 
	Sexo						varchar(255),
	Habilitado					BIT,

	CONSTRAINT chk_Sexo_Afiliado	CHECK (Sexo = 'masculino' OR Sexo='femenino'),
	CONSTRAINT PK_AFILIADOS PRIMARY KEY (Id_afiliado),
	CONSTRAINT FK_Afiliado_Plan FOREIGN KEY(Plan_id) REFERENCES TRIGGER_EXPLOSION.PlanMedico(Id_plan),
	CONSTRAINT FK_Afiliado_Usuario FOREIGN KEY(Id_usuario) REFERENCES TRIGGER_EXPLOSION.Usuario(Id_usuario),
	CONSTRAINT FK_Afiliado_Conyuge FOREIGN KEY(Conyuge) REFERENCES TRIGGER_EXPLOSION.Afiliado(Id_afiliado),
	CONSTRAINT FK_Afiliado_Tipo_documento FOREIGN KEY (Id_tipo_documento) REFERENCES TRIGGER_EXPLOSION.TipoDocumento,
	CONSTRAINT FK_Afiliado_EstadoCivil FOREIGN KEY(Id_estado_civil) REFERENCES TRIGGER_EXPLOSION.EstadoCivil(Id_estado_civil)
	)

	CREATE TABLE TRIGGER_EXPLOSION.Modificaciones_afiliado
	(
	Id_modificacion				numeric(18,0) IDENTITY(1,1),
	Id_afiliado					numeric(18,0),
	Plan_viejo_id				numeric(18,0),
	Motivo						varchar(255),
	Fecha_modificacion			DateTime,

	CONSTRAINT PK_MODIFICACION PRIMARY KEY (Id_modificacion),
	CONSTRAINT FK_Afiliado FOREIGN KEY(Id_afiliado) REFERENCES TRIGGER_EXPLOSION.Afiliado(Id_afiliado),
	CONSTRAINT FK_PlanViejo FOREIGN KEY(Plan_viejo_id) REFERENCES TRIGGER_EXPLOSION.PlanMedico(Id_plan)
	)

	CREATE TABLE TRIGGER_EXPLOSION.Profesional
	(
	Id_profesional				numeric(18,0) IDENTITY(1,1),
	Id_usuario					numeric(18,0),
	Matricula					numeric(18,0),
	Rol_id						numeric(18,0),
	Nombre						varchar(255),
	Apellido					varchar(255),
	Numero_documento			numeric(18,0),
	Tipo_documento				numeric(18,0),
	Direccion					varchar(255),
	Telefono					numeric(18,0),
	Mail						varchar(255),
	Fecha_Nacimiento			datetime,
	Id_tipo_documento			numeric(18,0) DEFAULT 1, --el tipo de documento default es DNI
	Sexo						varchar(255),
	Habilitado					BIT,

	CONSTRAINT chk_Sexo_Profesional	CHECK (Sexo IN ('masculino','femenino')),
	CONSTRAINT FK_Profesional_Rol FOREIGN KEY(Rol_id) REFERENCES TRIGGER_EXPLOSION.Rol(Id_rol),
	CONSTRAINT FK_Profesional_Tipo_documento FOREIGN KEY (Id_tipo_documento) REFERENCES TRIGGER_EXPLOSION.TipoDocumento,
	CONSTRAINT FK_Profesional_Usuario FOREIGN KEY(Id_usuario) REFERENCES TRIGGER_EXPLOSION.Usuario(Id_usuario),
	CONSTRAINT PK_Profesional PRIMARY KEY (Id_profesional)
	)


	CREATE TABLE TRIGGER_EXPLOSION.TipoEspecialidad
	(
	Codigo_tipo_especialidad		numeric(18,0) IDENTITY(1,1),
	Descripcion					varchar(255),

	CONSTRAINT PK_TipoEspecialidad PRIMARY KEY (Codigo_tipo_especialidad)
	

	)


	CREATE TABLE TRIGGER_EXPLOSION.Especialidad(
	Id_especialidad				numeric(18,0) IDENTITY(1,1),
	Descripcion					varchar(255),
	Codigo_tipo_especialidad		numeric(18,0),

	CONSTRAINT PK_Especialidad PRIMARY KEY (Id_especialidad),
	CONSTRAINT FK_Especialidad_TipoEspecialidad FOREIGN KEY(Codigo_tipo_especialidad) REFERENCES TRIGGER_EXPLOSION.TipoEspecialidad(Codigo_tipo_especialidad)
	)

	CREATE TABLE TRIGGER_EXPLOSION.ProfesionalXEspecialidad
	(
	Id_especialidad				numeric(18,0),
	Id_profesional				numeric(18,0),

	CONSTRAINT PK_ProfesionalXEspecialidad PRIMARY KEY (Id_especialidad, Id_profesional)
	)


	CREATE TABLE TRIGGER_EXPLOSION.Turno
	(
	Id_turno				numeric(18,0) IDENTITY(1,1),
	Id_afiliado				numeric(18,0),
	Id_profesional			numeric(18,0),
	Fecha_programada		datetime,
	Fecha_y_hora_llegada	datetime,
	Especialidad_id			numeric(18,0),
	Cancelado BIT DEFAULT 0,


	CONSTRAINT FK_Turno_Especialidad FOREIGN KEY (Especialidad_id) REFERENCES TRIGGER_EXPLOSION.Especialidad (Id_especialidad),
	CONSTRAINT PK_Turno PRIMARY KEY (Id_turno),
	CONSTRAINT FK_Turno_Afiliado FOREIGN KEY(Id_afiliado) REFERENCES TRIGGER_EXPLOSION.Afiliado(Id_afiliado),
	CONSTRAINT FK_Turno_Profesional FOREIGN KEY(Id_profesional) REFERENCES TRIGGER_EXPLOSION.Profesional(Id_profesional),
	

	)


	CREATE TABLE TRIGGER_EXPLOSION.ConsultaMedica
	(
	Id_consulta				numeric(18,0) IDENTITY(1,1),
	Sintomas				varchar(255),
	Diagnostico				varchar(255),
	Consulta_realizada		bit DEFAULT 0,
	Fecha_y_hora			datetime,


	CONSTRAINT PK_ConsultaMedica PRIMARY KEY (Id_consulta),
	CONSTRAINT FK_ConsultaMedica_Turno FOREIGN KEY(Id_consulta) REFERENCES TRIGGER_EXPLOSION.Turno(Id_turno)
	)

	
	CREATE TABLE TRIGGER_EXPLOSION.Compra
	(
	Id_compra				numeric(18,0) IDENTITY(1,1),
	Cantidad_bonos			numeric(18,0),
	Costo_total				numeric(18,0),
	Id_afiliado				numeric(18,0),
	Fecha					datetime,

	CONSTRAINT PK_Compra PRIMARY KEY (Id_compra),
	CONSTRAINT FK_Compra_Afiliado FOREIGN KEY(Id_afiliado) REFERENCES TRIGGER_EXPLOSION.Afiliado(Id_afiliado)


	)

	CREATE TABLE TRIGGER_EXPLOSION.Bono
	(
	Id_bono					numeric(18,0) IDENTITY(1,1),
	Id_compra				numeric(18,0),
	Id_afiliado_comprador	numeric(18,0),
	Id_plan_original		numeric(18,0),
	Numero_consulta_medica	numeric(18,0),
	Id_usado_por			numeric(18,0),
	Fecha_impresion			datetime,
	Descripcion				varchar(255),

	CONSTRAINT PK_Bono PRIMARY KEY (Id_bono, Id_afiliado_comprador), --Dice que cada ID de bono es particular de cada afiliado, revisar
	CONSTRAINT FK_Bono_Compra FOREIGN KEY(Id_compra) REFERENCES TRIGGER_EXPLOSION.Compra(Id_Compra),
	CONSTRAINT FK_Bono_AfiliadoComprador FOREIGN KEY(Id_afiliado_comprador) REFERENCES TRIGGER_EXPLOSION.Afiliado(Id_afiliado),
	CONSTRAINT FK_Bono_PlanOriginal FOREIGN KEY(Id_plan_original) REFERENCES TRIGGER_EXPLOSION.PlanMedico(Id_plan),
	CONSTRAINT FK_Bono_AfiliadoUsadoPor FOREIGN KEY(Id_usado_por) REFERENCES TRIGGER_EXPLOSION.Afiliado(Id_afiliado),
	)


	CREATE TABLE TRIGGER_EXPLOSION.TipoCancelacion
	(
	Id_tipo_cancelacion				numeric(18,0) IDENTITY(1,1),
	Descripcion						varchar(255),

	CONSTRAINT PK_TipoCancelacion PRIMARY KEY (Id_tipo_cancelacion)
	)

	CREATE TABLE TRIGGER_EXPLOSION.Cancelacion
	(
	Id_cancelacion			numeric(18,0) IDENTITY(1,1),
	Id_tipo_cancelacion		numeric(18,0),
	Motivo					varchar(255),
	Id_turno				numeric(18,0),

	CONSTRAINT PK_Cancelacion PRIMARY KEY (Id_cancelacion),
	CONSTRAINT FK_Cancelacion_TipoCancelacion FOREIGN KEY(Id_tipo_cancelacion) REFERENCES TRIGGER_EXPLOSION.TipoCancelacion(Id_tipo_cancelacion),
	CONSTRAINT FK_Cancelacion_Turno FOREIGN KEY(Id_turno) REFERENCES TRIGGER_EXPLOSION.Turno(Id_turno)

	)

	CREATE TABLE TRIGGER_EXPLOSION.Agenda
	(
	Id_agenda				numeric(18,0) IDENTITY(1,1),
	Id_profesional			numeric(18,0),
	Fecha_inicio			DATETIME,
	Fecha_fin				DATETIME,
	Especialidad			varchar(255)


	CONSTRAINT PK_Agenda PRIMARY KEY (Id_agenda),
	CONSTRAINT FK_Agenda_Profesional FOREIGN KEY(Id_profesional) REFERENCES TRIGGER_EXPLOSION.Profesional(Id_profesional)

	)

		CREATE TABLE TRIGGER_EXPLOSION.Dias_disponible
	(
	Id_dia					numeric(18,0) IDENTITY(1,1),
	Id_agenda				numeric(18,0),
	Dia						varchar(255),
	inicio_jornada			TIME,
	fin_jornada				TIME,


	CONSTRAINT PK_Dias_Disponible PRIMARY KEY (Id_dia),
	CONSTRAINT FK_Dias_Agenda FOREIGN KEY(Id_agenda) REFERENCES TRIGGER_EXPLOSION.Agenda(Id_agenda)

	)


	-----------------------------TERMINA CREACION DE TABLAS--------------------------------------------------


	-------------------------------COMIENZA MIGRACION DE DATOS-------------------------------------


	--*****************************ROL*******************************************
	INSERT INTO TRIGGER_EXPLOSION.Rol
	(Nombre) values ('Afiliado'), ('Profesional'), ('Administrador')


	--*****************************Estado Civil*******************************************
	INSERT INTO TRIGGER_EXPLOSION.EstadoCivil(Descripcion)
	values ('Soltero'), ('Casado'), ('Divorciado'), ('Viudo')

	------------------------------admin---------------------------------------------

	SET IDENTITY_INSERT TRIGGER_EXPLOSION.Usuario ON
	INSERT INTO TRIGGER_EXPLOSION.Usuario (Id_usuario, Username, Contrasenia, Primer_login)
	VALUES (0, 'admin','w23e', 1) -- El admin sera el usuario 0 
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.Usuario OFF


	--*****************************Usuario***********************************************
	INSERT INTO TRIGGER_EXPLOSION.Usuario(Username, Contrasenia)
	SELECT DISTINCT Medico_Dni, 'w23e'
	FROM gd_esquema.Maestra
	WHERE Medico_Dni IS NOT NULL
	UNION
	SELECT DISTINCT Paciente_Dni, 'w23e'
	FROM gd_esquema.Maestra

	--*****************************Tipo de documento*******************************************
	INSERT INTO TRIGGER_EXPLOSION.TipoDocumento(Descripcion)
	VALUES ('DNI'), ('CI'), ('LC')

	
	--*****************************Planes*******************************************
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.PlanMedico ON
	INSERT INTO TRIGGER_EXPLOSION.PlanMedico(Id_plan, Precio_bono_consulta,Precio_bono_farmacia, Descripcion)
	SELECT DISTINCT Plan_Med_Codigo, Plan_Med_Precio_Bono_Consulta, Plan_Med_Precio_Bono_Farmacia ,Plan_Med_Descripcion
	FROM gd_esquema.Maestra
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.PlanMedico OFF


	--*****************************TipoEspecialidad*******************************************
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.TipoEspecialidad ON
	INSERT INTO TRIGGER_EXPLOSION.TipoEspecialidad (Codigo_tipo_especialidad, Descripcion)
	SELECT DISTINCT Tipo_Especialidad_Codigo, Tipo_Especialidad_Descripcion
		FROM gd_esquema.Maestra
		WHERE Tipo_Especialidad_Codigo IS NOT NULL;
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.TipoEspecialidad OFF

	--*****************************Especialidad*******************************************
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.Especialidad ON
	INSERT INTO TRIGGER_EXPLOSION.Especialidad (Id_especialidad, Descripcion, Codigo_tipo_especialidad)
	SELECT DISTINCT Especialidad_Codigo, Especialidad_Descripcion, Tipo_Especialidad_Codigo
		FROM gd_esquema.Maestra
		WHERE Tipo_Especialidad_Codigo IS NOT NULL;
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.Especialidad OFF

		--***************************Profesional**************************************************
	INSERT INTO TRIGGER_EXPLOSION.Profesional(Id_usuario,Nombre,Apellido,Direccion,Mail,Fecha_Nacimiento,Telefono,Numero_documento, Habilitado)
	SELECT DISTINCT U.Id_usuario, UPPER(LEFT(M.Medico_Nombre,1))+LOWER(SUBSTRING(M.Medico_Nombre,2,LEN(M.Medico_Nombre))), M.Medico_Apellido, M.Medico_Direccion, M.Medico_Mail, M.Medico_Fecha_Nac, M.Medico_Telefono, M.Medico_Dni, 1
	FROM TRIGGER_EXPLOSION.Usuario U, gd_esquema.Maestra M
	WHERE U.Username  = CAST(M.Medico_Dni AS varchar(255))

	

	--*****************************ProfesionalXEspecialidad*******************************************
	INSERT INTO TRIGGER_EXPLOSION.ProfesionalXEspecialidad (Id_especialidad, Id_profesional)
	SELECT DISTINCT e.Id_especialidad, p.Id_profesional
		FROM TRIGGER_EXPLOSION.Profesional p, TRIGGER_EXPLOSION.Especialidad e, gd_esquema.Maestra m
		WHERE p.Numero_documento=m.Medico_Dni AND e.Id_especialidad=m.Especialidad_Codigo;

	--*****************************Funcionalidad*******************************************
	INSERT INTO TRIGGER_EXPLOSION.Funcionalidad (Nombre)
	VALUES ('Ver Agenda'), ('Sacar Turno'), ('Comprar Bonos'), ('ABM Rol'), ('ABM Afiliado'), ('Estadisticas'), ('Cancelar Turno')

	--*****************************RolXFunc*******************************************
	INSERT INTO TRIGGER_EXPLOSION.RolXFuncionalidad(Id_rol, Id_funcionalidad)
	VALUES (1,2), (1,3), (2,1), (3,3), (3,4), (3,5), (3,6), (1,7), (2,7)

	--***************************Afiliado**************************************************
	INSERT INTO TRIGGER_EXPLOSION.Afiliado(Id_usuario, Nombre, Apellido, Numero_documento, Direccion,Mail,Plan_id,Fecha_nacimiento, Id_tipo_documento, Habilitado, Telefono, Total_consultas_medicas)
	SELECT DISTINCT U.Id_usuario, M.Paciente_Nombre, M.Paciente_Apellido, M.Paciente_Dni, M.Paciente_Direccion, M.Paciente_Mail, M.Plan_Med_Codigo,M.Paciente_Fecha_Nac, 1, 1, m.Paciente_Telefono, MAX(m.Bono_Consulta_Numero) total_consultas
	FROM gd_esquema.Maestra M, TRIGGER_EXPLOSION.Usuario U
	WHERE U.Username = CAST(M.Paciente_Dni AS varchar(255))
	GROUP BY U.Id_usuario, M.Paciente_Nombre, M.Paciente_Apellido, M.Paciente_Dni, M.Paciente_Direccion, M.Paciente_Mail, M.Plan_Med_Codigo,M.Paciente_Fecha_Nac, M.Paciente_Telefono

	
	--*****************************UsuarioXRol*******************************************

	INSERT INTO TRIGGER_EXPLOSION.UsuarioXRol (Id_usuario, Id_rol)
	SELECT A.Id_usuario, r.Id_rol
	FROM TRIGGER_EXPLOSION.Afiliado A, TRIGGER_EXPLOSION.Rol R
	WHERE R.Nombre = 'Afiliado'

	INSERT INTO TRIGGER_EXPLOSION.UsuarioXRol (Id_usuario, Id_rol)
	SELECT P.Id_usuario, r.Id_rol
	FROM TRIGGER_EXPLOSION.Profesional P, TRIGGER_EXPLOSION.Rol R
	WHERE R.Nombre = 'Profesional'

	INSERT INTO TRIGGER_EXPLOSION.UsuarioXRol (Id_usuario, Id_rol)
	SELECT U.Id_usuario, r.Id_rol
	FROM TRIGGER_EXPLOSION.Rol R, TRIGGER_EXPLOSION.Usuario U
	WHERE R.Nombre = 'Administrador' AND U.Username = 'admin'
	



	--*****************************Turno*******************************************
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.Turno ON
	INSERT INTO TRIGGER_EXPLOSION.Turno (Id_turno, Id_afiliado, Id_profesional, Fecha_programada, Especialidad_id)
	SELECT DISTINCT m.Turno_Numero, a.Id_afiliado, p.Id_profesional, m.Turno_Fecha, m.Especialidad_Codigo
	FROM gd_esquema.Maestra m
	JOIN TRIGGER_EXPLOSION.Afiliado a ON (m.Paciente_Dni = a.Numero_documento)
	JOIN TRIGGER_EXPLOSION.Profesional p ON (m.Medico_Dni = p.Numero_documento)
	WHERE Turno_Numero IS NOT NULL AND m.Bono_Consulta_Numero IS NULL
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.Turno OFF

	--*****************************ConsultaMedica*******************************************

	SET IDENTITY_INSERT TRIGGER_EXPLOSION.ConsultaMedica ON
	INSERT INTO TRIGGER_EXPLOSION.ConsultaMedica (Id_consulta, Sintomas, Diagnostico, Consulta_realizada, Fecha_y_hora)
	SELECT DISTINCT t.Id_turno, m.Consulta_Sintomas, m.Consulta_Enfermedades, 1, m.Turno_Fecha
		FROM gd_esquema.Maestra m JOIN TRIGGER_EXPLOSION.Turno t ON (t.Id_turno = m.Turno_Numero)
		WHERE m.Bono_Consulta_Numero IS NOT NULL
		ORDER BY t.Id_turno
	SET IDENTITY_INSERT TRIGGER_EXPLOSION.ConsultaMedica OFF

	--*****************************Compras*******************************************

	INSERT INTO TRIGGER_EXPLOSION.Compra (Id_afiliado, Fecha, Cantidad_bonos, Costo_total)
	SELECT DISTINCT Id_afiliado, Bono_Consulta_Fecha_Impresion, COUNT( Bono_Consulta_Numero) Cantidad_bonos, Plan_Med_Precio_Bono_Consulta
	FROM gd_esquema.Maestra m
	JOIN TRIGGER_EXPLOSION.Afiliado a ON (a.Numero_documento = m.Paciente_Dni)
	WHERE Bono_Consulta_Fecha_Impresion IS NOT NULL
	group by Id_afiliado, Bono_Consulta_Fecha_Impresion, Plan_Med_Precio_Bono_Consulta
	ORDER BY Id_afiliado


	--*****************************Bono*******************************************

	INSERT INTO TRIGGER_EXPLOSION.Bono (Numero_consulta_medica, Id_compra, Id_afiliado_comprador, Id_usado_por,Id_plan_original, Fecha_impresion)
	SELECT DISTINCT m.Bono_Consulta_Numero, c.Id_compra, a.id_afiliado, a.Id_afiliado, a.Plan_id, m.Bono_Consulta_Fecha_Impresion
	FROM TRIGGER_EXPLOSION.Afiliado a 
	JOIN gd_esquema.Maestra m ON (a.Numero_documento = m.Paciente_Dni AND m.Bono_Consulta_Numero iS NOT NULL)
	JOIN TRIGGER_EXPLOSION.Compra c ON (m.Compra_Bono_Fecha = c.Fecha AND A.Id_afiliado = c.Id_afiliado)
	WHERE m.Bono_Consulta_Numero IS NOT NULL
	ORDER BY Bono_Consulta_Numero


	--*****************************Agenda*******************************************

	INSERT INTO TRIGGER_EXPLOSION.Agenda (Id_profesional, Especialidad, Fecha_inicio, Fecha_fin)
	SELECT p.Id_profesional, e.Descripcion,  MIN(Turno_Fecha), MAX(Turno_Fecha)
	FROM gd_esquema.Maestra m
	JOIN TRIGGER_EXPLOSION.Profesional p ON (p.Numero_documento = Medico_Dni)
	JOIN TRIGGER_EXPLOSION.Especialidad e ON (e.Id_especialidad = m.Especialidad_Codigo)
	WHERE Turno_fecha is not null
	GROUP BY p.Id_profesional, e.Descripcion

	--*****************************DiasDisponible*******************************************

	SELECT Medico_Dni, Especialidad_Descripcion,DATENAME(WEEKDAY, Turno_fecha) Dia,cast(Turno_fecha as time) [Horas]
	INTO #TempAgenda
	FROM gd_esquema.Maestra m
	WHERE Turno_fecha is not null;


	INSERT INTO TRIGGER_EXPLOSION.Dias_disponible (Id_agenda,Dia, inicio_jornada, fin_jornada) 
	SELECT DISTINCT a.Id_agenda,t.Dia, MIN(t.Horas), MAX(t.Horas)
	FROM #TempAgenda t
	JOIN TRIGGER_EXPLOSION.Profesional p ON (p.Numero_documento = Medico_Dni)
	JOIN TRIGGER_EXPLOSION.Agenda a ON (a.Id_profesional = p.Id_profesional)
	GROUP BY a.Id_agenda, t.Dia
	ORDER BY Id_agenda

	Drop Table #TempAgenda 

	--*****************************TipoCancelacion*******************************************

	INSERT INTO TRIGGER_EXPLOSION.TipoCancelacion (Descripcion)
	VALUES ('Problemas de horario'), ('Trabajo'), ('Prefiero no informar')



		----------------------------------TERMINA MIGRACION DE DATOS----------------------------------------------------

	COMMIT TRANSACTION TRANSACCION_INICIAL
END TRY

BEGIN CATCH
	IF(@@TRANCOUNT > 0 )
	BEGIN
	ROLLBACK TRANSACTION TRANSACCION_INICIAL
	PRINT 'ERROR DETECTADO, TODOS LOS CAMBIOS REVERTIDOS'
	END
	    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage





END CATCH
GO
	--***************************Stored Procedures**************************************************

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
---------------------------------------USUARIOS------------------------------------------------
------------------------------------------------------------------------------------------------


	------------------------RESETEAR INTENTOS FALLIDOS------------------------------
CREATE PROCEDURE TRIGGER_EXPLOSION.SP_ResetIntentos(@Id_usuario numeric(18,0))
AS
BEGIN
UPDATE TRIGGER_EXPLOSION.Usuario SET Intentos_fallidos = 0 WHERE Id_usuario = @Id_usuario
END
GO


------------------------CAMBIAR PASSWORD------------------------------
CREATE PROCEDURE TRIGGER_EXPLOSION.SP_CambiarPassword(@Id_usuario numeric(18,0), @Pass varchar(255))
AS
BEGIN
UPDATE TRIGGER_EXPLOSION.Usuario SET Contrasenia = @Pass where Id_usuario = @Id_usuario
END
GO



------------------------HABILITAR USUARIO------------------------------
CREATE PROCEDURE TRIGGER_EXPLOSION.SP_HabilitarUsuario(@Id_usuario numeric(18,0)) AS
BEGIN
	UPDATE TRIGGER_EXPLOSION.Usuario SET Habilitado = 1 WHERE Id_usuario = @Id_usuario
END
GO

------------------------DESHABILITAR USUARIO------------------------------
CREATE PROCEDURE TRIGGER_EXPLOSION.SP_DesHabilitarUsuario(@Id_usuario numeric(18,0)) AS
BEGIN
	UPDATE TRIGGER_EXPLOSION.Usuario SET Habilitado = 0 WHERE Id_usuario = @Id_usuario
END
GO


------------------------AUMENTAR CANTIDAD DE INTENTOS FALLIDOS ------------------------------
CREATE PROCEDURE TRIGGER_EXPLOSION.SP_SumarIntentoFallido(@Id_usuario numeric(18,0)) AS
BEGIN
	UPDATE TRIGGER_EXPLOSION.Usuario SET Intentos_fallidos = (Intentos_fallidos +1) WHERE Id_usuario = @Id_usuario
END
GO


------------------------CAMBIO EL FLAG DE PRIMERA VEZ ------------------------------
CREATE PROCEDURE TRIGGER_EXPLOSION.SP_PrimeraVez(@Value numeric(18,0), @ID numeric(18,0)) 
AS
BEGIN
UPDATE  TRIGGER_EXPLOSION.Usuario SET Primer_login = @Value WHERE Id_usuario = @ID
END
GO


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
--------------------------------------AGENDA MEDICA--------------------------------------------
-----------------------------------------------------------------------------------------------


--------------------Devuelve el ID de profesional dado el ID de usuario------------------------
CREATE PROCEDURE TRIGGER_EXPLOSION.GetIdProfesional(@Value numeric(18,0),  @Return numeric(18,0) output) 

AS
BEGIN
	DECLARE @profesional  numeric(18,0)
	SELECT  @profesional = Id_Profesional
	FROM TRIGGER_EXPLOSION.Profesional  
	WHERE Id_usuario =  @Value
	SET @Return = @profesional
END
GO


----------- ---------Muestra la disponibilidad con el id-usuario que recibe---------------------

CREATE PROCEDURE TRIGGER_EXPLOSION.InsertDisponibilidadPorIdUsuario(@id_profesional numeric(18,0), @fecha_init DATE, @fecha_fin DATE, @especialidad numeric(18,0), @Return numeric(18,0) output)
AS
BEGIN
	-- IF EXISTS(SELECT * FROM service s WHERE s.service_id = ?)
	INSERT INTO TRIGGER_EXPLOSION.Agenda (Id_profesional, Fecha_inicio,Fecha_fin, Especialidad)
	VALUES (@id_profesional, @fecha_init, @fecha_fin, @especialidad);

	DECLARE @i numeric(18,0) = 0
	WHILE  @i= DATEDIFF(DAY, @fecha_init,@fecha_fin)

	EXECUTE TRIGGER_EXPLOSION.InsertarDiasPorDisponibilidad 1, DATEADD(DAY,1,@fecha_init), '08:00:00', '08:30:00'

	SET @Return= 0

END
GO

CREATE PROCEDURE TRIGGER_EXPLOSION.InsertarDiasPorDisponibilidad(@id_agenda numeric(18,0),@fecha DATE, @hora_init TIME, @hora_fin TIME, @Return numeric(18,0) output)
AS
BEGIN

	INSERT INTO TRIGGER_EXPLOSION.Dias_disponible(Id_agenda, Dia,inicio_jornada, fin_jornada)
	VALUES (@id_agenda,DATENAME(DAY, @fecha), @hora_init, @hora_fin);
	
	

END
GO

	


-------Devuelve el id afiliado dado el dni

CREATE PROCEDURE TRIGGER_EXPLOSION.GetIdAfiliado(@Value numeric(18,0),  @Return numeric(18,0) output) 

AS
BEGIN
	
	SELECT @Return = Id_afiliado
	FROM TRIGGER_EXPLOSION.Afiliado 
	WHERE Numero_documento =  @Value
	--SET @Return = Id_afiliado
END
GO


----Inserta el disgnostico de cada paciente--pruebas

	SELECT* FROM TRIGGER_EXPLOSION.ConsultaMedica WHERE Id_consulta=57162
	SELECT * FROM TRIGGER_EXPLOSION.Turno WHERE Id_turno=57162
	SELECT * FROM TRIGGER_EXPLOSION.Afiliado WHERE Id_afiliado=551501
	SELECT * FROM TRIGGER_EXPLOSION.Profesional

	UPDATE TRIGGER_EXPLOSION.ConsultaMedica
	SET Sintomas='DDDD', Diagnostico= 'CCCC', Consulta_realizada=1
	WHERE Id_consulta=(	SELECT  MAX(Id_consulta)
	FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno
	WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =15 AND Id_afiliado=551501 AND Fecha_programada <= '20150211 16:40:00 PM')

--Falta convertir a sp
	UPDATE TRIGGER_EXPLOSION.Turno
	SET Fecha_y_hora_llegada='Fecha'
	WHERE Id_turno=(	SELECT  MAX(Id_consulta)
	FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno
	WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =15 AND Id_afiliado=551501 AND Fecha_programada <= '20150211 16:40:00 PM')

-----------

--PRUEBAS MEL --- NO LO BORREN PLEASE --

	SELECT * FROM TRIGGER_EXPLOSION.Profesional

	SELECT Dias_disponible.Dia, Dias_disponible.inicio_jornada
	FROM TRIGGER_EXPLOSION.Dias_disponible, TRIGGER_EXPLOSION.Agenda
	WHERE Agenda.Id_profesional = 2 AND  Dias_disponible.Id_agenda = Agenda.Id_agenda
	ORDER BY  Dias_disponible.Dia, Dias_disponible.inicio_jornada

	SELECT  Id_profesional
	FROM TRIGGER_EXPLOSION.Profesional  
	WHERE Id_usuario = 5553
	----






	----
	SELECT Dias_disponible.Dia, Dias_disponible.inicio_jornada
	FROM TRIGGER_EXPLOSION.Dias_disponible, TRIGGER_EXPLOSION.Agenda
	WHERE Agenda.Id_profesional = 1  AND  Dias_disponible.Id_agenda = Agenda.Id_agenda
	ORDER BY  Dias_disponible.Dia, Dias_disponible.inicio_jornada


	--SELECT startDate, endDate
	--FROM YourTable
	--WHERE '2012-10-25 00' between startDate and endDate

	




----

	---

	SELECT Id_turno, Id_consulta, Id_afiliado 
	FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno
	WHERE ConsultaMedica.Id_consulta = Turno.Id_turno

	SELECT Id_consulta
	FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno
	WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =15 AND Id_afiliado=17901 AND Fecha_programada< '20150101 11:20:00 AM'

	--<>
	SELECT Id_consulta
	FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno
	WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional ='id_profesional' AND Id_afiliado='id_afiliado' AND Fecha_programada< '20150101 11:20:00 AM'
	ORDER BY Fecha_programada ASC


	SELECT Id_agenda
	FROM TRIGGER_EXPLOSION.Agenda
	WHERE Id_profesional=3 AND ( '20150101 08:00:00 AM'<= Fecha_inicio AND '20150601 11:00:00 AM'>= Fecha_fin OR '20150101 08:00:00 AM'>= Fecha_inicio AND '20150601 11:00:00 AM'<= Fecha_fin )


	----PRUEBA PEDIR TURNO

	SELECT * FROM TRIGGER_EXPLOSION.Dias_disponible
	SELECT * FROM TRIGGER_EXPLOSION.Agenda
	SELECT * FROM TRIGGER_EXPLOSION.Turno

	SELECT Id_turno, Fecha_programada
	FROM  TRIGGER_EXPLOSION.Turno, TRIGGER_EXPLOSION.Agenda, TRIGGER_EXPLOSION.Dias_disponible
	WHERE Turno.Id_profesional=1 AND Turno.Especialidad_id=2 


	---SELECT TOP 1 products.id FROM products WHERE products.id = ?

--FIN PRUEBAS MEL


