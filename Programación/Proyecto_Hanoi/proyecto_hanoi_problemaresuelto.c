
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Función para inicializar el juego

int cont = 0;

void inicio_juego() {

	 
    printf("#######################################################################\n");
    printf("#                                                                     #\n");
    printf("#              Bienvenido al juego de las Torres de Hanoi             #\n");
    printf("#                                                                     #\n"); 
    printf("#######################################################################\n\n\n");
    
    printf("#######################################################################\n");
    printf("#                                                                     #\n");
    printf("#                                                                     #\n");
    printf("#                                                                     #\n");
    printf("#         #                     |                       |             #\n");
    printf("#        ###                    |                       |             #\n");
    printf("#       #####                   |                       |             #\n");
    printf("#                                                                     #\n");
    printf("#                                                                     #\n");
    printf("#                                                                     #\n");
    printf("#######################################################################\n");
}

// Función para imprimir el estado de las varillas

void imprimir_varillas(int array_izquierdo[], int array_central[], int array_derecho[]) {
    printf("\nEstado de las varillas:\n");
    for (int i = 2; i >= 0; i--) {
        printf("    ");
        // Imprimir varilla izquierda
        if (array_izquierdo[i] != 0) {
            for (int j = 0; j < array_izquierdo[i] * 2 - 1; j++) { 
                printf("#");
            }
        } else {
            printf(" | ");
        }
        printf("    ");
        // Imprimir varilla central
        if (array_central[i] != 0) {
            for (int j = 0; j < array_central[i] * 2 - 1; j++) {  
                printf("#");
            }
        } else {
            printf(" | ");
        }
        printf("    ");
        // Imprimir varilla derecha
        if (array_derecho[i] != 0) {
            for (int j = 0; j < array_derecho[i] * 2 - 1; j++) {  
                printf("#");
            }
        } else {
            printf(" | ");
        }
        printf("\n");
    }
    printf("\n");
}

// Función para encontrar el índice del disco más pequeño en una varilla
int indice_disco_mas_pequeno(int array[]) {
    int menor = 0;
    for (int i = 0; i < 3; i++) {
        if (array[i] != 0) {
            if (menor == 0 || array[i] < menor) {
                menor = array[i];
            }
        }
    }
    return menor;
}

// Función para mover un disco
void mover_disco(int *eje_origen, int *eje_destino) {
    int disco_a_mover = 0;
    int i = 0, j = 0;

    // Encontrar el disco más pequeño en el eje de origen
    for (int k = 0; k < 3; k++) {
        if (eje_origen[k] != 0) {
            if (disco_a_mover == 0 || eje_origen[k] < disco_a_mover) {
                disco_a_mover = eje_origen[k];
                i = k;
            }
        }
    }

    // Validar si hay un disco para mover
    if (disco_a_mover == 0) {
        printf("No hay discos en el eje de origen.\n");
        return;
    }

    // Encontrar la primera posición vacía en el eje de destino
    while (j < 3 && eje_destino[j] != 0) {
        j++;
    }

    // Validar si el movimiento es permitido
    if (j == 0 || eje_destino[j - 1] > disco_a_mover) {
        eje_destino[j] = disco_a_mover; // Mover el disco al destino
        eje_origen[i] = 0;             // Eliminar el disco del origen
    } else {
        printf("Movimiento no permitido: no se puede colocar un disco mayor sobre uno menor.\n");
    }
}

// Menú de opciones
char menu_movimientos() {
    char menu;
    printf("\nMenu de opciones\n\n");
    printf("a. Desplaza el disco mas pequeno desde el eje izquierdo al central\n");
    printf("s. Desplaza el disco mas pequeno desde el eje izquierdo al derecho\n");
    printf("d. Desplaza el disco mas pequeno desde el eje central al izquierdo\n");
    printf("f. Desplaza el disco mas pequeno desde el eje central al derecho\n");
    printf("g. Desplaza el disco mas pequeno desde el eje derecho al izquierdo\n");
    printf("h. Desplaza el disco mas pequeno desde el eje derecho al central\n");
    printf("x. Salir del juego\n");
    printf("Selecciona una opcion: ");
    scanf(" %c", &menu);
    return menu;
}

// Ejecutar operación en función del menú
void operacion(char menu, int array_izquierdo[], int array_central[], int array_derecho[]) {
	
    switch (menu) {
        case 'a':
            mover_disco(array_izquierdo, array_central);
            printf("Moviendo el disco mas pequeno del eje izquierdo al central.\n");
            cont += 1;
            break;
        case 's':
            mover_disco(array_izquierdo, array_derecho);
            printf("Moviendo el disco mas pequeno del eje izquierdo al derecho.\n");
            cont += 1;
            break;
        case 'd':
            mover_disco(array_central, array_izquierdo);
            printf("Moviendo el disco mas pequeno del eje central al izquierdo.\n");
            cont += 1;
            break;
        case 'f':
            mover_disco(array_central, array_derecho);
            printf("Moviendo el disco mas pequeno del eje central al derecho.\n");
            cont += 1;
            break;
        case 'g':
            mover_disco(array_derecho, array_izquierdo);
            printf("Moviendo el disco mas pequeno del eje derecho al izquierdo.\n");
            cont += 1;
            break;
        case 'h':
            mover_disco(array_derecho, array_central);
            printf("Moviendo el disco mas pequeno del eje derecho al central.\n");
            cont += 1;
            break;
        case 'x':
            printf("Has salido del juego.\n");
            break;
        default:
            printf("Opcion no valida. Intenta de nuevo.\n");
            break;
    }
}

// Verificar si el juego se ha completado
int comprobacion_final(int array_derecho[]) {
    // Verificar si los discos están en orden correcto (1, 2, 3)
    if (array_derecho[0] == 3 && array_derecho[1] == 2 && array_derecho[2] == 1) {
        return 1;  // El juego está completo
    }
    return 0;  // El juego no está completo
}

int contar_movimientos() {
	int nota = 9; // Pongo que la nota maxima que puede optar el usuario si no lo hace en el numero minimo de movimientos saca un 9
    int arquitecto_perfecto = pow(2, 3) - 1; // (2^n) -1
   
    // Calcular la diferencia entre el número de movimientos realizados y el ideal
    int diferencia = cont - arquitecto_perfecto;
    
    printf("Numero de movimientos: %d\n", cont);
    
    if (arquitecto_perfecto == cont) {
    	printf("ERES UN ARQUITECTO PERFECTO|n Has sacado un 10");
	} else {
		nota -= diferencia;
		 if (nota < 0) {
            nota = 0;  // Aseguramos que la nota no sea negativa
        }
        printf("Has hecho %d movimientos extra. Tu nota es: %d\n", diferencia, nota);
	} 
    
}


// Programa principal
int main() {
    char menu;
    int array_izquierdo[] = {3, 2, 1};
    int array_central[] =   {0, 0, 0};
    int array_derecho[] =   {0, 0, 0};


    inicio_juego();
  	do {
	    menu = menu_movimientos();
	    operacion(menu, array_izquierdo, array_central, array_derecho);
	    imprimir_varillas(array_izquierdo, array_central, array_derecho);
	    
	} while (menu != 'x' && !comprobacion_final(array_derecho));

	if (comprobacion_final(array_derecho)) {
		system("cls");
    	printf(" ¡Felicidades! Has completado el juego de las Torres de Hanoi.\n");
    	contar_movimientos();
	}

    return 0;
}
