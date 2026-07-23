# Action RPG 2D — Diário de Desenvolvimento

> Objetivo: aprender arquitetura, organização e desenvolvimento de um Action RPG de pequeno escopo.

## Cronograma

| Fase | Status | Iniciada em |Concluída em |
|---|---|---|---|
| 1. Fundação do Projeto | ⬜ | 13/06/2026 | 22/07/2026|
| 2. Mundo dividido em áreas | ⬜ | | |
| 3. Combate | ⬜ | | |
| 4. IA dos inimigos | ⬜ | | |
| 5. Loot e itens | ⬜ | | |
| 6. Inventário e equipamentos | ⬜ | | |
| 7. NPCs e diálogos | ⬜ | | |
| 8. Quests | ⬜ | | |
| 9. Save/Load | ⬜ | | |
|10. Progressão | ⬜ | | |
|11. Boss | ⬜ | | |
|12. Polimento | ⬜ | | |

---

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

# Fase 2 — Mundo dividido em áreas

**Objetivo:** criar um mundo composto por mapas pequenos.

## Checklist:
- [ ] Área inicial
- [ ] Segunda área
- [ ] Portais
- [ ] Spawn points
- [ ] Limites da câmera

## Critério
Jogador navega entre áreas.

---

# Fase 3 — Combate

## Checklist
- [ ] Ataque
- [ ] Vida
- [ ] Dano
- [ ] Knockback
- [ ] Morte

## Critério:
Combate agradável contra inimigos simples.

---

# Fase 4 — IA

## Checklist
- [ ] Patrulha
- [ ] Perseguição
- [ ] Ataque
- [ ] Retorno
- [ ] Três tipos de inimigo

## Critério
IA fluida e diversificada

---

# Fase 5 — Loot e Itens

## Checklist
- [ ] Drops
- [ ] Consumíveis
- [ ] Moedas

## Critério
Coletaveis e consumíveis estão presentes e dropam de inimigos/objetos.

---

# Fase 6 — Inventário e Equipamentos

## Checklist
- [ ] Inventário
- [ ] Equipamentos
- [ ] Atualização de atributos

## Critério
Inventário criado e é atualizado 

---

# Fase 7 — NPCs e Diálogos

## Checklist
- [ ] Interação
- [ ] Sistema de diálogo
- [ ] Escolhas simples

## Critério
Ao menos um NPC com diálogo e escolhas. Sistema de interação está presente.

---

# Fase 8 — Quests

## Checklist
- [ ] Aceitar missão
- [ ] Progresso
- [ ] Conclusão

---

# Fase 9 — Save / Load

- [ ] Salvar jogador
- [ ] Inventário
- [ ] Quests
- [ ] Área atual

---

# Fase 10 — Progressão

- [ ] XP
- [ ] Level
- [ ] Atributos

---

# Fase 11 — Boss

- [ ] Múltiplas fases
- [ ] Recompensa

---

# Fase 12 — Polimento

- [ ] Sons
- [ ] Partículas
- [ ] Menus
- [ ] Balanceamento

---

# Diário de Desenvolvimento

## Fase 1
<details>

<summary><b>Data:</b> 13/06/2026</summary>

#### Objetivo da sessão
- Estrutura base de pastas
- Cena principal
- Player

#### O que foi feito
- Criado pastas para scripts globais, assets, player e scenes
- Criado main scene, por enquanto vazia
- Importado estrutura base de player do projeto libs

#### Problemas encontrados
- Algumas adaptações necessárias no player, nada severo

#### Próxima sessão
- Criar mapas, HUD e troca de cenas

</details>

<details>
<summary><b>Data:</b> 16/07/2026</summary>

#### Objetivo da sessão
Criar mapas, HUD e troca de cenas

### O que foi feito
- Adicionado texturas pro mapa
- Criado tilemap, tileset e terrains
- Criado mapa inicial
- Adicionado texturas pro player
- Ajustado viewport para tamanho do mapa


### Próxima sessão
- Adicionar segundo mapa, criar transição e adicionar HUD
</details>

<details>
<summary><b>Data:</b>21/07/2026</summary>

#### Objetivo da sessão
Adicionar segundo mapa, criar transição e adicionar HUD

#### O que foi feito
- Criado segundo mapa
- Adicionado transição entre mapas (hard loaded).
    - Transição acontece quando player sai da area da camera

#### Problemas encontrados
- Bug quando player fica na posição onde a próxima área estará

#### Hipóteses
- Tentar mover o player 8px na direção da transição pra evitar ficar na area

#### Correção aplicada
- Aplicar na próxima sessão


#### Próxima sessão
- Corrigir transição de câmera
- Adicionar HUD
- Adicionar GameManager e gerir load de mapas
</details>

<details>
<summary><b>Data:</b>22/07/2026</summary>

#### Objetivo da sessão
- Corrigir transição de câmera
- Adicionar HUD
- Adicionar GameManager e gerir load de mapas

#### O que foi feito
- Corrigido transição de câmera. Aplicado area específica no player pra detectar as bordas do mapa e ajustado as áreas da camera pra que não se sobreponham durante a transição
- Adicionado GameManager com o player carregado em memória
- Adicionado LevelManager para gerenciar qual mapa está ativo e desabilitar os demais
- Adicionado HUD com corações representando hp

#### Aprendizados
- Transição de camera pode ser feito com controle de area
- Mapas podem ser pré-carregados e ativados/desativados pelo manager ao invés de carregados por demanda

#### Próxima sessão
Iniciar fase 2
</details>


> Copie este bloco para cada sessão.
```
<details>

<summary><b>Data:</b></summary>

#### Objetivo da sessão

#### O que foi feito


#### Problemas encontrados

#### Hipóteses

#### Correção aplicada

#### Aprendizados

#### Próxima sessão

</details>
```