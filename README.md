<!DOCTYPE html>
<html lang="uk">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
        /* Стили для згорнутої/розгорнутої секції */
        .project {
            margin-bottom: 20px;
        }

        .project-title {
            font-weight: bold;
            cursor: pointer;
            color: #007acc;
        }

        .project-title:hover {
            text-decoration: underline;
        }

        .project-details {
            display: none; /* Приховано за замовчуванням */
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div id="greeting2">
  <h1>✨ Welcome to my page, I’m Vlada!</h1>
</div>

<h1>Моє портфоліо</h1>

    <!-- Проєкт 1 -->
    <div class="project">
        <div class="project-title">Використання кластерного аналізу у мові R...</div>
        <div class="project-details">
            Використання кластерного аналізу у мові R. Для даної роботи використала реальні дані. Дана робота була використана у дипломній роботі.
        </div>
    </div>

    <!-- Проєкт 2 -->
    <div class="project">
        <div class="project-title">Аналіз фінансових даних у Python...</div>
        <div class="project-details">
            У проєкті використано бібліотеки Pandas і Matplotlib для аналізу фінансових даних за реальними кейсами.
        </div>
    </div>

    <script>
        // Додавання інтерактивності для згортання/розгортання
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.project-title').forEach(title => {
                title.addEventListener('click', () => {
                    const details = title.nextElementSibling;
                    details.style.display = details.style.display === 'none' || details.style.display === '' ? 'block' : 'none';
                });
            });
        });
    </script>
</body>
</html>

