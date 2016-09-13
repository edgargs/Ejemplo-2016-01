CREATE TABLE CABECERA(
NUMERO CHAR(5) NOT NULL,
FECHA DATE NOT NULL,
CONSTRAINT PK_CABECERA PRIMARY KEY (NUMERO)
);

CREATE TABLE DETALLE(
NUMERO CHAR(5) NOT NULL,
SECUENCIAL NUMBER(4,0) NOT NULL,
MONTO NUMBER(5,2) NOT NULL,
CONSTRAINT PK_DETALLE PRIMARY KEY (NUMERO,SECUENCIAL),
CONSTRAINT FK_DETALLE_CABECERA FOREIGN KEY (NUMERO) REFERENCES CABECERA(NUMERO)
);

CREATE OR REPLACE PROCEDURE P_INSERT_DOCUMENTO(id_in IN CHAR,xml_in IN VARCHAR2) AS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  
  INSERT INTO CABECERA(NUMERO,FECHA)
  SELECT x.numero,to_date(replace(x.fecha,'T',' '),'YYYY-MM-DD HH24:MI:SS') fecha
     FROM XMLTABLE ('/cabecera'
                    PASSING XMLTYPE(xml_in)
                    COLUMNS numero CHAR(5) PATH 'numero', 
                            fecha VARCHAR2(19) PATH 'fecha') x
    WHERE x.numero = id_in;
  
  INSERT INTO DETALLE(NUMERO,SECUENCIAL,MONTO) 
  SELECT id_in,x.secuencial,TO_NUMBER(x.monto,'990.00') monto
     FROM XMLTABLE ('/cabecera/detalle'
                    PASSING XMLTYPE(xml_in)
                    COLUMNS monto VARCHAR2(6) PATH 'monto', 
                            secuencial NUMBER(4,0) PATH 'secuencial') x
    ;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20112,'Error al grabar:'||SQLERRM);
END;
/

DECLARE
 id_in CHAR(5);
 xml_in VARCHAR2(500);
BEGIN
  id_in := '00001';
  xml_in := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cabecera>
    <detalle>
        <monto>10.0</monto>
        <secuencial>1</secuencial>
    </detalle>
    <detalle>
        <monto>6.95</monto>
        <secuencial>2</secuencial>
    </detalle>
    <fecha>2016-09-13T13:23:28.319-05:00</fecha>
    <numero>00001</numero>
</cabecera>';
  P_INSERT_DOCUMENTO(id_in,xml_in);
END;
/

SELECT *
FROM CABECERA NATURAL JOIN DETALLE;
