Sistema de Gestion Electoral y de Identidad
Entidad: Registraduria Municipal de Nobsa, Boyaca
Proyecto: Modulo de Administracion y Consulta Ciudadana

1. Introduccion
Este sistema tiene como objetivo automatizar los procesos de inscripcion de ciudadanos, expedicion de documentos de identidad y asignacion de puestos de votacion en el municipio de Nobsa. La plataforma esta dividida en un portal publico de consulta para los votantes y un panel administrativo protegido para los funcionarios.

2. Tecnologias y Requisitos del Sistema
Entorno de Desarrollo
Lenguaje: Java JDK 17 o superior.

Servidor: Apache Tomcat 10 (Jakarta EE).

Base de Datos: PostgreSQL.

Librerias Back-end: JSTL (Jakarta Standard Tag Library) para el manejo dinamico de las vistas.

Interfaz de Usuario (Front-end)
Tecnologias Base: HTML5 y CSS3.

Estilo Visual: Minimalista, utilizando una paleta institucional en blanco y azul.

Frameworks y Herramientas: FontAwesome 6 para iconografia, SweetAlert 2 para notificaciones modernas, y Google reCAPTCHA para la seguridad del portal publico.

3. Arquitectura del Sistema (MVC)
El software sigue el patron de diseno Modelo-Vista-Controlador (MVC) para garantizar escalabilidad y facilidad de mantenimiento:

Modelo: Clases Java (POJO) que representan las entidades del sistema (Ciudadano, Documento, Mesa, Zona).

Vista: Paginas JSP (JavaServer Pages) con diseno adaptativo e interfaz limpia.

Controlador: Servlets encargados de gestionar las peticiones HTTP, procesar la logica de negocio y comunicarse con la base de datos.

Capa DAO (Data Access Object): Interfaces implementadas para la persistencia de datos usando JDBC.

4. Especificaciones Funcionales
Gestion de Ciudadanos
Inscripcion: Captura de datos basicos (nombres, apellidos, fecha de nacimiento, contacto).

Identificacion Automatica: Generacion automatica de identificacion con el prefijo regional de Nobsa (15491) para personas sin documento previo.

Asignacion Electoral: Vinculacion del ciudadano con una mesa y puesto de votacion.

Gestion de Documentos
Control de Tramites: Registro de Cedulas, Tarjetas de Identidad, etc.

Seguimiento de Estados: Clasificacion en estado Vigente, Vencido o Cancelado.

Seguridad de Integridad: Restriccion para impedir la eliminacion de ciudadanos con documentos activos.

Logistica Electoral
Zonificacion: Administracion de puestos de votacion por sectores.

Gestion de Mesas: Control de capacidad y ubicacion fisica detallada (aulas/salones).

5. Estructura de la Base de Datos
El modelo relacional se fundamenta en las siguientes entidades:

Ciudades: Tabla maestra de municipios para vinculacion territorial.

Zonas de Votacion: Definicion de los puestos de votacion geograficos.

Mesas de Votacion: Detalle de mesas vinculadas a una zona especifica.

Ciudadanos: Informacion del votante y su vinculo con la mesa.

Documentos Expedidos: Registro historico de la identificacion fisica.

6. Seguridad y Validaciones
Sesiones: Acceso al panel administrativo protegido mediante sessionScope.

Proteccion de Datos: Limpieza de caracteres especiales para evitar errores y vulnerabilidades.

Validacion Humana: Mitigacion de ataques de bots mediante Google reCAPTCHA en las consultas publicas.

7. Manual de Operacion Basica
Ingreso: Acceso de funcionarios mediante login institucional.

Registro y Edicion: Uso de modales y botones dedicados para crear ("Inscribir Persona") o editar datos sin recargar la pagina.

Consulta: Los ciudadanos pueden consultar e imprimir su certificado de votacion usando unicamente su cedula desde el portal principal.

Elaborado por: Johann Sebastian Salazar Lopez
Ubicacion: Sogamoso, Boyaca, Colombia
Fecha de actualizacion: 23 Abril, 2026
