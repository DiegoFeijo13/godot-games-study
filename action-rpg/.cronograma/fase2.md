# Action RPG 2D — Diário de Desenvolvimento

# Fase 2 — Mundo dividido em áreas

**Objetivo:** criar um mundo composto por mapas pequenos.

## Checklist:
- [x] Área inicial
- [x] Segunda área
- [ ] Portais
- [ ] Spawn points
- [x] Limites da câmera

## Critério
Jogador navega entre áreas.

---

# Diário de Desenvolvimento - Fase 2

## Data: 03/08/2026

### Objetivo da sessão
- Criar mapas até a primeira dungeon

### O que foi feito
- Adicionados 5 mapas que fecham o caminho até a primeira dungeon

### Problemas encontrados
- n/a

### Próxima sessão
- Primeiros mapas da dungeon 1
- Teleport entre áreas

## Data: 04/08/2026

### Objetivo da sessão
- Primeiros mapas da dungeon 1
- Teleport entre áreas

### O que foi feito
- Três salas da dungeon 1
- Teleport entre overworld e dungeon

### Problemas encontrados
- Sistema de controle de mapas não está preparado para iniciar a cena com o player em uma posição diferente da inicial
- O mesmo para a camera

### Próxima sessão
- Corrigir level manager e camera

## Data: 06/08/2026

### Objetivo da sessão
- Corrigir level manager e camera

### O que foi feito
- Adicionado player manager para gerenciar instância de player e eventos de modificação de posicionamento global e nodos pais
- Modificado eventos para disparar troca de posição de câmera ao carregar nova cena

### Problemas encontrados
- Posição da câmera não está funcionando corretamente

### Próxima sessão
- Modificar gerenciador de mapas para que carregue os mapas dinâmicamente conforme jogador se move, fazendo com que cada mapa seja sua própria cena, evitando assim modificar posição de câmera a cada transição de cena.

> Copie este bloco para cada sessão.
```
## Data: 03/08/2026

### Objetivo da sessão
- 

### O que foi feito
- 

### Problemas encontrados
- 

### Próxima sessão
- 
```