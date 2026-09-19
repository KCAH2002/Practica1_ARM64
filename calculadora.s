.section .data  // aqui voy a declarar los datos


// menu principal

menu:  // etiqueta que marca donde empieza el menu
    // estas lineas guardan el texto del menu en memoria
    .ascii "\n================================\n"
    .ascii "      CALCULADORA ARM64\n"
    .ascii "================================\n"
    .ascii "1. Suma\n"
    .ascii "2. Resta\n"
    .ascii "3. Multiplicacion\n"
    .ascii "4. Division entera\n"
    .ascii "5. Potencia\n"
    .ascii "6. Factorial\n"
    .ascii "7. Salir\n\n"
    .ascii "Seleccione una opcion: "

menu_fin:

.equ menu_len, menu_fin - menu  // calcula cuantos bytes tiene el menu



// mensajes para pedir numeros

msg_numero1:
    .ascii "\nIngrese el primer numero: "

msg_numero1_fin:

.equ msg_numero1_len, msg_numero1_fin - msg_numero1


msg_numero2:
    .ascii "Ingrese el segundo numero: "

msg_numero2_fin:

.equ msg_numero2_len, msg_numero2_fin - msg_numero2



// mensaje del resultado

msg_resultado:
    .ascii "Resultado: "

msg_resultado_fin:

.equ msg_resultado_len, msg_resultado_fin - msg_resultado



// mensaje de error para division entre cero

msg_division_cero:
    .ascii "\nerror: no se puede dividir entre cero\n"

msg_division_cero_fin:

.equ msg_division_cero_len, msg_division_cero_fin - msg_division_cero





// salto de linea

salto_linea:
    .ascii "\n"

.equ salto_linea_len, 1



// mensajes temporales

msg_multiplicacion:
    .ascii "\nseleccionaste multiplicacion\n"

msg_multiplicacion_fin:

.equ msg_multiplicacion_len, msg_multiplicacion_fin - msg_multiplicacion


msg_division:
    .ascii "\nseleccionaste division entera\n"

msg_division_fin:

.equ msg_division_len, msg_division_fin - msg_division


msg_potencia:
    .ascii "\nseleccionaste potencia\n"

msg_potencia_fin:

.equ msg_potencia_len, msg_potencia_fin - msg_potencia


msg_factorial:
    .ascii "\nseleccionaste factorial\n"

msg_factorial_fin:

.equ msg_factorial_len, msg_factorial_fin - msg_factorial



// mensajes de control

msg_invalida:
    .ascii "\nopcion invalida, intente nuevamente\n"

msg_invalida_fin:

.equ msg_invalida_len, msg_invalida_fin - msg_invalida


msg_salir:
    .ascii "\nsaliendo de la calculadora...\n"

msg_salir_fin:

.equ msg_salir_len, msg_salir_fin - msg_salir




// mensaje para pedir la base

msg_base:
    .ascii "\nIngrese la base: "

msg_base_fin:

.equ msg_base_len, msg_base_fin - msg_base


// mensaje para pedir el exponente

msg_exponente:
    .ascii "Ingrese el exponente: "

msg_exponente_fin:

.equ msg_exponente_len, msg_exponente_fin - msg_exponente


// mensaje para pedir el numero del factorial

msg_factorial_numero:
    .ascii "\nIngrese el numero: "

msg_factorial_numero_fin:

.equ msg_factorial_numero_len, msg_factorial_numero_fin - msg_factorial_numero


// error cuando el exponente es negativo

msg_exponente_negativo:
    .ascii "\nerror: el exponente no puede ser negativo\n"

msg_exponente_negativo_fin:

.equ msg_exponente_negativo_len, msg_exponente_negativo_fin - msg_exponente_negativo


// error cuando el factorial recibe un numero negativo

msg_factorial_negativo:
    .ascii "\nerror: el factorial no acepta numeros negativos\n"

msg_factorial_negativo_fin:

.equ msg_factorial_negativo_len, msg_factorial_negativo_fin - msg_factorial_negativo




.section .bss  // aqui reservo memoria que usare durante el programa


buffer_opcion:
    .skip 16  // guarda la opcion del menu


buffer_numero:
    .skip 64  // guarda el numero escrito por el usuario


buffer_salida:
    .skip 32  // guarda temporalmente el numero convertido a texto



.section .text  // aqui van las instrucciones que ejecuta el cpu

.global _start  // hace visible la etiqueta _start para el linker



// inicio del programa

_start:

    b mostrar_menu  // empieza mostrando el menu



// mostrar y leer el menu

mostrar_menu:

    // imprimir el menu

    adr x1, menu
    mov x2, #menu_len
    bl imprimir_texto


    // leer la opcion del usuario

    mov x0, #0              // x0 = 0 significa entrada por teclado
    adr x1, buffer_opcion   // aqui se guarda lo que escriba el usuario
    mov x2, #16             // permite leer hasta 16 bytes
    mov x8, #63             // x8 = 63 indica que vamos a usar read
    svc #0                  // lee desde el teclado


    // verificar que solamente escribio un numero y enter

    cmp x0, #2              // debe recibir un caracter y el enter
    b.ne opcion_invalida    // si recibe mas o menos es invalido


    // cargar lo que escribio

    adr x1, buffer_opcion
    ldrb w2, [x1]           // guarda el primer caracter
    ldrb w3, [x1, #1]       // guarda el segundo caracter


    // verificar que el segundo caracter sea enter

    cmp w3, #10             // ascii 10 significa salto de linea
    b.ne opcion_invalida


    // convertir ascii a numero

    sub w2, w2, #48         // convierte el caracter a numero


    // revisar que opcion selecciono

    cmp w2, #1
    b.eq opcion_suma

    cmp w2, #2
    b.eq opcion_resta

    cmp w2, #3
    b.eq opcion_multiplicacion

    cmp w2, #4
    b.eq opcion_division

    cmp w2, #5
    b.eq opcion_potencia

    cmp w2, #6
    b.eq opcion_factorial

    cmp w2, #7
    b.eq salir


    // si no coincide con ninguna opcion

    b opcion_invalida



// suma

opcion_suma:

    // pedir el primer numero

    adr x1, msg_numero1
    mov x2, #msg_numero1_len
    bl imprimir_texto

    bl leer_entero          // lee el numero y lo devuelve en x0

    mov x19, x0             // guardar el primer numero en x19


    // pedir el segundo numero

    adr x1, msg_numero2
    mov x2, #msg_numero2_len
    bl imprimir_texto

    bl leer_entero          // lee el segundo numero

    mov x20, x0             // guardar el segundo numero en x20


    // hacer la suma

    add x21, x19, x20       // suma los dos numeros


    // mostrar la palabra resultado

    adr x1, msg_resultado
    mov x2, #msg_resultado_len
    bl imprimir_texto


    // mostrar el numero obtenido

    mov x0, x21             // colocar el resultado en x0
    bl imprimir_entero      // convertir e imprimir el resultado


    // imprimir un salto de linea

    adr x1, salto_linea
    mov x2, #salto_linea_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu



// resta

opcion_resta:

    // pedir el primer numero

    adr x1, msg_numero1
    mov x2, #msg_numero1_len
    bl imprimir_texto

    bl leer_entero

    mov x19, x0             // guardar el primer numero


    // pedir el segundo numero

    adr x1, msg_numero2
    mov x2, #msg_numero2_len
    bl imprimir_texto

    bl leer_entero

    mov x20, x0             // guardar el segundo numero


    // hacer la resta

    sub x21, x19, x20       // resta el segundo numero al primero


    // mostrar la palabra resultado

    adr x1, msg_resultado
    mov x2, #msg_resultado_len
    bl imprimir_texto


    // mostrar el resultado

    mov x0, x21
    bl imprimir_entero


    // imprimir salto de linea

    adr x1, salto_linea
    mov x2, #salto_linea_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu



// multiplicacion

opcion_multiplicacion:

    // pedir el primer numero

    adr x1, msg_numero1
    mov x2, #msg_numero1_len
    bl imprimir_texto

    bl leer_entero          // lee el primer numero

    mov x19, x0             // guarda el primer numero


    // pedir el segundo numero

    adr x1, msg_numero2
    mov x2, #msg_numero2_len
    bl imprimir_texto

    bl leer_entero          // lee el segundo numero

    mov x20, x0             // guarda el segundo numero


    // hacer la multiplicacion

    mul x21, x19, x20       // multiplica los dos numeros


    // mostrar la palabra resultado

    adr x1, msg_resultado
    mov x2, #msg_resultado_len
    bl imprimir_texto


    // mostrar el resultado

    mov x0, x21             // coloca el resultado en x0
    bl imprimir_entero      // imprime el resultado


    // imprimir salto de linea

    adr x1, salto_linea
    mov x2, #salto_linea_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu



// division entera

opcion_division:

    // pedir el primer numero

    adr x1, msg_numero1
    mov x2, #msg_numero1_len
    bl imprimir_texto

    bl leer_entero          // lee el primer numero

    mov x19, x0             // guarda el dividendo


    // pedir el segundo numero

    adr x1, msg_numero2
    mov x2, #msg_numero2_len
    bl imprimir_texto

    bl leer_entero          // lee el segundo numero

    mov x20, x0             // guarda el divisor


    // revisar que el divisor no sea cero

    cmp x20, #0             // compara el divisor con cero
    b.eq error_division     // si es cero muestra un error


    // hacer la division entera

    sdiv x21, x19, x20      // divide x19 entre x20


    // mostrar la palabra resultado

    adr x1, msg_resultado
    mov x2, #msg_resultado_len
    bl imprimir_texto


    // mostrar el resultado

    mov x0, x21
    bl imprimir_entero


    // imprimir salto de linea

    adr x1, salto_linea
    mov x2, #salto_linea_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu


// error de division

error_division:

    // mostrar mensaje de division entre cero

    adr x1, msg_division_cero
    mov x2, #msg_division_cero_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu




// potencia

opcion_potencia:

    // pedir la base

    adr x1, msg_base
    mov x2, #msg_base_len
    bl imprimir_texto

    bl leer_entero          // lee la base

    mov x19, x0             // guarda la base


    // pedir el exponente

    adr x1, msg_exponente
    mov x2, #msg_exponente_len
    bl imprimir_texto

    bl leer_entero          // lee el exponente

    mov x20, x0             // guarda el exponente


    // revisar que el exponente no sea negativo

    cmp x20, #0             // compara el exponente con cero
    b.lt error_exponente    // si es menor que cero muestra error


    // preparar la potencia

    mov x21, #1             // empieza el resultado en 1
    mov x22, x20            // x22 sera el contador


ciclo_potencia:

    // revisar si ya terminamos

    cmp x22, #0             // revisa si el contador llego a cero
    b.eq potencia_lista     // si llego a cero termina el ciclo


    // multiplicar una vez mas por la base

    mul x21, x21, x19       // resultado = resultado * base


    // disminuir el contador

    sub x22, x22, #1        // resta 1 al contador


    // repetir el ciclo

    b ciclo_potencia



potencia_lista:

    // mostrar la palabra resultado

    adr x1, msg_resultado
    mov x2, #msg_resultado_len
    bl imprimir_texto


    // mostrar el resultado

    mov x0, x21
    bl imprimir_entero


    // imprimir salto de linea

    adr x1, salto_linea
    mov x2, #salto_linea_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu



error_exponente:

    // mostrar mensaje de error

    adr x1, msg_exponente_negativo
    mov x2, #msg_exponente_negativo_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu








// factorial

opcion_factorial:

    // pedir el numero

    adr x1, msg_factorial_numero
    mov x2, #msg_factorial_numero_len
    bl imprimir_texto

    bl leer_entero          // lee el numero

    mov x19, x0             // guarda el numero


    // revisar que no sea negativo

    cmp x19, #0
    b.lt error_factorial    // si es negativo muestra error


    // preparar el factorial

    mov x20, #1             // aqui se guarda el resultado
    mov x21, x19            // x21 sera el contador


ciclo_factorial:

    // revisar si terminamos

    cmp x21, #1             // compara el contador con 1
    b.le factorial_listo    // si es 1 o menor termina


    // multiplicar resultado por contador

    mul x20, x20, x21       // resultado = resultado * contador


    // disminuir contador

    sub x21, x21, #1        // contador = contador - 1


    // repetir

    b ciclo_factorial



factorial_listo:

    // mostrar la palabra resultado

    adr x1, msg_resultado
    mov x2, #msg_resultado_len
    bl imprimir_texto


    // mostrar el resultado

    mov x0, x20
    bl imprimir_entero


    // imprimir salto de linea

    adr x1, salto_linea
    mov x2, #salto_linea_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu



error_factorial:

    // mostrar mensaje de error

    adr x1, msg_factorial_negativo
    mov x2, #msg_factorial_negativo_len
    bl imprimir_texto


    // regresar al menu

    b mostrar_menu


    



// opcion invalida

opcion_invalida:

    adr x1, msg_invalida
    mov x2, #msg_invalida_len
    bl imprimir_texto

    b mostrar_menu



// subrutina para leer enteros

leer_entero:

    // leer lo que escribe el usuario

    mov x0, #0              // entrada desde teclado
    adr x1, buffer_numero   // aqui se guarda el texto ingresado
    mov x2, #64             // permite leer hasta 64 bytes
    mov x8, #63             // syscall read
    svc #0


    // preparar los registros para convertir ascii a numero

    adr x9, buffer_numero   // x9 apunta al inicio del texto
    mov x10, #0             // aqui se va formando el numero
    mov x11, #0             // posicion actual del caracter
    mov x12, #1             // guarda el signo del numero


    // revisar si el numero empieza con signo negativo

    ldrb w13, [x9]          // cargar el primer caracter
    cmp w13, #45            // ascii 45 es el signo -
    b.ne convertir_digitos  // si no es negativo empieza la conversion


    // marcar que el numero es negativo

    mov x12, #-1            // guardar signo negativo
    add x11, x11, #1        // saltar el caracter -



convertir_digitos:

    // cargar el caracter actual

    ldrb w13, [x9, x11]


    // revisar si llegamos al enter

    cmp w13, #10            // ascii 10 significa enter
    b.eq terminar_conversion


    // convertir caracter ascii a digito

    sub w13, w13, #48       // convierte por ejemplo '5' en 5


    // multiplicar el numero actual por 10

    mov x14, #10
    mul x10, x10, x14


    // convertir w13 a 64 bits

    uxtw x13, w13


    // agregar el nuevo digito

    add x10, x10, x13


    // avanzar al siguiente caracter

    add x11, x11, #1

    b convertir_digitos



terminar_conversion:

    // revisar si el numero era negativo

    cmp x12, #1
    b.eq numero_convertido


    // cambiar el numero a negativo

    neg x10, x10



numero_convertido:

    mov x0, x10             // devolver el numero usando x0

    ret



// subrutina para imprimir enteros

imprimir_entero:

    // guardar el numero que recibimos

    mov x9, x0


    // apuntar al final del buffer

    adr x10, buffer_salida
    add x10, x10, #32


    // x11 contara cuantos caracteres vamos guardando

    mov x11, #0


    // x12 indica si el numero era negativo

    mov x12, #0


    // revisar si el numero es negativo

    cmp x9, #0
    b.ge revisar_cero


    // recordar que era negativo

    mov x12, #1


    // convertirlo temporalmente a positivo

    neg x9, x9



revisar_cero:

    // caso especial cuando el resultado es cero

    cmp x9, #0
    b.ne convertir_salida


    // guardar el caracter 0

    sub x10, x10, #1
    mov w13, #48            // ascii 48 es el caracter 0
    strb w13, [x10]

    add x11, x11, #1

    b agregar_signo



convertir_salida:

    // dividir el numero entre 10

    mov x14, #10
    udiv x15, x9, x14


    // obtener el residuo de la division

    msub x16, x15, x14, x9


    // convertir el residuo a ascii

    add x16, x16, #48


    // guardar el caracter en el buffer

    sub x10, x10, #1
    strb w16, [x10]


    // aumentar la cantidad de caracteres

    add x11, x11, #1


    // continuar trabajando con el cociente

    mov x9, x15


    // repetir mientras aun queden digitos

    cmp x9, #0
    b.ne convertir_salida



agregar_signo:

    // revisar si el numero original era negativo

    cmp x12, #0
    b.eq escribir_numero


    // agregar el signo menos

    sub x10, x10, #1
    mov w13, #45            // ascii 45 es -
    strb w13, [x10]

    add x11, x11, #1



escribir_numero:

    // imprimir el numero convertido

    mov x0, #1              // salida por pantalla
    mov x1, x10             // direccion donde empieza el numero
    mov x2, x11             // cantidad de caracteres
    mov x8, #64             // syscall write
    svc #0

    ret



// subrutina para imprimir texto

imprimir_texto:

    mov x0, #1              // salida por pantalla
    mov x8, #64             // syscall write
    svc #0

    ret



// salir del programa

salir:

    // mostrar mensaje de salida

    adr x1, msg_salir
    mov x2, #msg_salir_len
    bl imprimir_texto


    // terminar el programa

    mov x0, #0              // codigo de salida correcto
    mov x8, #93             // syscall exit
    svc #0

