; Programa que calcula la raíz cuadrada entera de un número del 0 al 99 usando sumas sucesivas

	.org 0000h

start: 
	ld b, 49	; Cargar el número en B (puedes cambiarlo por cualquier número entre 0 y 99)
	ld c, 0		; C será el acumulador de sumas (equivalente a A * A)
	ld a, b 	; A será la raíz cuadrada candidata y B es el valor que se suma sucesivamente (1, 3, 5, 7, ...)

	cp 0
	jr Z, ultimo
	cp 1
	jr Z, ultimo
;Aquí se verifica si el número es 0 o 1. En esos casos, la raíz cuadrada ya es conocida:
;Si el número es 0, salta a la etiqueta ultimo y se detiene el programa.
;Si el número es 1, también salta a ultimo.

	ld d,1
	ld e,1
;Se cargan los valores 1 en los registros D y E. Estos registros probablemente se usan para controlar la iteración del ciclo.

ciclo primcipal:
	ld a,b
	cp d
	jr c, ultimo_1
	inc e
	ld h,0
	ld l,0
;El código compara el valor de B con D, que es el valor sucesivo que se va sumando (1, 3, 5, 7, ...).
;Si B es menor que D, se salta a la etiqueta ultimo_1, lo que indica que se ha encontrado la raíz cuadrada entera.
;Si no, el programa incrementa E, que representa la raíz cuadrada candidata, y reinicia los registros H y L para realizar una multiplicación posterior.

multiplicacion:
	ld a,l
	add a,e
	ld l,a
	inc h
	ld a,e
	cp h
	jr nz, multiplicacion
	ld d,l
	jr ciclo
;La multiplicación mediante sumas sucesivas. El valor en E (el candidato a la raíz cuadrada) se suma sucesivamente hasta que se haya realizado el cuadrado.
;Después de completar la multiplicación, el resultado se almacena en D, y el programa vuelve al ciclo para continuar con el cálculo.

ultimo:
	ld c,a
	halt

ultimo_1:
	dec e
	ld c,e
	halt
;Si se llega a ultimo, el valor de la raíz cuadrada se coloca en C y el programa se detiene.
;Si se llega a ultimo_1, se decrementa E (el candidato) porque ha sobrepasado el valor de la raíz cuadrada, y el valor correcto se guarda en C.

	.end
	