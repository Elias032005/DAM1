
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
		Significado de juego[3][3]
		He usado un array bidimendional para este ejercicio. 
	
		Para que dibuje los diferentes tipos de discos.He decidido hacer un if y un else principal donde el principal motivo es mirar si la posición que está mirando el for hay un '0' dibujara una '|'
		que significara que en está posición no hay ningun disco.
		Si cuando recora el array, hay un número, dependiendo el número se dibujaran tantos '#'.
		Para el número 3, le he dicho que dibuje 5 '#'
		Para el número 2, le he dicho que dibuje 3 '#'
		Para el número 1, le he dicho que dibuje 1 '#'
		
		Cuando este a punto de salir del bulce for, haga un salto de línea.
	*/

    int juego[3][3] = {
        {0, 0, 0}, /* Primera fila */ 
        {0, 0, 0}, /* Segunda fila */
        {3, 2, 1}  /* Tercera fila, esta sí imprimirá los '#' */
       
    };

    for (int z = 0; z < 3; z++) {
        for (int x = 0; x < 3; x++) {
            if (juego[z][x] == 0) {                  												
                printf("   |  ");						
            } else {									 
                if (juego[z][x] == 3) {				
                    printf(" ##### ");
                } else if (juego[z][x] == 2) {
                    printf(" ### ");
                } else if (juego[z][x] == 1) {
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

void hanoi_ui_ndiscos(int num_discos, int* posicion_discos) {
    // Inicializar el array juego (3x3)
    int juego[3][3] = {
        {0, 0, 0},
        {0, 0, 0},
        {0, 0, 0}
    };

    // Distribuir los discos en las tres columnas comenzando desde la fila inferior
    int disco_actual = 1; // Contador de discos
    int ancho_maximo = 7; // El primer disco tiene el máximo ancho (7 '#')

    for (int i = 2; disco_actual <= num_discos; i--) {  // Comienza en la fila inferior
        for (int j = 0; j < 3 && disco_actual <= num_discos; j++) { // Recorremos las tres columnas
            juego[i][j] = disco_actual; // Colocar el disco
            disco_actual++; // Avanzar al siguiente disco
        }
    }

    // Imprimir el array como una representación visual
    for (int i = 0; i < 3; i++) { // Recorremos las filas
        for (int j = 0; j < 3; j++) { // Recorremos las columnas
            if (juego[i][j] == 0) {
                // Si no hay disco, imprimir '|' para indicar la columna vacía
                printf("   |   ");
            } else {
                // Si hay disco, calcular el tamaño del disco
                int disco = juego[i][j];
                
                // El tamaño de cada disco depende de su número. El primer disco tiene el máximo tamaño (7), 
                // y los siguientes discos disminuyen en tamaño de dos en dos (7, 5, 3, 1, ...)
                int ancho = ancho_maximo - (disco - 1) * 2;

                // Calcular los espacios para centrar el disco en la columna (7 caracteres de ancho por columna)
                int espacios_izq = (7 - ancho) / 2;

                // Imprimir los espacios a la izquierda
                for (int k = 0; k < espacios_izq; k++) {
                    printf(" "); // Espacios antes del disco
                }

                // Imprimir el disco con '#'
                for (int k = 0; k < ancho; k++) {
                    printf("#");
                }

                // Imprimir los espacios a la derecha
                for (int k = 0; k < espacios_izq; k++) {
                    printf(" ");
                }
            }

            // Separar las columnas
            printf(" ");
        }
        // Nueva línea para la siguiente fila
        printf("\n");
    }
}



int main(int argc, char *argv[]) {

	// Durante la evaluación podré cambiar estos valores.

     int posicion_discos[4] = {3,2,1,1};
     int num_discos = 4;
     
     
	printf("Ejemplo de hanoi_ui_3discos\n");
	int posiciones[] = {3,2,1};
	hanoi_ui_3discos(posiciones);


	printf("\nEjemplo de hanoi_ui_ndiscos\n");
	int n_posiciones[] = {3,2,1,1,1};
	hanoi_ui_ndiscos(5, n_posiciones);
	
	return 0;

}

