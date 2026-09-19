# GUIA COMPLETA DE GDB - CALCULADORA ARM64

Para depurar la calculadora se utilizan dos terminales.

---

# PREPARACION

Antes de iniciar: En una terminal

```bash
cd ~/Practica1_ARM64
aarch64-linux-gnu-as -g -o calculadora.o calculadora.s
aarch64-linux-gnu-ld -o calculadora calculadora.o
```

---

# TERMINAL 1 - QEMU

Ejecutar:

```bash
qemu-aarch64 -g 1234 ./calculadora
```

El programa parecera detenido.

QEMU esta esperando que GDB se conecte por el puerto `1234`.

"No escribir nada mas en esta terminal por el momento."

---

# TERMINAL 2 - GDB

Ejecutar:

```bash
gdb-multiarch calculadora
```
Puede no aparecer de inmediatoel gdb, preciona:

```text
c
```

Cuando aparezca:

```text
(gdb)
```

ejecutar:

```gdb
set architecture aarch64
```

Luego:

```gdb
target remote :1234
```

Esto conecta GDB con QEMU.

---

# PONER BREAKPOINT EN LA SUMA 
-----------------------------

```gdb
break opcion_suma
```

aqui nos sale algo como 

```text
Punto de interrupción 1 at 
```


Luego escribimos:

```gdb
continue
```
En ese momento GDB queda esperando.

### En la terminal 1
Debe aparecer el menu.

Escribir:

```text
1
```

### En la terminal 2


GDB debe mostrar algo parecido a:

```text
Breakpoint 1, opcion_suma () at calculadora.s:...
```
Y abajo: 
```text
(gdb)
```

---

## VER REGISTROS

```gdb
info registers x0 x19 x20 x21
```

Al inicio de la suma, x19, x20 y x21 pueden estar en cero.


---

# AVAZEMOS AL PRIMER NUMERO

```gdb
ni
```

`ni` ejecuta la siguiente instruccion.

Para ver la siguiente instruccion:

```gdb
x/i $pc
```

`pc` es el program counter.

Pero esta parte puedes saltartelo, escribimos `ni` alrededor de 3 veces hasta que aparezca:

```text
bl leer_entero ...
```
y despues:

```text
(gdb)
```

Volvemos aescrinir:
```gdb
ni
```
Ahora GDB parecerá detenido.

---
### Volvemos a la terminal 1
Debe aparecer:
```gdb
Ingrese el primer numero:
```

Escribimos:
```gdb
15
```

y enter.


### Volver a la terminal 2

Verificamos el primer numero:

```gdb
info registers x0
```

Debe aparecer algo como :

```text
x0    0xf    15
```

Ahora revisamos:
```text
x/i $pc
```

Deberia estar cerca de:

```text
mov     x19, x0
```

ejecutamos con:

```gdb
ni
```

luego:

```gdb
info registers x19
```

deberia mostrar algo como:

```text
x19    0xf    15
```
es decir primer numero registrado

---

# segundo numero

Avanzar con:

```gdb
ni
```

hasta encontrar nuevamente:

```asm
bl leer_entero
```
Alrededor de 3  `ni`


Entonces ejecutamos:

```gdb
ni
```
otra vez parece que esta esperando 


### Ir a terminal 1

Escribir:

```text
8
```

### Volvemos a terminal 2

Verificar:

```gdb
info registers x0
```

Se espera:

```text
x0    0x8    8
```

con:

```gdb
ni
```
hasta ver: 

```asm
mov x20, x0
```



Verificar:

```gdb
info registers x19 x20
```

Resultado:

```text
x19    0xf    15
x20    0x8     8
```

---

# DEMOSTRAR LA SUMA

Consultar la instruccion actual:

```gdb
x/i $pc
```

Se busca:

```asm
add x21, x19, x20
```

Antes de ejecutarla:

```gdb
info registers x19 x20 x21
```

Se espera:

```text
x19    0xf    15
x20    0x8     8
x21    0x0     0
```

Ejecutar una instruccion:

```gdb
ni
```

Volver a consultar:

```gdb
info registers x19 x20 x21
```

Resultado esperado:

```text
x19    0xf     15
x20    0x8      8
x21    0x17    23
```

Interpretacion:

```text
x19 = primer operando = 15
x20 = segundo operando = 8
x21 = resultado = 23
```

---

# COMANDOS IMPORTANTES

| comando | funcion |
|---|---|
| `break opcion_suma` | detenerse al entrar a la suma |
| `continue` | continuar la ejecucion |
| `ni` | ejecutar la siguiente instruccion |
| `x/i $pc` | mostrar la siguiente instruccion |
| `info registers` | mostrar todos los registros |
| `info registers x19 x20 x21` | mostrar registros seleccionados |
| `delete` | eliminar breakpoints |
| `quit` | salir de gdb |

---

# SI GDB DICE QUE NO HAY REGISTROS

Si aparece un mensaje parecido a que el programa no tiene registros disponibles, normalmente significa que:

- el programa termino
- gdb no esta conectado
- qemu ya no esta ejecutandose
- el programa esta corriendo y no se encuentra detenido

La solucion mas sencilla es reiniciar limpio.

Terminal 1:

```bash
qemu-aarch64 -g 1234 ./calculadora
```

Terminal 2:

```bash
gdb-multiarch calculadora
```

Luego:

```gdb
set architecture aarch64
target remote :1234
break opcion_suma
continue
```

En terminal 1 escribir:

```text
1
```

Al detenerse en `opcion_suma`, los registros vuelven a estar disponibles.

---

# SALIR DE GDB

```gdb
quit
```

Si pregunta:

```text
A debugging session is active.
Quit anyway? (y or n)
```

Responder:

```text
y
```

Si qemu queda abierto en la otra terminal:

```text
ctrl + c
```


# Captura

![alt text](imagen13.png)


# para el breakpoint

puede ser cualquiera 

Por ejemplo:

```
break opcion_resta
break opcion_multiplicacion
break opcion_division
break opcion_potencia
break opcion_factorial
```

Luego ponemos:
```
continue
```
y en la terminal de QEMU seleccionamos la opcion que corresponda y listo . :)