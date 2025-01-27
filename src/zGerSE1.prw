//Bibliotecas
#Include "totvs.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} zGerSE1
	Fun��o que gera t�tulos a receber
	@type user function
	@author AOliveira
	@since 04/01/2021
	@version 1.0
/*/
User Function zGerSE1()
	Local aArea := GetArea()
	//Objetos da Janela
	Private oDlgPvt
	Private oMsGetTit
	Private aHeadTit := {}
	Private aColsTit := {}
	Private oBtnGera
	Private oBtnFech
	Private oBtnCopy
	//Tamanho da Janela
	Private	aTamanho	:= MsAdvSize()
	Private	nJanLarg	:= aTamanho[5]
	Private	nJanAltu	:= aTamanho[6]
	//Fontes
	Private	cFontUti   := "Tahoma"
	Private	oFontAno   := TFont():New(cFontUti,,-38)
	Private	oFontSub   := TFont():New(cFontUti,,-20)
	Private	oFontSubN  := TFont():New(cFontUti,,-20,,.T.)
	Private	oFontBtn   := TFont():New(cFontUti,,-14)
	
	//Criando o cabe�alho da Grid
	//              Nome               Campo         M�scara                        Tamanho                   Decimal                   Valid          Usado  Tipo F3     CBOX
	//Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE               ,SX3->X3_TAMANHO           ,SX3->X3_DECIMAL,SX3->X3_VALID,SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	aAdd(aHeadTit, {"Prefixo",         "SE1_PREFIXO", "",                            TamSX3("E1_PREFIXO")[01], 0,                        ".T.",         ".T.", "C", "",    ""} )
	aAdd(aHeadTit, {"Num.T�tulo",      "SE1_NUM",     "",                            TamSX3("E1_NUM"    )[01], 0,                        ".T.",         ".T.", "C", "",    "",,"u_Get2Tit()"} )
	aAdd(aHeadTit, {"Parcela",         "SE1_PARCELA", "",                            TamSX3("E1_PARCELA")[01], 0,                        ".T.",         ".T.", "C", "",    ""} )
	aAdd(aHeadTit, {"Tipo",            "SE1_TIPO",    "",                            TamSX3("E1_TIPO"   )[01], 0,                        ".T.",         ".T.", "C", "05",  ""} )
	aAdd(aHeadTit, {"Natureza",        "SE1_NATUREZ", "",                            TamSX3("E1_NATUREZ")[01], 0,                        ".T.",         ".T.", "C", "SED", ""} )
	aAdd(aHeadTit, {"Cliente",         "SXX_CLIENTE", "",                            TamSX3("E1_CLIENTE")[01], 0,                        "u_zSE1Cli()", ".T.", "C", "SA1", ""} )
	aAdd(aHeadTit, {"Loja",            "SXX_LOJA",    "",                            TamSX3("E1_LOJA"   )[01], 0,                        ".F.",         ".T.", "C", "",    ""} )
	aAdd(aHeadTit, {"Nome",            "SXX_NOMCLI",  "",                            TamSX3("E1_NOMCLI" )[01], 0,                        ".F.",         ".F.", "C", "",    ""} )
	aAdd(aHeadTit, {"Emiss�o",         "SE1_EMISSAO", "",                            TamSX3("E1_EMISSAO")[01], 0,                        ".T.",         ".T.", "D", "",    ""} )
	aAdd(aHeadTit, {"Vencimento",      "SE1_VENCTO",  "",                            TamSX3("E1_VENCTO" )[01], 0,                        "u_zSE1Dat()", ".T.", "D", "",    ""} )
	aAdd(aHeadTit, {"Vencimento Real", "SE1_VENCREA", "",                            TamSX3("E1_VENCREA")[01], 0,                        ".T.",         ".T.", "D", "",    ""} )
	aAdd(aHeadTit, {"Valor T�tulo",    "SE1_VALOR",   PesqPict('SE1', 'E1_VALOR'),   TamSX3("E1_VALOR"  )[01], TamSX3("E1_VALOR")[02],   "u_zSE1Vlr()", ".T.", "N", "",    ""} )
	aAdd(aHeadTit, {"Taxa Perman.",    "SE1_VALJUR",  PesqPict('SE1', 'E1_VALJUR'),  TamSX3("E1_VALJUR" )[01], TamSX3("E1_VALJUR")[02],  ".T.",         ".T.", "N", "",    ""} )
	aAdd(aHeadTit, {"Porc Juros",      "SE1_PORCJUR", PesqPict('SE1', 'E1_PORCJUR'), TamSX3("E1_PORCJUR")[01], TamSX3("E1_PORCJUR")[02], ".T.",         ".T.", "N", "",    ""} )
	aAdd(aHeadTit, {"Hist�rico",       "SE1_HIST",    "",                            TamSX3("E1_HIST"   )[01], 0,                        ".T.",         ".T.", "C", "",    ""} )

	//Cria��o da tela com os dados que ser�o informados dos t�tulos
	DEFINE MSDIALOG oDlgPvt TITLE "Cria��o de T�tulos - Contas a Receber" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Labels gerais
		@ 004, 003 SAY "FIN" SIZE 200, 030 FONT oFontAno OF oDlgPvt COLORS RGB(149,179,215) PIXEL
		@ 004, 040 SAY "Gera��o de" SIZE 200, 030 FONT oFontSub OF oDlgPvt COLORS RGB(031,073,125) PIXEL
		@ 014, 040 SAY "T�tulos a Receber" SIZE 200, 030 FONT oFontSubN OF oDlgPvt COLORS RGB(031,073,125) PIXEL
		
		//Bot�es
		@ 006, (nJanLarg/2-001)-(0067*03) BUTTON oBtnCopy  PROMPT "Copiar Linha"  SIZE 065, 018 OF oDlgPvt ACTION (fCopLinha())                                FONT oFontBtn PIXEL
		@ 006, (nJanLarg/2-001)-(0067*02) BUTTON oBtnGera  PROMPT "Gerar"         SIZE 065, 018 OF oDlgPvt ACTION (Processa({|| fGeraTit()}, "Processando"))   FONT oFontBtn PIXEL
		@ 006, (nJanLarg/2-001)-(0067*01) BUTTON oBtnFech  PROMPT "Fechar"        SIZE 065, 018 OF oDlgPvt ACTION (oDlgPvt:End(),RollBackSX8())                FONT oFontBtn PIXEL

		
		//Grid dos t�tulos financeiros
		oMsGetTit := MsNewGetDados():New(	    029,;                                        //nTop
    										003,;                                        //nLeft
    										(nJanAltu/2)-3,;                             //nBottom
    										(nJanLarg/2)-3,;                             //nRight
    										GD_INSERT + GD_DELETE + GD_UPDATE,;          //nStyle
    										"AllwaysTrue()",;                            //cLinhaOk
    										,;                                           //cTudoOk
    										"",;                                         //cIniCpos
    										,;                                           //aAlter
    										,;                                           //nFreeze
    										9999,;                                       //nMax
    										,;                                           //cFieldOK
    										,;                                           //cSuperDel
    										,;                                           //cDelOk
    										oDlgPvt,;                                    //oWnd
    										aHeadTit,;                                   //aHeader
    										aColsTit)                                    //aCols
	
//    oMsGetTit:Acols[1,2] := 
 
	ACTIVATE MSDIALOG oDlgPvt CENTERED
	
	RestArea(aArea)
Return

/*/{Protheus.doc} fGeraTit
	Fun��o que gera os t�tulos financeiros
	@type  Static Function
	@author AOliveira
	@since 04/01/2021
/*/
Static Function fGeraTit()
	Local aArea     := GetArea()
	Local aColsAux  := oMsGetTit:aCols
	Local nAtual    := 0
	Local nModBkp   := 0
	Local lContinua := .T.
	Local cEmBranco := ""
	Local nPosPre   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_PREFIXO"})
	Local nPosTit   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_NUM"    })
	Local nPosPar   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_PARCELA"})
	Local nPosTip   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_TIPO"   })
	Local nPosNat   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_NATUREZ"})
	Local nPosFor   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SXX_CLIENTE"})
	Local nPosLoj   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SXX_LOJA"   })
	Local nPosNom   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SXX_NOMCLI" })
	Local nPosEmi   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_EMISSAO"})
	Local nPosVen   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_VENCTO" })
	Local nPosRea   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_VENCREA"})
	Local nPosVal   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_VALOR"  })
	Local nPosJur   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_VALJUR" })
	Local nPosPor   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_PORCJUR"})
	Local nPosHis   := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_HIST"   })
	Local aVetSE1   := {}
	
	DbSelectArea('SE1')
	SE1->(DbSetOrder(1)) // E1_FILIAL + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA
	
	ProcRegua(Len(aColsAux))
	
	//Percorre as linhas
	For nAtual := 1 To Len(aColsAux)
		IncProc("Analisando a linha "+cValToChar(nAtual)+" de "+cValToChar(Len(aColsAux))+"...")
		
		//Se a linha n�o estiver exclu�da
		If ! aColsAux[nAtual][Len(aHeadTit) + 1]
			cEmBranco := ""
			
			//Se j� existir um t�tulo com esse n�mero, retorna erro
			If SE1->(DbSeek(FWxFilial('SE1') + aColsAux[nAtual][nPosPre] + aColsAux[nAtual][nPosTit] + aColsAux[nAtual][nPosPar] + aColsAux[nAtual][nPosTip] + aColsAux[nAtual][nPosFor] + aColsAux[nAtual][nPosLoj]))
				MsgStop("N�mero de t�tulo com esse prefixo, para esse Cliente j� encontrado!" + CRLF +;
					"Linha: " + cValToChar(nAtual) + CRLF +;
					"T�tulo: " + aColsAux[nAtual][nPosTit], "Aten��o")
				lContinua := .F.
			EndIf
			
			//Se houver algum campo obrigat�rio em branco, retorna erro
			//cEmBranco += Iif(Empty(aColsAux[nAtual][nPosPre]), "Prefixo" + CRLF,         "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosTit]), "Num.T�tulo" + CRLF,      "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosPar]), "Parcela" + CRLF,         "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosTip]), "Tipo" + CRLF,            "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosNat]), "Natureza" + CRLF,        "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosFor]), "Cliente" + CRLF,         "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosLoj]), "Loja" + CRLF,            "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosNom]), "Nome" + CRLF,            "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosEmi]), "Emiss�o" + CRLF,         "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosVen]), "Vencimento" + CRLF,      "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosRea]), "Vencimento Real" + CRLF, "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosVal]), "Valor T�tulo" + CRLF,    "")
			cEmBranco += Iif(Empty(aColsAux[nAtual][nPosHis]), "Hist�rico" + CRLF,       "")
			
			If ! Empty(cEmBranco)
				MsgStop("Campo(s) em branco: "+CRLF+cEmBranco, "Aten��o")
				lContinua := .F.
			EndIf
		EndIf
	Next
	
	//Se n�o houve erro no processo
	If lContinua
		//Faz um backup da nModulo e altera para financeiro
		nModBkp := nModulo
		nModulo := 6
		
		ProcRegua(Len(aColsAux))
		
		//Percorre novamente os dados digitados
		For nAtual := 1 To Len(aColsAux)
		
			IncProc("Gerando T�tulo - linha "+cValToChar(nAtual)+" de "+cValToChar(Len(aColsAux))+"...")
			
			//Se a linha n�o estiver exclu�da
			If ! aColsAux[nAtual][Len(aHeadTit) + 1]
				//Prepara o array para o execauto
				aVetSE1 := {}
				//aAdd(aVetSE1, {"E1_FILIAL",  FWxFilial("SE1"),          Nil})
				aAdd(aVetSE1, {"E1_NUM",     aColsAux[nAtual][nPosTit],   Nil})
				aAdd(aVetSE1, {"E1_PREFIXO", aColsAux[nAtual][nPosPre],   Nil})
				aAdd(aVetSE1, {"E1_PARCELA", aColsAux[nAtual][nPosPar],   Nil})
				aAdd(aVetSE1, {"E1_TIPO",    aColsAux[nAtual][nPosTip],   Nil})
				aAdd(aVetSE1, {"E1_NATUREZ", aColsAux[nAtual][nPosNat],   Nil})
				aAdd(aVetSE1, {"E1_CLIENTE", aColsAux[nAtual][nPosFor],   Nil})
				aAdd(aVetSE1, {"E1_LOJA",    aColsAux[nAtual][nPosLoj],   Nil})
				aAdd(aVetSE1, {"E1_NOMCLI",  aColsAux[nAtual][nPosNom],   Nil})
				aAdd(aVetSE1, {"E1_EMISSAO", aColsAux[nAtual][nPosEmi],   Nil})
				aAdd(aVetSE1, {"E1_VENCTO",  aColsAux[nAtual][nPosVen],   Nil})
				aAdd(aVetSE1, {"E1_VENCREA", aColsAux[nAtual][nPosRea],   Nil})
				aAdd(aVetSE1, {"E1_VALOR",   aColsAux[nAtual][nPosVal],   Nil})
				aAdd(aVetSE1, {"E1_VALJUR",  aColsAux[nAtual][nPosJur],   Nil})
				aAdd(aVetSE1, {"E1_PORCJUR", aColsAux[nAtual][nPosPor],   Nil})
				aAdd(aVetSE1, {"E1_HIST",    aColsAux[nAtual][nPosHis],   Nil})
				aAdd(aVetSE1, {"E1_MOEDA",   1,                           Nil})
				
				//Inicia o controle de transa��o
				Begin Transaction
					//Chama a rotina autom�tica
                    ConfirmSX8()
					lMsErroAuto := .F.
					MSExecAuto({|x,y| FINA040(x,y)}, aVetSE1, 3)
					
					//Se houve erro, mostra o erro ao usu�rio e desarma a transa��o
					If lMsErroAuto
						MostraErro()
						DisarmTransaction()
					EndIf
				//Finaliza a transa��o
				End Transaction
			EndIf
		Next
			
		//Volta a vari�vel nModulo
		nModulo := nModBkp
	EndIf
	
	RestArea(aArea)
Return

/*/{Protheus.doc} fCopLinha
	Fun��o que copia a linha e cria uma nova em baixo
	@type  Static Function
	@author AOliveira
	@since 04/01/2021
/*/
Static Function fCopLinha()
	Local aArea    := GetArea()
	Local aColsAux := oMsGetTit:aCols
	Local nLinha   := oMsGetTit:nAt
	Local aLinNov  := {}
	Local nPosTit  := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_NUM"})
	Local nPosParc := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_PARCELA"})
	Local aPergs   := {}
	Local aRetorn  := {}
	Local cTitulo  := aColsAux[nLinha][nPosTit]
	Local nQuant   := 0
	Local nAtual   := 0
	Local cIncParc := "1"
	
	//Se n�o tiver t�tulo, n�o poder� ser copiado
	If Empty(cTitulo)
		MsgAlert("Linha com t�tulo em branco, n�o poder� ser copiada.", "Aten��o")
	
	Else
		//Cria uma c�pia da Linha
		aLinNov := aClone(aColsAux[nLinha])
		aLinNov[nPosTit] := Space(Len(aLinNov[nPosTit]))
		
		//Se a parcela tiver em branco, muda para n�o a pergunta
		If Empty(aColsAux[nLinha][nPosParc])
			cIncParc := "2"
		EndIf
		
		//Adiciona os parametros para a pergunta
		aAdd(aPergs, {1, "T�tulo",              cTitulo, "",       ".T.",        "", ".F.", 80, .F.})
		aAdd(aPergs, {1, "Quantidade",          nQuant,  "@E 999", "Positivo()", "", ".T.", 80, .T.})
		aAdd(aPergs, {2, "Incrementa Parcela",  Val(cIncParc), {"1=Sim", "2=N�o"},          80, ".T.", .F.})
		
		//Se a pergunta for confirmada
		If ParamBox(aPergs, "Informe os par�metros", @aRetorn, , , , , , , , .F., .F.)
			nQuant   := aRetorn[2]
			cIncParc := cValToChar(aRetorn[3])
			
			//Adiciona no array
			For nAtual := 1 To nQuant
				If cIncParc == "1"
					aLinNov[nPosParc] := Soma1(aLinNov[nPosParc])
				EndIf
				
				aAdd(aColsAux, aClone(aLinNov))
			Next
		EndIf
		
		//Seta novamente o array
		oMsGetTit:SetArray(aColsAux)
		oMsGetTit:Refresh()
	EndIf
	
	RestArea(aArea)
Return

/*/{Protheus.doc} zSE1Cli
	Fun��o que valida o Cliente digitado
	@type user function
	@author AOliveira
	@since 19/12/2017
	@version 1.0
/*/
User Function zSE1Cli()
	Local aArea    := GetArea()
	Local lRet     := .T.
	Local cCliente := &( ReadVar() )
	Local nLinha   := oMsGetTit:nAt
	Local nPosLoj  := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SXX_LOJA"   })
	Local nPosNom  := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SXX_NOMCLI" })
	
	DbSelectArea('SA1')
	SA1->(DbSetOrder(1))
	
	//Tenta posicionar no Cliente
	If SA1->(DbSeek(FWxFilial('SA1') + cCliente))
		oMsGetTit:aCols[nLinha][nPosLoj] := SA1->A1_LOJA
		oMsGetTit:aCols[nLinha][nPosNom] := SA1->A1_NOME
		
	Else
		lRet := .F.
		MsgStop("Cliente n�o encontrado!", "Aten��o")
	EndIf
	
	RestArea(aArea)
Return lRet

/*/{Protheus.doc} zSE1Dat
	Fun��o que valida a data de vencimento, atualizando o vencimento real
	@type user function
	@author AOliveira
	@since 19/12/2017
	@version 1.0
/*/

User Function zSE1Dat()
	Local aArea    := GetArea()
	Local lRet     := .T.
	Local dVencto  := &( ReadVar() )
	Local nLinha   := oMsGetTit:nAt
	Local nPosReal := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_VENCREA" })
	
	//Pega a pr�xima data v�lida do sistema
	oMsGetTit:aCols[nLinha][nPosReal] := DataValida(dVencto, .T.)
			
	RestArea(aArea)
Return lRet

/*/{Protheus.doc} zSE1Vlr
	Fun��o para atualizar a taxa permanecian e o porc juros
	@type user function
	@author AOliveira
	@since 10/01/2017
	@version 1.0
/*/
User Function zSE1Vlr()
	Local aArea      := GetArea()
	Local lRet       := .T.
	Local nValor     := &( ReadVar() )
	Local nTaxa      := GetMV('MV_TXPER')
	Local nLinha     := oMsGetTit:nAt
	Local nPosVlrJur := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_VALJUR"  })
	Local nPosPorJur := aScan(aHeadTit, {|x| Alltrim(x[2]) == "SE1_PORCJUR" })
	
	//Pega a pr�xima data v�lida do sistema
	oMsGetTit:aCols[nLinha][nPosPorJur] := nTaxa
	oMsGetTit:aCols[nLinha][nPosVlrJur] := nValor * (nTaxa / 100)
			
	RestArea(aArea)
Return lRet

User Function GetTit()

Local nLinha   := oMsGetTit:nAt

If Empty( oMsGetTit:aCols[nLinha,2]) 
   oMsGetTit:aCols[nLinha,2] :=GetSXENum('SE1', 'E1_NUM')
   ConfirmSX8()
Endif   

Return(.T.)


User Function Get2Tit()

Local nTitulo := GetSXENum('SE1', 'E1_NUM')

ConfirmSX8()

Return(nTitulo)


