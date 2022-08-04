CREATE TABLE EDI_ELEMENT_PROFILE
(
  SEGMENTID                  VARCHAR(     3) CHARACTER SET ASCII NOT NULL COLLATE ASCII,
  ELEMENTID                  VARCHAR(     4) CHARACTER SET ASCII NOT NULL COLLATE ASCII,
  ELEMENTCOUNT               INTEGER         DEFAULT 1 NOT NULL,
  ELEMENTTYPE                VARCHAR(    12) CHARACTER SET ASCII DEFAULT 'AN' NOT NULL COLLATE ASCII,
  MAXIMUMLENGTH              INTEGER         DEFAULT 1 NOT NULL,
 CONSTRAINT PK_EDI_ELEMENT_PROFILE PRIMARY KEY (SEGMENTID, ELEMENTID)
);

CREATE TABLE EDI_LOOP_PROFILE
(
  OWNERLOOPID               VARCHAR(    12) CHARACTER SET ASCII NOT NULL COLLATE ASCII,
  PARENTLOOPID              VARCHAR(    12) CHARACTER SET ASCII NOT NULL COLLATE ASCII,
 CONSTRAINT PK_EDI_LOOP_PROFILE PRIMARY KEY (OWNERLOOPID, PARENTLOOPID)
);

CREATE TABLE EDI_SEGMENT_PROFILE
(
  SEGMENTID                 VARCHAR(     3) CHARACTER SET ASCII NOT NULL COLLATE ASCII,
  OWNERLOOPID               VARCHAR(    12) CHARACTER SET ASCII DEFAULT 'N/A' NOT NULL COLLATE ASCII,
  PARENTLOOPID              VARCHAR(    12) CHARACTER SET ASCII DEFAULT 'N/A' NOT NULL COLLATE ASCII,
 CONSTRAINT PK_EDI_SEGMENT_PROFILE PRIMARY KEY (SEGMENTID, OWNERLOOPID, PARENTLOOPID)
);