Return-Path: owner-aurora-editor@sfu.ca
Return-Path: <owner-aurora-editor@sfu.ca>
Received: from rm-rstar.sfu.ca by icpsr.umich.edu (8.8.8/2.2)
	with ESMTP id XAA25858; Mon, 24 Nov 1997 23:57:48 -0500 (EST)
Received: from dfw-ix2.ix.netcom.com (dfw-ix2.ix.netcom.com [206.214.98.2]) by rm-rstar.sfu.ca (8.8.7/SFU-3.0H) with ESMTP
  id UAA21887 for <aurora-editor@sfu.ca> (from jawilson@ix.netcom.com); Mon, 24 Nov 1997 20:26:01 -0800 (PST)
Received: (from smap@localhost)
          by dfw-ix2.ix.netcom.com (8.8.4/8.8.4)
	  id WAA15150 for <aurora-editor@sfu.ca>; Mon, 24 Nov 1997 22:25:45 -0600 (CST)
Received: from mor-nj3-16.ix.netcom.com(205.184.197.112) by dfw-ix2.ix.netcom.com via smap (V1.3)
	id rma015109; Mon Nov 24 22:24:49 1997
Message-Id: <3.0.1.16.19971124232319.3c7f572e@popd.ix.netcom.com>
X-Sender: jawilson@popd.ix.netcom.com
X-Mailer: Windows Eudora Light Version 3.0.1 (16)
Date: Mon, 24 Nov 1997 23:23:19
To: aurora-editor@sfu.ca
From: Jim Wilson <jawilson@ix.netcom.com>
Subject: LSTFILES Macro
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I've made another change to the LSTFILES macro. This version allows you to
narrow down the list of displayed files to selections you pick. You can
base your search criteria on patterns that appear in the files name and/or
the path.

Let me know if you have a problem with it.

Jim Wilson


/* ------------------------------------------------------------------ */
/* Macro:        LSTFILES.AML                                         */
/* Written by:   Jim Wilson                                           */
/*                                                                    */
/* Description:  Macro used to display a list of files being edited   */
/*               WITHOUT displaying the path before the file name.    */
/*               This makes jumping from one file to the next a       */
/*               matter of typing the first letter(s) of the actual   */
/*               file name, unlike the original Aurora 'filelist'     */
/*               function where the path name prevents you from doing */
/*               that.                                                */
/*                                                                    */
/* Version:      1.0 -- 8/97                                          */
/*               -----------                                          */
/*               Initial version.                                     */
/*                                                                    */
/*                                                                    */
/*               2.0 -- 10/97                                         */
/*               ------------                                         */
/*               Combined the original LSTFILE1 and LSTFILE2 into a   */
/*               a single program called LSTFILES.                    */
/*                                                                    */
/*               Modified the window title to show the total number   */
/*               of files being edited.                               */
/*                                                                    */
/*               Added a function that adjusts the window size if a   */
/*               lot of files are to be displayed in the popup.       */
/*                                                                    */
/*               Added the 'f' argument (full) to display the path    */
/*               as well as the file name.                            */
/*                                                                    */
/*               Added the 'n' argument (numbers) to display a number */
/*               before each file so you can use that to jump from    */
/*               one file to the next.                                */
/*                                                                    */
/*                                                                    */
/*               2.0a -- 10/97                                        */
/*               -------------                                        */
/*               Displays an asterick at the end of any file name     */
/*               that has been modified.                              */
/*                                                                    */
/*                                                                    */
/*               2.1 -- 11/97                                         */
/*               ------------                                         */
/*               Changed the 'f' argument to 'w' (Wide display) to    */
/*               avoid conflicts with the new definiton of the 'f'    */
/*               argument.                                            */
/*                                                                    */
/*               Added the 'f' argument (File name) so you can use a  */
/*               character pattern to narrow down the displayed       */
/*               files to only those that match your search pattern   */
/*               in the files name.                                   */
/*                                                                    */
/*               Added the 'd' argument (Dir name) so you can use a   */
/*               character pattern to narrow down the displayed       */
/*               files to only those that match your search pattern   */
/*               in the files path.                                   */
/*                                                                    */
/*               You can use both the 'f' and 'd' options together    */
/*               to search for matches in the files name AND dir.     */
/*               When used this way you will get two dialog boxes,    */
/*               one for the name and another for the directory.      */
/*                                                                    */
/*               Note that DOS wildcards are not supported -- the     */
/*               search is for character patterns only.               */
/*                                                                    */
/* ------------------------------------------------------------------ */

include bootpath "define.aml"


var FileName, Path, WideDisplay, ShowNumbers, NumOfSpaces

Spaces       =3D "              "                       // used to pad=
 output
Options      =3D arg 2                                  // grab any args=
 passed
PadWidth     =3D 14                                     // space for file=
 name
BufferName   =3D "LstFiles"                             // buffer name
TotalMatched =3D 0                                      // total files being
edited
CurrentFile  =3D getcurrbuf                             // save current file
number


function SaveName                                     // save selected name
to array
  TotalMatched =3D TotalMatched + 1                     // add one to counte=
r
for # of files

  if? WideDisplay                                     // setup filename for
displaying
      (databuf BufferName ((if? ShowNumbers TotalMatched:2 '') + ' ' +
FileName + Spaces[1..NumOfSpaces] + (if? (bufchanged? CurrentFile) '* ' '
') + Path    ) end)
      (databuf BufferName ((if? ShowNumbers TotalMatched:2 '') + ' ' +
FileName + (if? (bufchanged? CurrentFile) ' *' '  ')) end)
endfunction


if? (pos 'w' Options 'i') (WideDisplay =3D TRUE) (WideDisplay =3D FALSE)   /=
/
setup for display window type
if? (pos 'n' Options 'i') (ShowNumbers =3D TRUE) (ShowNumbers =3D FALSE)   /=
/
setup for display of numbers

if (pos 'f' Options 'i') then                         // for file name
matching
   FileSpec =3D ask 'Enter character pattern' "_LstFileNames" '' 'File Name
Pattern Match' 'd' 40
   if? not FileSpec (return)                          // if <esc> hit then
bail out
   if? FileSpec =3D=3D ' ' (FileSpec =3D '')                // if <enter> hi=
t
then default to all files
   if? FileSpec (addhistory "_LstFileNames" FileSpec) // if something was
typed add it to history
endif

if (pos 'd' Options 'i') then                         // for dir name=
 matching
   DirSpec =3D ask 'Enter character pattern' "_LstFileNames" '' 'Directory
Name Pattern Match' 'd' 40
   if? not DirSpec (return)                           // if <esc> hit then
bail out
   if? DirSpec =3D=3D ' ' (DirSpec =3D '')                  // if <enter> hi=
t
then default to all files
   if? DirSpec (addhistory "_LstFileNames" DirSpec)   // if something was
typed add it to history
endif


while CurrentFile do
  FileName    =3D upcase (getname (getbufname CurrentFile))  // grab just th=
e
file name
  Path        =3D upcase (getpath (getbufname CurrentFile))  // grab just th=
e
path name
  NumOfSpaces =3D PadWidth - length (FileName)          // calculate number
of spaces to pad display

  if FileName then                                    // if a valid file
name was found
     if? (not FileSpec and not DirSpec) (SaveName)    // no other arguments
     if? (DirSpec and not FileSpec and (pos DirSpec Path 'i')) (SaveName)
// 'p' argument
     if? (FileSpec and not DirSpec and (pos FileSpec FileName 'i'))
(SaveName)   // 'f' argument
     if? (FileSpec and DirSpec and (pos FileSpec FileName 'i') and (pos
DirSpec Path 'i')) (SaveName)   // 'f' and 'p' arguments
  endif

  CurrentFile =3D getprevbuf CurrentFile                // get next file=
 name
endwhile


if TotalMatched =3D=3D 0 then                             // if nothing was=
 found
   msgbox 'No matches found for "' + (if? FileSpec FileSpec) + (if? DirSpec
(if? FileSpec '" and "') + DirSpec) + '"' 'Error' 'b'
   return
endif


Selected =3D popup BufferName                           // setup title and
window size
           (if? WideDisplay ('File Name =C4=C4=C4=C4 Directory Name
=C4=C4=C4=C4=C4=C4=C4=C4=C4=C4=C4=C4=C4=C4=C4=C4=C4 Files: ') ('Files: ')) +=
 TotalMatched
           (if? WideDisplay (60) (15))                // popup window width
           (if? TotalMatched > (getvidrows)-8 (getvidrows)-8)  // popup
window height
destroybuf BufferName                                 // remove temp buffer


if Selected then                                      // TRUE if a file was
chosen
   CurrentFile =3D getcurrbuf                           // grab current file
again

   case ShowNumbers                                   // find 1st char in
file name
     when TRUE  FirstChar =3D (pos '[0-9] ' Selected 'x') + 2
     when FALSE FirstChar =3D (pos '^ .' Selected 'ix') + 1
   endcase

   case WideDisplay                                   // find last char in
file name
     when TRUE  LastChar =3D (pos '   ' Selected) - 1
     when FALSE LastChar =3D (length Selected) - 2
   endcase

   while CurrentFile do
     FileName =3D upcase (getname (getbufname CurrentFile))  // get a file=
 name

     if FileName =3D=3D Selected [FirstChar..LastChar] then    // if it matc=
hes
selected file..
        open (getbufname CurrentFile)                      // ..jump to it
     endif

     CurrentFile =3D getprevbuf CurrentFile             // ..else get next
file name
   endwhile
endif


Regards,
Jim Wilson

