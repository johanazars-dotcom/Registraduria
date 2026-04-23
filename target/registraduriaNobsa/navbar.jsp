<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<style>
    /* --- NAVBAR AESTHETIC: WHITE & BLUE GLASSMORPHISM --- */
    .navbar {
        background: rgba(255, 255, 255, 0.85); /* Blanco semitransparente */
        backdrop-filter: blur(16px); /* Efecto vidrio moderno */
        -webkit-backdrop-filter: blur(16px);
        padding: 1rem 4rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 20px rgba(0, 43, 92, 0.05); /* Sombra muy suave */
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        width: 100%;
        z-index: 1000;
        font-family: 'Inter', sans-serif;
        box-sizing: border-box;
        border-bottom: 1px solid rgba(0, 123, 255, 0.1);
        transition: all 0.4s ease;
    }
    
    .navbar.scrolled {
        background: rgba(255, 255, 255, 0.98);
        padding: 0.8rem 4rem;
        box-shadow: 0 10px 30px rgba(0, 43, 92, 0.08);
    }

    .navbar-brand { 
        font-family: 'Plus Jakarta Sans', 'Inter', sans-serif;
        font-weight: 800; 
        font-size: 1.5rem; 
        text-decoration: none; 
        color: #002b5c; /* Azul Marino Institucional */
        letter-spacing: -0.5px;
        display: flex;
        align-items: center;
        gap: 12px;
        transition: transform 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
    }
    
    .navbar-brand:hover {
        transform: translateY(-1px);
    }
    
    .brand-icon {
        color: #007bff; /* Azul Vibrante */
        font-size: 1.6rem;
    }

    .nav-links { 
        display: flex; 
        align-items: center;
        gap: 25px; 
    }
    
    .nav-links > a.nav-basic { 
        color: #64748b; /* Gris Pizarra */
        text-decoration: none; 
        font-size: 0.95rem; 
        font-weight: 600;
        transition: all 0.3s ease; 
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .nav-links > a.nav-basic:hover { 
        color: #007bff; 
    }

    /* --- BOTÓN DE GESTIÓN (ADMIN) --- */
    .btn-gestion {
        background: #e6f0f9; /* Azul super claro */
        color: #007bff !important;
        padding: 10px 22px;
        border-radius: 50px;
        border: 1px solid rgba(0, 123, 255, 0.15);
        font-weight: 700;
        font-size: 0.9rem;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }

    .btn-gestion:hover {
        background: #007bff;
        color: #ffffff !important;
        transform: translateY(-2px);
        box-shadow: 0 8px 15px rgba(0, 123, 255, 0.2);
    }

    /* --- BOTÓN ESPECIAL DE BÚSQUEDA (PÚBLICO) --- */
    .btn-search { 
        background: #002b5c; 
        color: #ffffff !important;
        padding: 12px 28px; 
        border-radius: 50px; 
        text-decoration: none;
        font-weight: 600;
        font-size: 0.95rem;
        box-shadow: 0 4px 12px rgba(0, 43, 92, 0.15);
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .btn-search:hover {
        background: #007bff;
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0, 123, 255, 0.25);
    }

    /* --- CÁPSULA DE PERFIL (ADMIN) --- */
    .admin-profile {
        display: flex;
        align-items: center;
        gap: 15px;
        background: #f8fafc;
        padding: 6px 20px 6px 12px;
        border-radius: 50px;
        border: 1px solid #e2e8f0;
        margin-left: 10px;
    }

    .admin-name {
        color: #002b5c;
        font-size: 0.9rem;
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .admin-name i {
        color: #007bff;
    }

    .badge-status {
        width: 8px;
        height: 8px;
        background: #10b981; /* Verde Esmeralda (Online) */
        border-radius: 50%;
        display: inline-block;
        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.2);
    }

    /* --- BOTÓN DE SALIDA --- */
    .logout-wrapper {
        border-left: 1px solid #e2e8f0;
        padding-left: 15px;
        margin-left: 5px;
        display: flex;
        align-items: center;
    }

    .logout-link {
        color: #94a3b8 !important;
        font-size: 1.1rem;
        transition: all 0.3s ease;
    }

    .logout-link:hover {
        color: #ef4444 !important; /* Rojo elegante */
        transform: translateX(3px);
    }
    
    .login-lock {
        color: #cbd5e1;
        font-size: 1.2rem;
        margin-left: 10px;
        transition: 0.3s;
    }
    
    .login-lock:hover {
        color: #007bff;
    }
</style>

<nav class="navbar" id="mainNav">
    <a href="index.jsp" class="navbar-brand">
        <i class="fa-solid fa-building-columns brand-icon"></i> 
        <span>Registraduría Nobsa</span>
    </a>
    
    <div class="nav-links">
        <a href="index.jsp" class="nav-basic"><i class="fa-solid fa-house"></i> Inicio</a>
        
        <c:choose>
            <%-- SECCIÓN: ADMINISTRADOR AUTENTICADO --%>
            <c:when test="${not empty sessionScope.admin}">
                
                <a href="ciudadanos" class="btn-gestion">
                    <i class="fa-solid fa-users-gear"></i> Gestión
                </a>

                <div class="admin-profile">
                    <span class="admin-name">
                        <span class="badge-status"></span>
                        <i class="fa-solid fa-circle-user" style="font-size: 1.2rem;"></i> 
                        ${sessionScope.admin}
                    </span>
                    
                    <div class="logout-wrapper">
                        <a href="logout" class="logout-link" title="Cerrar Sesión Segura">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        </a>
                    </div>
                </div>
            </c:when>

            <%-- SECCIÓN: PÚBLICO (USUARIO NO LOGUEADO) --%>
            <c:otherwise>
                <a href="consulta-completa" class="btn-search">
                    <i class="fa-solid fa-magnifying-glass"></i> Consulta Rápida
                </a>

                <a href="login.jsp" class="login-lock" title="Acceso Exclusivo Funcionarios">
                    <i class="fa-solid fa-lock"></i>
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<script>
    window.addEventListener('scroll', function() {
        const navbar = document.getElementById('mainNav');
        if (window.scrollY > 20) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
</script>