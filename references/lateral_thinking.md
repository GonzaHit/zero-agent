# Pensamiento Lateral en Ciberseguridad

## 1. Encadenamiento de Vulnerabilidades (Vulnerability Chaining)
Un escaneo estándar es muy lineal: escanea, encuentra un puerto, busca un exploit para ese puerto. Si no lo hay, asume que es seguro.
**El Enfoque Lateral:** Combina vulnerabilidades de bajo impacto para lograr un ataque crítico.
*Ejemplo:* Encuentras un *Path Traversal* que solo deja leer archivos inútiles (Low severiy). Luego encuentras un *File Upload* que no permite subir `.php`. Piensa: *"Voy a subir un archivo ZIP con un payload, y usaré el Path Traversal para que el servidor lo descomprima en otro directorio o lo interprete mediante envolturas de PHP (php://filter, phar://)"*.

## 2. Buscar fallas en la Lógica de Negocio (Business Logic Flaws)
Las herramientas automatizadas están hechas para buscar inyecciones SQL, XSS, o CVEs conocidos. No entienden de "dinero", "usuarios" o "carritos de compras".
**El Enfoque Lateral:** Analiza qué hace la aplicación. En un e-commerce, intenta comprar un artículo cambiando la cantidad a `-1` en la solicitud HTTP para ver si el servidor te *suma* dinero a tu saldo. Juega con los roles (IDOR). Modifica parámetros lógicos.

## 3. Persistencia Ciega (No te rindas fácilmente)
Si pruebas 3 payloads de SQLi y fallan, no concluyas inmediatamente que "el parámetro es seguro".
**El Enfoque Lateral:** Asume que hay un WAF (Firewall) o una sanitización parcial.
- Empieza a codificar en Base64.
- Usa URL Encode doble.
- Intercala comentarios en medio de las consultas SQL (`SEL/**/ECT`).
- Alterna mayúsculas y minúsculas.

## 4. La "Intuición" de los Tiempos de Respuesta
A veces una inyección no devuelve un error visible en el HTML, pero sí afecta el servidor.
**El Enfoque Lateral:** Fíjate en el tiempo que tarda el servidor en responder. Si pones una comilla simple (`'`) y la página web no da error, pero tarda 2 segundos más en cargar, podrías estar frente a un *Blind SQLi basado en tiempo* (Time-based Blind SQLi) o una *Command Injection ciega* (e.g. `ping -c 10 127.0.0.1`).

---
**Instrucción para el Agente:** Siempre que propongas el "Enfoque Lateral" en tu patrón ReAct, debes forzarte a proponer al menos una de estas 4 metodologías. No te limites al "happy path" de explotación.