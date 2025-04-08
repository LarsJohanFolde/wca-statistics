WITH Sub8 AS (
  SELECT DISTINCT r.personId, MIN(c.start_date) AS first_sub_8
  FROM Results r 
  JOIN Competitions c ON c.id = r.competitionId 
  WHERE r.eventId = '333' AND r.best < 800
  GROUP BY r.personId
)

SELECT 
  r.personId AS 'WCA ID',
  r.personName AS Name, 
  r.countryId AS Country,
  SUM(
    CASE WHEN r.value1 > 799 AND r.value1 < 900 THEN 1 ELSE 0 END +
    CASE WHEN r.value2 > 799 AND r.value2 < 900 THEN 1 ELSE 0 END +
    CASE WHEN r.value3 > 799 AND r.value3 < 900 THEN 1 ELSE 0 END +
    CASE WHEN r.value4 > 799 AND r.value4 < 900 THEN 1 ELSE 0 END +
    CASE WHEN r.value5 > 799 AND r.value5 < 900 THEN 1 ELSE 0 END 
  ) AS Sub8,
  f.first_sub_8 AS FirstSub8
FROM Results r 
LEFT JOIN Competitions c ON c.id = r.competitionId
LEFT JOIN Sub8 f ON f.personId = r.personId
WHERE 
  r.eventId = '333'
  AND COALESCE(f.first_sub_8, "9999-12-31") > c.start_date
GROUP BY r.personId
ORDER BY Sub8 DESC 
LIMIT 30
