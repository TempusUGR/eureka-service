# TempusUGR - Eureka Discovery Service

Este repositorio contiene el código fuente del `eureka-service`, el **Servidor de Descubrimiento de Servicios** para el proyecto **TempusUGR**.

Este microservicio es una pieza de infraestructura crítica en la arquitectura. Su única función es actuar como un **registro central** donde todos los demás microservicios (como `user-service`, `auth-service`, etc.) se registran al iniciarse y se localizan entre sí dinámicamente. Esto elimina la necesidad de hardcodear direcciones IP y puertos, permitiendo que la comunicación entre servicios sea flexible, escalable y resiliente.

---

## ✨ Funcionalidad Principal

* **Registro de Servicios (Service Registration)**: Cada microservicio cliente, al arrancar, envía una señal (heartbeat) a Eureka para registrar su nombre de aplicación, dirección IP y puerto.
* **Descubrimiento de Servicios (Service Discovery)**: Cuando un servicio necesita comunicarse con otro, consulta a Eureka por el nombre del servicio de destino para obtener una lista de las instancias disponibles y sus ubicaciones de red.
* **Monitorización de Estado**: Eureka espera heartbeats periódicos de cada servicio registrado. Si un servicio deja de enviar estos heartbeats, Eureka lo elimina del registro tras un tiempo de espera, asegurando que el listado de servicios activos sea siempre fiable.
* **Dashboard Web**: Eureka proporciona una interfaz web donde se pueden visualizar en tiempo real todas las instancias de servicios registradas, su estado actual y otros metadatos.

![Image](https://github.com/user-attachments/assets/ee832204-9fa6-4c5a-affa-66f74e272f88)

---

## 🛠️ Pila Tecnológica

* **Lenguaje/Framework**: Java 21, Spring Boot 3.4.4
* **Componente Principal**: **Spring Cloud Netflix Eureka Server**. Este proyecto es esencialmente una aplicación Spring Boot con la dependencia y la anotación `@EnableEurekaServer` para activar su funcionalidad como servidor de descubrimiento.

---

## 🏗️ Rol en la Arquitectura

El `eureka-service` es el corazón de la comunicación entre servicios. No tiene dependencias de otros microservicios de la aplicación y debe ser **el primer servicio en levantarse** en la secuencia de despliegue, ya que todos los demás dependen de él para poder registrarse y comunicarse.

---

## 🚀 Puesta en Marcha Local

### **Prerrequisitos**

* Java 21 o superior.
* Maven 3.x.

### **Configuración**

La configuración de un servidor Eureka es particular, ya que por defecto también intenta comportarse como un cliente. Es crucial desactivar este comportamiento en `src/main/resources/application.properties`:

```properties
# -- CONFIGURACIÓN DEL SERVIDOR --
# Puerto estándar para el servidor Eureka
server.port=8761

# -- CONFIGURACIÓN DE EUREKA SERVER --
# Desactivar el comportamiento de cliente: el servidor no debe intentar registrarse a sí mismo.
eureka.client.register-with-eureka=false
eureka.client.fetch-registry=false

# Opcional: URL del servicio para la interfaz web
eureka.instance.hostname=localhost
