Este proyecto está siendo desarrollado con la finalidad de controlar el nivel de agua y la temperatura de un termotanque solar.
El mismo consta de varias etapas:
*Desarrollo de aplicación móvil: Desarrollada con flutter, el usuario puede interactuar ya sea para saber el estado de los sensores, activar alarmas, prender y apagar 
relay, y otras aplicaciones.
*Desarrollo de placa arduino: Esta etapa es para controlar el termotanque mediante wifi, para eso utilice un esp8266 y lo codifique para conectarse a una red wifi y que 
se conecte a Firebase donde guardara datos que luego tomara la aplicación móvil.
También maneja las entradas salidas del sensor de nivel y temperatura, además de los relay y otras opciones.
*Desarrollo de Firebase: Se crea una base de datos para guardar los usuarios, y una base de datos en tiempo real para leer el estado de los sensores y relay.
Prácticamente se hace una triangulación entre la palca Arduino y la aparición móvil mediante Firebase.
*Desarrollo de Hardware: Por último en altium se desarrolla una pcb para incorporar el sistema completo y poder comercializarlo, esto implica placa Arduino, relay, entrada de sensores, conexión a red, y otros componentes para el funcionamiento.
