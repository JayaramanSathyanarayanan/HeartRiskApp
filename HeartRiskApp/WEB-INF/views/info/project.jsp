<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Project Overview"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<style>
    section {
        margin-bottom: 36px;
    }

    section h2 {
        font-size: 1.4rem;
        font-weight: 700;
        margin-bottom: 18px;
        background: linear-gradient(135deg, #ff3c78, #ff8c00);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    section p {
        margin-bottom: 14px;
        color: rgba(255,255,255,.8);
        line-height: 1.8;
        font-size: 0.95rem;
    }

    section ul {
        list-style: none;
        margin: 16px 0;
        padding: 0;
    }

    section ul li {
        padding: 8px 0;
        color: rgba(255,255,255,.75);
        padding-left: 24px;
        position: relative;
        font-size: 0.95rem;
    }

    section ul li::before {
        content: '→';
        position: absolute;
        left: 0;
        color: #ff3c78;
        font-weight: bold;
    }

    .feature-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 18px;
        margin-top: 24px;
    }

    .feature-card {
        background: rgba(255,255,255,.04);
        border: 1px solid rgba(255,60,120,.15);
        padding: 22px;
        border-radius: 12px;
        transition: all 0.3s ease;
        backdrop-filter: blur(10px);
    }

    .feature-card:hover {
        transform: translateY(-4px);
        border-color: rgba(255,60,120,.4);
        box-shadow: 0 8px 20px rgba(255,60,120,.15);
        background: rgba(255,60,120,.06);
    }

    .feature-card h3 {
        font-size: 1.1rem;
        margin-bottom: 10px;
        color: #fff;
        font-weight: 700;
    }

    .feature-card p {
        font-size: 0.85rem;
        color: rgba(255,255,255,.7);
        margin-bottom: 0;
    }

    .card-top {
        margin-bottom: 28px;
    }

    .back-btn {
        display: inline-block;
        padding: 10px 24px;
        background: linear-gradient(135deg, #ff3c78, #ff8c00);
        color: #fff;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 20px;
        border: none;
        font-size: 0.9rem;
    }

    .back-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(255,60,120,.3);
    }
</style>
    <div class="page-wrap">
        <div class="card">
            <div class="card-top">
                <h1 style="font-size: 1.8rem;">📋 Project Overview</h1>
                <p style="color: rgba(255,255,255,.6); font-size: 0.95rem;">Cardiovascular Risk Assessment System</p>
            </div>

            <section>
                <h2>About CardioAssess</h2>
                <p>Cardiovascular diseases remain one of the leading causes of mortality worldwide. Early identification of potential risk factors plays a crucial role in preventive healthcare.</p>
                <p>CardioAssess is an academic project that demonstrates modern web development practices in the healthcare domain. It provides multiple diagnostic tools and a comprehensive risk assessment engine to help users understand their cardiovascular health.</p>
            </section>

            <section>
                <h2>Key Features</h2>
                <div class="feature-grid">
                    <div class="feature-card">
                        <h3>📊 Risk Assessment</h3>
                        <p>Comprehensive evaluation using evidence-based algorithms to estimate cardiovascular disease risk.</p>
                    </div>
                    <div class="feature-card">
                        <h3>💪 BMI Calculator</h3>
                        <p>Calculate body mass index and receive personalized health recommendations.</p>
                    </div>
                    <div class="feature-card">
                        <h3>🩸 Blood Pressure</h3>
                        <p>Track and classify blood pressure readings based on medical guidelines.</p>
                    </div>
                    <div class="feature-card">
                        <h3>⏰ Heart Age</h3>
                        <p>Discover your heart's biological age based on your risk profile.</p>
                    </div>
                    <div class="feature-card">
                        <h3>🫀 Anatomy Explorer</h3>
                        <p>Interactive guide to understand heart structures and functions.</p>
                    </div>
                    <div class="feature-card">
                        <h3>❓ Educational Quiz</h3>
                        <p>Test your cardiovascular health knowledge with interactive questions.</p>
                    </div>
                </div>
            </section>

            <section>
                <h2>Technology Stack</h2>
                <ul>
                    <li><strong>Backend:</strong> Apache Tomcat, Jakarta EE (Servlets & JSP)</li>
                    <li><strong>Frontend:</strong> HTML5, CSS3, Vanilla JavaScript</li>
                    <li><strong>Database:</strong> MySQL/MariaDB</li>
                    <li><strong>Security:</strong> Password hashing, Session management, SQL parameterization</li>
                </ul>
            </section>

            <section>
                <h2>Architecture</h2>
                <p>The application follows the MVC (Model-View-Controller) pattern:</p>
                <ul>
                    <li><strong>Models:</strong> User, Assessment entities</li>
                    <li><strong>Views:</strong> JSP pages for UI rendering</li>
                    <li><strong>Controllers:</strong> Servlets handling business logic</li>
                    <li><strong>Utilities:</strong> Risk Engine, Database utilities</li>
                </ul>
            </section>

            <div style="text-align: center; margin-top: 36px;">
                <a href="${pageContext.request.contextPath}/" class="back-btn">← Back to Home</a>
            </div>
        </div>
    </div>

