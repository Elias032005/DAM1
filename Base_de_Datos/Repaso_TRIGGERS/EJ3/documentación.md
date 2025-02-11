# DOCUMENTACIÓN/INFORMACIÓN PARA LA DDBB DE POKÉMON

# EXPLICACIÓN DEL DIAGRMA
Las palabras en negrita seran el nombre de las tablas (EJ: **Pokedex**)

**Pokedex:** Esta tabla será la tabla main del diograma. 
La tabla tendra 7 columnas, estás són:
 1. id (INT,AUTO_INCREMENT PRIMARY KEY)
 2. numero_dex (INT INT NOT NULL UNIQUE)
 3. nombre (VARCHAR(100) NOT NULL)
 4. tipo_primario (VARCHAR(40) NOT NULL)
 5. tipo_secundario VARCHAR(50)
 6. descripción (TEXT)

**Habilidades** Está tabla guardara las habilidades.
La tabla tendra 3 columnas, estás són:
1.  id (INT AUTO_INCREMENT PRIMARY KEY)
2.  nombre (VARCHAR(100) NOT NULL UNIQUE)
3.  descripcion (TEXT)

**pokemon_habilidades** Tabla relacional entre pokedex y habilidades.
La Tabla tendra 5 columnas, estás són:
1. id INT AUTO_INCREMENT PRIMARY KEY
2. pokemon_id INT NOT NULL
3. habilidad_id INT NOT NULL,
4. FOREIGN KEY (pokemon_id) REFERENCES pokedex(id)
5. FOREIGN KEY (habilidad_id) REFERENCES habilidades(id)






  
**RELACIONES**
- Tendra una tabla intermedia (n:m) con la tabla **habilidades.** En esta tabla guardara la información de el pokémon y que habilidad tiene y si el pokemon tiene los 4 movimientos ocupados para aprender.
- Tendra una doble relación (1:n) en la tabla **evoluciones**, con esto podremos ver el pokemon base y el pokemon que ha evolucionado.
- Tendra una tabla intermedia (n:m) con la tabla **movimientos**. En esta tabla guardara el número de pokedex del pokémon, el id del movimiento y el id del pokemon_movimiento

****

# INFORMACIÓN PARA LA DDBB

  **Datos principales para la ddbb**
  Link: https://pokemondb.net/pokedex/all
   1. Foto por cada pokémon
2. Más info por cada pokémon (altura, peso, HP, Attack, Defense, Sp. Atk, Sp.Def, Speed, Catch rate
3.  Aparición (ruta/region), Tipo de región)
4. Tabla de tipos (debilidades/inmunes/eficaces)
5. Naturaleza
6. Tablas de Objetos (Pokéballs, pociones, Bayas, MT, MO, Equipables, Cristales, Megapiedras, Obj_Evolutivos, Obj_equipables)
7. Tabla auditoria 

      

