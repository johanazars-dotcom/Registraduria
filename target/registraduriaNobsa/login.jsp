<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso Administrativo | Registraduria de Nobsa</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
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
            --danger-soft: #FEE2E2;
            --danger-text: #DC2626;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: var(--bg-body);
            color: var(--text-dark);
            /* Fondo sutil con patron de puntos y resplandor azul */
            background-image: radial-gradient(var(--blue-light) 1px, transparent 1px);
            background-size: 30px 30px;
            position: relative;
            overflow: hidden;
        }

        /* Resplandor decorativo de fondo */
        body::before {
            content: '';
            position: absolute;
            width: 600px;
            height: 600px;
            background: var(--blue-light);
            border-radius: 50%;
            filter: blur(100px);
            top: -200px;
            left: -200px;
            opacity: 0.6;
            z-index: -1;
        }

        .login-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin-top: 60px; /* Espacio para el navbar */
            z-index: 1;
        }

        /* --- TARJETA AESTHETIC --- */
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            width: 100%;
            max-width: 440px;
            padding: 50px 40px;
            border-radius: 24px;
            border: 1px solid var(--border-color);
            box-shadow: 0 25px 50px -12px rgba(0, 43, 92, 0.15);
            text-align: center;
        }

        .icon-container {
            width: 75px;
            height: 75px;
            background: var(--blue-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            box-shadow: 0 10px 25px rgba(0, 123, 255, 0.15);
            border: 2px solid var(--card-bg);
            transition: transform 0.3s ease;
        }

        .login-card:hover .icon-container {
            transform: scale(1.05) translateY(-5px);
        }

        .icon-container i {
            font-size: 2rem;
            color: var(--blue-accent);
        }

        .login-card h2 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-navy);
            font-weight: 800;
            margin: 0 0 10px 0;
            font-size: 2.2rem;
            letter-spacing: -0.5px;
        }

        .login-card p {
            color: var(--text-gray);
            font-size: 0.95rem;
            margin: 0 0 35px 0;
            line-height: 1.5;
        }

        /* --- FORMULARIO Y CAMPOS --- */
        .form-group {
            text-align: left;
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--primary-navy);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding-left: 5px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 20px;
            color: #94a3b8;
            font-size: 1.1rem;
            transition: 0.3s;
        }

        .input-wrapper input {
            width: 100%;
            padding: 16px 16px 16px 50px;
            background: var(--bg-body);
            border: 2px solid transparent;
            border-radius: 16px;
            outline: none;
            transition: all 0.3s ease;
            font-size: 1rem;
            color: var(--text-dark);
            font-family: 'Inter', sans-serif;
            font-weight: 500;
            box-sizing: border-box;
        }

        .input-wrapper input::placeholder { color: #cbd5e1; font-weight: 400; }

        /* Efecto Focus Aesthetic */
        .input-wrapper input:focus {
            background: var(--card-bg);
            border-color: var(--blue-accent);
            box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.1);
        }

        .input-wrapper input:focus + i,
        .input-wrapper input:valid + i {
            color: var(--blue-accent);
        }

        /* --- BOTON DE ACCESO --- */
        .btn-login {
            width: 100%;
            background: var(--primary-navy);
            color: var(--card-bg);
            border: none;
            padding: 16px;
            border-radius: 16px;
            font-weight: 700;
            font-size: 1.05rem;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 15px;
            box-shadow: 0 10px 20px rgba(0, 43, 92, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-login:hover {
            background: var(--blue-accent);
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0, 123, 255, 0.25);
        }

        /* --- ALERTAS --- */
        .alert-error {
            background: var(--danger-soft);
            color: var(--danger-text);
            padding: 16px 20px;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 25px;
            border: 1px solid #fecaca;
            display: flex;
            align-items: center;
            gap: 10px;
            text-align: left;
        }

        /* --- ENLACE DE RETORNO --- */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 30px;
            text-decoration: none;
            color: var(--text-gray);
            font-size: 0.95rem;
            font-weight: 600;
            transition: 0.3s;
        }

        .back-link:hover {
            color: var(--blue-accent);
            transform: translateX(-5px);
        }
    </style>
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <div class="login-wrapper">
        <div class="login-card">
            
            <div class="icon-container">
                <i class="fa-solid fa-shield-halved"></i>
            </div>
            
            <h2>Acceso Seguro</h2>
            <p>Plataforma exclusiva para personal autorizado de la Registraduria Municipal</p>

            <c:if test="${not empty error}">
                <div class="alert-error">
                    <i class="fa-solid fa-circle-exclamation" style="font-size: 1.1rem;"></i> 
                    <span>${error}</span>
                </div>
            </c:if>

            <form action="login" method="post">
                <div class="form-group">
                    <label>Usuario Institucional</label>
                    <div class="input-wrapper">
                        <input type="text" name="usuario" placeholder="Ej: admin" required autocomplete="off">
                        <i class="fa-solid fa-user"></i>
                    </div>
                </div>

                <div class="form-group">
                    <label>Contrasena de Seguridad</label>
                    <div class="input-wrapper">
                        <input type="password" name="clave" placeholder="••••••••" required>
                        <i class="fa-solid fa-key"></i>
                    </div>
                </div>

                <button type="submit" class="btn-login">
                    Iniciar Sesion <i class="fa-solid fa-arrow-right-to-bracket"></i>
                </button>
            </form>

            <a href="index.jsp" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> Volver al Portal Publico
            </a>
            
        </div>
    </div>

</body>
</html>