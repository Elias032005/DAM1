#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

	void IniciarEstado(int *barras, int *agua, int *uranio, int * xenon, int*vapor, int*temperatura, int *potencia, int *presion, int * menu, int * hora) { 
	 //Empezaran todos los datos/resultados a 0
		*barras = 0;
		*agua = 0;
		*uranio = 0;
		*xenon = 0;
		*vapor = 0;
		*temperatura = 0;
		*potencia = 0;
		*presion = 0;
		*menu = 0;
		*hora = 0;	
	}
	
	void ImprimirEstado(int*barras, int *agua, int *uranio, int *xenon, int *vapor, int *temperatura, int *potencia, int *presion) {
		
	 //Mostrara Los estados de los datos del programa
	 
		printf("Parametros en estado actual: \n");
		printf("Parametros                   Cantidad\n");
		printf("Barras                         %d\n",*barras);
		printf("Agua                           %d\n",*agua);
		printf("Uranio                         %d\n",*uranio);
		printf("Xenon                          %d\n",*xenon);
		printf("Vapor                          %d\n",*vapor);
		printf("Temperatura                    %d\n",*temperatura);
		printf("Potencia                       %d\n",*potencia);
		printf("Presión                       %d\n\n",*presion);
	}
	
	void MostrarMenu(int *menu) {
		
		//Mostrara el menu
		
		printf("Menu\n\n");
		
		printf("Opcion          Titulo\n");
		printf("1.               Sumergir barra\n");
		printf("2.               Elevar barra\n");
		printf("3.               Anade agua\n");
		printf("4.               Anadir uranio\n");
		printf("5.               Simular hora\n");
		printf("6.              Mostrar datos\n");
		printf("0.              Cerrar menu\n");
		printf("Elija una opcion: ");
		scanf("%d", menu);

	}
	
int ExcedeLimites (int * barras, int* agua, int *uranio,int *potencia, int *presion) {
	
	if (*barras < 0 || *barras > 10) {
		return 1;
	}
			
	if (*agua < 0 || *agua > 1000) {
		return 1;
	}	
	if (*uranio < 0 || *uranio > 100) {
		return 1;
	}	
	if (*potencia > 1000){ 
		return 1;
	}
	if (*presion > 100) {
		return 1;
	}	
	
	return 0;
}


int Operacion(int *barras, int *agua, int *uranio, int * hora, int *xenon, int *vapor, int *temperatura, int *potencia, int *presion, int *menu /* int *i, int *array[24][9]*/) {
		int menu2 = 0;
		switch (*menu){
			case 1: 
					*barras = *barras +1; //suma una barra
					break;
			case 2: 
					*barras = *barras -1; //resta una barra
					break;
			case 3:
					*agua = *agua +50;  //suma 50 litros deagua
					break;
			case 4:
					*uranio = *uranio += 5; // suma 5 de uranio
					break;
			case 5:
					*hora = *hora + 1; // Si el usuario elige la opción 5, se simulara una hora
					/**i = *i +1;*/
				 // 1. Se produce un kilo de Xenon por cada cinco kilos de Uranio
				    *xenon += *uranio/5;
					// Genera Xenon a razón de 1 por cada 5 de Uranio
					*uranio -= *uranio / 5;
				    if (*agua >= 1) {
				        *vapor += 2;  // Se genera 2 kilos de vapor por cada 1 de agua
				        *agua -= 1;   // Se consume 1 kilo de agua
				    }
				
				    // 3. Se consumirá un kg de Uranio por cada 10 grados de temperatura
				    *uranio -= *temperatura / 10;  // Se consume Uranio dependiendo de la temperatura
				
				    // 4. La temperatura baja hasta un grado por cada barra de control insertada en el reactor
				    *temperatura -= *barras;  // La temperatura baja en 1 grado por cada barra
				
				    // 5. La temperatura sube un grado por cada diez kilos de Vapor presente en el reactor
				    *temperatura += *vapor / 10;  // La temperatura sube 1 grado por cada 10 kilos de vapor
				
				    // 6. Se perderá hasta un MW de potencia por cada kg de Xenon
				    *potencia -= *xenon;  // Se pierde potencia por cada kilo de Xenon
				
				    // 7. Si la temperatura es inferior a 100 grados se perderán hasta dos kg de Xenon
				    if (*temperatura < 100) {
				        *xenon -= 2;  // Se pierde 2 kilos de Xenon si la temperatura es inferior a 100 grados
				    }
				
				    // 8. Si la temperatura es superior a 100 grados, se perderán hasta cinco kilos de vapor
				    if (*temperatura > 100) {
				        *vapor -= 5;  // Se pierde 5 kilos de vapor si la temperatura es superior a 100 grados
				    }
				
				    // 9. La presión bajará hasta diez pascales cuando la temperatura sea inferior a 100
				    //     y subirá un pascal por cada diez kilos de vapor cuando sea superior.
				    if (*temperatura < 100) {
				        *presion -= 10;  // La presión baja 10 pascales si la temperatura es inferior a 100 grados
				    } else {
				        *presion += *vapor / 10;  // La presión sube 1 pascal por cada 10 kilos de vapor si la temperatura es superior a 100
				    }
				
				    // 10. La potencia se establecerá al resultado de dividir la temperatura entre 10 y multiplicar por el uranio
				    *potencia = (*temperatura / 10) * *uranio;  // La potencia depende de la temperatura y el uranio
								
					
				// Avisos específicos
				// declarar variables de avisos específicos
				int NOBARS = 0, LOWBARS = 0, HIGHBARS = 0;
			    int NOXEPOISON = 0, LOWXEPOISON = 0, MIDXEPOISON = 0, HIGHXEPOISON = 0;
			    int NOSPIKETEMP = 0, SPIKETEMP = 0;
			    int LOWPRES = 0, HIGHPRES = 0, DANGERPRES = 0;
			    int NOPOWER = 0, MIDPOWER = 0, HIGHPOWER = 0, DANGERPOWER = 0;
			    int SAFETURBINE = 0, XEPOISON = 0, ADDWATER = 0, ADDBARS = 0;
			    
				if (*barras == 0) {
					printf("1.  NOBARS\n");
					NOBARS = 1;
				}
				if (*barras >= 1 && *barras <= 5) {
					printf("2.  LOWBARS\n");
					LOWBARS = 1;
				}
				if (*barras >= 6 && *barras <= 10) {
					printf("3.  HIGHBARS\n");
					int HIGHBARS = 1;
				}
				if (*xenon < *uranio ) {
					printf("4.  NOXEPOISON\n");
					int  NOXEPOISON = 1;
				}
				if ( *xenon >= *uranio || *xenon - *uranio <= 50) {
					printf("5.  LOWXEPOISON\n");
					int LOWXEPOISON = 1;
				}
				if ( *xenon > *uranio || *xenon - *uranio >= 50) {
					printf("6.  MIDXEPOISON\n");
					int  MIDXEPOISON = 1;
				}
				if (*xenon > *uranio || *xenon - *uranio >= 100) {
					printf("7.  HIGHXEPOISON\n");
					int  HIGHXEPOISON = 1;	
				}
				if (*temperatura <= 100 || *vapor <= 5) {
					printf("8.  NOSPIKETEMP\n");
					int NOSPIKETEMP = 1;
				}
				if (*temperatura > 100 && *vapor > 5) {
					printf("9.  SPIKETEMP\n");
					int SPIKETEMP = 1;
				}
				if (*presion < 50) {
					printf("10. LOWPRES\n");
					int  LOWPRES = 1;
				}
				if (*presion > 50) {
					printf("11. HIGHPRES\n");
					int HIGHPRES = 1;
				}
				if (*presion >100) {
					printf("12. DANGERPRES\n");
					int DANGERPRES = 1;
				}
				if (*potencia == 0) {
					printf("13. NOPOWER\n");
					int NOPOWER = 1;
				}
				if (*potencia >= 1 && *potencia <= 200) {
					printf("14. MIDPOWER\n");
					int MIDPOWER = 1;
				}
				if (*potencia > 200) {
					printf("15.HIGHPOWER\n");
					int HIGHPOWER = 1;
				}
				if (*potencia > 1000) {
					printf("16. DANGERPOWER");
					int DANGERPOWER = 1;
				}
				
				// Avisos generales
				//Para que funcionen, he creado las variables de cada aviso específoco paraque en los avisos generales no se repita código
				
				if (DANGERPRES != 1 && DANGERPOWER != 1) {
					printf("001. SAFETURBINE\n");	
				}
				if (MIDXEPOISON == 1 || HIGHXEPOISON == 1) {
					printf("002.  XEPOISON\n");
				}
				if (SAFETURBINE == 1 && SPIKETEMP != 1 &&  NOPOWER == 1 || MIDPOWER == 1) {
					printf("003. ADDWATER\n");
				}
				if (SPIKETEMP == 1 && XEPOISON == 1 || SAFETURBINE != 1) {
					printf("004. ADDBARS\n");
				}
				if (SAFETURBINE == 1 && NOPOWER == 1 && MIDPOWER == 1 && SPIKETEMP != 1 && XEPOISON == 1 )  {
					printf("005.  ADDURANIUM\n");
				}
				/*
				//Almacenamiento por hora
				array[*hora][0]= *hora;
				array[*hora][1] = *barras;
				array[*hora][2] = *agua;
				array[*hora][3] = *uranio;
				array[*hora][4] = *xenon;
				array[*hora][5] = *vapor;
				array[*hora][6] = *temperatura;
				array[*hora][7] = *potencia;
				array[*hora][8] = *presion;
			
				for (int i = 0; i <= *hora; i++){
					for (int j = 0; j < 9; j++) {
						printf("%d", array[i][j]);
					}
				}
				*/
				break;
			case 6:
					if (*hora >= 5) {
						printf("Han pasado 5 o mas horas\n");
						printf("\n");
						
						printf("1. Potencia total\n");
						printf("2. Potencia Media\n");
						printf("3. Maximo de Xenon\n");
						printf("4. Temperatura minima\n");
						printf("5. Horas calientes\n");
						printf("6. Horas opticas\n");
						printf("7. Hora pico potencia\n");
						printf("8. Hora seca\n");
						printf("9. Primera hora optica\n");
						printf("10. Balance medio agua uranio\n");
						printf("11. Potencia total segura\n");
						printf("12. Incrementos de presión\n");
						printf("13. Movimientos barras\n");
						printf("14. Hora pesada\n");
						printf("14. Hora economica\n");
						printf("\n");
						scanf("Selecciona una opcion: %d", &menu2);

						switch (menu2) {
								case 1: 
										printf("Opcion1\n");
									break;
								case 2: 
										printf("Opcion2\n");
									break;
								case 3: 
										printf("Opcion3\n");
									break;
								case 4: 
										printf("Opcion4\n");
									break;
								case 5: 
										printf("Opcion5\n");
									break;
								case 6: 
										printf("Opcion6\n");
									break;
								case 7: 
										printf("Opcion7\n");
									break;
								case 8: 
										printf("Opcion8\n");
									break;
								case 9: 
										printf("Opcion9\n");
									break;
								case 10: 
										printf("Opcion10\n");
									break;
								case 11: 
										printf("Opcion11\n");
									break;
								case 12: 
										printf("Opcion12\n");
									break;
								case 13: 
										printf("Opcion13\n");
									break;
								case 14: 
										printf("Opcion14\n");
									break; 		
						}
											
					} 
					else {
						printf("NO han pasado 5 o mas horas\n");
						}
				 break;
		}
	
	}
	
int main(int argc, char *argv[]) {
	
	//variables
	
	int barras;
	int agua;
	int uranio;
	int xenon;
	int vapor;
	int temperatura;
	int potencia;
	int presion;
	int menu;	
	int hora;
	/*int *array[24][9];
	int i = 0;
	*/
	IniciarEstado(&barras, &agua, &uranio, &xenon, &vapor, &temperatura, &potencia, &presion, &hora, &menu );
	
	//menu 
	
	do {
		ImprimirEstado(&barras, &agua, &uranio, &xenon, &vapor, &temperatura, &potencia, &presion);
		MostrarMenu(&menu);
		Operacion(&barras, &agua, &uranio, &hora, &xenon, &vapor, &temperatura, &potencia, &presion, &menu); /* &i, &array[24][9]*/

			
	}  while (menu != 0 && ExcedeLimites(&barras, &agua, &uranio, &potencia, &presion) == 0);
	
	return 0;
}
