DROP SEQUENCE SEQ_GEOMID;
CREATE SEQUENCE SEQ_GEOMID SESSION;
-- CREATE SEQUENCE SEQ_GEOMID;
TRUNCATE TABLE USERGEOM_GEOMETRY CASCADE;
DROP TABLE USERGEOM_GEOMETRY;
-- CREATE TABLE USERGEOM_GEOMETRY (
CREATE GLOBAL TEMPORARY TABLE USERGEOM_GEOMETRY (
		  ElementID varchar2(22) NOT NULL,
		  Geometry SDO_GEOMETRY NOT NULL, 
		  BODY_MAJOR_AXIS1 SDO_GEOMETRY,
		  BODY_MAJOR_AXIS2 SDO_GEOMETRY,
		  BODY_MAJOR_AXIS3 SDO_GEOMETRY,
		  BODY_MAJOR_AXIS_CENTROID SDO_GEOMETRY,
		  PRIMARY KEY (ElementID)
) ON COMMIT PRESERVE ROWS;
-- );
CREATE INDEX I_USERG_ASSOCEID1 ON USERGEOM_GEOMETRY(Assoc_EID1);
CREATE INDEX I_USERG_ASSOCEID2 ON USERGEOM_GEOMETRY(Assoc_EID2);

TRUNCATE TABLE USERGEOM_TOPO_FACE CASCADE;
DROP TABLE USERGEOM_TOPO_FACE;
-- CREATE TABLE USERGEOM_TOPO_FACE (
CREATE GLOBAL TEMPORARY TABLE USERGEOM_TOPO_FACE (
		  ElementID varchar2(22) NOT NULL,
		  ID	varchar2(22) NOT NULL,
		  Type varchar2(8) NOT NULL,
		  Polygon SDO_GEOMETRY NOT NULL,
		  Normal SDO_GEOMETRY NOT NULL,
		  AngleFromNorth number,
		  Centroid SDO_GEOMETRY NOT NULL,
		  Orientation varchar2(8),
		  Area number
) ON COMMIT PRESERVE ROWS;
-- );
CREATE INDEX I_USERG_TOPOF_GID ON USERGEOM_TOPO_FACE (ElementID);

TRUNCATE TABLE USERGEOM_SPATIALINDEX CASCADE;
DROP TABLE USERGEOM_SPATIALINDEX;
-- CREATE TABLE USERGEOM_SPATIALINDEX (
CREATE GLOBAL TEMPORARY TABLE USERGEOM_SPATIALINDEX (
		  ElementID varchar2(22) NOT NULL, 
		  CellID varchar2(12) NOT NULL, 
		  CellType number(1) NOT NULL,
		  XMINBOUND integer,
		  YMINBOUND integer,
		  ZMINBOUND integer,
		  XMAXBOUND integer,
		  YMAXBOUND integer,
		  ZMAXBOUND integer,
		  DEPTH integer,
		  PRIMARY KEY (ElementID, CellID)
) ON COMMIT PRESERVE ROWS;
-- );
CREATE INDEX I_USERG_SPIDX_CID ON USERGEOM_SPATIALINDEX(CELLID); 
CREATE INDEX IXMIN_SPIDX_UGEOM ON USERGEOM_SPATIALINDEX(XMINBOUND);
CREATE INDEX IYMIN_SPIDX_UGEOM ON USERGEOM_SPATIALINDEX(YMINBOUND);
CREATE INDEX IZMIN_SPIDX_UGEOM ON USERGEOM_SPATIALINDEX(ZMINBOUND);
CREATE INDEX IXMAX_SPIDX_UGEOM ON USERGEOM_SPATIALINDEX(XMAXBOUND);
CREATE INDEX IYMAX_SPIDX_UGEOM ON USERGEOM_SPATIALINDEX(YMAXBOUND);
CREATE INDEX IZMAX_SPIDX_UGEOM ON USERGEOM_SPATIALINDEX(ZMAXBOUND);
-- CREATE GLOBAL TEMPORARY TABLE BIMRL_OUTPUT_DETAILS
-- (
-- 		  ELEMENTID VARCHAR2(22) NOT NULL,
-- 		  OUTPUTDETAILS VARCHAR2(22)
-- ) ON COMMIT PRESERVE ROWS;
-- CREATE INDEX I_OUTDET_EID ON BIMRL_OUTPUT_DETAILS(ELEMENTID);

TRUNCATE TABLE CELLTREEDETTMP CASCADE;
DROP TABLE CELLTREEDETTMP;
CREATE GLOBAL TEMPORARY TABLE CELLTREEDETTMP (
		  CELLID varchar2(12) NOT NULL,
		  ELEMENTID varchar2(22) NOT NULL
) ON COMMIT PRESERVE ROWS;
CREATE INDEX I_CTTMP_CELLID ON CELLTREEDETTMP (CELLID);
CREATE INDEX I_CTTMP_CELLEID ON CELLTREEDETTMP (CELLID, ELEMENTID);

TRUNCATE TABLE BIMRLQUERYTEMP CASCADE;
DROP TABLE BIMRLQUERYTEMP;
CREATE GLOBAL TEMPORARY TABLE BIMRLQUERYTEMP (
		  ID1 varchar2(22)
);
