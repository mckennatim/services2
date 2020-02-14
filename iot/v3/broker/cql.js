
CREATE TABLE test (
devid text,
date text,
event_time timestamp,
temp text,
PRIMARY KEY ((devid,date),event_time)
);

INSERT INTO test(devid,date,event_time,temp) VALUES ('CYURD001','2017-06-30','2017-06-30 07:01:00','42');

CREATE TABLE tstat_by_day (
devid text,
senrel int,
date text,
event_time timestamp,
temp int,
relay int,
hilimit int,
lolimit int,
PRIMARY KEY ((devid,senrel,date),event_time)
);

INSERT INTO tstat_by_day(devid,senrel,date,event_time,temp,relay,hilimit,lolimit) VALUES ('CYURD001','0','2017-06-30','2017-06-30 07:01:00',72,1,74,70);

SELECT * FROM tstat_by_day WHERE devid='CYURD001' AND senrel='0' AND date='2017-06-30';

SELECT * FROM tstat_by_day WHERE devid='CYURD001';///wont worjk wo index on devid

DROP TABLE timr_by_month;
CREATE TABLE timr_by_month (
devid text,
senrel int,
month text,
event_time timestamp,
relay int,
PRIMARY KEY ((devid,month,senrel),event_time)
)WITH CLUSTERING ORDER BY (event_time DESC);

INSERT INTO timr_by_month(devid,senrel,month,event_time,relay) VALUES ('CYURD001','0','2017-06','2017-06-30 07:01:00',1);

SELECT * FROM timr_by_month WHERE devid='CYURD001' AND senrel='0' AND month='2017-06';