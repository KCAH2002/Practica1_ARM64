# calculadora arm64

Practica de arquitectura de computadores y ensambladores 1.

El programa implementa una calculadora de numeros enteros completamente en ensamblador ARM64/AArch64.

## funciones

La calculadora permite:

1. suma
2. resta
3. multiplicacion
4. division entera
5. potencia
6. factorial
7. salir

Tambien incluye validaciones para:

- opcion invalida
- division entre cero
- exponente negativo
- factorial negativo

## estructura recomendada

```text
Practica1_ARM64/
├── calculadora.s
├── Makefile
├── README.md
├── .gitignore
├── documentacion/
└── evidencias/
```

## requisitos

En Ubuntu o Linux Mint instalar:

```bash
sudo apt update
sudo apt install binutils-aarch64-linux-gnu qemu-user gdb-multiarch make
```

Comprobar:

```bash
aarch64-linux-gnu-as --version
aarch64-linux-gnu-ld --version
qemu-aarch64 --version
gdb-multiarch --version
make --version
```

## forma rapida de ejecutar

```bash
make
make run
```

Limpiar archivos generados:

```bash
make clean
```

## forma manual

Ensamblar:

```bash
aarch64-linux-gnu-as -g -o calculadora.o calculadora.s
```

Enlazar:

```bash
aarch64-linux-gnu-ld -o calculadora calculadora.o
```

Comprobar arquitectura:

```bash
file calculadora
```

Debe aparecer algo similar a:

```text
ELF 64-bit LSB executable, ARM aarch64
```

Ejecutar:

```bash
qemu-aarch64 ./calculadora
```

## menu esperado

```text
================================
      CALCULADORA ARM64
================================
1. Suma
2. Resta
3. Multiplicacion
4. Division entera
5. Potencia
6. Factorial
7. Salir

Seleccione una opcion:
```

## pruebas rapidas

### suma

```text
opcion: 1
primer numero: 15
segundo numero: 8
resultado: 23
```

### division entera

```text
opcion: 4
primer numero: 7
segundo numero: 2
resultado: 3
```

### division entre cero

```text
opcion: 4
primer numero: 20
segundo numero: 0
```

Debe mostrar un mensaje de error.

### potencia

```text
opcion: 5
base: 2
exponente: 4
resultado: 16
```

### factorial

```text
opcion: 6
numero: 5
resultado: 120
```

## depuracion con gdb

Se utilizan dos terminales.

### terminal 1

```bash
make debug-server
```

o manualmente:

```bash
qemu-aarch64 -g 1234 ./calculadora
```

### terminal 2

```bash
gdb-multiarch calculadora
```

Dentro de gdb:

```gdb
set architecture aarch64
target remote :1234
break opcion_suma
continue
```

En la terminal 1 seleccionar:

```text
1
```

En gdb:

```gdb
info registers x0 x19 x20 x21
ni
x/i $pc
```

Prueba recomendada:

```text
15 + 8
```

Resultado esperado:

```text
x19 = 15
x20 = 8
x21 = 23
```

## ejecutar en otra computadora

La forma mas segura es clonar y volver a generar el ejecutable desde `calculadora.s`.

```bash
git clone URL_DEL_REPOSITORIO
cd NOMBRE_DEL_REPOSITORIO
sudo apt update
sudo apt install binutils-aarch64-linux-gnu qemu-user gdb-multiarch make
make
make run
```

## autores

Agregar aqui los nombres y carnets correspondientes.
