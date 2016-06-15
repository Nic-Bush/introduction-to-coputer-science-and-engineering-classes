#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(void) {
  char hello[] = "hello ", world[] = "world!\n", *s;\
int len1 = strlen(hello);
int len2 = strlen(world);
s = (char*)malloc(sizeof(char)*(len1 + len2 + 1));
 strcat(s,hello);
 strcat(s,world);
s[len1+len2]='0';
 printf("%s",s);
return 0;
}
