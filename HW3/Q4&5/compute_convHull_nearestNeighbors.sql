--Postgres+PostGIS
--Convex HULL
SELECT ST_AsText(ST_ConvexHull(
    ST_Collect(
      ST_GeomFromText('MULTIPOINT(-121.28815 38.79351, -121.21186 38.79155, -121.21212 38.79067, -121.21272 38.79024, -121.21367 38.79083, -121.21421 38.79117, -121.21405 38.79170, -121.21328 38.79162, -121.21333 38.79213, -121.21249 38.79201, -121.21206 38.79223, -121.21152 38.79186, -121.21103 38.79136)')
            )) );

--out: "POLYGON((-121.21272 38.79024,-121.28815 38.79351,-121.21206 38.79223,-121.21152 38.79186,-121.21103 38.79136,-121.21272 38.79024))"

--KNN
DROP TABLE mygeometries;

CREATE TABLE mygeometries (name varchar, geom geometry(Point, 4326));

--From locations grabbing first 3 letters to insert 
INSERT INTO mygeometries VALUES
	('HOM', st_SetSrid(st_MakePoint(-121.28815, 38.79351), 4326)),
	('CEN', st_SetSrid(st_MakePoint(-121.21186, 38.79155), 4326)),
	('RID', st_SetSrid(st_MakePoint(-121.21212, 38.79067), 4326)),
	('THE', st_SetSrid(st_MakePoint(-121.21272, 38.79024), 4326)),
	('NBU', st_SetSrid(st_MakePoint(-121.21367, 38.79083), 4326)),
	('VBU', st_SetSrid(st_MakePoint(-121.21421, 38.79117), 4326)),
	('MTB', st_SetSrid(st_MakePoint(-121.21405, 38.79170), 4326)),
	('BBU', st_SetSrid(st_MakePoint(-121.21328, 38.79162), 4326)),
	('CBU', st_SetSrid(st_MakePoint(-121.21333, 38.79213), 4326)),
	('WIN', st_SetSrid(st_MakePoint(-121.21249, 38.79201), 4326)),
	('WEA', st_SetSrid(st_MakePoint(-121.21206, 38.79223), 4326)),
	('BEL', st_SetSrid(st_MakePoint(-121.21152, 38.79186), 4326)),
	('KBU', st_SetSrid(st_MakePoint(-121.21103, 38.79136), 4326));


SELECT * FROM mygeometries ORDER BY geom <-> ST_GeomFromText ('POINT(-121.28815 38.79351)', 4326) LIMIT 4;

--Another Solution:
/*
SELECT *
FROM mygeometries
ORDER BY geom <-> st_setsrid(st_makepoint(-121.28815,38.79351),4326)
LIMIT 4;
*/

/*
Both Queries out-put:
"VBU"	"0101000020E6100000791EDC9DB54D5EC0C5C9FD0E45654340"
"MTB"	"0101000020E61000005D6DC5FEB24D5EC0211FF46C56654340"
"NBU"	"0101000020E6100000B988EFC4AC4D5EC00C59DDEA39654340"
"CBU"	"0101000020E61000005D50DF32A74D5EC01A170E8464654340"
*/

--Credit: Query from Stackoverflow shared in class: https://stackoverflow.com/questions/10461179/k-nearest-neighbor-query-in-postgis
--Examples: https://stackoverflow.com/questions/37827468/find-the-nearest-location-by-latitude-and-longitude-in-postgresql
--          https://stackoverflow.com/questions/47619397/find-nearest-items-from-lat-lng-in-postgresql
--          http://postgis.net/workshops/postgis-intro/geometries.html
