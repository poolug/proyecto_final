# Proyecto Final - Chanchito Sano
_Esta app, sirve para administrar, organizar, conocer y proyectar las finanzas del usuario final._

- Historias de Usuario\
https://trello.com/b/6e3gEZ6x/chanchito-sano

- Link al proyecto\
http://chanchito-sano.com/

## Usabilidad 👾

- Existen 2 usuarios, **Admin** y **Member**. Los Admin, pueden registrar, actualizar, eliminar e invitar a otro usuarios (Member). Mientras que el usuario **Member**, sólo puede ver información, proporcionada por el **Admin** que los invitó.
- Existe un (1) usuario **SuperUser**, es el administrador de la plataforma y tiene el poder absoluto de todos los registros de los **Admin** y **Member**.

Datos iniciales de prueba:
```
Usuarios Admin X = (1..2)
Correo: admin-X@email.com
Contraseña: 123456

Usuarios Member X = (1..12)
Correo: member-X@email.com
Contraseña: 123456
*Nota: los primeros 5 member, son invitados del admin-1 y los últimos 5 member, son invitados del admin-2

SuperUser
Correo: super@email.com
Contraseña: 123456
Link de acceso: http://chanchito-sano.com/admin/login
```

## Comenzando 🚀

_Estas instrucciones te permitirán obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo y pruebas._

### Pre-requisitos 📋

_Requisitos para instalar el software y como instalarlas_

Instalar ruby y rails (si es que no lo tiene)
```
ruby '2.6.6'
gem 'rails', '~> 5.2.6'
```
Otras gemas usadas en el proyecto
```
# autenticación para los usuarios
gem 'devise'

# gestor del "superusuario" de la app
gem 'activeadmin'

# bootstrap, jquery
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'

# formularios anidados
gem 'cocoon'

#autenticación con facebook
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

# envío de correos
gem 'sendgrid-ruby'

# graficar modelos
gem 'rails-erd'
```
**NOTA**: El proyecto usa un gemset, para garantizar que al entrar al proyecto, esté usando la versión de ruby on rails correctas. Este gemset está en el archivo *app/.rvmrc*\
![image](https://user-images.githubusercontent.com/83673595/160249970-41c054c7-8c40-47de-825b-c31780b47ed0.png)

Descargar ó clonar el proyecto.
- Clonar\
Desde tu terminal:
```
git@github.com:poolug/proyecto_final.git
```
- Descargar\
[https://github.com/poolug/proyecto_final/archive/refs/heads/main.zip](https://github.com/poolug/proyecto_final/archive/refs/heads/main.zip)

### Instalación y setup 🔧
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
  password: tu_contraseña # debes colocar tu contraseña de postgresql
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
## Agradecimientos 🎁

* Sixto Guerra - Docente Academia Desafío Latam
* Fabian Pino - Ayudante en Academia Desafío Latam
* Alex Pérez - Docente en Academia Desafío Latam
* Pablo Infanta - Ayudante en Academia Desafío Latam
* Mirson Camadro - Ayudante en Academia Desafío Latam
---
⌨️ con ❤️ por [Paul Uzcategui](https://github.com/poolug) 😊
