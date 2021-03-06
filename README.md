# Proyecto Final - Chanchito Sano
_Esta app, sirve para administrar, organizar, conocer y proyectar las finanzas del usuario final._

- Historias de Usuario\
https://trello.com/b/6e3gEZ6x/chanchito-sano

- Link al proyecto\
https://chanchito-sano.com/

## Usabilidad 馃懢

- Existen 2 usuarios, **Admin** y **Member**. Los Admin, pueden registrar, actualizar, eliminar e invitar a otro usuarios (Member). Mientras que el usuario **Member**, s贸lo puede ver informaci贸n, proporcionada por el **Admin** que los invit贸.
- Existe un (1) usuario **SuperUser**, es el administrador de la plataforma y tiene el poder absoluto de todos los registros de los **Admin** y **Member**.

Datos iniciales de prueba:
```
Usuarios Admin X = (1..2)
Correo: admin-X@email.com
Contrase帽a: 123456

Usuarios Member X = (1..12)
Correo: member-X@email.com
Contrase帽a: 123456
*Nota: los primeros 5 member, son invitados del admin-1 y los 煤ltimos 5 member, son invitados del admin-2

SuperUser
Correo: super@email.com
Contrase帽a: 123456
Link de acceso: http://chanchito-sano.com/admin/login
```

## Comenzando 馃殌

_Estas instrucciones te permitir谩n obtener una copia del proyecto en funcionamiento en tu m谩quina local para prop贸sitos de desarrollo y pruebas._

### Pre-requisitos 馃搵

_Requisitos para instalar el software y como instalarlas_

Instalar ruby y rails (si es que no lo tiene)
```
ruby '2.6.6'
gem 'rails', '~> 5.2.6'
```
Otras gemas usadas en el proyecto
```
# autenticaci贸n para los usuarios
gem 'devise'

# gestor del "superusuario" de la app
gem 'activeadmin'

# bootstrap, jquery
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'

# formularios anidados
gem 'cocoon'

#autenticaci贸n con facebook
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'omniauth'

# ocultar credenciales
gem 'figaro'

# Amazon S3
gem "aws-sdk-s3", "~> 1.111"

# graficar
gem 'chartkick'
gem "groupdate"

# env铆o de correos
gem 'sendgrid-ruby'

# graficar modelos
gem 'rails-erd'
```
**NOTA**: El proyecto usa un gemset, para garantizar que al entrar al proyecto, est茅 usando la versi贸n de ruby on rails correctas. Este gemset est谩 en el archivo *app/.rvmrc*\
![image](https://user-images.githubusercontent.com/83673595/160249970-41c054c7-8c40-47de-825b-c31780b47ed0.png)

Descargar 贸 clonar el proyecto.
- Clonar\
Desde tu terminal:
```
git@github.com:poolug/proyecto_final.git
```
- Descargar\
[https://github.com/poolug/proyecto_final/archive/refs/heads/main.zip](https://github.com/poolug/proyecto_final/archive/refs/heads/main.zip)

### Instalaci贸n y setup 馃敡
Entrar a la carpeta del proyecto y desde tu terminal, ejecutar:
```
bundle i
```
Instalar dependencias, desde tu terminal, ejecutar:
```
yarn add highcharts
```
Abrir el archivo en app/config/database.yml y colocar las credenciales de postgresql, de tu equipo.
```
default: &default
  adapter: postgresql
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000
  username: tu_usuario # debes colocar tu usuario de postgresql
  password: tu_contrase帽a # debes colocar tu contrase帽a de postgresql
```
Crear base de datos, ejecutar migraciones, cargar datos de pruebas.
```
rails db:create
rails db:migrate
rails db:seed
```
Configurar variables de entorno con Figaro, para uso de AWS, en app/config/application.yml
```
# amazon
access_key_id: "tu_acces_key_id"
secret_access_key: "tu_secret_acces_key"
region: "tu_region_aws"
bucket: "nombre_de_tu_bucket"
```
Luego en app/config/storage.yml
```
amazon:
  service: S3
  access_key_id: <%= Figaro.env.access_key_id %>
  secret_access_key: <%= Figaro.env.secret_access_key %>
  region: <%= Figaro.env.region %>
  bucket: <%= Figaro.env.bucket %>
```
## Agradecimientos 馃巵

* Sixto Guerra - Docente Academia Desaf铆o Latam
* Fabian Pino - Ayudante en Academia Desaf铆o Latam
* Alex P茅rez - Docente en Academia Desaf铆o Latam
* Pablo Infanta - Ayudante en Academia Desaf铆o Latam
* Mirson Camadro - Ayudante en Academia Desaf铆o Latam
---
鈱笍 con 鉂わ笍 por [Paul Uzcategui](https://github.com/poolug) 馃槉
