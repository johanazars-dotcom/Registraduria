<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Ciudadanos | Registraduría de Nobsa</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-navy: #002b5c;
            --blue-accent: #007bff;
            --blue-light: #e6f0f9;
            --bg-body: #f8fafc;
            --card-bg: #ffffff;
            --text-dark: #0f172a;
            --text-gray: #64748b;
            --border-color: #e2e8f0;
            --danger-soft: #fee2e2;
            --danger-text: #dc2626;
            --success-soft: #dcfce7;
            --success-text: #166534;
            --sidebar-width: 280px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            margin: 0;
            display: flex;
            color: var(--text-dark);
            background-image: radial-gradient(var(--blue-light) 1px, transparent 1px);
            background-size: 30px 30px;
        }

        /* --- SIDEBAR AESTHETIC --- */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background-color: var(--primary-navy);
            color: #ffffff;
            position: fixed;
            left: 0;
            top: 0;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            z-index: 100;
            box-shadow: 4px 0 20px rgba(0, 43, 92, 0.1);
        }

        .sidebar-logo {
            padding: 0 30px 30px;
            border-bottom: 1px solid rgba(255,255,255,0.05);
            margin-bottom: 20px;
        }
        
        .sidebar-logo h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 800;
            margin: 0;
            letter-spacing: -0.5px;
        }

        .sidebar-logo small {
            color: var(--blue-accent);
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-size: 0.75rem;
        }

        .nav-item {
            padding: 16px 30px;
            display: flex;
            align-items: center;
            gap: 15px;
            color: rgba(255,255,255,0.6);
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 500;
            border-right: 4px solid transparent;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(255,255,255,0.05);
            color: #ffffff;
            border-right-color: var(--blue-accent);
        }
        
        .nav-item i { width: 20px; text-align: center; }

        /* --- CONTENIDO PRINCIPAL --- */
        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            padding: 50px;
            max-width: 1400px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 40px;
        }
        
        .page-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-weight: 800;
            margin: 0;
            color: var(--primary-navy);
            letter-spacing: -0.5px;
        }

        /* --- TARJETA DE DATOS --- */
        .data-card {
            background: var(--card-bg);
            border-radius: 20px;
            border: 1px solid var(--border-color);
            box-shadow: 0 20px 40px rgba(0, 43, 92, 0.05);
            overflow: hidden;
        }
        
        .table-toolbar {
            padding: 24px;
            border-bottom: 1px solid var(--border-color);
            background: #fafcff;
        }

        table { width: 100%; border-collapse: collapse; }
        
        th {
            background: #f1f5f9;
            padding: 18px 24px;
            font-size: 0.75rem;
            text-transform: uppercase;
            color: var(--text-gray);
            font-weight: 700;
            border-bottom: 1px solid var(--border-color);
            text-align: left;
            letter-spacing: 0.5px;
        }
        
        td {
            padding: 18px 24px;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.95rem;
            color: var(--text-dark);
            transition: background 0.2s;
        }
        
        tr:hover td { background-color: #fafcff; }
        tr:last-child td { border-bottom: none; }

        /* --- BOTONES AESTHETIC --- */
        .btn-primary {
            background: var(--primary-navy);
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(0, 43, 92, 0.15);
        }
        
        .btn-primary:hover {
            background: var(--blue-accent);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.25);
        }

        .btn-action-icon {
            background: #f1f5f9;
            color: var(--text-gray);
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }
        
        .btn-action-icon:hover {
            background: var(--blue-accent);
            color: white;
        }
        
        .btn-action-icon.danger:hover {
            background: var(--danger-text);
            color: white;
        }

        /* --- BADGES --- */
        .badge-puesto {
            background: var(--blue-light);
            color: var(--primary-navy);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .badge-mesa {
            background: var(--blue-accent);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
        }

        /* --- MODAL GLASSMORPHISM --- */
        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 43, 92, 0.4);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            display: none; justify-content: center; align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background: var(--card-bg);
            width: 100%; max-width: 650px;
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 43, 92, 0.25);
        }

        .modal-header {
            display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;
        }
        
        .modal-header h2 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-navy);
            margin: 0;
            font-size: 1.8rem;
            letter-spacing: -0.5px;
        }
        
        .close-btn {
            background: #f1f5f9; border: none; width: 36px; height: 36px; border-radius: 50%;
            cursor: pointer; color: var(--text-gray); transition: 0.2s;
            display: flex; align-items: center; justify-content: center; font-size: 1.2rem;
        }
        .close-btn:hover { background: var(--danger-soft); color: var(--danger-text); }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .full-width { grid-column: 1 / -1; }
        
        .form-group label {
            display: block; font-size: 0.75rem; font-weight: 700; color: var(--primary-navy);
            margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px;
        }
        
        .form-group input, .form-group select {
            width: 100%; padding: 14px 16px; border: 2px solid var(--border-color);
            border-radius: 12px; box-sizing: border-box; font-family: 'Inter', sans-serif;
            font-size: 0.95rem; color: var(--text-dark); transition: 0.3s; background: var(--bg-body);
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none; border-color: var(--blue-accent); background: var(--white);
            box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.1);
        }
        
        .readonly-input { background: #f1f5f9 !important; color: #94a3b8 !important; cursor: not-allowed; border-color: #e2e8f0 !important; }

        .modal-footer {
            margin-top: 30px; display: flex; justify-content: flex-end; gap: 12px;
            padding-top: 20px; border-top: 1px solid var(--border-color);
        }
        
        .btn-cancel {
            background: var(--white); color: var(--text-dark); padding: 12px 24px;
            border-radius: 12px; border: 1px solid var(--border-color); cursor: pointer;
            font-weight: 600; transition: 0.2s;
        }
        .btn-cancel:hover { background: #f1f5f9; }

        /* --- ALERTAS --- */
        .alert { padding: 16px 20px; border-radius: 12px; margin-bottom: 25px; font-weight: 600; display: flex; align-items: center; gap: 10px; }
        .alert-error { background: var(--danger-soft); color: var(--danger-text); border: 1px solid #fecaca; }
        .alert-success { background: var(--success-soft); color: var(--success-text); border: 1px solid #bbf7d0; }
    </style>
</head>
<body>

    <aside class="sidebar">
        <div class="sidebar-logo">
            <h2>Registraduría</h2>
            <small>Gestión Interna</small>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/ciudadanos" class="nav-item active"><i class="fa-solid fa-users"></i> Personas</a>
            <a href="${pageContext.request.contextPath}/documentos-expedidos" class="nav-item"><i class="fa-solid fa-id-card"></i> Documentos</a>
            <a href="${pageContext.request.contextPath}/zonas" class="nav-item"><i class="fa-solid fa-map-location-dot"></i> Zonas de votación</a>
            <a href="${pageContext.request.contextPath}/mesas" class="nav-item"><i class="fa-solid fa-box-archive"></i> Mesas</a>
        </nav>
        <div style="margin-top: auto; padding: 0 30px;">
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="padding: 16px 0; color: #cbd5e1; border-top: 1px solid rgba(255,255,255,0.1);">
                <i class="fa-solid fa-arrow-right-from-bracket"></i> Cerrar Sesión
            </a>
        </div>
    </aside>

    <main class="main-content">
        <header class="page-header">
            <div>
                <h1>Directorio de Ciudadanos</h1>
                <p style="color: var(--text-gray); margin: 8px 0 0;">Censo electoral de Nobsa, Boyacá</p>
            </div>
            <button class="btn-primary" onclick="abrirModalNuevo()">
                <i class="fa-solid fa-plus"></i> Inscribir Persona
            </button>
        </header>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i> ${error}
            </div>
        </c:if>

        <c:if test="${not empty mensaje}">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i> ${mensaje}
            </div>
        </c:if>

        <div class="data-card">
            <div class="table-toolbar">
                <div style="color: var(--text-gray); font-size: 0.9rem; font-weight: 500;">
                    Total registrados: <strong style="color: var(--primary-navy);">${lista.size()}</strong> ciudadanos
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Documento</th>
                        <th>Nombre Completo</th>
                        <th>Puesto de Votación</th>
                        <th>Mesa</th>
                        <th style="text-align: right;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${lista}">
                        <tr>
                            <td style="font-family: 'Inter', monospace; font-weight: 700; color: var(--primary-navy);">${c.numeroDocumento}</td>
                            <td style="font-weight: 500;">${c.nombres} ${c.apellidos}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty c.nombreZona}">
                                        <span class="badge-puesto"><i class="fa-solid fa-location-dot"></i> ${c.nombreZona}</span>
                                    </c:when>
                                    <c:otherwise><span style="color: var(--text-gray); font-size: 0.85rem;">No asignado</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty c.idMesa && c.idMesa != 0}">
                                        <span class="badge-mesa">Mesa ${c.numeroMesa}</span>
                                    </c:when>
                                    <c:otherwise><span style="color: var(--text-gray);">---</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td style="text-align: right;">
                                <button class="btn-action-icon" title="Editar"
                                        data-id="${c.id}"
                                        data-doc="${c.numeroDocumento}"
                                        data-nom="${c.nombres}"
                                        data-ape="${c.apellidos}"
                                        data-fec="${c.fechaNacimiento}"
                                        data-tel="${c.telefono}"
                                        data-cor="${c.correo}"
                                        data-mes="${c.idMesa}"
                                        onclick="abrirModalEditar(this)">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                                
                                <a href="${pageContext.request.contextPath}/ciudadanos?action=eliminar&id=${c.id}" 
                                   class="btn-action-icon danger" title="Eliminar"
                                   onclick="return confirm('¿Está seguro de eliminar permanentemente este registro?')">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <div id="modalCiudadano" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Inscribir Persona</h2>
                <button type="button" class="close-btn" onclick="cerrarModal()">&times;</button>
            </div>
            
            <form action="${pageContext.request.contextPath}/ciudadanos" method="post">
                <input type="hidden" name="action" id="formAction" value="insertar">
                <input type="hidden" name="id" id="formId">

                <div class="form-grid">
                    <div class="form-group full-width">
                        <label>Documento de Identidad</label>
                        <input type="number" name="numeroDocumento" id="formDoc" placeholder="Dejar en blanco para generar automáticamente">
                    </div>
                    <div class="form-group">
                        <label>Nombres</label>
                        <input type="text" name="nombres" id="formNombres" required>
                    </div>
                    <div class="form-group">
                        <label>Apellidos</label>
                        <input type="text" name="apellidos" id="formApellidos" required>
                    </div>
                    <div class="form-group">
                        <label>Fecha de Nacimiento</label>
                        <input type="date" name="fechaNacimiento" id="formFecha" required>
                    </div>
                    <div class="form-group">
                        <label>Teléfono</label>
                        <input type="tel" name="telefono" id="formTel" placeholder="Opcional">
                    </div>
                    <div class="form-group full-width">
                        <label>Correo Electrónico</label>
                        <input type="email" name="correo" id="formCorreo" placeholder="Opcional">
                    </div>

                    <div class="form-group full-width">
                        <label>Asignación Electoral</label>
                        <select name="idMesa" id="formIdMesa">
                            <option value="">-- Sin asignar / No inscrito --</option>
                            <c:forEach var="m" items="${listaMesas}">
                                <option value="${m.id}">Mesa ${m.numero_mesa} - ${m.nombreZona} (${m.ubicacion_detallada})</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="cerrarModal()">Cancelar</button>
                    <button type="submit" class="btn-primary">Guardar Registro</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const modal = document.getElementById('modalCiudadano');

        function abrirModalNuevo() {
            document.getElementById('formAction').value = "insertar";
            document.getElementById('modalTitle').innerText = "Inscribir Persona";
            document.getElementById('formId').value = "";
            
            let docInput = document.getElementById('formDoc');
            docInput.value = "";
            docInput.readOnly = false;
            docInput.classList.remove('readonly-input');
            
            document.getElementById('formNombres').value = "";
            document.getElementById('formApellidos').value = "";
            document.getElementById('formFecha').value = "";
            document.getElementById('formTel').value = "";
            document.getElementById('formCorreo').value = "";
            document.getElementById('formIdMesa').value = "";
            
            modal.style.display = "flex";
        }

        function abrirModalEditar(btn) {
            document.getElementById('formAction').value = "actualizar";
            document.getElementById('modalTitle').innerText = "Actualizar Datos";
            
            document.getElementById('formId').value = btn.getAttribute('data-id');
            
            let docInput = document.getElementById('formDoc');
            docInput.value = btn.getAttribute('data-doc');
            docInput.readOnly = true;
            docInput.classList.add('readonly-input');
            
            document.getElementById('formNombres').value = btn.getAttribute('data-nom');
            document.getElementById('formApellidos').value = btn.getAttribute('data-ape');
            document.getElementById('formFecha').value = btn.getAttribute('data-fec');
            document.getElementById('formTel').value = btn.getAttribute('data-tel');
            document.getElementById('formCorreo').value = btn.getAttribute('data-cor');
            
            let mesaId = btn.getAttribute('data-mes');
            document.getElementById('formIdMesa').value = (mesaId === 'null' || mesaId === '' || mesaId === '0') ? "" : mesaId;
            
            modal.style.display = "flex";
        }

        function cerrarModal() {
            modal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                cerrarModal();
            }
        }
    </script>
</body>
</html>