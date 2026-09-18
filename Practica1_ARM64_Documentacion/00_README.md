# PRACTICA 1 ARM64 - PAQUETE DE DOCUMENTACION

Este paquete reune las guias necesarias para ejecutar, probar, depurar, explicar y documentar la practica de la calculadora de numeros enteros en ensamblador ARM64.

## ARCHIVOS INCLUIDOS

1. `01_GUIA_GENERAL_CALCULADORA.md`
   - como entrar al proyecto
   - como ensamblar
   - como enlazar
   - como ejecutar
   - como probar todas las operaciones
   - como probar las validaciones

2. `02_GUIA_GDB_COMPLETA.md`
   - uso de dos terminales
   - conexion entre qemu y gdb
   - breakpoint en suma
   - revision de registros
   - avance instruccion por instruccion
   - evidencia x19 = 15, x20 = 8, x21 = 23

3. `03_HOJA_DEFENSA_RAPIDA.md`
   - comandos rapidos
   - respuestas cortas
   - que hacer si el auxiliar pide una demostracion

4. `04_PREGUNTAS_DEFENSA.md`
   - posibles preguntas
   - respuestas sugeridas
   - registros, instrucciones, syscalls, ciclos, validaciones y gdb

5. `05_MANUAL_USUARIO.md`
   - como usar la calculadora desde el punto de vista del usuario
   - operaciones disponibles
   - ejemplos
   - mensajes de error

6. `06_MANUAL_TECNICO.md`
   - estructura interna del programa
   - secciones `.data`, `.bss`, `.text`
   - subrutinas
   - registros
   - conversion ascii-entero y entero-ascii
   - flujo de cada operacion
   - compilacion y depuracion

7. `07_DOCUMENTACION_BREVE.md`
   - texto base para entregar como documentacion
   - introduccion
   - objetivos
   - descripcion
   - operaciones
   - validaciones
   - gdb
   - conclusiones

8. `08_PRUEBAS_Y_EVIDENCIAS.md`
   - lista exacta de pruebas recomendadas
   - capturas que conviene guardar
   - resultado esperado de cada prueba

## ESTRUCTURA RECOMENDADA DEL PROYECTO

```text
Practica1_ARM64/
├── calculadora.s
├── calculadora.o
├── calculadora
├── documentacion/
│   ├── 00_README.md
│   ├── 01_GUIA_GENERAL_CALCULADORA.md
│   ├── 02_GUIA_GDB_COMPLETA.md
│   ├── 03_HOJA_DEFENSA_RAPIDA.md
│   ├── 04_PREGUNTAS_DEFENSA.md
│   ├── 05_MANUAL_USUARIO.md
│   ├── 06_MANUAL_TECNICO.md
│   ├── 07_DOCUMENTACION_BREVE.md
│   └── 08_PRUEBAS_Y_EVIDENCIAS.md
└── evidencias/
    ├── menu.png
    ├── suma.png
    ├── resta.png
    ├── multiplicacion.png
    ├── division.png
    ├── division_cero.png
    ├── potencia.png
    ├── exponente_negativo.png
    ├── factorial.png
    ├── factorial_negativo.png
    ├── opcion_invalida.png
    └── gdb_suma.png
```

## COMANDO BASE

```bash
cd ~/Practica1_ARM64
aarch64-linux-gnu-as -g -o calculadora.o calculadora.s
aarch64-linux-gnu-ld -o calculadora calculadora.o
qemu-aarch64 ./calculadora
```
