<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mesas de Votación | Registraduría Nobsa</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@600;700&family=Inter:wght@300;400;500;600&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
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
        .badge-capacidad {
            background: var(--blue-light);
            color: var(--primary-navy);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

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
            width: 100%; max-width: 550px;
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

        .form-group { margin-bottom: 20px; }
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
            <small>Administración Nobsa</small>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/ciudadanos" class="nav-item"><i class="fa-solid fa-users"></i> Personas</a>
            <a href="${pageContext.request.contextPath}/documentos-expedidos" class="nav-item"><i class="fa-solid fa-id-card"></i> Documentos</a>
            <a href="${pageContext.request.contextPath}/zonas" class="nav-item"><i class="fa-solid fa-map-location-dot"></i> Zonas de Votación</a>
            <a href="${pageContext.request.contextPath}/mesas" class="nav-item active"><i class="fa-solid fa-box-archive"></i> Mesas</a>
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
                <h1>Mesas de Votación</h1>
                <p style="color: var(--text-gray); margin: 8px 0 0;">Distribución de mesas por puestos y capacidades.</p>
            </div>
            <button class="btn-primary" onclick="abrirModalNuevo()">
                <i class="fa-solid fa-plus"></i> Nueva Mesa
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
                    Mesas instaladas: <strong style="color: var(--primary-navy);">${listaMesas.size()}</strong>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID (Interno)</th>
                        <th>Número de Mesa</th>
                        <th>Capacidad</th>
                        <th>Ubicación Física</th>
                        <th>Puesto (Zona)</th>
                        <th style="text-align: right;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="m" items="${listaMesas}">
                        <tr>
                            <td style="font-family: 'Inter', monospace; font-weight: 700; color: var(--text-gray);">${m.id}</td>
                            <td style="font-weight: 600; color: var(--primary-navy); font-size: 1.05rem;">Mesa ${m.numero_mesa}</td>
                            <td>
                                <span class="badge-capacidad">
                                    <i class="fa-solid fa-users"></i> ${m.capacidad} votantes
                                </span>
                            </td>
                            <td>${m.ubicacion_detallada}</td>
                            <td style="font-weight: 500;">${m.nombreZona}</td>
                            <td style="text-align: right;">
                                <button class="btn-action-icon" title="Editar Mesa"
                                        data-id="${m.id}"
                                        data-num="${m.numero_mesa}"
                                        data-cap="${m.capacidad}"
                                        data-ubi="${fn:escapeXml(m.ubicacion_detallada)}"
                                        data-zon="${m.id_zona}"
                                        onclick="abrirModalEditar(this)">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                                
                                <a href="${pageContext.request.contextPath}/mesas?action=eliminar&id=${m.id}" 
                                   class="btn-action-icon danger" title="Eliminar Mesa"
                                   onclick="return confirm('¿Seguro que desea eliminar permanentemente esta mesa?')">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <div id="mesaModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Nueva Mesa</h2>
                <button type="button" class="close-btn" onclick="cerrarModal()">&times;</button>
            </div>
            
            <form action="${pageContext.request.contextPath}/mesas" method="POST">
                <input type="hidden" name="action" id="formAction" value="insertar">
                <input type="hidden" name="id" id="formId">

                <div class="form-group">
                    <label>Número de Mesa</label>
                    <input type="number" name="numero_mesa" id="formNumero" required min="1" placeholder="Ej: 14">
                </div>
                
                <div class="form-group">
                    <label>Capacidad de Votantes</label>
                    <input type="number" name="capacidad" id="formCapacidad" required value="400">
                </div>

                <div class="form-group">
                    <label>Ubicación Física (Aula/Salón)</label>
                    <input type="text" name="ubicacion_detallada" id="formUbicacion" required placeholder="Ej: Aula 101, Piso 1">
                </div>

                <div class="form-group">
                    <label>Puesto de Votación (Zona)</label>
                    <select name="id_zona" id="formZona" required>
                        <option value="">-- Seleccione un puesto --</option>
                        <c:forEach var="z" items="${listaZonas}">
                            <option value="${z.id}">${z.puestoVotacion} (${z.nombreZona})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="cerrarModal()">Cancelar</button>
                    <button type="submit" class="btn-primary">Guardar Información</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const modal = document.getElementById('mesaModal');

        function abrirModalNuevo() {
            document.getElementById('modalTitle').innerText = "Nueva Mesa de Votación";
            document.getElementById('formAction').value = "insertar";
            document.getElementById('formId').value = "";
            document.getElementById('formNumero').value = "";
            document.getElementById('formCapacidad').value = "400";
            document.getElementById('formUbicacion').value = "";
            document.getElementById('formZona').value = "";
            
            modal.classList.add('active');
        }

        function abrirModalEditar(btn) {
            document.getElementById('modalTitle').innerText = "Editar Mesa de Votación";
            document.getElementById('formAction').value = "actualizar";
            
            document.getElementById('formId').value = btn.getAttribute('data-id');
            document.getElementById('formNumero').value = btn.getAttribute('data-num');
            document.getElementById('formCapacidad').value = btn.getAttribute('data-cap');
            document.getElementById('formUbicacion').value = btn.getAttribute('data-ubi');
            document.getElementById('formZona').value = btn.getAttribute('data-zon');
            
            modal.classList.add('active');
        }

        function cerrarModal() {
            modal.classList.remove('active');
        }

        window.onclick = function(event) {
            if (event.target == modal) { 
                cerrarModal(); 
            }
        }
    </script>
</body>
</html>