CREATE DATABASE IF NOT EXISTS football_xg_project;

USE football_xg_project;

CREATE TABLE football_raw (
    NO VARCHAR(50),
    CLUB VARCHAR(100),
    SEASON VARCHAR(50),
    M VARCHAR(50),
    W VARCHAR(50),
    D VARCHAR(50),
    L VARCHAR(50),
    G VARCHAR(50),
    GC VARCHAR(50),
    xG VARCHAR(50),
    xGA VARCHAR(50),
    SH VARCHAR(50),
    SOT VARCHAR(50),
    pass_att VARCHAR(50),
    PASS VARCHAR(50),
    poss_pct VARCHAR(50),
    FOUL VARCHAR(50),
    YC VARCHAR(50),
    RC VARCHAR(50)
);

SHOW COLUMNS FROM football_xg_project.football_raw;

