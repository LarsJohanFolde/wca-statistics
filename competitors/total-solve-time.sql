-- Rank the competitors on the total amount of time spent on their solutions.
-- Ignores: DNFs, Multi-Blind, Fewest Moves, and Multi-Blind Old Style
-- Output: Name, Time in hours

SELECT
  p.name AS Navn,
  ROUND(SUM(
    CASE WHEN r.value1 > 0 AND r.eventId NOT IN ('333mbf', '333fm', '333mbo') THEN value1 ELSE 0 END +
    CASE WHEN r.value2 > 0 AND r.eventId NOT IN ('333mbf', '333fm', '333mbo') THEN value2 ELSE 0 END +
    CASE WHEN r.value3 > 0 AND r.eventId NOT IN ('333mbf', '333fm', '333mbo') THEN value3 ELSE 0 END +
    CASE WHEN r.value4 > 0 AND r.eventId NOT IN ('333mbf', '333fm', '333mbo') THEN value4 ELSE 0 END +
    CASE WHEN r.value5 > 0 AND r.eventId NOT IN ('333mbf', '333fm', '333mbo') THEN value5 ELSE 0 END
  ) / 360000, 2) AS TotalSolveHours
FROM Persons p
JOIN Results r ON r.personId = p.wca_id
WHERE p.subId = 1 AND p.countryId = 'norway'
GROUP BY p.wca_id, p.name
ORDER BY TotalSolveHours DESC
LIMIT 20
