# ZERO — Agente Autónomo de Ciberseguridad Ofensiva

```
 ███████╗███████╗██████╗  ██████╗ 
 ╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
   ███╔╝ █████╗  ██████╔╝██║   ██║
  ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
 ███████╗███████╗██║  ██║╚██████╔╝
 ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ 
 [ Autonomous Offensive Security Agent ]
```

ZERO es un skill de ciberseguridad ofensiva diseñado para operar como agente autónomo sobre cualquier sistema Linux. Combina pensamiento lateral, una base de 753 skills especializados, gestión inteligente de herramientas con auditoría de código, y memoria persistente que evoluciona con cada operación.

> **⚠️ Disclaimer:** Esta herramienta está diseñada exclusivamente para uso en entornos autorizados (CTFs, laboratorios, pentesting con permiso). El uso no autorizado contra sistemas de terceros es ilegal.

---

## Qué es

Un prompt-skill que convierte a un LLM con acceso a terminal (Claude Code, Cursor, Codex CLI, etc.) en un operador de ciberseguridad autónomo capaz de:

- **Resolver CTFs** — enumerar, explotar, escalar, capturar flags
- **Auditar sistemas** — identificar vulnerabilidades en infraestructura y aplicaciones
- **Pentesting** — reconocimiento, explotación, post-explotación, pivoting
- **Análisis forense** — memoria, disco, red, malware
- **Red teaming** — evasión, persistencia, movimiento lateral

---

## Instalación

```bash
# 1. Clonar este repositorio
git clone https://github.com/<tu-usuario>/zero.git
cd zero

# 2. Inicializar la base de skills (submodule)
git submodule init
git submodule update

# 3. Crear los archivos de memoria sensible (excluidos del repo)
cp memory/credentials.md.template memory/credentials.md
cp memory/operations.md.template memory/operations.md
cp memory/tools-audited.md.template memory/tools-audited.md

# 4. (Opcional) Instalar jq para búsqueda en skills
sudo apt install jq
```

## Requisitos

| Componente | Requerido | Notas |
|:-----------|:---------:|:------|
| **Sistema operativo** | Linux (cualquier distro) | Debian, Ubuntu, Kali, Parrot, Arch, etc. |
| **LLM con terminal** | Sí | Claude Code, Cursor, Windsurf, Codex CLI, o cualquier agente con shell access |
| **jq** | Recomendado | Para buscar en el índice de skills (`apt install jq`) |
| **git** | Recomendado | Para actualizar la base de skills |
| **Python 3** | Recomendado | Para scripts a medida y scripts de los skills |

> **No se requiere ninguna herramienta ofensiva preinstalada.** ZERO detecta qué hay disponible, construye lo que falta, y descarga lo que necesita (auditándolo antes).

---

## Estructura del directorio

```
zero/
├── SKILL.md                              # Prompt principal del agente
├── README.md                             # Este archivo
├── references/
│   └── lateral_thinking.md               # 4 técnicas de pensamiento lateral
├── memory/                               # Memoria persistente (evoluciona)
│   ├── operations.md                     # Flags, shells, escalaciones logradas
│   ├── techniques.md                     # Técnicas exitosas documentadas
│   ├── tools-audited.md                  # Herramientas externas auditadas
│   ├── credentials.md                    # Credenciales descubiertas (⚠️ sensible)
│   └── lessons-learned.md               # Errores y cómo evitarlos
└── Anthropic-Cybersecurity-Skills/       # 753 skills especializados
    ├── index.json                        # Índice searchable con tags
    ├── mappings/                         # MITRE ATT&CK + NIST CSF mappings
    └── skills/                           # 753 directorios con SKILL.md + scripts
        ├── performing-memory-forensics-with-volatility3/
        ├── exploiting-sql-injection-with-sqlmap/
        ├── analyzing-cobalt-strike-beacon-configuration/
        └── ... (750 más)
```

---

## Cómo usarlo

### 1. Invocación directa

Copiá o referenciá el archivo `SKILL.md` como system prompt o skill de tu agente LLM. El método exacto depende de la plataforma:

**Claude Code:**
```bash
# Desde el directorio zero/
claude --skill ./SKILL.md
```

**Cursor / Windsurf / Cline:**
- Agregar `SKILL.md` como archivo de contexto o custom instruction
- O colocar el directorio `zero/` dentro de `.cursor/skills/` o equivalente

**Agente custom (LangChain, CrewAI, etc.):**
```python
with open("zero/SKILL.md") as f:
    system_prompt = f.read()
# Usar como system message del agente
```

### 2. Ejemplo de uso — CTF

```
Tú:     "Target: 10.10.10.40. Resolvé esta máquina."

ZERO:   [Reconoce el entorno operativo]
        [Lee memoria de operaciones previas]
        [Ejecuta nmap contra el target]
        [Aplica patrón ReAct sobre los resultados]
        [Busca skills relevantes según servicios encontrados]
        [Explota la vulnerabilidad — ruta obvia]
        [Si falla → pensamiento lateral, cambia encoding, chaining]
        [Escala privilegios]
        [Captura flag]
        [Guarda en memory/operations.md]
```

### 3. Ejemplo de uso — Auditoría web

```
Tú:     "Auditá la aplicación web en https://target.com"

ZERO:   [Fingerprint del sistema]
        [Busca skills: web-application-security, api-security]
        [Reconocimiento: gobuster, nikto, whatweb]
        [Analiza con patrón ReAct]
        [Prueba OWASP Top 10]
        [Si WAF detectado → técnicas de bypass de lateral_thinking.md]
        [Crea scripts a medida si necesita tooling específico]
        [Reporta hallazgos]
        [Guarda técnicas exitosas en memory/techniques.md]
```

---

## Flujo operativo

```
INICIO DE OPERACIÓN
│
├─→ Reconocer entorno (OS, herramientas instaladas, interfaces de red)
│
├─→ Leer memoria — ¿operaciones similares previas? ¿técnicas reutilizables?
│
├─→ Reconocimiento activo del target
│
├─→ Análisis con patrón ReAct
│     ├── Enfoque obvio (ruta estándar de explotación)
│     └── Enfoque lateral (vulnerability chaining, WAF bypass, timing)
│
├─→ Consultar skills relevantes (753 disponibles, búsqueda por tags)
│
├─→ ¿Necesito herramientas?
│     ├── Instalada en el sistema → usar
│     ├── Script en un skill → usar
│     ├── Crear a medida → Python/Bash en /tmp/zero-tools/
│     └── Descargar de repo → AUDITAR CÓDIGO PRIMERO
│
├─→ Ejecutar ataque → si falla → cambiar enfoque → persistir
│
├─→ Post-explotación / Escalación / Pivoting
│
├─→ Reportar resultado
│
└─→ GUARDAR EN MEMORIA todo lo significativo
```

---

## Componentes clave

### Pensamiento lateral (`references/lateral_thinking.md`)

Cuatro técnicas obligatorias que ZERO aplica cuando la ruta obvia falla:

1. **Vulnerability Chaining** — combinar fallas de bajo impacto para lograr ataque crítico
2. **Business Logic Flaws** — atacar la lógica de negocio, no solo inyecciones técnicas
3. **Persistencia Ciega** — asumir WAF/filtro y cambiar encoding/técnica
4. **Timing Analysis** — explotar diferencias en tiempo de respuesta (Blind SQLi, Command Injection)

### Base de Skills (753 skills)

Cada skill contiene:
- `SKILL.md` — workflow paso a paso con prerequisitos y validación
- `scripts/` — scripts Python listos para usar
- `references/` — estándares NIST, MITRE ATT&CK, workflows técnicos

**Buscar skills por tag:**
```bash
cat Anthropic-Cybersecurity-Skills/index.json | jq '.skills[] | select(.tags[] | contains("sqli"))' 
```

**Buscar por subdominio:**
```bash
cat Anthropic-Cybersecurity-Skills/index.json | jq '.skills[] | select(.subdomain == "penetration-testing")'
```

**Listar todos los subdominios:**
```bash
cat Anthropic-Cybersecurity-Skills/index.json | jq '.subdomain_stats | keys[]'
```

### Auditoría de código externo

Antes de ejecutar cualquier herramienta descargada, ZERO busca automáticamente:
- Reverse shells ocultas
- Exfiltración de datos del sistema
- Código ofuscado (base64, eval, chr encoding)
- Persistencia no deseada (crontab, bashrc, authorized_keys)

### Memoria persistente (`memory/`)

| Archivo | Qué almacena | Cuándo se escribe |
|:--------|:-------------|:------------------|
| `operations.md` | Flags, shells, escalaciones | Al completar un objetivo |
| `techniques.md` | Técnicas que funcionaron | Al descubrir algo reutilizable |
| `tools-audited.md` | Tools externas verificadas | Al aprobar una auditoría de código |
| `credentials.md` | Passwords, hashes, tokens | Al descubrir credenciales |
| `lessons-learned.md` | Errores y rabbit holes | Al perder tiempo en algo evitable |

La memoria persiste entre sesiones. Cada operación hace a ZERO más eficiente.

---

## Actualizar la base de skills

```bash
cd zero/Anthropic-Cybersecurity-Skills
git pull origin main
```

---

## Seguridad

- `memory/credentials.md` contiene datos sensibles — **no commitear a repos públicos**
- Agregar al `.gitignore`:
  ```
  zero/memory/credentials.md
  ```
- Los scripts creados en `/tmp/zero-tools/` se eliminan automáticamente al reiniciar el sistema
- La auditoría de código externo es **obligatoria** — ZERO no ejecuta código descargado sin revisarlo

---

## Atribución y créditos

| Componente | Autor | Licencia | Enlace |
|:-----------|:------|:---------|:-------|
| **ZERO** (SKILL.md, memoria, flujo) | [@gonzalmeida](https://github.com/gonzalmeida) | MIT | Este repositorio |
| **Anthropic Cybersecurity Skills** (753 skills) | [@mukul975](https://github.com/mukul975) | Apache 2.0 | [Repo original](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) |
| **Pensamiento Lateral** (references/) | Creación propia | MIT | Este repositorio |

> La base de 753 skills de ciberseguridad se incluye como **git submodule** apuntando al repositorio original de mukul975. No se modifica ni se redistribuye su contenido — se referencia tal cual. Toda la atribución y licencia Apache 2.0 del proyecto original se mantiene intacta.

## Licencia

Este proyecto (SKILL.md, sistema de memoria, flujo operativo, lateral_thinking.md) se distribuye bajo **MIT License**.

La base de skills `Anthropic-Cybersecurity-Skills/` mantiene su licencia original **Apache 2.0** — ver [su LICENSE](https://github.com/mukul975/Anthropic-Cybersecurity-Skills/blob/main/LICENSE).

---

> *"No soy un chatbot. Soy el proceso con PID en tu kernel que piensa como atacante."*
