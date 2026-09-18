# PRUEBAS Y EVIDENCIAS

## OBJETIVO

Esta guia indica que pruebas ejecutar y que capturas guardar para demostrar el funcionamiento completo de la calculadora.

---

# 1. MENU

Ejecutar:

```bash
qemu-aarch64 ./calculadora
```

Guardar captura del menu.

Nombre sugerido:

```text
menu.png
```

---

# 2. SUMA

Prueba:

```text
1
15
8
```

Resultado esperado:

```text
Resultado: 23
```

Captura:

```text
suma.png
```

---

# 3. RESTA CON RESULTADO NEGATIVO

Prueba:

```text
2
8
20
```

Resultado:

```text
Resultado: -12
```

Captura:

```text
resta.png
```

---

# 4. MULTIPLICACION

Prueba:

```text
3
-7
4
```

Resultado:

```text
Resultado: -28
```

Captura:

```text
multiplicacion.png
```

---

# 5. DIVISION ENTERA

Prueba:

```text
4
7
2
```

Resultado:

```text
Resultado: 3
```

Captura:

```text
division.png
```

---

# 6. DIVISION ENTRE CERO

Prueba:

```text
4
20
0
```

Resultado:

```text
error: no se puede dividir entre cero
```

Captura:

```text
division_cero.png
```

---

# 7. POTENCIA

Prueba:

```text
5
2
4
```

Resultado:

```text
Resultado: 16
```

Captura:

```text
potencia.png
```

---

# 8. EXPONENTE NEGATIVO

Prueba:

```text
5
5
-2
```

Resultado:

```text
error: el exponente no puede ser negativo
```

Captura:

```text
exponente_negativo.png
```

---

# 9. FACTORIAL

Prueba:

```text
6
5
```

Resultado:

```text
Resultado: 120
```

Captura:

```text
factorial.png
```

---

# 10. FACTORIAL NEGATIVO

Prueba:

```text
6
-5
```

Resultado:

```text
error: el factorial no acepta numeros negativos
```

Captura:

```text
factorial_negativo.png
```

---

# 11. OPCION INVALIDA

Prueba:

```text
9
```

Resultado:

```text
opcion invalida, intente nuevamente
```

Captura:

```text
opcion_invalida.png
```

---

# 12. CASOS ESPECIALES

## potencia con exponente cero

```text
5
5
0
```

Resultado:

```text
Resultado: 1
```

## factorial de cero

```text
6
0
```

Resultado:

```text
Resultado: 1
```

---

# 13. GDB

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

En terminal 1:

```text
1
15
8
```

La evidencia final debe mostrar:

```text
x19 = 15
x20 = 8
x21 = 23
```

Nombre sugerido:

```text
gdb_suma.png
```

---

# CHECKLIST FINAL

- [ ] menu
- [ ] suma
- [ ] resta
- [ ] multiplicacion
- [ ] division entera
- [ ] division entre cero
- [ ] potencia
- [ ] exponente negativo
- [ ] factorial
- [ ] factorial negativo
- [ ] opcion invalida
- [ ] gdb
- [ ] codigo fuente `.s`
- [ ] ejecutable
- [ ] documentacion
