*Foxpro code
*https://forum.foxclub.ru/read.php?29,886031
FUNCTION URLEncode(txt As String) As String
	LOCAL buffer As String, i As Integer, c As Integer, a as Integer
	buffer = ""
	For i = 1 To Len(txt)
		c = SUBSTR(txt, i, 1)
		IF ASC(c) < 128
			IF ASC(c) = 32
				buffer = buffer + "%20"
			ELSE
				buffer = buffer + c
			ENDIF
		ELSE
			a = UnicodeVal(c)
			buffer = buffer + "%" + Hex1(192 + INT(a / 64))
			buffer = buffer + "%" + Hex1(128 + MOD(a,64))
		ENDIF
	EndFor
	RETURN buffer
ENDFUNC

FUNCTION INTDEV(x, y)
	RETURN INT(ROUND(x,0)/ROUND(y,0))
ENDFUNC

FUNCTION Hex1(tnNum)
    RETURN STRCONV(CHR(tnNum), 15)
ENDFUNC

* Функция-аналог AscW (упрощенный вариант)
FUNCTION UnicodeVal
PARAMETERS tcString
	RETURN CTOBIN(STRCONV(LEFT(tcString,1), 5, 0x419), '2sr')
ENDFUNC
