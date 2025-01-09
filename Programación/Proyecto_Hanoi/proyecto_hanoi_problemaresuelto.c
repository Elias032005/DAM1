/*CÓDIGO HECHO PORR ELIAS RAFOLS DELGADO*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h> // esta libreria nos sirve para la parte de contar los movimientos.

// Función para inicializar el juego.

int cont = 0; //Esta variable es una variable global, esto quiere decir que la podemos usar/llamar a todos los voids.


// Función para imprimir el estado de las varillas.
void imprimir_varillas(int array_izquierdo[], int array_central[], int array_derecho[]) {
    printf("\nEstado de las varillas:\n");
    // este for e repetira 3 veces que son el num de discos que hay.
    for (int i = 2; i >= 0; i--) {
        printf("    ");
        // Imprimir varilla izquierda
        if (array_izquierdo[i] != 0) {
        	 // hacemos que la posicion i dentro del array lo multiplicamos por 2 y le restamos 1, ese numero sera el numero que printeara el '#'.
        	 // Ej: si la posicion (array[i]) es 3, pues hará 3*2 -1 = 5. Pues printeara 5 '#'.
            for (int j = 0; j < array_izquierdo[i] * 2 - 1; j++) {  
                printf("#");
            }
        } else {
            printf(" | ");
        }
        printf("    ");
        // Imprimir varilla central
        if (array_central[i] != 0) {
        	// hacemos que la posicion i dentro del array lo multiplicamos por 2 y le restamos 1, ese numero sera el numero que printeara el '#'.
        	 // Ej: si la posicion (array[i]) es 3, pues hará 3*2 -1 = 5. Pues printeara 5 '#'.
            for (int j = 0; j < array_central[i] * 2 - 1; j++) {  
                printf("#");
            }
        } else {
            printf(" | ");
        }
        printf("    ");
        // Imprimir varilla derecha
        if (array_derecho[i] != 0) {
        	// hacemos que la posicion i dentro del array lo multiplicamos por 2 y le restamos 1, ese numero sera el numero que printeara el '#'.
        	 // Ej: si la posicion (array[i]) es 3, pues hará 3*2 -1 = 5. Pues printeara 5 '#'.
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

// Función para encontrar el índice del disco más pequeño en una varilla.
int indice_disco_mas_pequeno(int array[]) {
    int menor = 0; // Iniciamos que el num es 0.
    for (int i = 0; i < 3; i++) {
    	//Se repetira 3 veces
        if (array[i] != 0) {
        	// Esto se hara si la posocion del array[i] es diferente de 0.
        	// Si menor es 0 o array[i] meno a la variable menor entonces se le reasignara el valor de array[i] a la variable menor.
            if (menor == 0 || array[i] < menor)  {
                menor = array[i];
            }
        }
    }
    return menor; // retorna la variable menor.
}

// Función para mover un disco
void mover_disco(int *eje_origen, int *eje_destino) {
    int disco_a_mover = 0; // Inicializamos en 0.
    int i = 0, j = 0; // Inicializamos en 0.

    // Encontrar el disco más pequeño en el eje de origen.
    for (int k = 0; k < 3; k++) {
        if (eje_origen[k] != 0) {
        	//Esto se hará si el eje_origen[k] es diferente a 0.
        	//Si disco_a_mover es 0 o eje_origen[k] menor disco_a_mover entonces la variable eje_origen[k] se asigna a disco_a_mover.
            if (disco_a_mover == 0 || eje_origen[k] < disco_a_mover) {
                disco_a_mover = eje_origen[k];
                //Le asignamos que k (que se a usado para la variable eje_origen se le asigne a la variable i).
                i = k;
            }
        }
    }

    // Validar si hay un disco para mover
    if (disco_a_mover == 0) {
        printf("No hay discos en el eje de origen.\n");
        return;
    }

    // Encontrar la primera posición vacía en el eje de destino.
    while (j < 3 && eje_destino[j] != 0) {
        j++;
    }

    // Validar si el movimiento es permitido
    //Si la variabe j es 0 o eje_destino[j - 1] mayor a disco_a_mover esto quiere decir que el verificara si el disco que queremos mover (disco_a_mover) es menor que el disco que ya está en la posición anterior.
    if (j == 0 || eje_destino[j - 1] > disco_a_mover) {
        eje_destino[j] = disco_a_mover; // Mover el disco al destino.
        eje_origen[i] = 0;             // Eliminar el disco del origen.
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
    scanf(" %c", &menu); //Se guardara la opcion que el usuario elija.
    return menu;
}

// Ejecutar operación en función del menú
void operacion(char menu, int array_izquierdo[], int array_central[], int array_derecho[]) {
	
    switch (menu) {
    	//llama al void de mover_disco y la primera variable asignada se guardara como eje_origen y la siguiente variable se guardara en la variable eje_destino.
    	//Cuando el usuario seleccione una opción, se le suamara +1 a la variable cont que anteriormente la definimos como variable global para usar despés.
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
    // Verificar si los discos están en orden correcto (3, 2, 1).
    if (array_derecho[0] == 3 && array_derecho[1] == 2 && array_derecho[2] == 1) {
        return 1;  // El juego está completo.
    }
    return 0;  // El juego no está completo
    //Si el juego esta completo se le retornara 1, mientras no este completo no se le enviara nada.
}

int contar_movimientos() {
	int nota = 10; // Pongo que la nota maxima que puede optar el usuario si no lo hace en el numero minimo de movimientos saca un 9
    int arquitecto_perfecto = pow(2, 3) - 1; // (2^n) -1
   
    // Calcular la diferencia entre el número de movimientos realizados y el ideal
    int diferencia = cont - arquitecto_perfecto;
    
    printf("Numero de movimientos: %d\n", cont);
    
    if (arquitecto_perfecto == cont) {
    	printf("ERES UN ARQUITECTO PERFECTO.\n Has sacado un 10.");
	} else {
		nota -= diferencia;
		 if (nota < 0) {
            nota = 0;  // Aseguramos que la nota no sea negativa
        }
        printf("Has hecho %d movimientos extra. Tu nota es: %d.\n", diferencia, nota);
	} 
}

// Programa principal
int main() {
	int menu_inicial;
    char menu;
    int array_izquierdo[] = {3, 2, 1};
    int array_central[] =   {0, 0, 0};
    int array_derecho[] =   {0, 0, 0};

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
    
    
    printf("\n\n Quieres jugar?\n");
    printf("1. Jugar\n");
    printf("2. Salir\n");
    printf("\n");
    
    scanf("%d", &menu_inicial);
    if (menu_inicial == 1) {
    		system("cls");
	    	do {
		    menu = menu_movimientos();
		    operacion(menu, array_izquierdo, array_central, array_derecho);
		    imprimir_varillas(array_izquierdo, array_central, array_derecho);
		    
		} while (menu != 'x' && !comprobacion_final(array_derecho));
	
		if (comprobacion_final(array_derecho)) {
			system("cls");
	    	printf(" Felicidades! Has completado el juego de las Torres de Hanoi.\n");
	    	contar_movimientos();
		}
	} 	
	else if ((menu_inicial == 2)) {
		printf("Cierra la ventana para poder jugar");
	} else {
		printf("Numero no correspondido");
	}
  	
    return 0;
}
