/* Include the system headers we need */
#include <stdlib.h>
#include <stdio.h>

/* Include our header */
#include "vector.h"

/* Define what our struct is */
struct_vector_t {
	size_t size;
	int *data;
};

/* Create a new vector */
vector_t *vector_new() {
	vector_t *retval;  

	/* First, we need to allocate the memory for the struct */
	retval = (vector_t *)malloc(1 * sizeof(vector_t));

	/* Check our return value to make sure we got memory */
	if(retval == NULL)
		return NULL;

	/* Why does the above statement cast the malloc's return value to 'vector_t *'
	 * instead of 'struct _vector_t *'?  Does it matter?  
	
	because we are sending it to a value that uses vector_t * we must use vector_t* instead of struct_vector_t* also struct_vector_t isnt the type, it is a structure of type vector_t.

 	*/
	 
	/* Now we need to initialize our data */
	retval->size = 1;
	retval->data = (int *)malloc(retval->size * sizeof(int));

	/* Check our return value to make sure we got memory */
	if(retval->data == NULL) {
		free(retval);
		return NULL;
	}

	retval->data[0] = 0;

	/* Note that 'retval->size' could be written '(*retval).size', but the ->
	 * convention is easier to read
	 */
	
	/* and return... */
	return retval;
}

/* Free up the memory allocated for the passed vector */
void vector_delete(vector_t *v) {
	/* Remember, you need to free up ALL the memory that is allocated */
	free(v->data);
	free(v);




	/* ADD CODE HERE */




}

/* Return the value in the vector */
int vector_get(vector_t *v, size_t loc) {

	/* If we are passed a NULL pointer for our vector, complain about it and
	 * return 0.
	 */
	if(v == NULL) {
		fprintf(stderr, "vector_get: passed a NULL vector.  Returning 0.\n");
		return 0;
	}

	/* If the requested location is higher than we have allocated, return 0.
	 * Otherwise, return what is in the passed location.
	 */
	if(loc < v->size) {
		return v->data[loc];
	} else {
		return 0;
	}
}

/* Set a value in the vector */
void vector_set(vector_t *v, size_t loc, int value) {
	/* What do you need to do if the location is greater than the size we have
	 * allocated?  Remember that unset locations should contain a value of 0.
	 */

if (loc > ((v->size)-1))
{
int* neo_vector_loc;
int i;
// must create a new pointer to new place with enough space to fit this
neo_vector_loc = (int*)malloc((loc)*sizeof(int) );
//must zero the malloced space...
for (i=0; i<loc-1;i++)
{
neo_vector_loc[i] = 0;
}
//must transfer over old data remembering that vectors start at 0 it will go till size-1
for(i=0;i< v->size -1; i++)
{
neo_vector_loc[i]=v[i];
}
//set value you wanted it is at loc - 1 cause vectors start at 0
neo_vector_loc[loc-1]=value;
v->size = loc;
//must free the previous vector
free (v-> data);
v->data = neo_vector_loc;
}

//need to make a new array, make new array big enough for spot, transfer data, store new data.


else 
{
(v->data)[loc] = value;
}
	/* ADD CODE HERE */




}
