<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil del Ciudadano | Registraduría Nobsa</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            /* Paleta Aesthetic Blanco y Azul */
            --bg-body: #f8fafc;
            --card-bg: #ffffff;
            --primary-navy: #002b5c;
            --blue-accent: #007bff;
            --blue-light: #e6f0f9;
            --text-dark: #0f172a;
            --text-gray: #64748b;
            --border-color: #e2e8f0;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            background-color: var(--bg-body);
            color: var(--text-dark);
            padding-bottom: 60px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* Fondo sutil */
            background-image: radial-gradient(var(--blue-light) 1px, transparent 1px);
            background-size: 30px 30px;
        }

        .profile-container {
            width: 100%;
            max-width: 850px;
            margin: 40px auto; 
            background: var(--card-bg);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 43, 92, 0.08);
            border: 1px solid var(--border-color);
            overflow: hidden;
            position: relative;
        }

        /* Encabezado Aesthetic */
        .profile-header {
            background: var(--card-bg);
            padding: 50px 50px 30px;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            border-bottom: 1px solid var(--border-color);
        }

        /* Detalle visual superior */
        .profile-header::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--primary-navy), var(--blue-accent));
        }

        .profile-icon {
            background: var(--blue-light);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--blue-accent);
            margin-bottom: 20px;
            box-shadow: 0 10px 20px rgba(0, 123, 255, 0.1);
        }

        .profile-title h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--primary-navy);
            margin: 0 0 5px 0;
            letter-spacing: -0.5px;
        }
        
        .profile-title p {
            color: var(--text-gray);
            margin: 0;
            font-size: 0.95rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 500;
        }

        .profile-body {
            padding: 40px 50px;
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 30px;
            background: var(--card-bg);
        }

        .info-card {
            background: var(--bg-body);
            border-radius: 16px;
            padding: 30px;
            border: 1px solid var(--border-color);
        }

        .section-title {
            color: var(--primary-navy);
            font-size: 1.05rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .section-title i { color: var(--blue-accent); }

        .data-group { margin-bottom: 20px; }
        .data-group:last-child { margin-bottom: 0; }
        
        .data-label { 
            display: block; 
            font-size: 0.75rem; 
            color: var(--text-gray); 
            font-weight: 600; 
            text-transform: uppercase; 
            letter-spacing: 1px;
            margin-bottom: 5px;
        }
        
        .data-value { 
            display: block; 
            font-size: 1.1rem; 
            color: var(--text-dark); 
            font-weight: 500; 
        }
        
        .doc-value { 
            font-family: 'Inter', monospace; 
            font-size: 1.2rem; 
            color: var(--primary-navy); 
            font-weight: 700; 
            background: var(--card-bg); 
            padding: 6px 12px; 
            border-radius: 8px; 
            border: 1px solid var(--border-color);
            display: inline-block;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }

        .electoral-box {
            background: var(--blue-light);
            border: 1px solid rgba(0, 123, 255, 0.2);
            border-radius: 16px; 
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .mesa-number {
            display: inline-block; 
            background: var(--blue-accent); 
            color: white;
            font-size: 1.3rem; 
            font-weight: 700; 
            padding: 10px 24px; 
            border-radius: 50px;
            box-shadow: 0 10px 20px rgba(0, 123, 255, 0.2);
            margin-top: 5px;
        }

        .profile-footer {
            background: var(--card-bg); 
            padding: 30px 50px; 
            border-top: 1px solid var(--border-color);
            display: flex; 
            justify-content: center; 
            gap: 15px;
        }

        .btn-action { 
            padding: 14px 28px; 
            border-radius: 50px; 
            font-weight: 600; 
            text-decoration: none; 
            cursor: pointer; 
            border: none; 
            display: inline-flex; 
            align-items: center; 
            gap: 10px; 
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }
        
        .btn-primary { 
            background: var(--card-bg); 
            color: var(--text-dark); 
            border: 1px solid var(--border-color);
        }
        .btn-primary:hover { background: var(--bg-body); transform: translateY(-2px); }
        
        .btn-success { 
            background: var(--primary-navy); 
            color: white; 
            box-shadow: 0 4px 12px rgba(0, 43, 92, 0.2);
        }
        .btn-success:hover { background: var(--blue-accent); transform: translateY(-2px); }

        /* Estilo para el estado del documento */
        .estado-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            margin-left: 10px;
            vertical-align: middle;
        }
        .estado-vigente { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .estado-alerta { background: #fee2e2; color: #b91c1c; border: 1px solid #fecaca; }

        @media print {
            .profile-footer, .btn-action { display: none !important; }
            body { background: white; align-items: flex-start; padding-top: 20px; }
            .profile-container { box-shadow: none; margin: 0; border: 1px solid #ccc; max-width: 100%; }
            .electoral-box { background: white; border: 2px solid var(--primary-navy); }
        }
    </style>
</head>
<body>

    <main class="profile-container">
        <header class="profile-header">
            <div class="profile-icon"><i class="fa-regular fa-id-card"></i></div>
            <div class="profile-title">
                <h2>Ficha de Identidad Ciudadana</h2>
                <p>Registraduría Municipal de Nobsa</p>
            </div>
        </header>

        <div class="profile-body">
            <div style="display: flex; flex-direction: column; gap: 30px;">
                <div class="info-card">
                    <h3 class="section-title"><i class="fa-solid fa-user"></i> Información Personal</h3>
                    <div class="data-group">
                        <span class="data-label">Número de Documento</span>
                        <div>
                            <span class="doc-value">${c.numeroDocumento}</span>
                            <c:choose>
                                <c:when test="${c.estado == 'vigente'}">
                                    <span class="estado-badge estado-vigente">Vigente</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="estado-badge estado-alerta">${not empty c.estado ? c.estado : 'Sin Expedición'}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="data-group">
                        <span class="data-label">Nombres Completos</span>
                        <span class="data-value">${c.nombres}</span>
                    </div>
                    <div class="data-group">
                        <span class="data-label">Apellidos</span>
                        <span class="data-value">${c.apellidos}</span>
                    </div>
                </div>

                <div class="info-card">
                    <h3 class="section-title"><i class="fa-solid fa-address-book"></i> Datos de Contacto</h3>
                    <div class="data-group">
                        <span class="data-label">Correo Electrónico</span>
                        <span class="data-value">${not empty c.correo ? c.correo : 'No registrado'}</span>
                    </div>
                    <div class="data-group">
                        <span class="data-label">Teléfono de Contacto</span>
                        <span class="data-value">${not empty c.telefono ? c.telefono : 'No registrado'}</span>
                    </div>
                </div>
            </div>

            <div class="electoral-box">
                <div class="section-title" style="border:none; margin-bottom:20px; color:var(--primary-navy)">
                    <i class="fa-solid fa-check-to-slot"></i> Estatus Electoral
                </div>
                
                <div class="data-group">
                    <span class="data-label" style="color: var(--primary-navy);">Puesto de Votación</span>
                    <span class="data-value" style="font-weight: 700; color: var(--primary-navy);">
                        ${not empty c.nombreZona ? c.nombreZona : 'Pendiente de Asignación'}
                    </span>
                </div>
                
                <div class="data-group" style="margin-top: 10px;">
                    <span class="data-label" style="color: var(--primary-navy);">Mesa Asignada</span>
                    <c:choose>
                        <c:when test="${not empty c.idMesa && c.idMesa != 0 && c.estado == 'vigente'}">
                            <div class="mesa-number">MESA N° ${c.numeroMesa}</div>
                        </c:when>
                        <c:when test="${not empty c.idMesa && c.idMesa != 0}">
                            <div style="color:#b91c1c; font-weight:600; background: white; padding: 10px; border-radius: 8px; margin-top: 5px; border: 1px solid #fecaca; font-size: 0.9rem;">
                                <i class="fa-solid fa-circle-exclamation"></i> Documento no vigente. Acérquese a la Registraduría.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <span style="color:var(--text-gray); font-weight:500;">Ciudadano no habilitado para votar</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <footer class="profile-footer">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-action btn-primary">
                <i class="fa-solid fa-magnifying-glass"></i> Nueva Consulta
            </a>
            <button onclick="window.print()" class="btn-action btn-success">
                <i class="fa-solid fa-print"></i> Imprimir Certificado
            </button>
        </footer>
    </main>
</body>
</html>