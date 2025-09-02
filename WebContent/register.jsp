<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Bus Reservation System</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* Custom Font */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
        }
        /* Animations */
        @keyframes cascadeIn {
            from { transform: translateY(30px) scale(0.95); opacity: 0; }
            to { transform: translateY(0) scale(1); opacity: 1; }
        }
        @keyframes typewriter {
            from { width: 0; }
            to { width: 100%; }
        }
        @keyframes blinkCaret {
            50% { border-color: transparent; }
        }
        @keyframes subtleGlow {
            0% { box-shadow: 0 0 5px rgba(45, 212, 191, 0.3); }
            50% { box-shadow: 0 0 10px rgba(45, 212, 191, 0.5); }
            100% { box-shadow: 0 0 5px rgba(45, 212, 191, 0.3); }
        }
        @keyframes progressRing {
            to { stroke-dashoffset: 0; }
        }
        .animate-cascade-in {
            animation: cascadeIn 0.6s ease-out forwards;
        }
        .animate-typewriter {
            overflow: hidden;
            white-space: nowrap;
            animation: typewriter 2s steps(40, end) forwards, blinkCaret 0.75s step-end infinite;
            border-right: 2px solid #2dd4bf;
        }
        .animate-subtle-glow {
            animation: subtleGlow 2s infinite ease-in-out;
        }
        /* Glassmorphic Card */
        .glassmorphic {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.2);
        }
        /* Wave Background */
        .wave-bg {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 200px;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%232dd4bf" fill-opacity="0.3" d="M0,224L80,213.3C160,203,320,181,480,181.3C640,181,800,203,960,213.3C1120,224,1280,224,1360,224L1440,224L1440,320L1360,320C1280,320,1120,320,960,320C800,320,640,320,480,320C320,320,160,320,80,320L0,320Z"></path></svg>') repeat-x;
            animation: wave 10s linear infinite;
            z-index: -1;
        }
        @keyframes wave {
            0% { background-position: 0 0; }
            100% { background-position: 1440px 0; }
        }
        /* Cursor Trail */
        .cursor-trail {
            position: fixed;
            width: 8px;
            height: 8px;
            background: rgba(45, 212, 191, 0.5);
            border-radius: 50%;
            pointer-events: none;
            transition: transform 0.3s ease;
            z-index: 1000;
        }
        /* Parallax Tilt */
        .tilt {
            transition: transform 0.2s ease;
        }
        /* Progress Ring */
        .progress-ring circle {
            stroke: #2dd4bf;
            stroke-dasharray: 283;
            stroke-dashoffset: 283;
            transition: stroke-dashoffset 1s ease;
        }
        .loading .progress-ring circle {
            animation: progressRing 1s ease forwards;
        }
        /* Smooth Transitions */
        input, button {
            transition: all 0.3s ease;
        }
        input:focus {
            transform: scale(1.02);
            box-shadow: 0 0 8px rgba(45, 212, 191, 0.4);
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 12px rgba(45, 212, 191, 0.5);
        }
        /* Initial Hidden State */
        .register-container {
            opacity: 0;
        }
        .form-element {
            opacity: 0;
        }
    </style>
</head>
<body class="bg-gray-900 flex items-center justify-center min-h-screen overflow-hidden">
    <!-- Wave Background -->
    <div class="wave-bg"></div>

    <div class="register-container glassmorphic p-10 rounded-2xl w-full max-w-lg tilt animate-cascade-in">
        <h2 class="text-3xl font-bold text-teal-400 text-center mb-2 form-element" style="animation-delay: 0.2s;">
            <span class="animate-typewriter inline-block">Register</span>
        </h2>
        <p class="text-gray-400 text-center mb-6 form-element" style="animation-delay: 0.3s;">Join Bus Reservation System</p>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error bg-red-500/80 text-white text-center p-3 rounded-lg mb-6 animate-cascade-in form-element" style="animation-delay: 0.4s;"><%= error %></div>
        <% } %>

        <form id="registerForm" action="register" method="post" class="space-y-6">
            <div class="form-element" style="animation-delay: 0.5s;">
                <label for="username" class="block text-sm font-medium text-gray-200">Username</label>
                <div class="relative">
                    <i class="fas fa-user absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400"></i>
                    <input type="text" id="username" name="username" required 
                           class="w-full pl-12 p-3 bg-gray-800/50 text-gray-200 border border-gray-700 rounded-lg focus:ring-teal-400 focus:border-teal-400 animate-subtle-glow" 
                           placeholder="Enter your username">
                </div>
                <p id="usernameError" class="text-red-400 text-sm mt-2 hidden">Username is required</p>
            </div>
            <div class="form-element" style="animation-delay: 0.6s;">
                <label for="email" class="block text-sm font-medium text-gray-200">Email</label>
                <div class="relative">
                    <i class="fas fa-envelope absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400"></i>
                    <input type="email" id="email" name="email" required 
                           class="w-full pl-12 p-3 bg-gray-800/50 text-gray-200 border border-gray-700 rounded-lg focus:ring-teal-400 focus:border-teal-400 animate-subtle-glow" 
                           placeholder="Enter your email">
                </div>
                <p id="emailError" class="text-red-400 text-sm mt-2 hidden">Email is required</p>
            </div>
            <div class="form-element" style="animation-delay: 0.7s;">
                <label for="password" class="block text-sm font-medium text-gray-200">Password</label>
                <div class="relative">
                    <i class="fas fa-lock absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400"></i>
                    <input type="password" id="password" name="password" required 
                           class="w-full pl-12 pr-12 p-3 bg-gray-800/50 text-gray-200 border border-gray-700 rounded-lg focus:ring-teal-400 focus:border-teal-400 animate-subtle-glow" 
                           placeholder="Enter your password">
                    <i id="togglePassword" class="fas fa-eye absolute right-4 top-1/2 transform -translate-y-1/2 text-teal-400 cursor-pointer"></i>
                </div>
                <p id="passwordError" class="text-red-400 text-sm mt-2 hidden">Password is required</p>
            </div>
            <button type="submit" id="submitButton" 
                    class="relative w-full bg-teal-500 hover:bg-teal-600 text-white p-3 rounded-lg flex items-center justify-center animate-subtle-glow form-element" 
                    style="animation-delay: 0.8s;">
                <span>Register</span>
                <svg class="progress-ring absolute w-12 h-12 hidden" viewBox="0 0 100 100">
                    <circle cx="50" cy="50" r="45" fill="none" stroke-width="5" />
                </svg>
            </button>
        </form>
        <div class="text-center mt-6 form-element" style="animation-delay: 0.9s;">
            <p class="text-gray-400">Already have an account?</p>
            <a href="login">
                <button class="mt-2 bg-indigo-500 hover:bg-indigo-600 text-white px-6 py-2 rounded-lg animate-subtle-glow">Login</button>
            </a>
        </div>
    </div>

    <script>
        // Trigger Animations on Page Load
        window.addEventListener('load', () => {
            const container = document.querySelector('.register-container');
            const elements = document.querySelectorAll('.form-element');
            
            container.style.opacity = '1';
            
            elements.forEach((element) => {
                element.classList.add('animate-cascade-in');
                element.style.opacity = '1';
            });
        });

        // Parallax Tilt Effect
        const tiltElement = document.querySelector('.tilt');
        document.addEventListener('mousemove', (e) => {
            const rect = tiltElement.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;
            const tiltX = (y / rect.height) * 10;
            const tiltY = -(x / rect.width) * 10;
            tiltElement.style.transform = `perspective(1000px) rotateX(${tiltX}deg) rotateY(${tiltY}deg)`;
        });
        document.addEventListener('mouseleave', () => {
            tiltElement.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg)';
        });

        // Cursor Trail Effect
        let trailCount = 0;
        document.addEventListener('mousemove', (e) => {
            if (trailCount % 5 === 0) { // Throttle for performance
                const trail = document.createElement('div');
                trail.className = 'cursor-trail';
                trail.style.left = `${e.pageX}px`;
                trail.style.top = `${e.pageY}px`;
                document.body.appendChild(trail);
                setTimeout(() => {
                    trail.style.transform = 'scale(0)';
                    setTimeout(() => trail.remove(), 300);
                }, 500);
            }
            trailCount++;
        });

        // Form Validation and Dynamic Feedback
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            const usernameError = document.getElementById('usernameError');
            const emailError = document.getElementById('emailError');
            const passwordError = document.getElementById('passwordError');
            const submitButton = document.getElementById('submitButton');
            const progressRing = submitButton.querySelector('.progress-ring');

            let isValid = true;

            if (!username) {
                usernameError.classList.remove('hidden');
                usernameError.classList.add('animate-cascade-in');
                isValid = false;
            } else {
                usernameError.classList.add('hidden');
            }

            if (!email) {
                emailError.classList.remove('hidden');
                emailError.classList.add('animate-cascade-in');
                isValid = false;
            } else {
                emailError.classList.add('hidden');
            }

            if (!password) {
                passwordError.classList.remove('hidden');
                passwordError.classList.add('animate-cascade-in');
                isValid = false;
            } else {
                passwordError.classList.add('hidden');
            }

            if (isValid) {
                submitButton.disabled = true;
                submitButton.classList.add('loading');
                submitButton.querySelector('span').textContent = 'Registering...';
                progressRing.classList.remove('hidden');
                setTimeout(() => {
                    this.submit();
                }, 1500);
            }
        });

        // Real-time Input Validation
        document.getElementById('username').addEventListener('input', function() {
            const usernameError = document.getElementById('usernameError');
            if (this.value.trim()) {
                usernameError.classList.add('hidden');
            }
        });

        document.getElementById('email').addEventListener('input', function() {
            const emailError = document.getElementById('emailError');
            if (this.value.trim()) {
                emailError.classList.add('hidden');
            }
        });

        document.getElementById('password').addEventListener('input', function() {
            const passwordError = document.getElementById('passwordError');
            if (this.value.trim()) {
                passwordError.classList.add('hidden');
            }
        });

        // Toggle Password Visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this;
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    </script>
</body>
</html>