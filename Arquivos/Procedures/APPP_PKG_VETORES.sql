/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_PKG_VETORES  : CRIAR A PACKAGE APPP_PKG_VETORES
* Author            : WeeDo 
* History           : 26/03/2009 - Matheus Goncalves
***********************************************************************************************************************/
CREATE OR REPLACE PACKAGE APPP_PKG_VETORES IS 
      TYPE NUMBER_VECTOR IS TABLE OF NUMBER INDEX BY BINARY_INTEGER; 
      TYPE CHAR_VECTOR   IS TABLE OF VARCHAR2(3000) INDEX BY BINARY_INTEGER;           
END;
/ 
