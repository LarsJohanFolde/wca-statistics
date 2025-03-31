-- Shows the amount of competitions delegated per delegate
-- Gives a list of Delegate names and the count of competitions where
-- they are listed.
-- Note: not all these people are, or have been, Delegates. Some have been
-- emergency Delegates in extraordinary circumstances.

SELECT 
  u.name AS Delegate,
  COUNT(cd.competition_id) AS CompetitionsDelegated
FROM users u
LEFT JOIN competition_delegates cd ON cd.delegate_id = u.id 
GROUP BY u.id 
HAVING CompetitionsDelegated > 0
ORDER BY CompetitionsDelegated DESC
LIMIT 50
