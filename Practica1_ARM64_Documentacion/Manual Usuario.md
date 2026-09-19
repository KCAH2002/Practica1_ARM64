# MANUAL DE USUARIO
## CALCULADORA DE NUMEROS ENTEROS EN ARM64

## 1. DESCRIPCION

La aplicacion es una calculadora de numeros enteros ejecutada desde consola.

Permite realizar:

1. suma
2. resta
3. multiplicacion
4. division entera
5. potencia
6. factorial
7. salir

El programa permanece activo despues de cada operacion y vuelve a mostrar el menu.

---

## 2. INICIAR EL PROGRAMA

Desde la carpeta del proyecto:

```bash
qemu-aarch64 ./calculadora
```

Se muestra:

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

## 3. SUMA

Seleccionar:

```text
1
```

Ejemplo:

```text
Ingrese el primer numero: 15
Ingrese el segundo numero: 8
Resultado: 23
```

---

## 4. RESTA

Seleccionar:

```text
2
```

Ejemplo:

```text
Ingrese el primer numero: 8
Ingrese el segundo numero: 20
Resultado: -12
```

---

## 5. MULTIPLICACION

Seleccionar:

```text
3
```

Ejemplo:

```text
Ingrese el primer numero: -7
Ingrese el segundo numero: 4
Resultado: -28
```

---

## 6. DIVISION ENTERA

Seleccionar:

```text
4
```

Ejemplo:

```text
Ingrese el primer numero: 7
Ingrese el segundo numero: 2
Resultado: 3
```

La calculadora trabaja con numeros enteros, por lo que no muestra resultados decimales.

---

## 7. DIVISION ENTRE CERO

No se permite usar cero como divisor.

Ejemplo:

```text
Ingrese el primer numero: 20
Ingrese el segundo numero: 0
```

Respuesta:

```text
error: no se puede dividir entre cero
```

---

## 8. POTENCIA

Seleccionar:

```text
5
```

Ejemplo:

```text
Ingrese la base: 2
Ingrese el exponente: 4
Resultado: 16
```

El exponente debe ser entero no negativo.

---

## 9. EXPONENTE NEGATIVO

Ejemplo:

```text
Ingrese la base: 5
Ingrese el exponente: -2
```

Respuesta:

```text
error: el exponente no puede ser negativo
```

---

## 10. FACTORIAL

Seleccionar:

```text
6
```

Ejemplo:

```text
Ingrese el numero: 5
Resultado: 120
```

---

## 11. FACTORIAL NEGATIVO

Ejemplo:

```text
Ingrese el numero: -5
```

Respuesta:

```text
error: el factorial no acepta numeros negativos
```

---

## 12. OPCION INVALIDA

Si se escribe una opcion fuera del menu:

```text
9
```

El programa muestra:

```text
opcion invalida, intente nuevamente
```

y regresa al menu.

---

## 13. SALIR

Seleccionar:

```text
7
```

El programa muestra:

```text
saliendo de la calculadora...
```

y termina.

---

## 14. CASOS IMPORTANTES

| entrada | resultado |
|---|---:|
| `15 + 8` | 23 |
| `8 - 20` | -12 |
| `-7 * 4` | -28 |
| `7 / 2` | 3 |
| `5^0` | 1 |
| `0!` | 1 |
