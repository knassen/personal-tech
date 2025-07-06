" Vim syntax file
" Language:	ICPSR cbenter/cbgen codebook files (.cbg)
" Maintainer:	Kent Nassen (knassen@umich.edu)
" Last change:	1998 April 29

" Remove any old syntax stuff hanging around
syntax clear

syntax keyword cbgKeyword  NA INAP DK OTHERS GO TO THOSE WITH CODE CODES WHO DO OR DID PAID WORK SELF EMPLOYED IF NOT CURRENTLY DOING NEVER ANY WERE SHOW CARD ONE ON ANSWER ONLY MULTIPLE ANSWERS POSSIBLE NON ACTIVE RESPONDENT IS CONTRIBUTING MOST FAMILY INCOME STILL STUDYING THE HOUSEHOLD SAY YEARS CONTACT UNDER OVER NO QUESTION SPLIT BALLOT PROMPT HESITATES ASK TRY AGAIN LESS MORE READ OUT ALL OUR YOUR COUNTRY EC UE EU MAXIMUM MINIMUM SPONTANEOUS YES NO IN ANSWERED TRUE FALSE FOR SEVERAL AT OLD ADD INSERT CORRECT DATE TIME ROTATING ORDER SAME AS FAST SLOW POSSIBLE STANDING FIRST SECOND THIRD FOURTH FIFTH FROM REPEAT AND WRITE CLOSE INTERVIEW NATIONALITY USE 24 HOUR CLOCK NATIONAL QUESTIONS MEDIA ESOMAR NUTS 

"syntax case ignore

syntax match cVrecord "^\/V *[0-9]*$"
syntax match cCrecord "^\/C[ (0-9)]* *[0-9]*[ \.]"
syntax match cQrecord /^\/Q/
"syntax match cKrecord "^\/K[(][0-9]*[)]." 
syntax match cSrecord "^\/S"
syntax match cXrecord "^\/X"
syntax match cInap    /<INAP/s-1
syntax match cDK	/ DK/s-1e+1
syntax match cNA	/ NA/s+1e+1
"syntax match cbgNumber "-\=\<[0-9]\+L\=\>\|\.0[0-9]\+\>"
syntax match cbgNumber "[A-Z]*[_\.][A-Z0-9]*\|[_\.]*[A-Z]*[0-9]*[\.]\|_[0-9]*[\.]\|:[0-9]*[\.]\|[0-9]_[0-9]" contains ALLBUT cbgKeyword
syntax match cbgFix	'V[0-9][0-9]*\|\"Yes"\|\"No\"\|"[sS]till [sS]tudying"\|"Employed"\|"Self-employed"\|not coded\|nor \|Actual number is coded\|coded'
syntax match cbgSpecialCharacter1 ">"
syntax match cbgSpecialCharacter2 "<"

syntax region cbgVarName start="^\/V" skip="^\/" end="" contains cVrecord
syntax region cbgCrecord start="^\/C[(][ 0-9][)] *[0-9]*\-[0-9]*\." skip="[^\/]" end="[\.]" contains ALL
syntax region cbgQrecord start="^\/Q" end=" " contains ALL
syntax region cbgKrecord start="^\/K" end=" " contains ALL
syntax region cbgSrecord start="^\/S" end=" " contains  ALL
syntax region cbgXrecord start="^\/X" end=" "  contains ALL
"syntax region cbgInap start="<INAP" skip="[^\/][^$]" end="[^\/][^$]" contains ALL
syntax region cbgDK start="<DK" skip="[^\/][^$]" end="[^\/][^$]" contains ALL
syntax region cbgNA start="<NA" skip="[^\/][^$]" end="[^\/][^$]" contains ALL
"syntax region cbgICPSR start="<" skip="[^\/][^$]" end="[^\/>^$]" contains ALLBUT cbgInap cbgNA cbgDK

" Error: Miscellaneous garbage like ???  (\?* really slows down the editor! Don't use it!)
syntax match addMiscErr                 "\?\?\?"

highlight link cbgKeyword             Statement
highlight cVrecord guifg=HotPink
highlight link cCrecord Character
highlight link cQrecord Number
highlight link cKrecord String
highlight link cbgKrecord String
highlight link cSrecord Include
highlight link cXrecord Comment
highlight link cbgNumber Number

" The following have been commented out so as not to force any
" unwanted color changes on the user.
"highlight cInap guifg=cyan
"highlight cDK guifg=cyan
"highlight cNA guifg=cyan
"highlight cbgICPSR guifg=cyan
"highlight cVrecord guifg=Red guibg=DarkSlateGrey
"highlight cbgFix guifg=Red guibg=DarkSlateGrey
"highlight cbgSpecialCharacter1 guifg=green guibg=DarkSlateGrey
"highlight cbgSpecialCharacter2 guifg=green guibg=DarkSlateGrey
"highlight cCrecord guifg=yellow
"highlight cQrecord guifg=green
"highlight cKrecord guifg=LightSkyBlue
"highlight cbgKrecord guifg=LightSkyBlue
"highlight cSrecord guifg=blue	
"highlight cXrecord guifg=plum
"highlight link addMiscErr Error
