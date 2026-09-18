# GUIA COMPLETA DE GDB - CALCULADORA ARM64

Para depurar la calculadora se utilizan dos terminales.

---

# PREPARACION

Antes de iniciar:

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

Eso es correcto.

QEMU esta esperando que GDB se conecte por el puerto `1234`.

No escribir nada mas en esta terminal por el momento.

---

# TERMINAL 2 - GDB

Ejecutar:

```bash
gdb-multiarch calculadora
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

```gdb
break opcion_suma
```

Luego:

```gdb
continue
```

Ahora ir a la terminal 1.

Debe aparecer el menu.

Escribir:

```text
1
```

Volver a la terminal 2.

GDB debe mostrar algo parecido a:

```text
Breakpoint 1, opcion_suma () at calculadora.s:...
```

---

# VER REGISTROS

```gdb
info registers x0 x19 x20 x21
```

Al inicio de la suma, x19, x20 y x21 pueden estar en cero.

Es normal.

---

# AVANZAR INSTRUCCION POR INSTRUCCION

```gdb
ni
```

`ni` ejecuta la siguiente instruccion.

Para ver la siguiente instruccion:

```gdb
x/i $pc
```

`pc` es el program counter.

---

# PRIMER OPERANDO

Avanzar hasta encontrar:

```asm
bl leer_entero
```

Ejecutar:

```gdb
ni
```

GDB parecera quedarse esperando.

Ir a la terminal 1.

Debe aparecer:

```text
Ingrese el primer numero:
```

Escribir:

```text
15
```

Volver a la terminal 2.

Verificar x0:

```gdb
info registers x0
```

Se espera:

```text
x0    0xf    15
```

Avanzar la instruccion:

```asm
mov x19, x0
```

con:

```gdb
ni
```

Verificar:

```gdb
info registers x19
```

Resultado esperado:

```text
x19    0xf    15
```

---

# SEGUNDO OPERANDO

Avanzar con:

```gdb
ni
```

hasta encontrar nuevamente:

```asm
bl leer_entero
```

Ejecutar:

```gdb
ni
```

Ir a terminal 1.

Escribir:

```text
8
```

Volver a GDB.

Verificar:

```gdb
info registers x0
```

Se espera:

```text
x0    0x8    8
```

Ejecutar:

```asm
mov x20, x0
```

con:

```gdb
ni
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

Esta es la mejor captura para la evidencia de GDB.

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
