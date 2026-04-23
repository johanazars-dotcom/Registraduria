#  Sistema de Registro Electoral - Registraduría de Nobsa

Este proyecto es una plataforma web desarrollada bajo el programa ADSO (Análisis y Desarrollo de Software) en el SENA CIMM. Su objetivo es gestionar el censo electoral y la validación de documentos de identidad para el municipio de Nobsa, Boyacá.

##  Justificación Técnica del Motor de DB
Para este proyecto se ha seleccionado PostgreSQL como motor de base de datos por las siguientes razones

1. Integridad Referencial Robusta Permite una gestión estricta de Llaves Foráneas entre las 5 tablas del sistema (ciudadanos, documentos, ciudades, zonas y mesas), garantizando la consistencia de los datos.
2. Tipos de Datos Avanzados El uso de tipos `DATE` y `TIMESTAMP` nativos facilita la integración con la API `java.time` de Java 21 sin pérdida de precisión.
3. Escalabilidad y Concurrencia Ofrece un rendimiento profesional para manejar múltiples consultas simultáneas, ideal para un entorno de consulta pública de ciudadanos.
4. Dominio Técnico Se elige PostgreSQL por ser el motor principal trabajado durante las sesiones de formación, permitiendo optimizar el diseño del esquema y las consultas complejas.

---

##  Arquitectura y Restricciones de Código

El desarrollo sigue estrictamente los estándares de calidad exigidos

 Patrón DAO (Data Access Object) Toda la lógica de persistencia está encapsulada. Los Servlets no contienen sentencias SQL.
 PreparedStatement Uso obligatorio en todas las consultas para prevenir ataques de Inyección SQL.
 Try-with-resources Implementado en todos los métodos del DAO para garantizar el cierre automático de conexiones y liberar recursos del servidor.
 Patrón POSTRedirectGET Aplicado en los Servlets para evitar la duplicación de registros al refrescar el navegador.
 Zero SQL en Servlets Cumplimiento total de la restricción de separar la lógica de control de la lógica de acceso a datos.

---

## Modelo de Datos (5 Tablas)

El sistema se fundamenta en 5 entidades interconectadas

1.  Ciudades Gestión de la división política local.
2.  Zonas de Votación Ubicaciones físicas de los puestos de votación en Nobsa.
3.  Mesas de Votación Subdivisiones para organizar el flujo de votantes.
4.  Ciudadanos Entidad principal con datos personales y vinculación a mesa.
5.  Documentos Expedidos Registro de vigencia y estado (vigente, vencido, cancelado) vinculado a cada ciudadano.
6.  Administradores que registran eliminan y editan los ciudadanos, zonas y documentos expedidos



---

## Tecnologías Utilizadas
 Backend Java 21, Jakarta EE (Servlets & JSP).
 Frontend HTML5, CSS3 (Fuentes Inter & Playfair Display), JavaScript (SweetAlert2).
 Base de Datos PostgreSQL.
 Seguridad Google reCAPTCHA v2.
 Entorno de Desarrollo VS Code  Maven.

---

## Autor
Johann Sebastián Salazar Lopez Aprendiz ADSO - SENA Regional Boyacá Centro Industrial de Mantenimiento y Manufactura (CIMM)