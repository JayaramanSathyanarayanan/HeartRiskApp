<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Health Quiz"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<style>
       
        .question {
            font-size: 1.1rem;
            font-weight: 600;
            line-height: 1.8;
            color: #fff;
            margin-bottom: 20px;
            padding: 16px 18px;
            background: rgba(255,60,120,.08);
            border-left: 3px solid #ff3c78;
            border-radius: 0 8px 8px 0;
        }

        .options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 24px;
        }

        .options button {
            padding: 12px 16px;
            border: 1.5px solid rgba(255,255,255,.1);
            border-radius: 8px;
            background: rgba(255,255,255,.04);
            color: rgba(255,255,255,.85);
            font-weight: 500;
            font-size: 0.95rem;
            cursor: pointer;
            text-align: left;
            transition: all 0.2s ease;
        }

        .options button:hover {
            background: rgba(255,60,120,.08);
            border-color: rgba(255,60,120,.4);
            color: #fff;
        }

        .options button.correct {
            background: rgba(255,140,0,.15);
            border-color: #ff8c00;
            color: #ffe0b2;
            box-shadow: 0 0 12px rgba(255,140,0,.3);
        }

        .options button.wrong {
            background: rgba(255,60,120,.12);
            border-color: #ff3c78;
            color: #ff9bb8;
        }

        .progress-container {
            width: 100%;
            height: 6px;
            background: rgba(255,255,255,.08);
            border-radius: 20px;
            overflow: hidden;
            margin-bottom: 24px;
            border: 1px solid rgba(255,60,120,.15);
        }

        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #ff3c78, #ff8c00);
            border-radius: 20px;
            transition: width 0.4s ease;
            box-shadow: 0 0 10px rgba(255,60,120,.5);
        }

        .quiz-buttons {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
        }

        .quiz-buttons button {
            flex: 1;
            padding: 12px 16px;
            border: 1.5px solid rgba(255,255,255,.15);
            border-radius: 8px;
            background: rgba(255,255,255,.04);
            color: #fff;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .quiz-buttons button#next-btn {
            background: linear-gradient(135deg, #ff3c78, #ff8c00);
            border: none;
            box-shadow: 0 4px 12px rgba(255,60,120,.3);
        }

        .quiz-buttons button#next-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255,60,120,.4);
        }

        .result-dashboard {
            text-align: center;
            animation: slideIn 0.5s ease;
        }

        .result-dashboard h2 {
            font-size: 1.8rem;
            margin-bottom: 16px;
            background: linear-gradient(135deg, #ff3c78, #ff8c00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .score-display {
            font-size: 2.2rem;
            font-weight: 800;
            background: linear-gradient(135deg, #ff3c78, #ff8c00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 16px;
            padding: 20px;
        }

        .result-message {
            font-size: 1rem;
            color: rgba(255,255,255,.7);
            margin-bottom: 24px;
            line-height: 1.6;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
        </div>
        
    </div>

    
    <!-- Main Content -->
    <div class="page-wrap">
        <div class="card">
            <div class="card-top">
                <h1 style="font-size: 1.6rem; margin-bottom: 6px;">❓ Health Quiz</h1>
                <p style="color: rgba(255,255,255,.6); font-size: 0.9rem;">Test your cardiovascular health knowledge</p>
            </div>

            <div class="progress-container">
                <div class="progress-bar" id="progressBar"></div>
            </div>

            <div class="question" id="question">Question text here...</div>

            <div class="options" id="options"></div>

            <div class="quiz-buttons">
                <button id="next-btn">Next Question →</button>
            </div>
        </div>
    </div>


    
    <script>
        // Quiz Logic
        const questions = [
            { q: "What is the primary function of the heart?", options: ["Pump blood", "Filter waste", "Store energy", "Produce hormones"], answer: "Pump blood" },
            { q: "Normal resting heart rate for adults is?", options: ["20-40 bpm", "60-100 bpm", "120-150 bpm", "150+ bpm"], answer: "60-100 bpm" },
            { q: "Which nutrient helps lower cholesterol?", options: ["Saturated fat", "Fiber", "Sodium", "Sugar"], answer: "Fiber" },
            { q: "How much exercise is recommended weekly?", options: ["15 min", "60 min", "150 min", "300 min"], answer: "150 min" },
            { q: "Blood pressure reading 120/80 is considered?", options: ["Low", "Normal", "Elevated", "High"], answer: "Normal" }
        ];

        let currentQ = 0;
        let score = 0;
        let answered = false;

        function displayQuestion() {
            const q = questions[currentQ];
            document.getElementById('question').textContent = (currentQ + 1) + ". " + q.q;
            const optDiv = document.getElementById('options');
            optDiv.innerHTML = '';

            q.options.forEach(opt => {
                const btn = document.createElement('button');
                btn.textContent = opt;
                btn.onclick = () => selectAnswer(opt, q.answer);
                optDiv.appendChild(btn);
            });

            const progress = ((currentQ) / questions.length) * 100;
            document.getElementById('progressBar').style.width = progress + '%';
            answered = false;
        }

        function selectAnswer(selected, correct) {
            if (answered) return;
            answered = true;
            const btns = document.querySelectorAll('.options button');
            btns.forEach(btn => {
                if (btn.textContent === correct) {
                    btn.classList.add('correct');
                }
                if (btn.textContent === selected && selected !== correct) {
                    btn.classList.add('wrong');
                }
                btn.disabled = true;
            });
            if (selected === correct) {
                score++;
                console.log('Correct answer! Score: ' + score);
            } else {
                console.log('Wrong answer. Score: ' + score);
            }
        }

        document.getElementById('next-btn').addEventListener('click', () => {
            currentQ++;
            if (currentQ < questions.length) {
                displayQuestion();
            } else {
                showResult();
            }
        });

        function showResult() {
            const totalQuestions = questions.length;
            const percentage = Math.round((score / totalQuestions) * 100);
            console.log('Quiz finished. Score: ' + score + '/' + totalQuestions + ' (' + percentage + '%)');
            
            const resultMsg = percentage === 100 ? "Perfect score! Excellent cardiovascular knowledge! 🌟" 
                            : percentage >= 80 ? "Great job! You know your heart health! 💪"
                            : percentage >= 60 ? "Good effort! Keep learning about heart health. 📚"
                            : "Keep improving! Read more about cardiovascular wellness. 💡";
            
            const html = '<div class="result-dashboard">' +
                '<h2>🎉 Quiz Complete!</h2>' +
                '<div class="score-display">' + score + '/' + totalQuestions + '</div>' +
                '<p style="font-size: 2rem; margin-bottom: 12px; color: rgba(255,255,255,.8);">' + percentage + '%</p>' +
                '<p class="result-message">' + resultMsg + '</p>' +
                '<a href="${pageContext.request.contextPath}/" class="btn" style="display: inline-block; margin-top: 12px;">Back to Home</a>' +
                '</div>';
            console.log('Rendering HTML:', html);
            document.querySelector('.card').innerHTML = html;
        }

        displayQuestion();

        
    </script>
