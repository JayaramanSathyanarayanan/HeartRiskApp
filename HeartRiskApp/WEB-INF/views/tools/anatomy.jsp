<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Heart Anatomy Explorer"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<style>
    body {
        max-height: 100vh;
        overflow: hidden;
        display: flex;
        flex-direction: column;
    }

    .main-container {
        display: flex;
        flex: 1;
        overflow: hidden;
        gap: 0;
        min-height: 0;
    }

    .image-panel {
        flex: 0 0 42%;
        background: rgba(255,255,255,.08);
        border-right: 2px solid rgba(255,60,120,.2);
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        overflow-y: auto;
        position: relative;
        padding: 0px;
    }

    .heart-diagram {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        filter: drop-shadow(0 8px 16px rgba(0, 0, 0, 0.4));
        transition: transform 0.3s ease;
        cursor: pointer;
    }

    .heart-diagram:hover {
        transform: scale(1.03);
    }

    .info-panel {
        flex: 1;
        padding: 28px;
        display: flex;
        flex-direction: column;
        overflow: hidden;
        min-height: 0;
        background: linear-gradient(135deg, rgba(13,5,20,.6), rgba(13,5,20,.4));
    }

    .counter {
        font-family: 'Courier New', monospace;
        font-size: 0.75rem;
        letter-spacing: 2px;
        text-transform: uppercase;
        color: rgba(255,60,120,.8);
        margin-bottom: 8px;
        flex-shrink: 0;
        font-weight: 700;
    }

    .part-name {
        font-size: 1.6rem;
        font-weight: 800;
        background: linear-gradient(135deg, #ff3c78, #ff8c00);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 12px;
        flex-shrink: 0;
    }

    .part-divider {
        width: 60px;
        height: 2px;
        background: linear-gradient(90deg, #ff3c78, #ff8c00);
        margin-bottom: 16px;
        flex-shrink: 0;
        border-radius: 2px;
    }

        .part-info {
            font-size: 1.1rem;
            line-height: 1.7;
            color: rgba(255,255,255,.75);
            overflow-y: auto;
            flex: 1;
            min-height: 0;
            padding-right: 10px;
        }

        .part-info::-webkit-scrollbar {
            width: 6px;
        }

        .part-info::-webkit-scrollbar-track {
            background: rgba(255, 60, 120, 0.05);
            border-radius: 3px;
        }

        .part-info::-webkit-scrollbar-thumb {
            background: rgba(255, 60, 120, 0.3);
            border-radius: 3px;
        }

        .part-info::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 60, 120, 0.5);
        }

        .nav-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding-top: 14px;
            margin-top: 16px;
            border-top: 1px solid rgba(255,60,120,.15);
            flex-shrink: 0;
        }

        .nav-btn {
            flex: 1;
            padding: 11px 16px;
            border: 1.5px solid rgba(255,60,120,.2);
            border-radius: 8px;
            background: rgba(255,60,120,.06);
            color: #fff;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
        }

        .nav-btn:hover {
            background: linear-gradient(135deg, rgba(255,60,120,.15), rgba(255,140,0,.1));
            border-color: rgba(255,60,120,.4);
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(255,60,120,.2);
        }

        .nav-btn:active {
            transform: translateY(0);
        }

        .back-link {
            display: inline-block;
            padding: 8px 20px;
            background: rgba(255,60,120,.08);
            border: 1.5px solid rgba(255,60,120,.2);
            border-radius: 6px;
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            margin-top: 16px;
        }

        .back-link:hover {
            background: linear-gradient(135deg, #ff3c78, #ff8c00);
            border-color: transparent;
            box-shadow: 0 4px 12px rgba(255,60,120,.3);
        }

        @media(max-width: 1024px) {
            .main-container {
                flex-direction: column;
            }

            .image-panel {
                flex: 0 0 35%;
                border-right: none;
                border-bottom: 2px solid rgba(255,60,120,.2);
            }

            .info-panel {
                flex: 1;
                padding: 20px;
            }
        }

        @media(max-width: 768px) {
            body {
                padding-top: 0;
            }

            .part-name { font-size: 1.3rem; }
            .part-info { font-size: 0.9rem; }
            .info-panel { padding: 14px; }
            .image-panel { padding: 12px; }
    </style>

<!-- Main Content -->
<div class="main-container">
    <div class="image-panel">
        <img src="${pageContext.request.contextPath}/images/heart_labeled.png" alt="Labeled Heart Anatomy" class="heart-diagram">
    </div>

    <div class="info-panel">
        <div class="counter"><span id="counter">1</span> / 18 Structures</div>
        <div class="part-name" id="partName">Right Atrium</div>
        <div class="part-divider"></div>
        <div class="part-info" id="partInfo">The right atrium is the first chamber of the heart that receives deoxygenated blood from systemic circulation...</div>

        <div class="nav-row">
            <button class="nav-btn" onclick="prevPart()">← Previous</button>
            <button class="nav-btn" onclick="nextPart()">Next →</button>
        </div>

        <a href="${pageContext.request.contextPath}/" class="back-link">← Back to Home</a>
    </div>
</div>

<script>
    // Heart Anatomy Data
    const parts = [
        { name:"Right Atrium", info:"The right atrium is the first chamber of the heart that receives deoxygenated blood from systemic circulation through the superior and inferior vena cavae. It acts as a temporary reservoir where blood accumulates before being pumped into the right ventricle. The walls of the right atrium are relatively thin because the chamber only needs to generate enough pressure to move blood into the adjacent ventricle. During atrial contraction (atrial systole), the right atrium pushes blood through the tricuspid valve into the right ventricle. This chamber also contains the sinoatrial (SA) node, the heart's natural pacemaker, which generates electrical impulses that initiate the heartbeat." },
        { name:"Atrioventricular (Tricuspid) Valve", info:"The tricuspid valve, located between the right atrium and right ventricle, is one of the heart's four major valves. It consists of three leaflets (cusps) that open to allow blood to pass from the right atrium into the right ventricle during atrial contraction. When the right ventricle contracts, the valve closes tightly to prevent blood from flowing backward into the atrium. The proper functioning of this valve is essential for maintaining unidirectional blood flow. The valve leaflets are attached to chordae tendineae, which stabilize them during ventricular contraction." },
        { name:"Chordae Tendineae", info:"The chordae tendineae are strong, fibrous cords of connective tissue that anchor the atrioventricular valve leaflets to the papillary muscles inside the ventricles. Their primary function is to prevent valve inversion or prolapse during ventricular contraction. When the ventricle contracts and pressure rises, the chordae tendineae tighten and hold the valve cusps in place so they close properly. Without these cords, the valve leaflets could flip backward into the atrium, causing regurgitation of blood and inefficient circulation." },
        { name:"Papillary Muscle", info:"The papillary muscles are conical muscular projections located within the ventricles. They attach to the chordae tendineae and contract simultaneously with the ventricular walls. Their contraction maintains tension on the chordae tendineae, ensuring that the atrioventricular valves remain closed during ventricular contraction. This coordination prevents backflow of blood into the atria and helps maintain efficient forward movement of blood through the circulatory system." },
        { name:"Right Ventricle", info:"The right ventricle is the chamber responsible for pumping deoxygenated blood from the heart to the lungs for oxygenation. Its walls are thicker than those of the atria but thinner than the left ventricle because it only needs to pump blood a short distance to the lungs. When the right ventricle contracts (ventricular systole), it generates pressure that pushes blood upward through the pulmonary semilunar valve into the pulmonary trunk. This marks the beginning of pulmonary circulation." },
        { name:"Pulmonary Semilunar Valve", info:"The pulmonary semilunar valve lies between the right ventricle and the pulmonary trunk. It consists of three crescent-shaped cusps that open when the right ventricle contracts, allowing blood to flow into the pulmonary arteries. Once the ventricle relaxes, the valve closes automatically due to pressure changes, preventing blood from flowing backward into the ventricle. This valve ensures that blood moves efficiently toward the lungs." },
        { name:"Pulmonary Trunk", info:"The pulmonary trunk is a large artery that emerges from the right ventricle and carries deoxygenated blood toward the lungs. Shortly after leaving the heart, it divides into the right and left pulmonary arteries. Unlike most arteries in the body, the pulmonary trunk carries deoxygenated blood. Its main function is to transport blood to the lungs where gas exchange occurs, allowing carbon dioxide to be released and oxygen to be absorbed." },
        { name:"Left Pulmonary Artery", info:"The left pulmonary artery is one of the two branches of the pulmonary trunk and carries deoxygenated blood specifically to the left lung. Inside the lungs, this blood flows through smaller arteries and capillaries surrounding the alveoli. In these capillaries, carbon dioxide diffuses out of the blood and oxygen diffuses in, transforming the blood into oxygen-rich blood that will later return to the heart." },
        { name:"Left Atrium", info:"After oxygenation in the lungs, oxygen-rich blood returns to the heart through the pulmonary veins and enters the left atrium. This chamber acts as a receiving reservoir for oxygenated blood before it moves into the left ventricle. The walls of the left atrium are relatively thin because the chamber only needs to move blood into the ventricle. During atrial contraction, blood flows through the mitral valve into the left ventricle." },
        { name:"Bicuspid (Mitral) Valve", info:"The bicuspid valve, also known as the mitral valve, is located between the left atrium and left ventricle. It consists of two cusps that open to allow oxygenated blood to flow into the left ventricle during atrial contraction. When the left ventricle contracts, the valve closes tightly to prevent blood from returning to the atrium. This valve plays a crucial role in maintaining one-directional blood flow in the heart." },
        { name:"Left Ventricle", info:"The left ventricle is the most powerful chamber of the heart because it must pump oxygenated blood throughout the entire body. Its muscular walls are significantly thicker than those of the right ventricle. During ventricular contraction, the left ventricle generates high pressure that forces blood through the aortic semilunar valve into the aorta. From there, oxygen-rich blood is distributed to all tissues and organs of the body." },
        { name:"Aortic Semilunar Valve", info:"The aortic semilunar valve lies between the left ventricle and the aorta. It opens when the left ventricle contracts, allowing oxygenated blood to flow into the aorta. When the ventricle relaxes, the valve closes automatically due to back pressure in the aorta. This prevents blood from returning to the ventricle and ensures that blood continues moving forward into systemic circulation." },
        { name:"Aortic Arch", info:"The aortic arch is the curved portion of the aorta that carries oxygenated blood from the left ventricle toward the upper body. It acts as a major distribution hub where important arteries branch off to supply the head, neck, and upper limbs. Its elastic walls help maintain blood pressure and ensure continuous blood flow even when the heart is between beats." },
        { name:"Left Common Carotid Artery", info:"The left common carotid artery branches directly from the aortic arch and supplies oxygenated blood to the left side of the head and neck, including the brain. It later divides into the internal and external carotid arteries. Because the brain requires a constant supply of oxygen and glucose, this artery plays a critical role in maintaining brain function." },
        { name:"Left Subclavian Artery", info:"The left subclavian artery also arises from the aortic arch and delivers oxygenated blood to the left arm, shoulder, and portions of the thoracic region. It continues as the axillary artery as it passes into the arm. This artery ensures adequate blood supply for muscular activity and tissue metabolism in the upper limb." },
        { name:"Right Subclavian Artery", info:"The right subclavian artery supplies oxygenated blood to the right arm and shoulder region. Unlike the left subclavian artery, it originates indirectly from the aortic arch through the brachiocephalic trunk. It plays an essential role in delivering oxygen and nutrients to the muscles and tissues of the right upper limb." },
        { name:"Septum", info:"The septum is a thick muscular wall that divides the heart into right and left halves. It prevents the mixing of oxygenated and deoxygenated blood, ensuring efficient circulation. The septum has two main parts: the interatrial septum separating the atria, and the interventricular septum separating the ventricles. This separation allows the heart to maintain two distinct circulation loops — pulmonary and systemic circulation." },
        { name:"Descending Aorta", info:"The descending aorta is the continuation of the aortic arch that travels downward through the chest and abdomen. It distributes oxygenated blood to the lower regions of the body, including the abdominal organs, pelvis, and legs. Numerous arteries branch off from this vessel to supply organs such as the kidneys, liver, intestines, and lower limbs." }
    ];

    let index = 0;

    function updateInfo() {
        const part = parts[index];
        document.getElementById('counter').textContent = index + 1;
        document.getElementById('partName').textContent = part.name;
        document.getElementById('partInfo').textContent = part.info;
        
        document.getElementById('partInfo').style.opacity = '0.6';
        setTimeout(() => {
            document.getElementById('partInfo').style.opacity = '1';
        }, 100);
    }

    function nextPart() {
        index = (index + 1) % parts.length;
        updateInfo();
    }

    function prevPart() {
        index = (index - 1 + parts.length) % parts.length;
        updateInfo();
    }

    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowRight') nextPart();
        if (e.key === 'ArrowLeft') prevPart();
    });

    document.getElementById('partInfo').style.transition = 'opacity 0.3s ease';
    updateInfo();
</script>

