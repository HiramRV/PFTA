##-------------------------------------------------
# Taller de Assembler
# Steven Rubio 15044 // Ricardo Rivera // Michelle Morales
# Base de datos disponibilidad Edificio A
#--------------------------------------------------

 .text
 .align 2
 .global main
main:

	#-----------
	#Direccion de pantalla
	#----------
	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]

	#-------------------------
	#get GPIO address
	#-------------------------
	bl GetGpioAddress
	#-------------------------

	#-----------------
	#Preparamos lectura de puertos
	#----------------
	
	@lectura en el puerto 27
	mov r0,#27
	mov r1,#0
	bl SetGpioFunction
	
	@lectura en el puerto 17
	mov r0,#17
	mov r1,#0
	bl SetGpioFunction
	#---------------------------------------------#
	@escritura en el puerto 5
	mov r0,#5
	mov r1,#1
	bl SetGpioFunction
	
	@escritura en el puerto 6
	mov r0,#6
	mov r1,#1
	bl SetGpioFunction
	
	@escritura en el puerto 13
	mov r0,#13
	mov r1,#1
	bl SetGpioFunction
	
	@escritura en el puerto 19
	mov r0,#19
	mov r1,#1
	bl SetGpioFunction

	@escritura en el puerto 26
	mov r0,#26
	mov r1,#1
	bl SetGpioFunction
	
	@escritura en el puerto 12
	mov r0,#12
	mov r1,#1
	bl SetGpioFunction
	
	@escritura en el puerto 16
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction
	
	@escritura en el puerto 20
	mov r0,#20
	mov r1,#1
	bl SetGpioFunction
	
	@escritura en el puerto 21
	mov r0,#21
	mov r1,#1
	bl SetGpioFunction

loop:
	#----------------Verificacion de botones------------------------#
	@@ lectura push button1
	mov r0,#27
	bl GetGpio
	mov r5,r0

	teq r5,#0
	@Si se presiona el boton verifica que opcion esta cambiando
	bne aBoton1
	
	@@ lectura push button1
	mov r0,#17
	bl GetGpio
	mov r5,r0

	teq r5,#0
	@Si se presiona el boton verifica que opcion esta cambiando
	bne aBoton2
	
	bl Interfaz
	
	b loop
		
		
/*SUBRUTINAS*/


/******************************************
#Subrutina fin:
#	se sale del programa
******************************************/	
fin:
	bl FFin
	mov r7,#1
	swi 

/******************************************
#Subrutina aBoton1:
#	verifica que accion realiza el usuario
******************************************/	
aBoton1:
	ldr r2,=boton2
	ldr r2,[r2]
	cmp r2,#0
	beq DiaS
	cmp r2,#1
	beq PisoS
	cmp r2,#2
	beq BuscarS

/******************************************
#Subrutina aBoton2:
#	verifica que accion realiza el usuario
******************************************/	
aBoton2:
	ldr r1,=boton2
	ldr r2,[r1]
	add r2,r2,#1
	cmp r2,#2
	b s2
	str r2,[r1]
	b loop
s2:
	mov r2,#0
	str r2,[r1]
	bl BuscarS
	
	
******************************************
#Subrutina DiaS:
#	Selecciona y valida el DIA seleccionado por el usuario
**********************************************************/	
DiaS:
	ldr r1,=dia
	ldr r2,[r1]
	add r2,r2,#1
	cmp r2,#2
	movgt r2,#0
	str r2,[r1]
	b loop

/******************************************
#Subrutina PisoS:
#	Selecciona y valida el piso seleccionado por el usuario
***********************************************************/	
PisoS:
	ldr r1,=piso
	ldr r2,[r1]
	add r2,r2,#1
	cmp r2,#4
	movgt r2,#0
	str r2,[r1]
	b loop
	
/******************************************
#Subrutina HorarioS:
#	Selecciona y valida el piso seleccionado por el usuario
***********************************************************/	
HorarioS:
	ldr r1,=horario
	ldr r2,[r1]
	add r2,r2,#1
	cmp r2,#4
	movgt r2,#15
	str r2,[r1]
	b loop

/******************************************
#Subrutina BuscarS:
#	Busca los salones disponibles para el usuario
#Parametros:
#	R0: Dia seleccionado (int entre 1 y 5)
#	R1: Piso seleccionado (int entre 1 y 3)
#	R2: Horario seleccionado (int entre 1 y 18)
#Retorna:
#	Impresión en pantalla de los salones disponibles
***********************************************************/
BuscarS:



/************************************************************************
#Subrutina Interfaz:
#	Imprime la interzas con el usuario
#	Verifica el estado del día, mes y horario seleccionado para imprimirlo
**************************************************************************/


.data
.balign 4
/*****Mouse************/
boton1:	.word 0 @Boton de seleccion
boton2:	.word 0 @Boton de movimiento 

dia:		.word 0
piso:		.word 0
horario:	.word 0
/*************Salones***********/
.global salon1
salon1:	.word 0 @Disponibilidad del salon 1
.global salon2
salon2:	.word 0 @Disponibilidad del salon 2
.global salon3
salon3:	.word 0 @Disponibilidad del salon 3
.global salon4
salon4:	.word 0 @Disponibilidad del salon 4
.global salon5
salon5:	.word 0 @Disponibilidad del salon 5
.global salon6
salon6:	.word 0 @Disponibilidad del salon 6
.global salon7
salon7:	.word 0 @Disponibilidad del salon 7
.global salon8
salon8:	.word 0 @Disponibilidad del salon 8
.global salon9
salon9:	.word 0 @Disponibilidad del salon 9