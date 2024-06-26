**************************************************
*-- Class:        formmain (c:\dev\vfp\api_hh_ru\formmain.vcx)
*-- ParentClass:  form
*-- BaseClass:    form
*-- Time Stamp:   06/26/24 09:22:13 PM
*
DEFINE CLASS formmain AS form


	Top = 0
	Left = 0
	Height = 540
	Width = 719
	DoCreate = .T.
	Caption = "Test api.hh.ru"
	WindowType = 1
	Name = "FormMain"


	ADD OBJECT label1 AS label WITH ;
		Caption = "Запрос", ;
		Height = 17, ;
		Left = 12, ;
		Top = 16, ;
		Width = 40, ;
		Name = "Label1"


	ADD OBJECT txtquery AS textbox WITH ;
		ControlSource = "m.pcQuery", ;
		Height = 23, ;
		Left = 60, ;
		Top = 12, ;
		Width = 624, ;
		Name = "txtQuery"


	ADD OBJECT label2 AS label WITH ;
		Caption = "Мои навыки", ;
		Height = 17, ;
		Left = 12, ;
		Top = 44, ;
		Width = 71, ;
		Name = "Label2"


	ADD OBJECT txtmyskills AS textbox WITH ;
		ControlSource = "m.pcMySkills", ;
		Height = 23, ;
		Left = 82, ;
		Top = 40, ;
		Width = 602, ;
		Name = "txtMySkills"


	ADD OBJECT grid1 AS grid1

	ADD OBJECT cmdsearch AS commandbutton WITH ;
		Top = 72, ;
		Left = 12, ;
		Height = 25, ;
		Width = 97, ;
		Caption = "Поиск", ;
		Name = "cmdSearch"


	PROCEDURE cmdsearch.Click
		CLOSE DATABASES ALL
		CREATE CURSOR curMySkills(Skill C(100))
		LOCAL ARRAY laMySkills(1)
		IF ALINES(laMySkills, thisform.txtMySkills.Text, 1, ",") > 0
			LOCAL lcStr
			FOR EACH lcStr IN laMySkills
				INSERT INTO curMySkills VALUES(lcStr)
			ENDFOR
		ENDIF

		GetVac(m.pcQuery)
		
		SELECT DISTINCT v.id, v.name, v.url ;
		FROM curVacancy v ;
			INNER JOIN curSkills s ON s.IdVac = v.Id ;
			INNER JOIN curMySkills ms ON ms.skill = s.skill ;
		INTO CURSOR curVacancy
		
		SELECT curVacancy
		GO TOP
		WITH thisform.grid1
			.RecordSource = ""
			.RecordSource = "curVacancy"

			.Column1.Width = 25
			.Column1.Name = "Column1"
			.Column2.Width = 359
			.Column2.Name = "Column2"
			.Column3.Width = 250
			.Column3.Name = "Column3"

			.Refresh 
		ENDWITH
	ENDPROC


ENDDEFINE
*
*-- EndDefine: formmain
**************************************************
DEFINE CLASS Grid1 AS grid

	Height = 385
	Left = 12
	Panel = 1
	RecordSource = "curVacancy"
	Top = 120
	Width = 685
	Name = "Grid1"

	ADD OBJECT column1 as column1
	ADD OBJECT column2 as column2
	ADD OBJECT column3 as column3

	PROCEDURE column3.hyperlink1.Click
		DECLARE INTEGER ShellExecute IN Shell32 INTEGER, STRING @, STRING @, STRING @, STRING @, SHORT
		
		ShellExecute(0, 'open', ALLTRIM(this.Text), '', '', 3)
	ENDPROC

ENDDEFINE

DEFINE CLASS column1 AS column

	ADD OBJECT header1 AS header WITH ;
		Alignment = 2, ;
		Caption = "Id", ;
		Name = "Header1"


	ADD OBJECT text1 AS textbox WITH ;
		BorderStyle = 0, ;
		Margin = 0, ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"

ENDDEFINE

DEFINE CLASS column2 AS column

	ADD OBJECT header1 AS header WITH ;
		Alignment = 2, ;
		Caption = "Название", ;
		Name = "Header1"


	ADD OBJECT text1 AS textbox WITH ;
		BorderStyle = 0, ;
		Margin = 0, ;
		ForeColor = RGB(0,0,0), ;
		BackColor = RGB(255,255,255), ;
		Name = "Text1"

ENDDEFINE

DEFINE CLASS column3 AS column

	ADD OBJECT header1 AS header WITH ;
		Alignment = 2, ;
		Caption = "Ссылка", ;
		Name = "Header1"

	ADD OBJECT hyperlink1 AS hyperlink1 WITH ;
		Top = 47, ;
		Left = 159, ;
		Height = 23, ;
		Width = 23, ;
		Name = "Hyperlink1", ;
		ReadOnly = .T.

ENDDEFINE

DEFINE CLASS hyperlink1 AS textbox
ENDDEFINE
