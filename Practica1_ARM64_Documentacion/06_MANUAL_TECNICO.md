# MANUAL TECNICO
## CALCULADORA ARM64

## 1. OBJETIVO TECNICO

Desarrollar una calculadora de numeros enteros en ensamblador ARM64 puro utilizando:

- entrada y salida por consola
- instrucciones aritmeticas
- comparaciones
- saltos condicionales
- ciclos
- subrutinas
- validaciones
- syscalls de Linux AArch64

---

## 2. HERRAMIENTAS

- GNU Assembler para AArch64
- GNU Linker
- QEMU AArch64
- GDB Multiarch
- Linux
- editor de codigo

Versiones utilizadas durante el desarrollo:

```text
GNU Binutils 2.42
QEMU 8.2.2
GDB Multiarch 15.1
```

---

## 3. ARCHIVOS

```text
calculadora.s
calculadora.o
calculadora
```

### calculadora.s

Codigo fuente en ensamblador ARM64.

### calculadora.o

Archivo objeto generado por el assembler.

### calculadora

Ejecutable ARM64 generado por el linker.

---

## 4. SECCIONES DEL PROGRAMA

### `.section .data`

Contiene datos inicializados.

Ejemplos:

- menu
- mensajes
- textos de error
- `Resultado:`

### `.section .bss`

Reserva memoria para datos que se utilizan durante la ejecucion.

Ejemplos:

```text
buffer_opcion
buffer_numero
buffer_salida
```

### `.section .text`

Contiene el codigo ejecutable.

---

## 5. PUNTO DE ENTRADA

```asm
.global _start
```

```asm
_start:
```

`_start` representa el punto inicial de ejecucion.

---

## 6. FLUJO GENERAL

```text
_start
   |
   v
mostrar_menu
   |
   v
leer opcion
   |
   v
validar opcion
   |
   +--> suma
   +--> resta
   +--> multiplicacion
   +--> division
   +--> potencia
   +--> factorial
   +--> salir
```

Despues de cada operacion:

```text
operacion
   |
   v
mostrar resultado
   |
   v
mostrar_menu
```

---

## 7. SUBRUTINA imprimir_texto

Se utiliza para imprimir cadenas.

La llamada se realiza con:

```asm
bl imprimir_texto
```

La subrutina utiliza:

```text
x0 = 1
x1 = direccion del texto
x2 = cantidad de bytes
x8 = 64
```

Luego:

```asm
svc #0
```

---

## 8. SUBRUTINA leer_entero

Su objetivo es convertir la entrada del teclado en un valor entero.

Ejemplo:

```text
"253\n"
```

se convierte a:

```text
253
```

Proceso:

```text
resultado = 0

resultado = 0 * 10 + 2
resultado = 2

resultado = 2 * 10 + 5
resultado = 25

resultado = 25 * 10 + 3
resultado = 253
```

Formula:

```text
resultado = resultado * 10 + digito
```

Tambien revisa si el primer caracter es:

```text
-
```

para aceptar numeros negativos.

---

## 9. SUBRUTINA imprimir_entero

Realiza el proceso contrario.

Ejemplo:

```text
123
```

se convierte a:

```text
"123"
```

Para obtener los digitos se realizan divisiones sucesivas entre 10.

Ejemplo:

```text
123 / 10 = 12 residuo 3
12 / 10 = 1 residuo 2
1 / 10 = 0 residuo 1
```

Los residuos se convierten a caracteres ASCII.

---

## 10. SUMA

Registros:

```text
x19 = primer numero
x20 = segundo numero
x21 = resultado
```

Instruccion:

```asm
add x21, x19, x20
```

---

## 11. RESTA

```asm
sub x21, x19, x20
```

---

## 12. MULTIPLICACION

```asm
mul x21, x19, x20
```

---

## 13. DIVISION ENTERA

Primero se valida:

```asm
cmp x20, #0
b.eq error_division
```

Si el divisor es valido:

```asm
sdiv x21, x19, x20
```

Se utiliza division con signo.

---

## 14. POTENCIA

Registros principales:

```text
x19 = base
x20 = exponente
x21 = resultado
x22 = contador
```

Inicializacion:

```asm
mov x21, #1
mov x22, x20
```

Ciclo:

```asm
mul x21, x21, x19
sub x22, x22, #1
```

El ciclo termina cuando x22 llega a cero.

Validacion:

```asm
cmp x20, #0
b.lt error_exponente
```

---

## 15. FACTORIAL

Registros principales:

```text
x19 = numero
x20 = resultado
x21 = contador
```

Inicializacion:

```asm
mov x20, #1
mov x21, x19
```

Ciclo:

```asm
mul x20, x20, x21
sub x21, x21, #1
```

Validacion:

```asm
cmp x19, #0
b.lt error_factorial
```

---

## 16. VALIDACION DEL MENU

La opcion es comparada con los valores del 1 al 7.

Ejemplo:

```asm
cmp w2, #1
b.eq opcion_suma
```

Si no coincide con ninguna opcion:

```asm
b opcion_invalida
```

---

## 17. SYSCALLS UTILIZADAS

| syscall | numero | uso |
|---|---:|---|
| read | 63 | leer teclado |
| write | 64 | imprimir |
| exit | 93 | terminar programa |

---

## 18. REGISTROS IMPORTANTES

| registro | uso |
|---|---|
| x0 | argumentos, resultados y syscalls |
| x1 | direcciones de memoria |
| x2 | cantidad de bytes |
| x8 | numero de syscall |
| x19 | primer operando o valor principal |
| x20 | segundo operando o resultado segun operacion |
| x21 | resultado o contador segun operacion |
| x22 | contador de potencia |

---

## 19. ENSAMBLAR

```bash
aarch64-linux-gnu-as -g -o calculadora.o calculadora.s
```

---

## 20. ENLAZAR

```bash
aarch64-linux-gnu-ld -o calculadora calculadora.o
```

---

## 21. EJECUTAR

```bash
qemu-aarch64 ./calculadora
```

---

## 22. DEPURACION

Terminal 1:

```bash
qemu-aarch64 -g 1234 ./calculadora
```

Terminal 2:

```bash
gdb-multiarch calculadora
```

GDB:

```gdb
set architecture aarch64
target remote :1234
break opcion_suma
continue
```

---

## 23. EVIDENCIA DE DEPURACION

Prueba:

```text
15 + 8
```

Antes de la suma:

```text
x19 = 15
x20 = 8
x21 = 0
```

Instruccion:

```asm
add x21, x19, x20
```

Despues:

```text
x21 = 23
```

Esto demuestra que la operacion se ejecuta directamente en registros ARM64.
