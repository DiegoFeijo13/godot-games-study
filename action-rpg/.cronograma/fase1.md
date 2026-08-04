# Action RPG 2D — Diário de Desenvolvimento

# Fase 1 — Fundação do Projeto

**Objetivo:** construir a arquitetura base.

## Checklist
- [x] Estrutura de pastas
- [x] Cena principal
- [x] Player
- [x] HUD mínima
- [x] GameManager
- [x] Troca de mapas
- [x] Convenções do projeto

### Conceitos
- Responsabilidade única
- Modularização
- Organização

### Erros comuns
- Managers demais
- Acoplamento excessivo

### Critério
Projeto organizado e jogável.

---

# Diário de Desenvolvimento - Fase 1

## Data: 13/06/2026

### Objetivo da sessão
- Estrutura base de pastas
- Cena principal
- Player

### O que foi feito
- Criado pastas para scripts globais, assets, player e scenes
- Criado main scene, por enquanto vazia
- Importado estrutura base de player do projeto libs

### Problemas encontrados
- Algumas adaptações necessárias no player, nada severo

### Próxima sessão
- Criar mapas, HUD e troca de cenas

## Data: 16/07/2026

### Objetivo da sessão
Criar mapas, HUD e troca de cenas

### O que foi feito
- Adicionado texturas pro mapa
- Criado tilemap, tileset e terrains
- Criado mapa inicial
- Adicionado texturas pro player
- Ajustado viewport para tamanho do mapa


### Próxima sessão
- Adicionar segundo mapa, criar transição e adicionar HUD

## Data: 21/07/2026

### Objetivo da sessão
Adicionar segundo mapa, criar transição e adicionar HUD

### O que foi feito
- Criado segundo mapa
- Adicionado transição entre mapas (hard loaded).
    - Transição acontece quando player sai da area da camera

### Problemas encontrados
- Bug quando player fica na posição onde a próxima área estará

### Hipóteses
- Tentar mover o player 8px na direção da transição pra evitar ficar na area

### Correção aplicada
- Aplicar na próxima sessão


### Próxima sessão
- Corrigir transição de câmera
- Adicionar HUD
- Adicionar GameManager e gerir load de mapas

## Data: 22/07/2026

### Objetivo da sessão
- Corrigir transição de câmera
- Adicionar HUD
- Adicionar GameManager e gerir load de mapas

### O que foi feito
- Corrigido transição de câmera. Aplicado area específica no player pra detectar as bordas do mapa e ajustado as áreas da camera pra que não se sobreponham durante a transição
- Adicionado GameManager com o player carregado em memória
- Adicionado LevelManager para gerenciar qual mapa está ativo e desabilitar os demais
- Adicionado HUD com corações representando hp

### Aprendizados
- Transição de camera pode ser feito com controle de area
- Mapas podem ser pré-carregados e ativados/desativados pelo manager ao invés de carregados por demanda

### Próxima sessão
Iniciar fase 2