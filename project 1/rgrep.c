#include <stdio.h>
#include <stdlib.h>

#define MAXLINE 256

char *progn;

void usage(void)
{
  fprintf(stderr,"Usage: %s pattern\n",progn);
}

int pattern_match(char *pattern, char *str)
{
int x = 0;
int y = 0;
int z = 0;
while(pattern[y]!='\0')
{
z++;
y++;
}
y=0;
while (pattern[y]!='\0')//pre reads the pattern to find all ? and make them run seperately
{
	if (pattern[y]=='?')//if it finds a ?
		{
		char* pattern1;
		pattern1=(char*)malloc((z+1)*sizeof(char));//create a new pattern
		for (z = 0; pattern[z]!='\0';z++) //copy pattern to 1
			{
			pattern1[z]=pattern[z];
			}
			pattern1[z]='\0';//put a zero in cause i found this easier than fixing the loop
		z=y;//set z to where the ? is
		while(pattern1[z-1]!='\0') //while what we are replacing is not null
			{
			pattern1[z-1]=pattern1[z];//shift everything left deleting letter before ?
			z++;
			}
		z=y;//do this again
		while(pattern1[z-1]!='\0')//same thing but to replace the ? this time
			{
			pattern1[z-1]=pattern1[z];
			z++;
			}
		if(pattern_match(pattern1,str)==1)
		{
		free(pattern1);
		return 1;
		}
		free(pattern1);
		x = y;
		while (pattern[x]!='\0')
			{
			pattern[x]=pattern[x+1];
			x++;
			}
		}
y++;
}
for(x=0; str[x]!='\0';x++)
{
	y=0;//reset pattern to start after fail
	while (pattern[y] != '\0')//while not at end of pattern
		{
		//3 cases, if \, if . and if ?
		if (pattern[y]=='\\')//next element is backslash
			{
			y++;//move pos forward 1
			if((pattern[y] != str[x])&& (pattern[y] != '.'))//if we dont have a free character and the characters entered are not equal
				{
				break;
				}
			}
		else if((pattern[y] != str[x])&& (pattern[y]!= '.') )//if no backslash will not increment but still check against conditions
			{
			break;
			}
//regularly increment
			x++;
			y++;

		}
if(pattern[y]=='\0')//if we get to the end of the pattern
	{
	return 1;//return true
	}
} // implement me
//returns 1 to print
}

int main(int argc, char **argv)
{
  char line[MAXLINE];
  char *pattern;
  progn = argv[0];
  
  if(argc!=2) {
    usage();
    return EXIT_FAILURE;
  }
  pattern = argv[1];
  
  while(!feof(stdin) && !ferror(stdin)) {
    if(!fgets(line,sizeof(line),stdin)) {
      break;
    }
    if(pattern_match(pattern,line)) {
      printf("%s",line);
    }
  }
  if(ferror(stdin)) {
    perror(progn);
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}
