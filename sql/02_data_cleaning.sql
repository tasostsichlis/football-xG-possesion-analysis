USE football_xg_project;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CLUB) AS total_clubs
FROM football_raw;

SELECT *
FROM football_raw;

SELECT CLUB, pass_att, PASS
FROM football_raw
WHERE pass_att NOT REGEXP '^[0-9]{1,3},[0-9]{3}$'
   OR PASS NOT REGEXP '^[0-9]{1,3},[0-9]{3}$';

UPDATE football_raw
SET
    pass_att = ROUND(REPLACE(pass_att, ',', '.') * 1000),
    PASS = ROUND(REPLACE(PASS, ',', '.') * 1000);

SELECT CLUB, M, xG, SH, pass_att, poss_pct
FROM football_raw;

ALTER TABLE football_raw
    MODIFY COLUMN M INT,
    MODIFY COLUMN xG DECIMAL(6,2),
    MODIFY COLUMN SH INT,
    MODIFY COLUMN pass_att INT,
    MODIFY COLUMN poss_pct DECIMAL(5,2),
    MODIFY COLUMN G INT;

SELECT
    CLUB,
    poss_pct,
    ROUND(xG / M, 2) AS xg_per_match,
    ROUND(xG / SH, 3) AS xg_per_shot,
    ROUND(xG / pass_att * 100, 3) AS xg_per_100_passes,
    G,
    ROUND(G / M, 2) AS goals_per_match
FROM football_raw;

CREATE VIEW football_metrics AS
SELECT
    CLUB,
    poss_pct,
    G,
    ROUND(G / M, 2) AS goals_per_match,
    ROUND(xG / M, 2) AS xg_per_match,
    ROUND(xG / SH, 3) AS xg_per_shot,
    ROUND(xG / pass_att * 100, 3) AS xg_per_100_passes
FROM football_raw;

SELECT *
FROM football_metrics
ORDER BY xg_per_100_passes DESC;

SELECT
    CLUB,
    poss_pct,
    xg_per_match,
    RANK() OVER (
        ORDER BY xg_per_match DESC
    ) AS rank_xg_per_match,
    xg_per_100_passes,
    RANK() OVER (
        ORDER BY xg_per_100_passes DESC
    ) AS rank_xg_per_100_passes
FROM football_metrics
ORDER BY rank_xg_per_match ;

