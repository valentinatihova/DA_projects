# Аналитика в авиакомпании

## Данные
База данных об авиаперевозках:
- аэропорты (airports);
- самолеты (aircrafts);
- билеты (tickets);
- рейсы (flights);
- стыковая таблица "рейсы-билеты" (ticket_flights);
- фестивали (festivals).

Схема и стуктура таблиц следующая:
![схема_таблиц](https://github.com/valentinatihova/Yandex_projects/raw/airports_analytics/схема_таблиц.jpg)

Информация о фестивалях 2018 года получена с сайта:  https://code.s3.yandex.net/learning-materials/data-analyst/festival_news/index.html

# Задача
Изучение базы данных российской авиакомпании и анализ спрос пассажиров на рейсы в города, где проходят крупнейшие фестивали.

## Используемые библиотеки
Pandas, Numpy, Pandas_profiling, Pymystem3, Collections, Seaborn, Matplotlib

## Ключевые слова
Обработка пропусков медианным значением, замена типа данных, обработка дубликатов, лемматизация, категоризация данных
