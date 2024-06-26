FUNCTION GetVac
LPARAMETERS tcQuery
LOCAL http, url0, text, qwe, timeout, CountV, CountP, isk, pg, url_, i, ii, url1, Items, Item, vak, keySkills, jj
	http = CreateObject("WinHttp.WinHttpRequest.5.1")
	http.Option(2) = 65001
	m.timeout = 2000 &&milliseconds
	http.setTimeouts(m.timeout, m.timeout, m.timeout, m.timeout)
	url0 = "https://api.hh.ru/vacancies?text=NAME:(" + ALLTRIM(tcQuery) + ")&only_with_salary=true&no_magic=true&period=30&label=not_from_agency&order_by=publication_time"
	url0 = URLEncode(url0)
	http.Open("get", url0)
	TRY
		http.send
	CATCH TO m.Err
		MESSAGEBOX(m.Err.Number)
		RETURN
	ENDTRY
	m.Text = http.responseText
	If ATC("errors", m.Text) > 0 Then
	    MESSAGEBOX(m.Text)
	    *SUSPEND
	    RETURN
	Else
	    If !EMPTY(m.Text) Then
	        qwe = json_decode(m.Text)
	    EndIf
	EndIf

	CountV = qwe.get("found")
	If CountV = 0 Then
	    MESSAGEBOX("Ничего не найдено.")
	    RETURN
	EndIf

	CountP = qwe.get("pages")
	isk = 1

	CREATE CURSOR curVacancy(Id N(10), Name c(100), url c(100))
	CREATE CURSOR curSkills(IdVac N(10), Skill C(100))

	For pg = 1 To CountP &&MIN(2,CountP)
	    If pg > 1 Then
	        url_ = url0 + "&page=" + ALLTRIM(STR(pg))
	        http.Open("get", url_)
	        http.send
	        m.Text = http.responseText
			If ATC("errors", m.Text) > 0 Then
			    MESSAGEBOX(m.Text)
			    *SUSPEND
			    RETURN
			ELSE
		        qwe = json_decode(m.Text)
		    ENDIF
	    EndIf
	    For i = 1 To MIN(CountV - (pg - 1), 20)
			ii = (pg - 1) * 20 + i
			m.Items = qwe.get("items")
			m.Item = m.Items.Array(i)
			url1 = m.Item.get("alternate_url")
			INSERT INTO curVacancy VALUES(ii, Item.get("name"), url1)
	        url_ = Item.get("url")
	        url_ = STRTRAN(url_, "?host=hh.ru", "")
	        http.Open("get", url_)
	        http.send
	        m.Text = http.responseText
			If ATC("errors", m.Text) > 0 Then
			    MESSAGEBOX(m.Text)
			    *SUSPEND
			    RETURN
			ELSE
		        vak = json_decode(m.Text)
		    ENDIF
	        keySkills = vak.get("key_skills")
	        CountSk = ALEN(keySkills.Array)
	        If CountSk > 0 Then
		        For jj = 1 To CountSk
					If jj <> 1 
						isk = isk + 1
					EndIf
					keySkill1 = keySkills.Array(jj)
					IF TYPE("keySkill1") = "O"
						keySkill1 = keySkill1.get("name")
		    			INSERT INTO curSkills VALUES(ii, keySkill1)
		    		ENDIF
				EndFor
	        EndIf
		EndFor
	EndFor
RETURN
