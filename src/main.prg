IF TYPE("_vfp.ActiveProject") = "O"
	SET PATH TO ADDBS(JUSTPATH(_vfp.ActiveProject.Name))
ENDIF
SET PROCEDURE TO vfp_tools.prg, json.prg, api_hh_ru.prg, formmain.prg

PRIVATE pcQuery, pcMySkills, FormMain
m.pcMySkills = "SQL, Foxpro"
m.pcQuery = "Программист Foxpro"
m.FormMain = NEWOBJECT("FormMain","formmain.prg")
m.FormMain.show()
