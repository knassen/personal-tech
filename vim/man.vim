" Vim syntax file 
" Language: Unix manual page -man macros (.man, .1, .2, etc.)
" Maintainer:	Kent Nassen (knassen@umich.edu)
" Last change:	1997 December 2

" Remove any old syntax stuff hanging around
syntax clear

" Have mixed in some raw nroff command since many man
" pages include them

syn match manMacroB		"^\.B"
syn match manMacroBI	"^\.BI"
syn match manMacroBR	"^\.BR"
syn match manMacroDT	"^\.DT"
syn match manMacroHP	"^\.HP"
syn match manMacroI		"^\.I"
syn match manMacroIB	"^\.IB"
syn match manMacroIP	"^\.IP"
syn match manMacroIR	"^\.IR"
syn match manMacroIX	"^\.IX"
syn match manMacroLP	"^\.LP"
syn match manMacroP		"^\.P"
syn match manMacroPD	"^\.PD"
syn match manMacroPP	"^\.PP"
syn match manMacroRB	"^\.RB"
syn match manMacroRE	"^\.RE"
syn match manMacroRI	"^\.RI"
syn match manMacroRS	"^\.RS"
syn match manMacroSB	"^\.SB"
syn match manMacroSH	"^\.SH"
syn match manMacroSM	"^\.SM"
syn match manMacroSS	"^\.SS"
syn match manMacroTH	"^\.TH"
syn match manMacroTP	"^\.TP"
syn match manMacroTX	"^\.TX"

syn match manStyleC		"\\fC"
syn match manStyleI		"\\fI"
syn match manStyleB		"\\fB"
syn match manStyleP		"\\fP"
syn match manStyleR		"\\fR"
syn match manStyleReg	"\\\*R"
syn match manStyleSize	"\\\*S"

syn match nroCommandBr	"^\.br"
syn match nroCommandIn	"^\.in"
syn match nroCommandSp	"^\.sp"

hi link manMacroB 				Statement
hi link manMacroBI 				Statement
hi link manMacroBR				Statement
hi link manMacroDT				Statement
hi link manMacroHP				Statement
hi link manMacroI 				Statement
hi link manMacroIB				Statement
hi link manMacroIP				Statement
hi link manMacroIR				Statement
hi link manMacroIX 				Statement
hi link manMacroLP 				Statement
hi link manMacroP 				Statement
hi link manMacroPD 				Statement
hi link manMacroPP 				Statement
hi link manMacroRB 				Statement
hi link manMacroRE 				Statement
hi link manMacroRI 				Statement
hi link manMacroRS 				Statement
hi link manMacroSB 				Statement
hi link manMacroSH 				Statement
hi link manMacroSM 				Statement
hi link manMacroSS 				Statement
hi link manMacroTH 				Statement
hi link manMacroTP 				Statement
hi link manMacroTX 				Statement

hi link nroCommandBr			Character
hi link nroCommandIn			Character
hi link nroCommandSp			Character

hi link manStyleC 				Number
hi link manStyleI 				Number
hi link manStyleB 				Number
hi link manStyleP 				Number
hi link manStyleR 				Number
hi link manStyleReg 			Number
hi link manStyleSize			Number

