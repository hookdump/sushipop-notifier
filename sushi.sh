#!/bin/bash

codigo=$1
tel=$2
ultimoEstado="0"

function actualizar {
	params="code=$codigo&tel=$tel"
	respuesta=`curl -s -X POST --data "$params" http://www.sushi-pop.com.ar/inc/_estados.jx.php`
	estado=`expr "$respuesta" : '.*\([0-6]\)\.jpg'`
	
	estados[0]="-"
	estados[1]="Confirmando..."
	estados[2]="Confirmado!"
	estados[3]="En elaboracion"
	estados[4]="En viaje"
	estados[5]="-"
	estados[6]="Entregado"

	if [[ $estado != $ultimoEstado ]]; then
		# nuevo estado!
		ultimoEstado=$estado
		descEstado="${estados[$estado]}"
		terminal-notifier -message "Sushi Status" -title "$descEstado"
	fi
}

while :
do
	actualizar
	sleep 20
done
