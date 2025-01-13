### Manual de Operaciones

### Report - Engine SMNYL

## Configuración de MongoDB

### Comandos de `mongosh`

1. **Conectar a MongoDB** :

   ```shell
        mongosh  
   ```
2. **Crear una base de datos** :

   ```shell
        use SMNY 
   ```
3. **Crear una Usuario dentro la base de datos** :

   ```shell
        db.createUser({user: "Nombre_usuario",pwd: "contraseña_usuario",roles: [ { role: "dbOwner", db: "SMNY" } ]});  
   ```

## Instalación de Dependencias

### En cualquier sistema operativo

1. **Instalar Node.js y npm** :

* 1.- Actualizar el sistema:

```shell
        sudo apt update && sudo apt upgrade -y
```

* 2.- Instalar curl si no está instalado:

```shell
        sudo apt install curl -y
```

* 3.- Instalar nvm (Node Version Manager):

```shell
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

* 4.- Cargar nvm en la sesión actual:

```shell
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

* 5.- Verificar la instalación de nvm:

```shell
        command -v nvm
```

* 6.- Instalar la última versión de Node.js:

```shell
        nvm install node
```

* 7.- Verificar la instalación de Node.js y npm:

```shell
        node -v
        npm -v
```

1. **Instalar dependencias del proyecto** :

   **npm** **install**

## Declaración de Librerías

```shell

┌──  crypto@1.0.1
├── dayjs@1.11.13
├── dotenv@16.4.7
├── jsonwebtoken@9.0.2
├── log4js@6.9.1
├── mongoose@8.9.2
├── mssql@11.0.1
├── node-cron@3.0.3
├── pm2@5.4.3
├── express@4.21.2
└── objects-to-csv@1.3.6
```

## Arquitectura del Proyecto

### Descripción

El proyecto está estructurado en módulos que se comunican entre sí para ejecutar procedimientos almacenados en una base de datos SQL, almacenar los resultados en MongoDB y generar reportes.

### Diagramas

#### Diagrama de Lógica

![Diagrama de Lógica](vscode-file://vscode-app/path/to/logic-diagram.png)

#### Diagrama de Despliegue

![Diagrama de Despliegue](vscode-file://vscode-app/path/to/deployment-diagram.png)

#### Diagrama de Clases

![Diagrama de Clases](vscode-file://vscode-app/path/to/class-diagram.png)

## Configuración del Archivo [.env](vscode-file://vscode-app/c:/Users/crist/AppData/Local/Programs/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html)

### Ejemplo de [.env](vscode-file://vscode-app/c:/Users/crist/AppData/Local/Programs/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html):

* El archivo .env debe tener todos estos datos ingresados antes de correr el servicio.

```env

    MONGO_URL=              ← Url conexión mongo-db
    MONGO_USER=             ← Usuario de mongo
    MONGO_PASS=             ← Contraseñan usuario mongo
    MONGO_DB_NAME=          ← Nombre de db
    PORT=                   ← Puerto de servidor
    SECRET_KEY=             ← Llave secreta token 
    TOKEN_EXPIRATION=       ← Duración de token
    ENCRYPTION_KEY=         ← Llave de encriptado (32 bytes preferencia)
    SQL_PASS=               ← Contraseña sql  
    SQL_IP=                 ← Ip sql
    SQL_PORT=               ← Puerto sql
    SQL_USER=               ← Usuario login sql
    SQL_DB=                 ← Base de datos sql
    EXECT_T=                ← Cron execución sp
 
```

## Sistema de Tokens

El sistema de tokens se utiliza para autenticar y autorizar las solicitudes a la API. Los tokens se generan y validan utilizando una clave secreta almacenada en el archivo [.env](vscode-file://vscode-app/c:/Users/crist/AppData/Local/Programs/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html).

## Comunicación entre Módulos

Los módulos se comunican entre sí mediante llamadas a funciones y eventos. Por ejemplo, el módulo `ExectSp` ejecuta un procedimiento almacenado y luego almacena los resultados en MongoDB utilizando el modelo `historicalModel`.

## Despliegue de la Aplicación

### Comandos para Correr la App

1. **Iniciar la aplicación** :

```shell
   pm2 start ecosystem.mjs
```

## Estructura de un Log y Cómo Leerlos

### Ejemplo de Log

**2024-12-26T18:55:55.148**                                                                      ← **timeStamp de sistema**
**INFO**                                                                                                       ← tipo de log
[**MongooDB.js:24**]                                                                                 ← archivo de procedencia de log
**2024-12-26T18:55:55.148**                                                                      ← utc-6 time stamp
 [**MONGO_CONNECTOR(INFO)**]: **Parámetros de conexión válidos**  ← [modulo(tipo log)]: evento

**2024-12-17T13:45:31.827** **INFO** [**MongooDB.js**:**24**] **null** [MONGO_CONNECTOR(**INFO**)]: Conexión exitosa a MongoDB

### Explicación

* **Timestamp** : Fecha y hora del evento.
* **Nivel de Log** : INFO, WARN, ERROR.
* **Archivo y Línea** : Archivo y línea donde se generó el log.
* **Mensaje** : Descripción del evento.

## Eventos Almacenados en MongoDB

### Ejemplo de Evento

**{**

**    **"reportid"**: **"12345"**,**

**    **"event"**: **"INFO"**,**

**    **"eventMsg"**: **"[EXTRACT-REPORT-DATA]: Reporte creado con éxito"**,**

**    **"eventDate"**: **"2024-12-17T14:54:27.575Z"

**}**

### Explicación

* **reportid** : ID del reporte asociado.
* **event** : Tipo de evento (INFO, WARN, ERROR).
* **eventMsg** : Mensaje descriptivo del evento.
* **eventDate** : Fecha y hora del evento.

## Manejo de Errores

### Pasos a Seguir en Caso de Error

1. **Revisar los logs** : Verifica los logs para identificar el error.
2. **Consultar la documentación** : Revisa esta documentación para posibles soluciones.
3. **Verificar la configuración** : Asegúrate de que la configuración en el archivo [.env](vscode-file://vscode-app/c:/Users/crist/AppData/Local/Programs/Microsoft%20VS%20Code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html) sea correcta.
4. **Reiniciar la aplicación** : Intenta reiniciar la aplicación.
5. **Contactar al soporte** : Si el problema persiste, contacta al equipo de soporte.

### Adicional

* **Monitoreo** : Implementa herramientas de monitoreo para detectar problemas en tiempo real.
* **Backups** : Realiza backups regulares de la base de datos para evitar pérdida de datos.

---

Esta documentación proporciona una guía completa para configurar, desplegar y mantener la aplicación, así como para manejar errores y entender la estructura de los logs y eventos almacenados en MongoDB
