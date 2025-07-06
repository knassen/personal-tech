" Vim syntax file
" Language:	SAS command files (.sas)
" Maintainer:	Kent Nassen (knassen@umich.edu)
" Last change:	1998 April 29

" Remove any old syntax stuff hanging around
syntax clear
syntax case ignore

" TO-DO:
" Missing are such SAS modules as AF, FSP, ETS, IML, QC, and QR, as well
"    as any hi'liting of SAS formats/informats.  They can be added if you use them.
"    The procs entered so far are from just BASE and STAT.
" There's an awful lot of repetition between keyword groups (e.g. function "input" and
"    keyword "input". This means that some keywords will need to be hi'ed only
"    in certain contexts (e.g. after an options statement).
" Also, not much of SAS' symbol set has been implemented yet.

" Note: Some of the commands here are specific to SAS in a Unix environment

" SAS Language keywords
syntax keyword sasKeyword abend abort array attrib 
syntax keyword sasKeyword bell blank by call cards cards4 data delete display dm do drop
syntax keyword sasKeyword end endsas error file filename footnote go to format if %include
syntax keyword sasKeyword infile informat input keep label length libname link list
syntax keyword sasKeyword %list lostcard merge missing noinput output over page put rename retain
syntax keyword sasKeyword return run %run select set skip stop title until update where while window x

" Misc. subcommands
syntax keyword sasSubcommands value max var position tables missing default list _all_ _infile_
syntax keyword sasSubcommands overprint _page_ cancel when otherwise point nobs color
syntax keyword sasSubcommands icolumn irow keys menu rows group attr blink hi rev_video
syntax keyword sasSubcommands underine autoskip auto persist protect required _cmd_ _msg_

" SAS Macro stuff
syntax keyword sasMacroVars sysbuffr syscmd sysdate sysday sysdevic sysdsn sysenv
syntax keyword sasMacroVars syserr sysindex sysinfo sysjobid syslast sysmenv sysmsg
syntax keyword sasMacroVars sysparm syspbuff sysrc sysscp systime sysver %cms %\* %display
syntax keyword sasMacroVars %do %until %while %end %global %goto %go %if %then %else
syntax keyword sasMacroVars %input %keydef %let %local %macro %mend %put %sysexec
syntax keyword sasMacroVars %tso %window
syntax keyword sasMacroFunctions %bquote %eval %index %length %nrbquote
syntax keyword sasMacroFunctions %nrstr %quote %qscan %qsubstr %qupcase %scan
syntax keyword sasMacroFunctions %str %substr %superq %unquote %upcase
syntax keyword sasMacroFunctions %cmpres %datatyp %left %qcmpres %qleft
syntax keyword sasMacroFunctions %qtrim %trim %verify

" These are SAS System Options + misc. option subcommands
syntax keyword sasOptions options 
syntax keyword sasOptions altlog altprint autoexec batch best bufno bufsize caps cardimage
syntax keyword sasOptions catcache center charcode chinese cleanup comamid compress config
syntax keyword sasOptions date dbcs dbcslang dbcstype dec device dg dmr dms dsnferr echoauto
syntax keyword sasOptions engine errorabend errors euc facom filelocks firstobs fmterr formchar 
syntax keyword sasOptions formdlim forms
syntax keyword sasOptions fsdevice fsimm fullstimer gwindow hitac host hp15 ibm implmac initstmt 
syntax keyword sasOptions invaliddata japanese label korean _last_ linesize lmode lptype log macro 
syntax keyword sasOptions mautosource maps merror missing mlogic mprint mrecall msgcase msglevel 
syntax keyword sasOptions news nocaps nocardimage nocenter nocharcode nocleanup nodate nodbcs nodmr 
syntax keyword sasOptions nodms nodsnferr noechoauto noerrorabend nofmterr nofullstimer nogwindow
syntax keyword sasOptions noimplmac nolabel nomacro nomautosource nomerror nomlogic nomprint
syntax keyword sasOptions nomrecall nonotes nonumber nooplist notes noovp noreplace noserror 
syntax keyword sasOptions nosetinit nosource nosource2 nospool nostdio nostimer nosymbolgen noterminal 
syntax keyword sasOptions noverbose novnferr noworkinit noworkterm noxwait number 
syntax keyword sasOptions obs oplist ovp pageno pagesize
syntax keyword sasOptions parm parmcards pcibm prime print probsig procleave remote replace reuse
syntax keyword sasOptions s= sas sasautos sashelp sasmsg sasuser seq serror setinit siteinfo sjis
syntax keyword sasOptions sortpgm sortsize source source2 spool stdio stimer symbolgen sysin sysleave
syntax keyword sasOptions sysparm sysprint s2 taiwanese tapeclose terminal unknown user verbose 
syntax keyword sasOptions vnferr work workinit workterm yearcutoff xwait

" SAS Data Step Options
syntax keyword sasDataOptions bufno bufsize cntllev compress drop fileclose firstobs in keep label
syntax keyword sasDataOptions obs rename replace reuse type where mem rec disp leave reread rewind

" These are Base SAS procs
syntax keyword sasProcs append calendar catalog chart cimport compare contents copy corr cport
syntax keyword sasProcs datasets format forms freq means options plot pmenu print printto proc
syntax keyword sasProcs rank sort spell sql standard summary tabulate timeplot transpose
syntax keyword sasProcs univariate v5tov6

" These are the Stat procs
syntax keyword sasProcs aceclus anova calis cancorr candisc catmod cluster corresp
syntax keyword sasProcs discrim factor fastclus freq glm lifereg lifetest logistic
syntax keyword sasProcs nested nlin npar1way orthoreg plan princomp prinqual probit
syntax keyword sasProcs reg rsreg score stepdisc transreg tree ttest varclus varcomp

" SAS Functions
syntax keyword sasFunctions abs arcos arsin atan betainv byte ceil cinv collate compound
syntax keyword sasFunctions compress cos cosh css cv daccdb daccdbsl daccsl daccsyd dacctab
syntax keyword sasFunctions date datejul datepart datetime day depdb depdbsl depsl depsyd deptab
syntax keyword sasFunctions dhms dif digamma dim erf erfc exp finv fipname fipnamel fipstate
syntax keyword sasFunctions floor fuzz gaminv gamma hbound hms hour index indexc input int intck
syntax keyword sasFunctions intnx intrr irr juldate kurtosis lag lbound left length lgamma
syntax keyword sasFunctions log log10 log2 max mdy mean min minute mod month mort n netpv
syntax keyword sasFunctions ordinal poisson probbeta probbnml probchi probf probgam probhypr
syntax keyword sasFunctions probit probnegb probnorm probt put qtr ranbin rancau ranexp
syntax keyword sasFunctions rangam range rank rannor ranpoi rantbl rantri ranuni repeat reverse right
syntax keyword sasFunctions round saving scan second sign sin sinh skewness sqrt std stderr
syntax keyword sasFunctions stfips stname stnamel substr sum symget tan tanh time timepart
syntax keyword sasFunctions tinv today translate trigamma trim trunc uniform upcase uss
syntax keyword sasFunctions var verify weekday year yyq zipfips zipname zipnamel zipstate


" SAS file-related keywords
syntax keyword sasFiles		log blksize column col dropover filevar flowover header line _null_
syntax keyword sasFiles		linesize ls linesleft ll lrecl mod n= pagesize ps notitle notitles
syntax keyword sasFiles 	old pad nopad noprint recfm stopover clear printer plotter terminal
syntax keyword sasFiles		dummy source2 s2 delimiter dlm eof eov expandtabs noexpandtabs
syntax keyword sasFiles		firstobs missover obs recfm sharebuffers sharebufs start unbuffered unbuf

" Comments and Strings
syntax region sasComment          start="/\*"  end="\*\/" contains=cTodo
syntax region sasComment2         start="^\*"  end=";" 
syntax match  sasCommentError     "^\*/"
syntax region  sasString            start=+"+  skip=+\\\\\|\\"+  end=+"+  
syntax region  sasString2            start=+'+  skip=+\\\\\|\\"+  end=+'+  

" Special Characters, Comparisons, and Numbers
syntax keyword sasSysmis    "\."	
syntax keyword sasDelim		";"
syntax keyword sasOperators	eq ne gt ge lt le yes no not and or inap if then else
syntax match sasLogic		"&\|"
syntax match sasLogic2		"\^\~\=\>\|\|\<\>\=\<"
syntax match sasInput	"@"
syntax match sasNumber "-\=\<[0-9]\+L\=\>\|\.0[0-9]\+\>"
syntax match sasNumber2 "[A-Z0-9]*\|[A-Z0-9]*[_\.][A-Z0-9]*\|[_\.]*[A-Z]*[0-9]*[\.]\|_[0-9]*[\.]\|:[0-9]*[\.]\|[0-9]_[0-9]" contains=ALLBUT,sasKeyword

" These links take advantage of standard vim color assignments
hi link sasComment Comment
hi link sasComment2 Comment
hi link sasCommentError Error
hi link sasError Error
hi link sasDataOptions Statement
hi link sasFiles Statement
hi link sasFunctions Special
hi link sasInput Number
hi link sasKeyword Statement
hi link sasMacroFunctions Special
hi link sasMacroVars Special
hi link sasNumber Number
hi link sasNumber2 Number
hi link sasOperators String
hi link sasOptions Statement
hi link sasProcs Statement
hi link sasSubcommands Statement

" In keeping with the new vim policy of not forcing color changes on
" users via the syntax files, the following 'suggested' color changes
" have been commented out. You can better use them in your .vimrc or in
" a .mysyntax file. See the vim on-line help for how to set this up.
"hi Comment guifg=PaleGoldenrod
"hi Number guifg=burlywood
"hi sasLogic guifg=LightGoldenrod
"hi sasLogic2 guifg=LightGoldenrod
"hi sasSysmis guifg=LightSkyBlue
"hi sasString guifg=PowderBlue
"hi sasString2 guifg=PowderBlue
"hi Statement guifg=chartreuse
"hi sasSysmis guifg=gold
"hi sasDelim guifg=violet
