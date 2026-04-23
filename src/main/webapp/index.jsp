<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal Institucional | Registraduría de Nobsa</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        /* --- PALETA DE COLORES AESTHETIC (SOLO AZUL Y BLANCO) --- */
        :root {
            --base-white: #ffffff;
            --bg-light: #fbfcfd; 
            --blue-light: #e6f0f9; 
            --blue-accent: #007bff; 
            --primary-navy: #002b5c; 
            --text-dark: #001f3f;
            --text-gray: #64748b;
            --border-color: #e2e8f0;
            --shadow-sm: 0 2px 4px rgba(0,43,92,0.03);
            --shadow-md: 0 10px 30px rgba(0,43,92,0.08);
            --shadow-lg: 0 20px 40px rgba(0,43,92,0.12);
        }

        * {
            box-sizing: border-box;
            transition: all 0.3s ease; /* Transiciones suaves para hovers */
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            background-color: var(--bg-light);
            color: var(--text-dark);
            overflow-x: hidden;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* --- HERO MINIMALISTA AESTHETIC --- */
        .hero-aesthetic {
            position: relative;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 120px 20px;
            background-color: var(--base-white);
            background-image: radial-gradient(var(--blue-light) 1px, transparent 1px);
            background-size: 30px 30px;
        }

        .hero-aesthetic::before {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            background: var(--blue-light);
            border-radius: 50%;
            filter: blur(80px);
            top: -100px;
            right: -100px;
            opacity: 0.5;
        }

        .hero-content {
            z-index: 2;
            width: 100%;
            max-width: 800px;
            text-align: center;
        }

        .hero-tag {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 10px 20px;
            background: var(--blue-light);
            color: var(--primary-navy);
            border-radius: 50px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-size: 0.7rem;
            margin-bottom: 25px;
            border: 1px solid rgba(0,43,92,0.1);
        }

        .hero-content h1 {
            font-size: clamp(2.5rem, 6vw, 4.5rem);
            font-weight: 800;
            line-height: 1.1;
            margin: 0 0 15px 0;
            letter-spacing: -2px;
            color: var(--primary-navy);
        }

        .hero-content h1 span {
            color: var(--blue-accent);
            position: relative;
        }
        
        .hero-content h1 span::after {
            content: '';
            position: absolute;
            bottom: 5px;
            left: 0;
            width: 100%;
            height: 8px;
            background-color: rgba(0, 123, 255, 0.1);
            z-index: -1;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            color: var(--text-gray);
            font-weight: 400;
            margin-bottom: 50px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* BUSCADOR ESTILO CLEAN/AESTHETIC */
        .search-aesthetic {
            width: 100%;
            max-width: 650px;
            background: var(--base-white);
            padding: 12px;
            border-radius: 100px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-lg);
            display: flex;
            margin: 0 auto;
        }

        .search-aesthetic:focus-within {
            border-color: var(--blue-accent);
            box-shadow: 0 15px 40px rgba(0, 123, 255, 0.15);
        }

        .search-input-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            padding-left: 20px;
        }

        .search-input-wrapper i {
            color: var(--blue-accent);
            font-size: 1.2rem;
            margin-right: 15px;
        }

        .search-aesthetic input {
            flex: 1;
            background: transparent;
            border: none;
            padding: 15px 10px;
            color: var(--text-dark);
            font-size: 1.1rem;
            outline: none;
            font-family: 'Inter', sans-serif;
        }

        .search-aesthetic input::placeholder { color: #a0aec0; font-weight: 400; }

        .search-aesthetic button {
            background: var(--blue-accent);
            color: var(--base-white);
            border: none;
            padding: 15px 35px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Inter', sans-serif;
        }

        .search-aesthetic button:hover {
            background: var(--primary-navy);
            transform: translateY(-2px);
        }

        .captcha-box {
            margin-top: 30px;
            display: flex;
            justify-content: center;
        }
        
        .g-recaptcha {
            transform: scale(0.9);
            transform-origin: center;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
        }

        /* --- FOOTER AESTHETIC --- */
        .footer-aesthetic {
            background: var(--base-white);
            padding: 60px 20px;
            text-align: center;
            color: var(--primary-navy);
            border-top: 1px solid var(--border-color);
            position: relative;
        }

        .footer-logo {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary-navy);
            letter-spacing: -1px;
            margin-bottom: 10px;
        }
        
        .footer-logo span { color: var(--blue-accent); }

        .footer-aesthetic p {
            letter-spacing: 2px;
            font-weight: 500;
            font-size: 0.8rem;
            color: var(--text-gray);
            text-transform: uppercase;
            margin-top: 0;
        }
        
        .sena-tag {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            background: var(--bg-light);
            padding: 12px 24px;
            border-radius: 50px;
            border: 1px solid var(--border-color);
            margin-top: 30px;
            font-size: 0.9rem;
            color: var(--text-dark);
        }
        
        .sena-tag i { color: var(--blue-accent); }

        .swal2-popup {
            font-family: 'Inter', sans-serif !important;
            border-radius: 20px !important;
            padding: 2em !important;
        }
        .swal2-title {
            color: var(--primary-navy) !important;
            font-weight: 800 !important;
            letter-spacing: -1px;
        }
        .swal2-confirm {
            background-color: var(--blue-accent) !important;
            border-radius: 50px !important;
            padding: 12px 35px !important;
            font-weight: 700 !important;
        }
        .swal2-html-container {
            color: var(--text-gray) !important;
        }
    </style>

    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    
    <script>
        function validarConsulta(e) {
            if (typeof grecaptcha !== 'undefined') {
                var response = grecaptcha.getResponse();
                if (response.length === 0) {
                    e.preventDefault(); 
                    Swal.fire({
                        icon: 'info',
                        title: 'Verificación',
                        text: 'Por favor, completa el captcha para validar que eres humano.',
                        confirmButtonText: 'Entendido',
                        buttonsStyling: true
                    });
                    return false;
                }
            }
            return true;
        }
    </script>
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <section class="hero-aesthetic">
        <div class="hero-content">
            <div class="hero-tag">
                <i class="fa-solid fa-building-flag"></i>
                Sistema Nacional de Identificación
            </div>
            
            <h1>Registraduría<br><span>Nacional</span></h1>
            
            <p class="hero-subtitle">Consulta el lugar de votación para las próximas elecciones en el municipio de Nobsa.</p>

            <form action="consulta-completa" method="post" onsubmit="return validarConsulta(event)">
                <div class="search-aesthetic">
                    <div class="search-input-wrapper">
                        <i class="fa-solid fa-id-card"></i>
                        <input type="text" name="documento" placeholder="Ingresa tu número de cédula..." autocomplete="off">
                    </div>
                    <button type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i> Consultar
                    </button>
                </div>
                
                <div class="captcha-box">
                    <div class="g-recaptcha" data-sitekey="6Levgb4sAAAAAPFS2JcWda5M4stwnZcvYCZ4qB3t"></div>
                </div>
            </form>
        </div>
    </section>

    <footer class="footer-aesthetic">
        <div class="footer-logo">REGISTRADURÍA DE <span>NOBSA</span></div>
        <p>Identidad • Democracia • Nación</p>
        
        <div class="sena-tag">
            <i class="fa-solid fa-code"></i>
            <div>
                <span style="font-weight: 700;">Desarrollado por ADSO 2026</span>
                <span style="color:var(--text-gray);"> | SENA CIMM - Boyacá</span>
            </div>
        </div>
    </footer>

    <c:if test="${not empty error}">
        <script>
            window.onload = function() {
                let config = {
                    title: 'Aviso Institucional',
                    icon: 'info',
                    html: '${error}',
                    confirmButtonText: 'Entendido',
                    animation: false
                };
                
                if ('${tipoError}' === 'documento-invalido') {
                    config.title = 'Estado de Documento';
                    config.icon = 'error'; 
                    config.html = 'Atención: El documento ingresado se encuentra en estado: <b style="color:#d33">${estadoDetalle.toUpperCase()}</b>.<br><br>Por favor acérquese a una sede de la Registraduría.';
                } else if ('${tipoError}' === 'no-encontrado') {
                    config.title = 'No Encontrado';
                    config.icon = 'question'; 
                    config.html = 'El número de documento no se encuentra registrado en el censo electoral actual de Nobsa.';
                } else if ('${tipoError}' === 'captcha') {
                    config.title = 'Falla de Validación';
                    config.icon = 'warning'; 
                }

                Swal.fire({
                    ...config,
                    confirmButtonColor: '#007bff', 
                    footer: '<span style="color: #64748b; font-size:0.8rem;">Censo Electoral Nobsa - Boyacá</span>'
                });
            };
        </script>
    </c:if>

</body>
</html>