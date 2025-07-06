" Vim syntax file
" Language:	ICPSR acquisition templates
" Maintainer:	Kent Nassen (knassen@umich.edu)
" Last change:	1997 September 9

"-------------------------------------------------------------------------
" Remove any old syntax stuff hanging around
"-------------------------------------------------------------------------
syntax clear

"syntax sync minlines=50

"-------------------------------------------------------------------------
" Keyword Definitions
"-------------------------------------------------------------------------
syntax keyword addStatement CDNET COBOL FORTRAN Fortran MS-DOS OSIRIS IF LIST PLEASE ACKNOWLEDGEMENT ACQUIRED ADDRESS AND ANY ASSIGNED BE BLOCKSIZE BY CASES COMMENTS PROBLEMS COPY DATA DATASET DATE DOCUMENTATION FILE FROM HARD HIGH-PRIORITY ICPSR INFORMATION INVESTIGATOR ITEMS LABELSNIFF LETTER LIST LRECL MEMORANDUM MTS NAME NUMBER OF ON OR PLEASE PRINCIPAL PROCESSOR RACK RE RECIPIENTS SCANNED SENT STUDY SYNOPSIS TAPE TAPE TITLE TO VOLUME WILL 

syntax keyword addMonths  		Jan January Feb February Mar March Apr April May June July 
syntax keyword addMonths  		Aug August Sept September Oct October Nov November Dec December
syntax keyword addVerRel  		version release
syntax keyword addStructType 	hierarchical relational rectangular 

"-------------------------------------------------------------------------
" Syntax Patterns for Intro Text, Special Characters, & Field Contents
"-------------------------------------------------------------------------
"syntax region addTextInput	start="= " end=";[ ]*$"

syntax match addSpecialCharacter1  ";"
syntax match addSpecialCharacter2  "/"
syntax match addSpecialCharacter3  "="
syntax match addSpecialCharacter4  "+"
syntax match addSpecialCharacter5  ":"
syntax match addSpecialCharacter6  ")"
syntax match addSpecialCharacter7  "("

"syntax match addIntro 			"PLEASE FILL IN THE FOLLOWING"
"syntax match addFull			"\-full front matter"
"syntax match addPartial			"\-just title & cit\. pages"
syntax match addNumber        	"-\=\<[0-9]\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
"syntax match addMultiple		"multiple pieces"
"syntax match addSeparate		"separate subtitles\?"
"syntax match addDataFiles		/[0-9]* data fil[es]* +/e-2 contains=addSpecialCharacter4,addNumber
"syntax match addWhy 			"why\?"
"syntax match addAffiliation 	"affiliation is:"
"syntax match addArchFilter1		" = ICPSR;"e-1s-2 contains=addArch,addSpecialCharacter3,addSpecialCharacter1
"syntax match addArchFilter2		" = NACDA;"e-1s-2 contains=addArch,addSpecialCharacter3,addSpecialCharacter1
"syntax match addArchFilter3		" = SAMHDA;"e-1s-2 contains=addArch,addSpecialCharacter3,addSpecialCharacter1
"syntax match addArchFilter4		" = CJAIN;"e-1s-2 contains=addArch,addSpecialCharacter3,addSpecialCharacter1
"syntax match addArchFilter5		" = EDUCATION;"e-1s-2 contains=addArch,addSpecialCharacter3,addSpecialCharacter1
"syntax match addYourName 		"Your name:"
"syntax match addMachine			"machine-readable documentation (.*)"
"syntax match addQuestionnaire	"data collection instrument (.*);" contains=addSpecialCharacter4,addSasDds,addSpssDds,addSpecialCharacter1
"syntax match addQuestionnaire2	"data collection instruments (.*);" contains=addSpecialCharacter4,addSasDds,addSpssDds,addSpecialCharacter1
"syntax match addTransport		"SAS [Tt]ransport [Ff]ile"
"syntax match addPortable		"SPSS [Pp]ortable [Ff]ile"
"syntax match addEdition			/[^A-Za-z]ed\./
"syntax match addTypeType		"survey data"
"syntax match addCjainOnly		"CJAIN ONLY"
"syntax match addChooseOne		/(CHOOSE ONE)/
"syntax match addPleaseList		/(PLEASE LIST HERE:)/
"syntax match addPDF				"(PDF)"
"syntax match addText			"(text)"
"syntax match addInap 			/Inap\|INAP\.\|Inap\.\|inap\./ 
"syntax region addGoodSpace		start="^Is this a PRIO" end="^[ 	]*codebook parts will"
"syntax region addGoodSpace2		start=+^The "UPDATE" template:+ end="^Add this field"
"syntax match addSasDds     		"SAS data definition statements +"me=e-2 contains=addSpecialCharacter4
"syntax match addSpssDds   		"SPSS data definition statements +"me=e-2 contains=addSpecialCharacter4
"syntax match addSpssDds2  		"SPSS data definition statements" 

syntax match acqwc2			"L\:\|W\:\|C\:\|maxlen\:\|minlen\:"


"-------------------------------------------------------------------------
" Syntax Patterns for EXTENT.PROCESS
"-------------------------------------------------------------------------
"syntax match addCdbk			"CDBK\.ICPSR"
"syntax match addConchk			"CONCHK\.PR\|CONCHK\.ICPSR"
"syntax match addDdef 			"DDEF\.ICPSR\|DDEF\.PR" 
"syntax match addFreqICPSR 		"FREQ\.ICPSR" 
"syntax match addFreqPr 			"FREQ\.PR" 
"syntax match addMdataICSPR 		"MDATA\.ICPSR" 
"syntax match addMdataPR 		"MDATA\.PR" 
"syntax match addRecode			"RECODE"
"syntax match addReformData 		"REFORM\.DATA" 
"syntax match addReformDoc 		"REFORM\.DOC" 
"syntax match addScan			"SCAN" contains=addSpecialCharacter2
"syntax match addUndocICPSR 		"UNDOCCHK\.ICPSR" 
"syntax match addUndocPR 		"UNDOCCHK\.PR" 


"-------------------------------------------------------------------------
" Syntax Patterns for Template Field Names
"-------------------------------------------------------------------------
"syntax match addAdd 			/^[ ]*ADD;/me=e-1 contains=addSpecialCharacer1
"syntax match addArch 			"^[ ]*ARCH\.FILTER" 
"syntax match addCase 			"^[ ]*CASE\.COUNT" 
"syntax match addCitation		"^[ ]*CITATION"
"syntax match addClassno			"^[ ]*CLASSNO"
"syntax match addClassif			"^[ ]*CLASSIF"
"syntax match addChanges			"^[ ]*COLLECT\.CHANGES" 
"syntax match addNote 			"^[ ]*COLLECT\.NOTE" 
"syntax match addConchkICPSR 	"^[ ]*CONCHK\.ICPSR" 
"syntax match addConchkPr 		"^[ ]*CONCHK\.PR" 
"syntax match addFormat 			"^[ ]*DATA\.FORMAT" 
"syntax match addSource 			"^[ ]*DATA\.SOURCE" 
"syntax match addType 			"^[ ]*DATA\.TYPE" 
"syntax match addAdded 			"^[ ]*DATE-ADDED" 
"syntax match addCollect 		"^[ ]*DATE\.OF\.COLLECT" 
"syntax match addUpdated 		"^[ ]*DATE-UPDATED" 
"syntax match addExtent 			"^[ ]*EXTENT\.COLLECT" 
"syntax match addProcess 		"^[ ]*EXTENT\.PROCESS" 
"syntax match addStruct 			"^[ ]*FILE\.STRUCT" 
"syntax match addAgency 			"^[ ]*FUNDING\.AGENCY" 
"syntax match addGrant 			"^[ ]*GRANT\.NUMBER" 
"syntax match addClassif 		"^[ ]*ICPSR\.CLASSIF[1234]" 
"syntax match addInvestigator	"^[ ]*INVESTIGATOR"
"syntax match addKeywords		"^[ ]*KEYWORDS"
"syntax match addLrecl			/^[ ]*LRECL =/me=e-1
"syntax match addClassn2			"^[ ]*NACDA\.CLASS" 
"syntax match addClassn			"^[ ]*NACJD\.CLASS" 
"syntax match addPart			"^ *[Pp][Aa][Rr][Tt];" contains=addSpecialCharacter1
"syntax match addName 			"^[ ]*PART\.NAME" 
"syntax match addPartNo			"^[ ]*PARTNO" 
"syntax match addRecords	 		"^[ ]*RECORDS\.PER\.CASE" 
"syntax match addRelated 		"^[ ]*RELATED\.PUBS" 
"syntax match addRestrictions	"^[ ]*RESTRICTIONS"
"syntax match addClasss			"^[ ]*SAMHDA\.CLASS" 
"syntax match addSampling		"^[ ]*SAMPLING" 
"syntax match addSeriesName 		"^[ ]*SERIES\.NAME" 
"syntax match addSeriesInfo 		"^[ ]*SERIES\.INFO" 
"syntax match addStudyNo			"^[ ]*STUDYNO"
"syntax match addSubject 		"^[ ]*SUBJECT\.TERM" 
"syntax match addSummary			"^[ ]*SUMMARY" 
"syntax match addTime 			"^[ ]*TIME\.PERIOD" 
"syntax match addTitle			"^[ ]*TITLE" 
"syntax match addTopic			"^[ ]*TOPIC"
"syntax match addUniverse		"^[ ]*UNIVERSE" 
"syntax match addUpdate			"^ ;[ ]UPDATE[ ][(0-9)]*"me=e-1 contains=addSpecialCharacter1 addNumber
"syntax match addVariables 		"^[ ]*VARIABLE\.COUNT" 


"-------------------------------------------------------------------------
" Syntax Patterns for Some Errors in an acquisition Template
"-------------------------------------------------------------------------
" Also see: addClassNo which is linked to Error (this field to be deleted)
" Note that these tests significantly slow down the editor, so some have
" been commented out for that reason (and some because they don't work ;)

" Error: No double quotes allowed anywhere
"syntax match addQuotesErr		+"+

" Error: Two or more spaces anywhere (not in an acq template!)
"syntax match addSpacesErr		"[    ][    ]" contains=addGoodSpace addGoodSpace2 addClassif addUpdate

" Error: Percent spelled as two words (technically correct, but not for our editeurs
"syntax match addPercentErr		/[Pp]er cent/

" Error: Hyphenated word at the end of the line
"syntax match addHyphenErr     	/[a-zA-Z]-$/s+1 
"syntax match addHyphenErr2    	/[0-9]*-$/

" Error: Spaces before a semicolon
"syntax match addSemicolonErr 	/[ ]*;/e-1 contains=addUpdate addSpecialCharacter1

" Error: Semicolon not at the end of the line?
"syntax match addSemicolonErr2	/\;[^\$]/
"syntax match addSemicolonErr2	/[A-Za-z ];[A-Za-z ]/

" Error: Forgot to answer a yes/no question
syntax match addYesNoErr		+yes/no+ contains=addSpecialCharacter2

" Error: The abbreviation for edition (ed.) needs a period
syntax match addEdErr			/ ed \|^ed / contains=addEd

" Error: MDATA without a .PR or .ICPSR (old template style)
syntax match addMdataErr		/MDATA[^\.ICPSR|\.PR]/me=e-1 contains=addSpecialCharacter2

" Error: Space at beginning of line that doesn't begin with a field name (doesn't work)
"syntax match addBeginningSpace	/^[ 	]*/ contains=addGoodSpace,addAdd,addArch,addCase,addCdbk,addClassno,addNote,addChanges,addConchkPr,addConchkICPSR,addFormat,addType,addSource,addAdded,addCollect,addUpdated,addUpdate,addExtent,addProcess,addStruct,addAgency,addGrant,addClassif,addKeywords,addLrecl,addClassn,addClassn2,addClasss,addSubject,addName,addRecords,addRelated,addSeriesName,addSeriesInfo,addTime,addTopic,addVariables,addPart

" Error: No slash before a semicolon (e.g. in EXTENT.PROCESS)
"syntax match addSlashErr		"\/;" contains=addSpecialCharacter1,addSpecialCharacter2

" Error: Miscellaneous garbage like ???  (\?* really slows down the editor!)
syntax match addMiscErr			"\?\?\?" 

"-------------------------------------------------------------------------
" Define the Colors that are Associated with each type of Match
"-------------------------------------------------------------------------
"highlight link addTextInput		Character

highlight link addStatement			Statement
"highlight link addAffiliation		Statement
"highlight link addTwoDotfields		Statement
"highlight link addThreeDotfields	Statement
"highlight link addInap				Number
"highlight link addSlashFields1		Statement
"highlight link addSlashFields2		Statement
"highlight link addArch 				Statement
"highlight link addArchFilter1		Number
"highlight link addArchFilter2		Number
"highlight link addArchFilter3		Number
"highlight link addArchFilter4		Number
"highlight link addArchFilter5		Number
"highlight link addCase 				Statement
"highlight link addCdbk 				Statement
"highlight link addCitation			Statement
"highlight link addClassif 			Statement
"highlight link addConchk			Number
"highlight link addNote 				Statement
"highlight link addChanges			Statement
"highlight link addConchkPr 			Number
"highlight link addConchkICPSR 		Number
"highlight link addEdition			Number
"highlight link addFormat 			Statement
"highlight link addRecode			Number
"highlight link addType 				Statement
"highlight link addSource 			Statement
"highlight link addAdded 			Statement
"highlight link addCollect 			Statement
"highlight link addUpdated 			Statement
"highlight link addUpdate			Statement
"highlight link addDdef 				Number
"highlight link addVerRel			Number
"highlight link addExtent 			Statement
"highlight link addProcess 			Statement
"highlight link addStruct 			Statement
"highlight link addFreqPr 			Number
"highlight link addFreqICPSR 		Number
"highlight link addAgency 			Statement
"highlight link addGrant 			Statement
"highlight link addClassif 			Statement
"highlight link addClassn 			Statement
"highlight link addClassn2 			Statement
"highlight link addClasss 			Statement
"highlight link addClassno			Error
"highlight link addCjainOnly			Error
"highlight link addInvestigator		Statement
"highlight link addKeywords			Statement
"highlight link addSubject 			Statement
"highlight link addLrecl				Statement
"highlight link addMdataPR 			Number
"highlight link addMdataICSPR  		Number
"highlight link addName 				Statement
"highlight link addPDF				Number
"highlight link addPartNo			Statement
"highlight link addText				Number
"highlight link addRecords 			Statement
"highlight link addReformData  		Number
"highlight link addReformDoc 		Number
"highlight link addRelated 			Statement
"highlight link addScan				Number
"highlight link addSeriesName  		Statement
"highlight link addSeriesInfo  		Statement
"highlight link addStructType		Number
"highlight link addTime 				Statement
"highlight link addTopic				Statement
"highlight link addTypeType			Number
"highlight link addUndocICPSR  		Number
"highlight link addUndocPR 			Number
"highlight link addVariables 		Statement
"highlight link addAdd 				Statement
"highlight link addYourName 			Statement
"highlight link addWhy 				Statement
"highlight link addSasDds 			Number
"highlight link addSpssDds 			Number
"highlight link addSpssDds2			Number
"highlight link addMachine			Number
"highlight link addQuestionnaire		Number
"highlight link addQuestionnaire2	Number
"highlight link addTransport   		Number
"highlight link addPortable   		Number
highlight link acqwc2			Number
"highlight link addFull				Statement
"highlight link addPartial			Statement
"highlight link addMultiple			Statement
"highlight link addSeparate			Statement
"highlight link addDataFiles			Number
"highlight link addMonths			Number
"highlight link addPercentErr		Error
"highlight link addQuotesErr			Error
"highlight link addSpacesErr			Error
"highlight link addHyphenErr2		Error
"highlight link addHyphenErr			Error
"highlight link addRestrictions		Statement
"highlight link addSemicolonErr		Error
"highlight link addSemicolonErr2		Error
"highlight link addStudyNo			Statement
"highlight link addSummary      		Statement
"highlight link addTitle				Statement
"highlight link addUniverse			Statement
"highlight link addSampling			Statement
"highlight link addYesNoErr			Error
"highlight link addEdErr				Error
"highlight link addMdataErr			Error
"highlight link addSlashErr			Error
"highlight link addMiscErr			Error
"highlight link addBeginningSpace	Error
"highlight link addSpecialCharacter5 		Statement
"highlight link addSpecialCharacter6 		Statement
"highlight link addSpecialCharacter7 		Statement

highlight link addNumber 			Special
"highlight link addIntro 			Special
"highlight link addPleaseList		Special
"highlight link addChooseOne			Special
highlight addSpecialCharacter1 		gui=bold guifg=orange
highlight addSpecialCharacter2 		gui=bold guifg=yellow
highlight addSpecialCharacter3 		gui=bold guifg=green
highlight addSpecialCharacter4 		gui=bold guifg=gold
"highlight addTextInput 			guifg=LightCyan
"highlight addPart 					guifg=PaleGreen	
