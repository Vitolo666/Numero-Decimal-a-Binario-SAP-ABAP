*&---------------------------------------------------------------------*
*& Report ZVSM_DECI_BINA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvsm_deci_bina.

*&---------------------------------------------------------------------*
* DECLARACION DE VARIABLES
*&---------------------------------------------------------------------*
DATA: suma_text(50) TYPE c,
      suma          TYPE i,
      exponente     TYPE i,
      flag          TYPE c.
*&---------------------------------------------------------------------*
* SELECTION-SCREEN
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK dec_to_bin WITH FRAME.
  PARAMETERS:
             p_numero TYPE i.
SELECTION-SCREEN END OF BLOCK dec_to_bin.
*&---------------------------------------------------------------------*
* START OF SELECTION
*&---------------------------------------------------------------------*
PERFORM iniciaizar.
PERFORM calcular_binario USING p_numero CHANGING suma_text.

IF flag EQ space.
  PERFORM imprimir.
ENDIF.

*&---------------------------------------------------------------------*
*& Form INICIAIZAR
*&---------------------------------------------------------------------*

FORM iniciaizar .

  suma = 0.
  exponente = 1.

ENDFORM.     " INICIALIZAR

*&---------------------------------------------------------------------*
*& Form calcular_binario
*&---------------------------------------------------------------------*

FORM calcular_binario  USING    p_num
                       CHANGING p_sum.

  DATA: digito TYPE i,
        numero TYPE i.

  numero = p_num.

  CATCH SYSTEM-EXCEPTIONS arithmetic_errors = 5.
    WHILE numero GT 0.
      digito = numero MOD 2.
      numero = numero DIV 2.
      suma = suma + digito * exponente.
      exponente = exponente * 10.
    ENDWHILE.
    p_sum = suma.
    CONDENSE p_sum NO-GAPS.
  ENDCATCH.

  IF sy-subrc = 5.
    WRITE / 'Error de calculo'.
    flag = 'X'.
  ENDIF.

ENDFORM.       " CALCULAR BINARIO

*&---------------------------------------------------------------------*
*& Form imprimir
*&---------------------------------------------------------------------*

FORM imprimir.

  WRITE:/ 'El numero binario de',25 p_numero.
  WRITE:/ 'es:',5 suma_text.

ENDFORM.        " IMPRIMIR
