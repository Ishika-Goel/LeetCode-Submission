# Write your MySQL query statement below
SELECT
  ROUND(
    (SELECT COUNT(DISTINCT a1.player_id)
     FROM Activity a1
     JOIN Activity a2
       ON a1.player_id = a2.player_id
      AND a2.event_date = DATE_ADD(a1.event_date, INTERVAL 1 DAY)
     JOIN (
        SELECT player_id, MIN(event_date) AS first_date
        FROM Activity
        GROUP BY player_id
     ) f
       ON f.player_id = a1.player_id
      AND f.first_date = a1.event_date
    ) / (SELECT COUNT(DISTINCT player_id) FROM Activity),
    2
  ) AS fraction;

  