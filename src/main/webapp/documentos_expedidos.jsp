<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de Documentos | Registraduria Nobsa</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@600;700&family=Inter:wght@300;400;500;600&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            var(--primary-navy): #002b5c;
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
            -webkit-font-smoothing: antialiased;
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
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(0, 43, 92, 0.15);
        }
        
        .btn-primary:hover {
            background: var(--blue-accent);
        }

        .btn-action-icon {
            background: #f1f5f9;
            color: var(--text-gray);
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            cursor: pointer;
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
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .badge-vigente { background: var(--success-soft); color: var(--success-text); border: 1px solid #bbf7d0; }
        .badge-vencido { background: var(--danger-soft); color: var(--danger-text); border: 1px solid #fecaca; }
        .badge-cancelado { background: #f1f5f9; color: var(--text-gray); border: 1px solid var(--border-color); }

        /* --- MODAL GLASSMORPHISM (SIN ANIMACIONES) --- */
        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 43, 92, 0.4);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            display: none; justify-content: center; align-items: center;
            z-index: 1000;
        }

        .modal-overlay.active { display: flex; }

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
            cursor: pointer; color: var(--text-gray); 
            display: flex; align-items: center; justify-content: center; font-size: 1.2rem;
        }
        .close-btn:hover { background: var(--danger-soft); color: var(--danger-text); }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .full-width { grid-column: 1 / -1; }
        
        .form-group label {
            display: block; font-size: 0.75rem; font-weight: 700; color: var(--primary-navy);
            margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px;
        }
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%; padding: 14px 16px; border: 2px solid var(--border-color);
            border-radius: 12px; box-sizing: border-box; font-family: 'Inter', sans-serif;
            font-size: 0.95rem; color: var(--text-dark); background: var(--bg-body);
        }
        
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none; border-color: var(--blue-accent); background: var(--white);
            box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.1);
        }
        
        .readonly-input { background: #f1f5f9 !important; color: #94a3b8 !important; pointer-events: none; border-color: #e2e8f0 !important; }

        .modal-footer {
            margin-top: 30px; display: flex; justify-content: flex-end; gap: 12px;
            padding-top: 20px; border-top: 1px solid var(--border-color);
        }
        
        .btn-cancel {
            background: var(--white); color: var(--text-dark); padding: 12px 24px;
            border-radius: 12px; border: 1px solid var(--border-color); cursor: pointer;
            font-weight: 600;
        }
        .btn-cancel:hover { background: #f1f5f9; }

        /* --- ALERTAS --- */
        .alert { padding: 16px 20px; border-radius: 12px; margin-bottom: 25px; font-weight: 600; display: flex; align-items: center; gap: 10px; }
        .alert-error { background: var(--danger-soft); color: var(--danger-text); border: 1px solid #fecaca; }
        .alert-success { background: var(--success-soft); color: var(--success-text); border: 1px solid #bbf7d0; }
        
        /* Ajustes SwitAlert2 */
        .swal2-popup { font-family: 'Inter', sans-serif !important; border-radius: 20px !important; }
        .swal2-confirm { border-radius: 10px !important; padding: 12px 24px !important; font-weight: 600 !important; }
        .swal2-cancel { border-radius: 10px !important; padding: 12px 24px !important; font-weight: 600 !important; }
    </style>
</head>
<body>

    <aside class="sidebar">
        <div class="sidebar-logo">
            <h2>Registraduria</h2>
            <small>Gestion Interna</small>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/ciudadanos" class="nav-item"><i class="fa-solid fa-users"></i> Personas</a>
            <a href="${pageContext.request.contextPath}/documentos-expedidos" class="nav-item active"><i class="fa-solid fa-id-card"></i> Documentos</a>
            <a href="${pageContext.request.contextPath}/zonas" class="nav-item"><i class="fa-solid fa-map-location-dot"></i> Zonas de votacion</a>
            <a href="${pageContext.request.contextPath}/mesas" class="nav-item"><i class="fa-solid fa-box-archive"></i> Mesas</a>
        </nav>
        <div style="margin-top: auto; padding: 0 30px;">
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="padding: 16px 0; color: #cbd5e1; border-top: 1px solid rgba(255,255,255,0.1);">
                <i class="fa-solid fa-arrow-right-from-bracket"></i> Cerrar Sesion
            </a>
        </div>
    </aside>

    <main class="main-content">
        <header class="page-header">
            <div>
                <h1>Documentos Expedidos</h1>
                <p style="color: var(--text-gray); margin: 8px 0 0;">Control de tramites de identidad en Nobsa, Boyaca</p>
            </div>
            <button class="btn-primary" onclick="abrirModalNuevo()">
                <i class="fa-solid fa-plus"></i> Expedir Documento
            </button>
        </header>

        <c:if test="${not empty param.error}">
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i> ${param.error}
            </div>
        </c:if>

        <c:if test="${not empty param.msj}">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i> ${param.msj}
            </div>
        </c:if>

        <div class="data-card">
            <div class="table-toolbar">
                <div style="color: var(--text-gray); font-size: 0.9rem; font-weight: 500;">
                    Total registrados: <strong style="color: var(--primary-navy);">${listaDocumentos.size()}</strong> tramites
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Serie</th>
                        <th>Ciudadano</th>
                        <th>Tipo Documento</th>
                        <th>Expedicion</th>
                        <th>Vencimiento</th>
                        <th>Estado</th>
                        <th style="text-align: right;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="d" items="${listaDocumentos}">
                        <tr>
                            <td style="font-family: 'Inter', monospace; font-weight: 700; color: var(--blue-accent);">${d.numeroSerie}</td>
                            <td>
                                <strong style="color: var(--primary-navy);">${d.nombreCompleto}</strong><br>
                                <small style="color: var(--text-gray); font-weight: 500;">CC: ${d.documentoCiudadano}</small>
                            </td>
                            <td style="font-weight: 500;">${d.tipoDocumento}</td>
                            <td>${d.fechaExpedicion}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty d.fechaVencimiento}"><span style="color: var(--text-gray);">Indefinido</span></c:when>
                                    <c:otherwise>${d.fechaVencimiento}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <span class="badge ${d.estado == 'vigente' ? 'badge-vigente' : (d.estado == 'vencido' ? 'badge-vencido' : 'badge-cancelado')}">
                                    <c:if test="${d.estado == 'vigente'}"><i class="fa-solid fa-check"></i></c:if>
                                    <c:if test="${d.estado == 'vencido'}"><i class="fa-solid fa-triangle-exclamation"></i></c:if>
                                    <c:if test="${d.estado == 'cancelado'}"><i class="fa-solid fa-ban"></i></c:if>
                                    ${d.estado}
                                </span>
                            </td>
                            <td style="text-align: right;">
                                <button class="btn-action-icon" title="Editar Tramite"
                                        data-id="${d.id}"
                                        data-ciu="${d.idCiudadano}"
                                        data-tipo="${d.tipoDocumento}"
                                        data-ser="${d.numeroSerie}"
                                        data-fexp="${d.fechaExpedicion}"
                                        data-fven="${d.fechaVencimiento}"
                                        data-est="${d.estado}"
                                        data-obs="${fn:replace(d.observaciones, "\"", "&quot;")}"
                                        onclick="abrirModalEditar(this)">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                                
                                <button class="btn-action-icon danger" title="Anular Registro" onclick="confirmarEliminar(${d.id})">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <div id="modalDocumento" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Expedir Documento</h2>
                <button type="button" class="close-btn" onclick="cerrarModal()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            
            <form action="${pageContext.request.contextPath}/documentos-expedidos" method="post">
                <input type="hidden" name="action" id="formAction" value="insertar">
                <input type="hidden" name="id" id="formId">

                <div class="form-grid">
                    <div class="form-group full-width">
                        <label>Ciudadano Propietario</label>
                        <select name="idCiudadano" id="formIdCiudadano" required>
                            <option value="">-- Seleccionar Ciudadano --</option>
                            <c:forEach var="c" items="${listaCiudadanos}">
                                <option value="${c.id}">${c.numeroDocumento} - ${c.nombres} ${c.apellidos}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Tipo de Documento</label>
                        <select name="tipoDocumento" id="formTipo" required>
                            <option value="Cédula de Ciudadanía">Cedula de Ciudadania</option>
                            <option value="Tarjeta de Identidad">Tarjeta de Identidad</option>
                            <option value="Registro Civil">Registro Civil</option>
                            <option value="Contraseña">Contrasena</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Numero de Serie</label>
                        <input type="text" name="numeroSerie" id="formSerie" placeholder="Automatico si se deja vacio">
                    </div>

                    <div class="form-group">
                        <label>Fecha Expedicion</label>
                        <input type="date" name="fechaExpedicion" id="formFechaExp">
                    </div>

                    <div class="form-group">
                        <label>Fecha Vencimiento</label>
                        <input type="date" name="fechaVencimiento" id="formFechaVenc" placeholder="Calculo legal automatico">
                    </div>

                    <div class="form-group full-width">
                        <label>Estado del Tramite</label>
                        <select name="estado" id="formEstado">
                            <option value="vigente">Vigente</option>
                            <option value="vencido">Vencido</option>
                            <option value="cancelado">Cancelado</option>
                        </select>
                    </div>

                    <div class="form-group full-width">
                        <label>Observaciones del Registrador</label>
                        <textarea name="observaciones" id="formObs" rows="3" placeholder="Anadir notas adicionales..."></textarea>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="cerrarModal()">Cancelar</button>
                    <button type="submit" class="btn-primary">Confirmar Tramite</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const modal = document.getElementById('modalDocumento');

        function abrirModalNuevo() {
            document.getElementById('formAction').value = "insertar";
            document.getElementById('modalTitle').innerText = "Expedir Nuevo Documento";
            document.getElementById('formId').value = "";
            
            let ciuInput = document.getElementById('formIdCiudadano');
            ciuInput.value = "";
            ciuInput.classList.remove('readonly-input');
            
            let serieInput = document.getElementById('formSerie');
            serieInput.value = "";
            serieInput.readOnly = false;
            serieInput.classList.remove('readonly-input');
            serieInput.placeholder = "Automatico si se deja vacio";
            
            document.getElementById('formTipo').value = "Cédula de Ciudadanía";
            document.getElementById('formFechaExp').value = new Date().toISOString().split('T')[0];
            
            let vencInput = document.getElementById('formFechaVenc');
            vencInput.value = "";
            vencInput.readOnly = false;
            vencInput.classList.remove('readonly-input');
            vencInput.placeholder = "Calculo legal automatico";
            
            document.getElementById('formEstado').value = "vigente";
            document.getElementById('formObs').value = "";
            
            modal.classList.add('active');
        }

        function abrirModalEditar(btn) {
            document.getElementById('formAction').value = "actualizar";
            document.getElementById('modalTitle').innerText = "Editar Documento";
            
            document.getElementById('formId').value = btn.getAttribute('data-id');
            
            let ciuInput = document.getElementById('formIdCiudadano');
            ciuInput.value = btn.getAttribute('data-ciu');
            ciuInput.classList.add('readonly-input');
            
            document.getElementById('formTipo').value = btn.getAttribute('data-tipo');
            
            let serieInput = document.getElementById('formSerie');
            serieInput.value = btn.getAttribute('data-ser');
            serieInput.readOnly = true;
            serieInput.classList.add('readonly-input');
            
            document.getElementById('formFechaExp').value = btn.getAttribute('data-fexp');
            
            let vencInput = document.getElementById('formFechaVenc');
            vencInput.value = btn.getAttribute('data-fven');
            vencInput.readOnly = false;
            vencInput.classList.remove('readonly-input');
            
            document.getElementById('formEstado').value = btn.getAttribute('data-est');
            document.getElementById('formObs').value = btn.getAttribute('data-obs');
            
            modal.classList.add('active');
        }

        function cerrarModal() {
            modal.classList.remove('active');
        }

        function confirmarEliminar(id) {
            Swal.fire({
                title: '¿Anular este documento?',
                text: "Esta accion borrara el registro fisico del sistema de Nobsa.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#e11d48',
                cancelButtonColor: '#64748b',
                confirmButtonText: 'Si, eliminar',
                cancelButtonText: 'Cancelar',
                animation: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "${pageContext.request.contextPath}/documentos-expedidos?action=eliminar&id=" + id;
                }
            })
        }

        window.onclick = function(event) {
            if (event.target == modal) cerrarModal();
        }
    </script>
</body>
</html>