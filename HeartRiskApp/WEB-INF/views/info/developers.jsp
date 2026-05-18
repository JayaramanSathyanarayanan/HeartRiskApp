<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Development Team"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<style>
    /* 1. CONTAINER WIDTH - Essential for horizontal space */
    .page-wrap {
        padding: 40px 20px;
        display: flex;
        justify-content: center;
        width: 100%;
    }

    .main-team-wrapper {
        width: 100%;
        max-width: 1300px; /* Wider container prevents the "tower" look */
        margin: 0 auto;
    }

    .card-top {
        text-align: center;
        margin-bottom: 40px;
    }

    /* 2. THE GRID - 2 columns that stretch wide */
    .developers-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 30px;
        width: 100%;
    }

    /* 3. THE CARD - Shaped into a Rectangle */
    .developer-box {
        background: rgba(255,255,255,.04); 
        border: 1px solid rgba(255,60,120,.15);
        border-radius: 20px;
        padding: 30px;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        /* Height set to 460px to force a landscape/square feel */
        height: 460px; 
        box-sizing: border-box;
        transition: 0.3s;
        position: relative;
    }

    .developer-box:hover {
        transform: translateY(-8px);
        border-color: rgba(255,60,120,.35);
        box-shadow: 0 15px 35px rgba(255,60,120,.2);
        background: rgba(255,60,120,.08);
    }

    .photo-halo {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #fff;
        box-shadow: 0 0 15px rgba(255,60,120,.2);
        margin-bottom: 15px;
        flex-shrink: 0;
    }

    .developer-box h3 {
        color: #fff;
        font-size: 1.9rem;
        margin: 0 0 5px 0;
    }

    .developer-box h4 {
        color: #ff3c78;
        font-size: 1.1rem;
        text-transform: uppercase;
        letter-spacing: 1.2px;
        margin-bottom: 12px;
    }

    .developer-box p {
        color: rgba(255, 255, 255, 0.7);
        font-size: 1.25rem;
        line-height: 1.5;
        margin-bottom: 15px;
        display: block;
        overflow: visible;
    }

    /* 4. THE SKILLS LIST - 2 columns inside the card to stay compact */
    .skills-grid {
        list-style: none;
        padding: 0;
        margin-top: auto; 
        width: 100%;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        padding-top: 15px;
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 8px;
    }

    .skills-grid li {
        color: rgba(255, 255, 255, 0.6);
        font-size: 1.1rem;
        text-align: left;
        display: flex;
        align-items: center;
    }

    .skills-grid li::before {
        content: '›';
        color: #ff3c78;
        margin-right: 6px;
        font-weight: bold;
    }

    /* Footer & Button */
    .footer-text {
        text-align: center;
        margin-top: 50px;
        color: rgba(255, 255, 255, 0.3);
        font-size: 0.8rem;
    }

    .back-btn {
        display: inline-block;
        padding: 10px 24px;
        background: linear-gradient(135deg, #ff3c78, #ff8c00);
        color: #fff;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 600;
        margin-top: 20px;
    }

    @media (max-width: 900px) {
        .developers-grid { grid-template-columns: 1fr; }
        .developer-box { height: auto; max-width: 450px; margin: 0 auto; }
    }
</style>

<div class="page-wrap">
    <div class="main-team-wrapper">
        <div class="card-top">
            <h1 style="color: white;">👥 Development Team</h1>
            <p style="color: rgba(255,255,255,.6); margin: 12px auto; max-width: 600px;">
                CardioAssess was developed as an academic project to demonstrate web-based health risk analysis and user-friendly medical interfaces.
            </p>
        </div>

        <div class="developers-grid">
            <div class="developer-box">
                <img src="${pageContext.request.contextPath}/images/234205.jpg" class="photo-halo" alt="Aryan">
                <h3>Aryan Bhandari</h3>
                <h4>Data Processing & Risk Logic</h4>
                <p>Responsible for designing the user interface and implementing the main interactive components.</p>
                <ul class="skills-grid">
                    <li>UI Layout & Styling</li>
                    <li>Risk Form Interface</li>
                    <li>Responsive Input</li>
                    <li>ECG Backgrounds</li>
                    <li>Interaction Logic</li>
                </ul>
            </div>

            <div class="developer-box">
                <img src="${pageContext.request.contextPath}/images/234230.png" class="photo-halo" alt="Sundaram">
                <h3>Sundaram Sai</h3>
                <h4>Frontend & UI Designer</h4>
                <p>Worked on implementing the risk calculation logic and data handling within the web application.</p>
                <ul class="skills-grid">
                    <li>Calculation Model</li>
                    <li>JS Risk Logic</li>
                    <li>Input Validation</li>
                    <li>Interpretation Module</li>
                    <li>Risk Score Testing</li>
                </ul>
            </div>

            <div class="developer-box">
                <img src="${pageContext.request.contextPath}/images/234216.JPG" class="photo-halo" alt="Jayaraman">
                <h3>Jayaraman S</h3>
                <h4>System Integration & Deployment</h4>
                <p>Handled integration of different modules and ensured smooth operation of the complete application.</p>
                <ul class="skills-grid">
                    <li>Frontend Integration</li>
                    <li>Page Optimization</li>
                    <li>Resource Mgmt</li>
                    <li>Debugging Issues</li>
                    <li>Final Deployment</li>
                </ul>
            </div>

            <div class="developer-box">
                <img src="${pageContext.request.contextPath}/images/234215.png" class="photo-halo" alt="Jaya Vijay">
                <h3>Jaya Vijay V</h3>
                <h4>Testing & Documentation</h4>
                <p>Focused on application testing, verification of outputs, and preparing technical documentation.</p>
                <ul class="skills-grid">
                    <li>Functional Testing</li>
                    <li>Input Validation</li>
                    <li>Project Documentation</li>
                    <li>System Observation</li>
                    <li>Presentation Prep</li>
                </ul>
            </div>

            
        </div>

        <div class="footer-text">
            Academic Project | Cardiovascular Risk Assessment System | 2026
        </div>

        <div style="text-align: center;">
            <a href="${pageContext.request.contextPath}/" class="back-btn">← Back to Home</a>
        </div>
    </div>
</div>