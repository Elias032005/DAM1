
#include <stdio.h>
#include <stdlib.h>

/*
	Autor: Willoom
	Fecha: 9 de diciembre de 2024
	Descripción:

		Al jugador se le imprime por pantalla una representación ASCII
		de los ejes tal como
  #     |     |
 ###    |     |
#####   |     |

		En el juego, el jugador ha de pasar un disco por turno a otro eje.

		Existen restricciones: 

			- no podemos poner un disco de diámetro superior sobre otro de 
			diámetro inferior, 

			- no podemos mover un disco desde un eje sin discos,

			- sólo podemos mover un disco a la primera posición inferior libre
			del eje destino. 
 
*/


/*

FUNCIÓN: hanoi_ui_3discos

PARÁMETROS: int * posicion_discos
			Este puntero al primer entero de un array de tres registra las posiciones de los discos
			en cada eje.

			Por tanto sus valores válidos serán:
			-> 1 eje izquierdo
			-> 2 eje central
			-> 3 eje derecho

			Si los valores del array son 3, 2, 1 el resultado esperado a visualizar por pantalla sería:

  |     |     |
  |     |     |
#####  ###    #	 

*/


void hanoi_ui_3discos() {
	/*
		Significado de [3][1][3]
		He usado un array multidimensional para este ejercicio. Esto quiere decir que el array podra optar en tener diferentes valores en tres dimensiones diferentes, donde la 'Z' (el primer 3) indica
		en qué fila está. Puede elegir en tres posiciones: Izquierda, Centro, Derecha. (del 0 al 2).
		El  '[1]' se refiere a la COLUMNA en total, que es el array completo. Solo puede optar a 1 opción (que es 0).
		La 'X' (el segundo 3), da referencia a las posibles opciones dentro de cada fila  (del 0 al 2).
		
		Para que dibuje los diferentes tipos de discos.He decidido hacer un if y un else principal donde el principal motivo es mirar si la posición que está mirando el for hay un '0' dibujara una '|'
		que significara que en está posición no hay ningun disco.
		Si cuando recora el array, hay un número, dependiendo el número se dibujaran tantos '#'.
		Para el número 3, le he dicho que dibuje 5 '#'
		Para el número 2, le he dicho que dibuje 3 '#'
		Para el número 1, le he dicho que dibuje 1 '#'
		
		Cuando este a punto de salir del bulce for, haga un salto de línea.
	*/

    int juego[3][1][3] = {
        {{0, 0, 0}}, /* Primera fila */ 
        {{0, 0, 0}}, /* Segunda fila */
        {{3, 2, 1}}  /* Tercera fila, esta sí imprimirá los '#' */
       
    };
    
    for (int z = 0; z < 3; z++) {
        for (int x = 0; x < 3; x++) {
            if (juego[z][0][x] == 0) {                  												
                printf("   |  ");						 /*<-- juego[z]: Indica en qué fila está (de 0 a 2)   */	
            } else {									 /*<-- juego[0]: Indica que cada fila solo tiene una "COLUMNA" (representa que todo el array esta en la misma columna)   */
                if (juego[z][0][x] == 3) {				/*<-- juego[x]: Accede a los valores dentro de la única columna de cada fila (de 0 a 2)    */
                    printf(" ##### ");
                } else if (juego[z][0][x] == 2) {
                    printf(" ### ");
                } else if (juego[z][0][x] == 1) {
                    printf("   #  ");
                }
            }
        }
        printf("\n");
    }
}
	

/*

FUNCIÓN: hanoi_ui_ndiscos

PARÁMETROS: int * posicion_discos
			Este puntero al primer entero de un array de n discos y registra las posiciones de estos discos
			en cada eje.

			Por tanto sus valores válidos serán:
			-> 1 eje izquierdo
			-> 2 eje central
			-> 3 eje derecho

			Si num_discos es cuatro y los valores del array son 3, 2, 1, 1 
			el resultado esperado a visualizar por pantalla sería:

   |       |       |
 #####     |       |
#######   ###      #    


*/

void hanoi_ui_ndiscos() {
	   	 int juego[3][1][3] = {
//Definimos el array juego, esto sera el problema de hanoi
        {{0, 0, 0}}, // Primera fila  
        {{2, 0, 0}}, // Segunda fila 
        {{1, 3, 4}}  // Tercera fila
    };

	
	/*La mecánica es la misma que en el ejercicio anterior. la 'Z' indica en que fila estáel '0'* indica que solamente tiene una 'COLUMNA' y la 'X' indica el valor concreto dentro del array*/
	/*Como solamente tenemos que poner 4 discos, en el array de juego he seguido un cierto orden. El disco '1' será el disco mas grande; eso quiere decir que tendra el mayor num de '#'.
	  Cuando en el array este asignado el valor '0' no dibujara una '|' que representara que en esa posición no hay ningun disco.
	  Cuado recorre el for de 'Z', cuando acabe el else if de 'juego[z][0][x] == 4' hará un salto de línea para que quede todo quede ordenado.
	  Para que también quede todo ordenado, en 'juego[z][0][x] == 1' asigno el tamaño máximo que puede ocupar un disco; cuando no haya ningun disco, he puesto el número de espacios que
	  número de '#' tiene para que quede todo ordenado.
	*/
		for (int z = 0; z < 3; z++) {
		    for (int x = 0; x < 3; x++) {
		        if (juego[z][0][x] == 0) {
		            printf("   |   ");
		        } else {
		        	if (juego[z][0][x] == 1) {
		        		printf("#######");
					}
					else if (juego[z][0][x] == 2) {
		        		printf(" ##### ");
					}
					else if (juego[z][0][x] == 3) {
		        		printf("  ### ");
					}
					else if (juego[z][0][x] == 4) {
		        		printf("    #  ");
					}
		           
		    }
		}
		printf("\n");
	}
}


int main(int argc, char *argv[]) {

	// Durante la evaluación podré cambiar estos valores.
  int juego[3][1][3] = {
        {{0, 0, 0}}, /* Primera fila */ 
        {{0, 0, 0}}, /* Segunda fila */
        {{3, 2, 1}}  /* Tercera fila, esta sí imprimirá los '#' */
    };
     int posicion_discos[4] = {3,2,1,1};
     int num_discos = 4;
     
     
	printf("Ejemplo de hanoi_ui_3discos\n");
	int posiciones[] = {3,2,1};
	hanoi_ui_3discos(posiciones);


	printf("\nEjemplo de hanoi_ui_ndiscos\n");
	int n_posiciones[] = {3,2,1,1,1};
	hanoi_ui_ndiscos();
	
	return 0;

}
