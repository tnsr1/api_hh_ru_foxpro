*Foxpro code
FUNCTION URLEncode(txt As String) As String
	LOCAL buffer As String, i As Integer, c As Integer, a as Integer
	buffer = ""
	For i = 1 To Len(txt)
		c = SUBSTR(txt, i, 1)
		IF ASC(c) < 128
			buffer = buffer + c
		ELSE
			a = UnicodeVal(c)
			buffer = buffer + "%" + Hex1(192 + INTDEV(a, 64))
			buffer = buffer + "%" + Hex1(128 + MOD(a,64))
		ENDIF
	EndFor
RETURN buffer

FUNCTION INTDEV(x, y)
RETURN INT(ROUND(x,0)/ROUND(y,0))

FUNCTION Hex1(tnNum)
    RETURN STRCONV(CHR(tnNum), 15)
ENDFUNC

FUNCTION UnicodeVal(tcString)
    LOCAL lcUnicodeString, lnUnicodeCode
    
    lcUnicodeString = STRCONV(tcString, 5, 0x419)
    * Получение кода первого двухбайтового символа
	lnUnicodeCode = ASC(SUBSTR(lcUnicodeString, 1, 1)) + ;
                    ASC(SUBSTR(lcUnicodeString, 2, 1)) * 256
    
    RETURN lnUnicodeCode
ENDFUNC
