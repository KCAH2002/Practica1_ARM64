# GUIA GENERAL - CALCULADORA ARM64

## 1. ENTRAR A LA CARPETA

```bash
cd ~/Practica1_ARM64
```

Verificar la ruta:

```bash
pwd
```

Resultado esperado:

```text
/home/claire/Practica1_ARM64
```

Ver archivos:

```bash
ls
```

Deberian aparecer:

```text
calculadora.s
calculadora.o
calculadora
```

---

## 2. ENSAMBLAR

```bash
aarch64-linux-gnu-as -g -o calculadora.o calculadora.s
```

### que hace

- `aarch64-linux-gnu-as`: assembler para aarch64
- `-g`: agrega informacion de depuracion para gdb
- `-o calculadora.o`: genera el archivo objeto
- `calculadora.s`: archivo fuente

Flujo:

```text
calculadora.s
      |
      v
assembler
      |
      v
calculadora.o
```

---

## 3. ENLAZAR

```bash
aarch64-linux-gnu-ld -o calculadora calculadora.o
```

### que hace

- `aarch64-linux-gnu-ld`: linker para aarch64
- `-o calculadora`: nombre del ejecutable
- `calculadora.o`: archivo objeto que se enlaza

Flujo:

```text
calculadora.o
      |
      v
linker
      |
      v
calculadora
```

---

## 4. COMPROBAR QUE EL EJECUTABLE ES ARM64

```bash
file calculadora
```

Se espera algo parecido a:

```text
calculadora: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, with debug_info, not stripped
```

Lo importante es:

```text
ARM aarch64
```

---

## 5. EJECUTAR

```bash
qemu-aarch64 ./calculadora
```

Menu esperado:

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

---

# PRUEBAS DE OPERACIONES

## suma

Entrada:

```text
opcion: 1
primer numero: 15
segundo numero: 8
```

Resultado:

```text
Resultado: 23
```

Instruccion principal:

```asm
add x21, x19, x20
```

Interpretacion:

```text
x21 = x19 + x20
```

---

## resta

Entrada:

```text
opcion: 2
primer numero: 8
segundo numero: 20
```

Resultado:

```text
Resultado: -12
```

Instruccion principal:

```asm
sub x21, x19, x20
```

---

## multiplicacion

Entrada:

```text
opcion: 3
primer numero: -7
segundo numero: 4
```

Resultado:

```text
Resultado: -28
```

Instruccion principal:

```asm
mul x21, x19, x20
```

---

## division entera

Entrada:

```text
opcion: 4
primer numero: 7
segundo numero: 2
```

Resultado:

```text
Resultado: 3
```

Instruccion principal:

```asm
sdiv x21, x19, x20
```

Se usa `sdiv` porque la calculadora admite numeros con signo.

---

# VALIDACIONES

## division entre cero

Entrada:

```text
opcion: 4
primer numero: 20
segundo numero: 0
```

Resultado esperado:

```text
error: no se puede dividir entre cero
```

Codigo clave:

```asm
cmp x20, #0
b.eq error_division
```

---

## potencia

Entrada:

```text
opcion: 5
base: 2
exponente: 4
```

Resultado:

```text
Resultado: 16
```

La potencia se realiza por multiplicacion repetida.

Ejemplo:

```text
resultado = 1
1 * 2 = 2
2 * 2 = 4
4 * 2 = 8
8 * 2 = 16
```

Codigo principal:

```asm
mul x21, x21, x19
sub x22, x22, #1
```

---

## exponente cero

Entrada:

```text
opcion: 5
base: 5
exponente: 0
```

Resultado:

```text
Resultado: 1
```

---

## exponente negativo

Entrada:

```text
opcion: 5
base: 5
exponente: -2
```

Resultado:

```text
error: el exponente no puede ser negativo
```

Codigo:

```asm
cmp x20, #0
b.lt error_exponente
```

---

## factorial

Entrada:

```text
opcion: 6
numero: 5
```

Resultado:

```text
Resultado: 120
```

Proceso:

```text
1 * 5 = 5
5 * 4 = 20
20 * 3 = 60
60 * 2 = 120
```

Codigo principal:

```asm
mul x20, x20, x21
sub x21, x21, #1
```

---

## factorial de cero

Entrada:

```text
opcion: 6
numero: 0
```

Resultado:

```text
Resultado: 1
```

---

## factorial negativo

Entrada:

```text
opcion: 6
numero: -5
```

Resultado:

```text
error: el factorial no acepta numeros negativos
```

Codigo:

```asm
cmp x19, #0
b.lt error_factorial
```

---

## opcion invalida

Entrada:

```text
opcion: 9
```

Resultado:

```text
opcion invalida, intente nuevamente
```

---

## salir

Entrada:

```text
opcion: 7
```

Resultado:

```text
saliendo de la calculadora...
```

Codigo de salida:

```asm
mov x0, #0
mov x8, #93
svc #0
```

---

# COMANDOS COMPLETOS PARA UNA DEMOSTRACION RAPIDA

```bash
cd ~/Practica1_ARM64

aarch64-linux-gnu-as -g -o calculadora.o calculadora.s

aarch64-linux-gnu-ld -o calculadora calculadora.o

file calculadora

qemu-aarch64 ./calculadora
```
