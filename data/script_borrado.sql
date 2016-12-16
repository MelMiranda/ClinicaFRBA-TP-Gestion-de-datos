--------------------------BORRO FKS---------------------------------------------
IF OBJECT_ID('TRIGGER_EXPLOSION.ConsultaMedica', 'U') IS NOT NULL
	ALTER TABLE TRIGGER_EXPLOSION.ConsultaMedica DROP CONSTRAINT FK_ConsultaMedica_Turno;
IF OBJECT_ID('TRIGGER_EXPLOSION.Compra', 'U') IS NOT NULL
	ALTER TABLE TRIGGER_EXPLOSION.Compra DROP CONSTRAINT FK_Compra_Afiliado;
IF OBJECT_ID('TRIGGER_EXPLOSION.Bono', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.Bono DROP CONSTRAINT	FK_Bono_Compra;
	ALTER TABLE TRIGGER_EXPLOSION.Bono DROP CONSTRAINT	FK_Bono_AfiliadoComprador;
	ALTER TABLE TRIGGER_EXPLOSION.Bono DROP CONSTRAINT	FK_Bono_PlanOriginal;
	ALTER TABLE TRIGGER_EXPLOSION.Bono DROP CONSTRAINT	FK_Bono_AfiliadoUsadoPor;
	END

IF OBJECT_ID('TRIGGER_EXPLOSION.Cancelacion', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.Cancelacion DROP CONSTRAINT	FK_Cancelacion_TipoCancelacion;
	ALTER TABLE TRIGGER_EXPLOSION.Cancelacion DROP CONSTRAINT	FK_Cancelacion_Turno;
	END
	
IF OBJECT_ID('TRIGGER_EXPLOSION.Afiliado', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.Afiliado DROP CONSTRAINT	FK_Afiliado_Tipo_documento;
	ALTER TABLE TRIGGER_EXPLOSION.Afiliado DROP CONSTRAINT	FK_Afiliado_Plan;
	ALTER TABLE TRIGGER_EXPLOSION.Afiliado DROP CONSTRAINT	FK_Afiliado_Usuario;
	ALTER TABLE TRIGGER_EXPLOSION.Afiliado DROP CONSTRAINT	FK_Afiliado_Conyuge;
	ALTER TABLE TRIGGER_EXPLOSION.Afiliado DROP CONSTRAINT	FK_Afiliado_EstadoCivil;
	ALTER TABLE TRIGGER_EXPLOSION.Afiliado DROP CONSTRAINT	FK_Afiliado_Padre;
	END
	
IF OBJECT_ID('TRIGGER_EXPLOSION.Profesional', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.Profesional DROP CONSTRAINT FK_Profesional_Tipo_documento;
	ALTER TABLE TRIGGER_EXPLOSION.Profesional DROP CONSTRAINT	FK_Profesional_Rol;
	ALTER TABLE TRIGGER_EXPLOSION.Profesional DROP CONSTRAINT	FK_Profesional_Usuario;
	END

IF OBJECT_ID('TRIGGER_EXPLOSION.Especialidad', 'U') IS NOT NULL 
	ALTER TABLE TRIGGER_EXPLOSION.Especialidad DROP CONSTRAINT	FK_Especialidad_TipoEspecialidad;

IF OBJECT_ID('TRIGGER_EXPLOSION.Turno', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.Turno DROP CONSTRAINT FK_Turno_Especialidad;
	ALTER TABLE TRIGGER_EXPLOSION.Turno DROP CONSTRAINT	FK_Turno_Afiliado;
	ALTER TABLE TRIGGER_EXPLOSION.Turno DROP CONSTRAINT	FK_Turno_Profesional;
	END

IF OBJECT_ID('TRIGGER_EXPLOSION.Modificaciones_afiliado', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.Modificaciones_afiliado DROP CONSTRAINT FK_Afiliado;
	ALTER TABLE TRIGGER_EXPLOSION.Modificaciones_afiliado DROP CONSTRAINT FK_PlanViejo;
	END

IF OBJECT_ID('TRIGGER_EXPLOSION.Agenda', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.Agenda DROP CONSTRAINT FK_Agenda_Profesional;
	END

IF OBJECT_ID('TRIGGER_EXPLOSION.Dias_disponible', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.Dias_disponible DROP CONSTRAINT FK_Dias_Agenda;
	END

IF OBJECT_ID('TRIGGER_EXPLOSION.UsuarioXRol', 'U') IS NOT NULL 
	BEGIN
	ALTER TABLE TRIGGER_EXPLOSION.UsuarioXRol DROP CONSTRAINT FK_UsuarioXRol_Usuario;
	ALTER TABLE TRIGGER_EXPLOSION.UsuarioXRol DROP CONSTRAINT FK_UsuarioXRol_Rol;
	END

----------------------------------------------------------------------
---------------------------procedures---------------------------------
----------------------------------------------------------------------
IF OBJECT_ID('SP_ResetIntentos') IS NOT NULL DROP PROC TRIGGER_EXPLOSIONN.SP_ResetIntentos


DROP PROCEDURE TRIGGER_EXPLOSION.alta_usuario;
DROP PROCEDURE TRIGGER_EXPLOSION.alta_afiliado;
DROP PROCEDURE TRIGGER_EXPLOSION.baja_afiliado;  
DROP PROCEDURE TRIGGER_EXPLOSION.getAfiliados;
DROP PROCEDURE TRIGGER_EXPLOSION.modificar_afiliado; 

DROP PROCEDURE TRIGGER_EXPLOSION.asignarFuncionalidad; 
DROP PROCEDURE TRIGGER_EXPLOSION.SP_altaRol;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_bajaRol;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_CambiarPassword;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_deshabilitarRol;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_habilitarRol;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_HabilitarUsuario;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_ResetIntentos;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_SumarIntentoFallido;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_getRol;
DROP PROCEDURE TRIGGER_EXPLOSION.SP_updateRol;
DROP FUNCTION TRIGGER_EXPLOSION.getRolesDelUsuario;
DROP PROCEDURE TRIGGER_EXPLOSION.GetDisponibilidadPorIdUsuario;
DROP FUNCTION TRIGGER_EXPLOSION.GetProfesionalId;
DROP FUNCTION TRIGGER_EXPLOSION.getFuncDelRol;
DROP PROCEDURE TRIGGER_EXPLOSION.comprarBonos;
DROP function TRIGGER_EXPLOSION.AfiliadosBonos;
DROP PROCEDURE TRIGGER_EXPLOSION.GetIdAfiliado;
DROP PROCEDURE TRIGGER_EXPLOSION.GetIdProfesional;
DROP function TRIGGER_EXPLOSION.ProfesionalesConsultados;
DROP procedure TRIGGER_EXPLOSION.getFuncionalidades;

DROP PROCEDURE TRIGGER_EXPLOSION.turnos_dia_siguiente;
drop procedure TRIGGER_EXPLOSION.cancelar_turno;
drop procedure TRIGGER_EXPLOSION.cancelar_turno_fechaEspecifica;
drop procedure TRIGGER_EXPLOSION.cancelar_turno_rangoDeFechas;
drop function TRIGGER_EXPLOSION.EspecialidadesBonos;
drop function TRIGGER_EXPLOSION.EspecialidadesBonos; -- Esta duplicado esto?
drop procedure TRIGGER_EXPLOSION.InsertarDiasPorDisponibilidad;
drop procedure TRIGGER_EXPLOSION.InsertDisponibilidadPorIdUsuario;
drop PROCEDURE TRIGGER_EXPLOSION.ProfesionalesConsultados;
drop procedure TRIGGER_EXPLOSION.SP_PrimeraVez;
drop function TRIGGER_EXPLOSION.EspecialidadesCanceladas;
drop function TRIGGER_EXPLOSION.EspecialidadesCanceladas;
drop function TRIGGER_EXPLOSION.ProfesionalesHoras;
drop function TRIGGER_EXPLOSION.FX_get_Disponibilidad;
drop function TRIGGER_EXPLOSION.getFechasDeTurnos;
drop function TRIGGER_EXPLOSION.getCantidadHorasEnLaSemana;
drop function TRIGGER_EXPLOSION.YaExisteAfiliadoConDocumento;
drop procedure TRIGGER_EXPLOSION.EliminarFuncionalidades;
drop procedure TRIGGER_EXPLOSION.ExisteRol;
drop procedure TRIGGER_EXPLOSION.FuncionalidadesPorRol;
drop function TRIGGER_EXPLOSION.getHorarioDisponibleDelDia;
drop procedure TRIGGER_EXPLOSION.getRoles;
drop procedure TRIGGER_EXPLOSION.inhabilitarRolXUsuario;
drop procedure TRIGGER_EXPLOSION.getRolesHabilitados;
drop procedure TRIGGER_EXPLOSION.ModificarNombreRol;
drop procedure TRIGGER_EXPLOSION.obtenerFuncionalidadId;
drop procedure TRIGGER_EXPLOSION.obtenerRolId;
drop function TRIGGER_EXPLOSION.ProfesionalesHoras;
drop procedure TRIGGER_EXPLOSION.RolHabilitado;

DROP FUNCTION TRIGGER_EXPLOSION.SP_validarRol;
----------------------------------------------------------------------
------------------------------drops-----------------------------------
----------------------------------------------------------------------

IF OBJECT_ID('TRIGGER_EXPLOSION.ProfesionalXEspecialidad', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.ProfesionalXEspecialidad;
IF OBJECT_ID('TRIGGER_EXPLOSION.Afiliado', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Afiliado;
IF OBJECT_ID('TRIGGER_EXPLOSION.Bono', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Bono;
IF OBJECT_ID('TRIGGER_EXPLOSION.Cancelacion', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Cancelacion;
IF OBJECT_ID('TRIGGER_EXPLOSION.Compra', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Compra;
IF OBJECT_ID('TRIGGER_EXPLOSION.ConsultaMedica', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.ConsultaMedica;
IF OBJECT_ID('TRIGGER_EXPLOSION.Especialidad', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Especialidad;
IF OBJECT_ID('TRIGGER_EXPLOSION.TipoCancelacion', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.TipoCancelacion;
IF OBJECT_ID('TRIGGER_EXPLOSION.TipoEspecialidad', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.TipoEspecialidad;
IF OBJECT_ID('TRIGGER_EXPLOSION.Turno', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Turno;
IF OBJECT_ID('TRIGGER_EXPLOSION.Profesional', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Profesional;
IF OBJECT_ID('TRIGGER_EXPLOSION.EstadoCivil', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.EstadoCivil;
IF OBJECT_ID('TRIGGER_EXPLOSION.Usuario', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Usuario;
IF OBJECT_ID('TRIGGER_EXPLOSION.Rol', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Rol;
IF OBJECT_ID('TRIGGER_EXPLOSION.PlanMedico', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.PlanMedico;
IF OBJECT_ID('TRIGGER_EXPLOSION.RolXFuncionalidad', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.RolXFuncionalidad;
IF OBJECT_ID('TRIGGER_EXPLOSION.Funcionalidad', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Funcionalidad;
IF OBJECT_ID('TRIGGER_EXPLOSION.TipoDocumento', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.TipoDocumento;
IF OBJECT_ID('TRIGGER_EXPLOSION.Modificaciones_afiliado', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Modificaciones_afiliado;
IF OBJECT_ID('TRIGGER_EXPLOSION.Agenda', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Agenda;
IF OBJECT_ID('TRIGGER_EXPLOSION.Dias_disponible', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.Dias_disponible;
IF OBJECT_ID('TRIGGER_EXPLOSION.UsuarioXRol', 'U') IS NOT NULL DROP TABLE TRIGGER_EXPLOSION.UsuarioXRol;



----------------------------------------------------------------------
-------------------------Stored Procedures----------------------------
----------------------------------------------------------------------


IF OBJECT_ID('TRIGGER_EXPLOSION.SP_ResetIntentos') IS NOT NULL DROP PROC TRIGGER_EXPLOSION.SP_ResetIntentos
IF OBJECT_ID('TRIGGER_EXPLOSION.SP_CambiarPassword') IS NOT NULL DROP PROC TRIGGER_EXPLOSION.SP_CambiarPassword
IF OBJECT_ID('TRIGGER_EXPLOSION.SP_HabilitarUsuario') IS NOT NULL DROP PROC TRIGGER_EXPLOSION.SP_HabilitarUsuario
IF OBJECT_ID('TRIGGER_EXPLOSION.SP_DesHabilitarUsuario') IS NOT NULL DROP PROC TRIGGER_EXPLOSION.SP_DesHabilitarUsuario
IF OBJECT_ID('TRIGGER_EXPLOSION.SP_SumarIntentoFallido') IS NOT NULL DROP PROC TRIGGER_EXPLOSION.SP_SumarIntentoFallido
IF OBJECT_ID('TRIGGER_EXPLOSION.SP_PrimeraVez') IS NOT NULL DROP PROC TRIGGER_EXPLOSION.SP_PrimeraVez


DROP SCHEMA TRIGGER_EXPLOSION;


