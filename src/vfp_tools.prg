*Foxpro code
*https://forum.foxclub.ru/read.php?29,886031
FUNCTION URLEncode(txt As String) As String
	LOCAL buffer As String, i As Integer, c As Integer, a as Integer
	buffer = ""
	For i = 1 To Len(txt)
	c = SUBSTR(txt, i, 1)
	DO CASE
	CASE c $ [ -~_.] &&OR (ASC(c) < 128 AND (ISDIGIT(c) OR ISALPHA(c))) ???
	    c = "%" + Hex1(c)
	CASE ASC(c) > 127
	    a = UnicodeVal(c)
	    c = "%" + Hex2(192 + INT(a / 64))+ "%" + Hex2(128 + MOD(a, 64))
	ENDCASE
	
	buffer = buffer + c
	EndFor
	RETURN buffer
ENDFUNC

FUNCTION Hex1(tcChar)
    RETURN STRCONV(tcChar, 15)
ENDFUNC

FUNCTION Hex2(tnNum)
    RETURN STRCONV(CHR(tnNum), 15)
ENDFUNC

FUNCTION INTDEV(x, y)
	RETURN INT(ROUND(x,0)/ROUND(y,0))
ENDFUNC

* Функция-аналог AscW (упрощенный вариант)
FUNCTION UnicodeVal
PARAMETERS tcString
	RETURN CTOBIN(STRCONV(LEFT(tcString,1), 5, 0x419), '2sr')
ENDFUNC
