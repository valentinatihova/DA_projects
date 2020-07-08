/* 1. Изучим таблицу airports и выведем список городов (city), в которых есть аэропорты */

SELECT DISTINCT(city)
FROM airports

/* 2. Изучим таблицу flights и подсчитаем количество вылетов (flight_id) из каждого аэропорта вылета (departure_airport). 
Назовем переменную cnt_flights и выведем её вместе со столбцом departure_airport. 
Результат отсортируем в порядке убывания количества вылетов.*/

SELECT departure_airport,
       COUNT(flight_id) AS cnt_flights
FROM flights
GROUP BY departure_airport
ORDER BY cnt_flights DESC

/* 3. Найдем количество рейсов на каждой модели самолёта с вылетом в сентябре 2018 года (flights_amount).*/

SELECT model, 
       COUNT(flights.flight_id) AS flights_amount
FROM aircrafts
INNER JOIN flights ON flights.aircraft_code = aircrafts.aircraft_code
WHERE EXTRACT(month FROM flights.DEPARTURE_TIME) = 9 
GROUP BY model

/* 4. Найдем количество рейсов по всем моделям самолетов Boeing и Airbus в сентябре (flights_amount).*/

SELECT COUNT(flights.flight_id) AS flights_amount
FROM aircrafts
INNER JOIN flights ON flights.aircraft_code = aircrafts.aircraft_code
WHERE EXTRACT(month FROM flights.DEPARTURE_TIME) = 9 
        AND (aircrafts.model LIKE 'Airbus%' OR aircrafts.model LIKE 'Boeing%')

/* 5. Найдем среднее количество прибывающих рейсов в день для каждого города за август 2018 года (average_flights). */

SELECT sql1.city, 
       AVG(sql1.avg_flights) AS average_flights
FROM

        (SELECT airports.city, 
                EXTRACT(day FROM flights.arrival_TIME), 
                COUNT(flights.flight_id) AS avg_flights
        FROM flights
        INNER JOIN airports ON flights.arrival_airport = airports.airport_code
        WHERE EXTRACT(month FROM flights.arrival_TIME) = 8
        GROUP BY airports.city,  
                 EXTRACT(day FROM flights.arrival_TIME)) AS sql1

GROUP BY sql1.city

/* 6. Установим фестивали, которые проходили с 23 июля по 30 сентября 2018 года в Москве, 
   и номер недели, в которую они проходили. Выведите название фестиваля festival_name и номер недели festival_week. */

SELECT festival_name, 
       EXTRACT (WEEK FROM festival_date) AS festival_week
FROM festivals
WHERE (festival_date BETWEEN '2018-07-23' AND '2018-09-30') AND festival_city = 'Москва'
ORDER BY 2

/* 7. Для каждой недели с 23 июля по 30 сентября 2018 года узнаем количество билетов, купленных на рейсы в Москву 
   (номер недели week_number и количество билетов ticket_amount). 
    Получим таблицу, в которой будет информация о количестве купленных за неделю билетов; отметка, проходил ли в эту неделю фестиваль; 
    название фестиваля festival_name и номер недели week_number. */

SELECT 
    SBQ.week_number,
    SBQ.ticket_amount,
    SBQ1.festival_week,
    SBQ1.festival_name
FROM 
    (SELECT EXTRACT('week' FROM CAST(flights.arrival_time AS date)) AS week_number,
            COUNT(ticket_flights.ticket_no) AS ticket_amount
    FROM ticket_flights
    INNER JOIN flights ON flights.flight_id = ticket_flights.flight_id
    INNER JOIN airports ON airports.airport_code = flights.arrival_airport
    WHERE CAST(flights.arrival_time AS date) BETWEEN '2018-07-23' AND '2018-09-30' AND airports.city = 'Москва'
    GROUP BY week_number) SBQ
LEFT JOIN 
    (SELECT festival_name, 
            EXTRACT (WEEK FROM festival_date) AS festival_week
    FROM festivals
    WHERE (festival_date BETWEEN '2018-07-23' AND '2018-09-30') AND festival_city = 'Москва') SBQ1 
ON 
    SBQ.week_number = SBQ1.festival_week 

/* В результате получена небольшая таблица: по ней видно, что спрос во время фестивалей практически не меняется. 
   По этим данным нельзя проверить гипотезу о связи музыкальных фестивалей и спроса на авиабилеты (критерий Стьюдента)*/
