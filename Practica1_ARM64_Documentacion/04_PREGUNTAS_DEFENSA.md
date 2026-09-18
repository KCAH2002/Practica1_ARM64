# POSIBLES PREGUNTAS DE DEFENSA

## 1. ¿que arquitectura utiliza el programa?

El programa utiliza ARM64, tambien llamada AArch64.

---

## 2. ¿esta hecho en C?

No. La logica principal esta desarrollada en ensamblador ARM64.

---

## 3. ¿que hace el assembler?

Convierte el archivo fuente `.s` en un archivo objeto `.o`.

Comando:

```bash
aarch64-linux-gnu-as -g -o calculadora.o calculadora.s
```

---

## 4. ¿que hace el linker?

Toma el archivo objeto y genera el ejecutable.

```bash
aarch64-linux-gnu-ld -o calculadora calculadora.o
```

---

## 5. ¿para que sirve qemu?

Permite ejecutar un binario ARM64 cuando el equipo de desarrollo no lo ejecuta directamente.

---

## 6. ¿para que sirve gdb?

Sirve para depurar el programa: colocar breakpoints, revisar registros, avanzar instruccion por instruccion y observar el flujo.

---

## 7. ¿que hace `.section .data`?

Guarda datos inicializados, por ejemplo los textos del menu y los mensajes.

---

## 8. ¿que hace `.section .bss`?

Reserva memoria para datos que se utilizaran durante la ejecucion, como buffers.

---

## 9. ¿que hace `.section .text`?

Contiene las instrucciones ejecutables.

---

## 10. ¿que significa `_start`?

Es el punto inicial desde donde comienza la ejecucion del programa.

---

## 11. ¿para que sirve `adr`?

Obtiene la direccion de una etiqueta y la coloca en un registro.

Ejemplo:

```asm
adr x1, menu
```

---

## 12. ¿para que sirve `mov`?

Copia o carga un valor en un registro.

---

## 13. ¿que hace `add`?

Suma dos valores.

```asm
add x21, x19, x20
```

---

## 14. ¿que hace `sub`?

Resta dos valores.

```asm
sub x21, x19, x20
```

---

## 15. ¿que hace `mul`?

Multiplica.

---

## 16. ¿que hace `sdiv`?

Realiza division entera con signo.

Se usa porque la calculadora acepta valores negativos.

---

## 17. ¿por que no se divide directamente entre cero?

Antes de ejecutar `sdiv` se compara el divisor con cero.

```asm
cmp x20, #0
b.eq error_division
```

---

## 18. ¿que hace `cmp`?

Compara dos valores y actualiza las banderas del procesador.

---

## 19. ¿que hace `b.eq`?

Salta si la comparacion anterior dio igualdad.

---

## 20. ¿que hace `b.ne`?

Salta si los valores no son iguales.

---

## 21. ¿que hace `b.lt`?

Salta si el primer valor es menor.

---

## 22. ¿que hace `b.le`?

Salta si el valor es menor o igual.

---

## 23. ¿que hace `b`?

Realiza un salto incondicional.

---

## 24. ¿que hace `bl`?

Llama una subrutina y guarda la direccion de retorno.

---

## 25. ¿que hace `ret`?

Regresa al punto desde donde se llamo la subrutina.

---

## 26. ¿que hace `ldrb`?

Carga un byte desde memoria.

Se utiliza para leer caracteres individuales del buffer.

---

## 27. ¿que hace `strb`?

Guarda un byte en memoria.

---

## 28. ¿por que hace falta convertir ascii a entero?

Porque el teclado entrega caracteres.

Por ejemplo:

```text
'5'
```

no es directamente el valor numerico 5.

En ASCII:

```text
'5' = 53
```

Se puede convertir con:

```text
53 - 48 = 5
```

---

## 29. ¿como se convierte un numero de varios digitos?

Se usa la idea:

```text
resultado = resultado * 10 + digito
```

Ejemplo para 253:

```text
0 * 10 + 2 = 2
2 * 10 + 5 = 25
25 * 10 + 3 = 253
```

---

## 30. ¿como reconoce un numero negativo?

La rutina revisa si el primer caracter es `-`.

El codigo ASCII de `-` es 45.

Al terminar la conversion se cambia el signo.

---

## 31. ¿por que hace falta imprimir_entero?

Las operaciones producen valores numericos, pero `write` imprime bytes o caracteres.

Por eso el resultado debe convertirse nuevamente a texto.

---

## 32. ¿como convierte un entero a ascii?

Divide repetidamente entre 10, obtiene residuos y los convierte a caracteres.

---

## 33. ¿por que potencia usa multiplicacion repetida?

Porque la potencia fue implementada mediante un ciclo que multiplica el resultado por la base una vez por cada unidad del exponente.

---

## 34. ¿como funciona `2^4`?

```text
resultado = 1
1 * 2 = 2
2 * 2 = 4
4 * 2 = 8
8 * 2 = 16
```

---

## 35. ¿como se controla el ciclo de potencia?

Se usa un contador.

En cada vuelta:

```asm
mul x21, x21, x19
sub x22, x22, #1
```

Cuando el contador llega a cero se termina.

---

## 36. ¿que sucede con `5^0`?

El resultado es 1.

El resultado inicia en 1 y el ciclo no se ejecuta porque el contador ya es cero.

---

## 37. ¿por que no acepta exponentes negativos?

La practica utiliza potencia entera mediante multiplicacion repetida para exponentes no negativos.

Se valida:

```asm
cmp x20, #0
b.lt error_exponente
```

---

## 38. ¿como funciona factorial?

Se inicia el resultado en 1 y se multiplica por el contador mientras disminuye.

Ejemplo:

```text
5! = 5 * 4 * 3 * 2 * 1 = 120
```

---

## 39. ¿por que `0!` devuelve 1?

Porque el resultado se inicializa en 1 y el ciclo termina sin realizar multiplicaciones.

---

## 40. ¿por que factorial no acepta negativos?

El factorial solicitado trabaja solo con enteros no negativos.

Se valida antes del ciclo.

---

## 41. ¿que registros se usaron en la suma?

En la implementacion actual:

```text
x19 = primer operando
x20 = segundo operando
x21 = resultado
```

---

## 42. ¿que demostro en GDB?

Se coloco un breakpoint en `opcion_suma`.

Con:

```text
15 + 8
```

se observo:

```text
x19 = 15
x20 = 8
```

Despues de:

```asm
add x21, x19, x20
```

se observo:

```text
x21 = 23
```

---

## 43. ¿que significa `0x17` en GDB?

Es 23 en hexadecimal.

```text
0x17 = 23 decimal
```

---

## 44. ¿que hace `break opcion_suma`?

Detiene el programa cuando la ejecucion llega a la etiqueta `opcion_suma`.

---

## 45. ¿que hace `continue`?

Continua la ejecucion hasta un breakpoint, una señal o el final del programa.

---

## 46. ¿que hace `ni`?

Ejecuta la siguiente instruccion durante la depuracion.

---

## 47. ¿que hace `x/i $pc`?

Muestra la instruccion ubicada en la direccion actual del program counter.

---

## 48. ¿que hace `info registers`?

Muestra los valores actuales de los registros.

---

## 49. ¿que es una syscall?

Es una solicitud que el programa hace al sistema operativo.

La calculadora usa syscalls para leer, escribir y salir.

---

## 50. ¿que syscall se usa para leer?

En Linux AArch64:

```text
read = 63
```

Se coloca:

```asm
mov x8, #63
svc #0
```

---

## 51. ¿que syscall se usa para escribir?

```text
write = 64
```

---

## 52. ¿que syscall se usa para salir?

```text
exit = 93
```

---

## 53. ¿por que se usa x0, x1 y x2 en las syscalls?

Se utilizan como registros de argumentos para las llamadas al sistema.

Por ejemplo en `write`:

```text
x0 = salida
x1 = direccion del texto
x2 = cantidad de bytes
x8 = numero de syscall
```

---

## 54. ¿por que el menu vuelve a aparecer?

Cada operacion termina con un salto hacia `mostrar_menu`.

---

## 55. ¿como se rechaza una opcion invalida?

El programa compara la opcion con los valores validos. Si no coincide con ninguna, salta a `opcion_invalida`.

---

## 56. ¿por que se usan subrutinas?

Para evitar repetir codigo y organizar mejor el programa.

Ejemplos:

```text
leer_entero
imprimir_entero
imprimir_texto
```

---

# RESPUESTAS CLAVE PARA MEMORIZAR

### leer_entero

> recibe los caracteres ingresados por teclado y los convierte de ascii a un numero entero que puede utilizar el cpu.

### imprimir_entero

> toma un resultado numerico y lo convierte a caracteres ascii para poder mostrarlo en pantalla.

### gdb

> se uso para detener la ejecucion, revisar registros y demostrar que los operandos y el resultado se almacenaban correctamente.

### potencia

> se realizo mediante multiplicacion repetida usando un ciclo y un contador.

### factorial

> se realizo mediante un ciclo iterativo que multiplica el resultado acumulado y disminuye el contador.
