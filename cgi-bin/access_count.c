/************************************************************************/
/*	Copyright 1994 by Chuck Musciano and Harris Corporation 	*/
/*									*/
/*	Full ownership of this software, and all rights pertaining to 	*/
/*	the for-profit distribution of this software, are retained by 	*/
/*	Chuck Musciano and Harris Corporation.  You are permitted to 	*/
/*	use this software without fee.  This software is provided "as 	*/
/*	is" without express or implied warranty.  You may redistribute 	*/
/*	this software, provided that this copyright notice is retained,	*/
/*	and that the software is not distributed for profit.  If you 	*/
/*	wish to use this software in a profit-making venture, you must 	*/
/*	first license this code and its underlying technology from 	*/
/*	Harris Corporation. 						*/
/*									*/
/*	Bottom line: you can have this software, you can use it, you 	*/
/*	can give it away.  You just can't sell any or all parts of it 	*/
/*	without prior permission from Harris Corporation. 		*/
/************************************************************************/

/************************************************************************/
/*									*/
/*	access_count.c	update and print HTML document access counts	*/
/*									*/
/************************************************************************/

#include	<unistd.h>
#include	<stdlib.h>
#include	<string.h>
#include	<stdio.h>

/************************************************************************/
/* Make sure these values are want you need for your system.		*/
/************************************************************************/

/************************************************************************/
/* Set COUNTS to the pathname of the file containing the document	*/
/* counts.  I put it in a file named ".counts" in my server document	*/
/* directory.  Put it anywhere you want; just make sure it is world-	*/
/* writable.								*/
/* #define		COUNTS		"/usr/local/http/docs/.counts" */
/*#define		COUNTS		"/afs/umich.edu/user/k/n/knassen/Public/html/.counts" */
#define		COUNTS		".counts"

/************************************************************************/
/* I have a policy that *my* accesses to my server aren't counted.	*/
/* (This seems fairer, don't you think?)  Set IGNORED_HOST to your	*/
/* machine's name *as it is presented to your server when you fetch a	*/
/* document*.  In my case, that is the unqualified hostname "melmac".	*/
/* That is probably the case with your machine, too, but it may not be.	*/
/* If you notice that the counts are incrementing each time you view a	*/
/* page, you got this name wrong.					*/
/*									*/
/* If you want to count your accesses, too, just define this to be "".	*/
/* But don't be bragging about how high your access counts are, either!	*/
/* #define		IGNORED_HOST	"melmac" */
#define		IGNORED_HOST	""

/************************************************************************/
/* It seems a bit quicker to staticly allocate the array of document	*/
/* names and counts.  If you have more than this many documents on your	*/
/* server, change the value accordingly.				*/
#define		MAX_DOCS	1024

/************************************************************************/
/* The code must have exclusive access to the COUNTS file.  If the file	*/
/* is locked when this program tries to gain access, it will sleep 2	*/
/* seconds and then retry this many times.  Making this number smaller	*/
/* means you run the risk of not inserting the access count on heavily	*/
/* loaded servers; making it larger make increase the time a client	*/
/* to get the document.  In practice, unless your server is really	*/
/* loaded, you won't get any lock collisions anyway.			*/
#define		RETRIES		5

/************************************************************************/
/* I wrote this code on a System V system (Solaris 2.3, to be exact).	*/
/* If you are running on a System V system, leave the following define	*/
/* alone.  If you are running a BSD system, comment it out to get the	*/
/* correct support for file locking.					*/
#define		SYSV

/************************************************************************/
/* Everything from here on out should be OK :-)				*/
/************************************************************************/

#ifndef	SYSV
#include	<sys/file.h>
#endif

static	int	count[MAX_DOCS];
static	char	*name[MAX_DOCS];

int	main(int argc, char **argv)

{	char	*remote_host, *document, buf[512], buf1[512]; 
	FILE	*f;
	int	i, j, k;
	
	if ((remote_host = getenv("REMOTE_HOST")) == NULL)
	   exit(0);
	
	if ((document = getenv("DOCUMENT_URI")) == NULL)
	   exit(0);
	
	if (f = fopen(COUNTS, "r+")) {
	   for (i = 0; i < RETRIES; i++)
#ifdef	SYSV
	      if (lockf(fileno(f), F_TLOCK, 0) == 0)
#else
	      if (flock(fileno(f), LOCK_EX | LOCK_NB) == 0)
#endif
		 break;
	      else
		 sleep(2);

	   if (i < RETRIES) {
	      for (i = 0; i < MAX_DOCS && fgets(buf, 512, f); i++)
		 if (sscanf(buf, "%d %s", &(count[i]), buf1) == 2)
		    name[i] = strdup(buf1);
	      for (j = 0; j < i; j++)
		 if (strcmp(document, name[j]) == 0)
		    break;
	      if (j >= i) {
		 name[j] = document;
		 count[j] = 0;
		 i++;
	         }
	      if (strcmp(remote_host, IGNORED_HOST) != 0)
		 count[j]++;
	      rewind(f);
	      for (k = 0; k < i; k++)
		 fprintf(f, "%8d %s\n", count[k], name[k]);
	      rewind(f);
#ifdef	SYSV
	      lockf(fileno(f), F_ULOCK, 0);
#else
	      flock(fileno(f), LOCK_UN);
#endif
	      if (count[j] > 999999)
		 printf("%d,%03d,%03d", count[j] / 1000000, (count[j] % 1000000) / 1000, count[j] % 1000);
	      else if (count[j] > 999)
		 printf("%d,%03d", count[j] / 1000, count[j] % 1000);
	      else
		 printf("%d", count[j]);
	      printf(" access%s.", count[j] != 1? "es" : "");
	      }
	   fclose(f);
	   }
	exit(0);
}
