# HOJA DE DEFENSA RAPIDA

## EJECUTAR LA CALCULADORA

```bash
cd ~/Practica1_ARM64
aarch64-linux-gnu-as -g -o calculadora.o calculadora.s
aarch64-linux-gnu-ld -o calculadora calculadora.o
qemu-aarch64 ./calculadora
```

## COMPROBAR QUE ES ARM64

```bash
file calculadora
```

Buscar:

```text
ARM aarch64
```

---

# GDB - DOS TERMINALES

## terminal 1

```bash
cd ~/Practica1_ARM64
qemu-aarch64 -g 1234 ./calculadora
```

## terminal 2

```bash
cd ~/Practica1_ARM64
gdb-multiarch calculadora
```

Dentro de GDB:

```gdb
set architecture aarch64
target remote :1234
break opcion_suma
continue
```

En terminal 1:

```text
1
```

Luego en GDB:

```gdb
info registers x0 x19 x20 x21
```

Avanzar:

```gdb
ni
```

Ver siguiente instruccion:

```gdb
x/i $pc
```

Prueba recomendada:

```text
15 + 8
```

Resultado final esperado en registros:

```text
x19 = 15
x20 = 8
x21 = 23
```

---

# OPERACIONES

| opcion | operacion | instruccion principal |
|---:|---|---|
| 1 | suma | `add` |
| 2 | resta | `sub` |
| 3 | multiplicacion | `mul` |
| 4 | division entera | `sdiv` |
| 5 | potencia | ciclo con `mul` |
| 6 | factorial | ciclo con `mul` |
| 7 | salir | syscall `exit` |

---

# VALIDACIONES

| prueba | resultado |
|---|---|
| opcion `9` | opcion invalida |
| `20 / 0` | error division entre cero |
| `5 ^ -2` | error exponente negativo |
| `(-5)!` | error factorial negativo |
| `5 ^ 0` | 1 |
| `0!` | 1 |

---

# RESPUESTAS CORTAS

**¿por que qemu?**  
porque el ejecutable es arm64 y qemu permite ejecutarlo en el entorno de desarrollo.

**¿por que gdb?**  
para detener el programa, revisar registros y avanzar instruccion por instruccion.

**¿para que sirve x19?**  
guarda el primer operando.

**¿para que sirve x20?**  
guarda el segundo operando en operaciones de dos operandos.

**¿para que sirve x21?**  
se usa para resultados o contadores dependiendo de la operacion.

**¿que hace `cmp`?**  
compara valores y modifica las banderas.

**¿que hace `b.eq`?**  
salta cuando la comparacion indica igualdad.

**¿que hace `b.lt`?**  
salta cuando el valor es menor.

**¿que hace `bl`?**  
llama una subrutina.

**¿que hace `ret`?**  
regresa de una subrutina.

**¿que hace `svc #0`?**  
solicita un servicio al sistema operativo.

**¿por que potencia tiene ciclo?**  
porque se implementa mediante multiplicacion repetida.

**¿por que factorial tiene ciclo?**  
porque se implementa de forma iterativa.

---

# DEMOSTRACION RAPIDA RECOMENDADA

1. `file calculadora`
2. ejecutar programa
3. suma `15 + 8 = 23`
4. division `7 / 2 = 3`
5. division entre cero
6. potencia `2^4 = 16`
7. factorial `5! = 120`
8. opcion invalida
9. gdb con `x19 = 15`, `x20 = 8`, `x21 = 23`
