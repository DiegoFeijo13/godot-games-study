# Action RPG 2D — Diário de Desenvolvimento

# Fase 3 — Combate

## Checklist
- [x] Ataque
- [x] Vida
- [x] Dano
- [x] Knockback
- [x] Morte

## Critério:
Combate agradável contra inimigos simples.

---

# Diário de Desenvolvimento - Fase 3

## Data: 10/08/2026

### Objetivo da sessão
- Implementar animações de movimentação e ataque

### O que foi feito
- Animações adicionadas
- Criado novo state attack
- Adicionado input handle na state machine
- Troca de state para attack ao capturar evento "action" pressed

### Problemas encontrados
- n/a

### Próxima sessão
- Criar Hit e Hurt boxes.
- Criar player inventory para armazenar equipamento e vida
- Determinar se arma está equipada antes de executar ataque

## Data: 17/08/2026

### Objetivo da sessão
- Criar Hit e Hurt boxes.
- Criar player inventory para armazenar equipamento e vida
- Determinar se arma está equipada antes de executar ataque

### O que foi feito
- Criado PlayerInventoryData pra armazenar os dados do player, como hp e max hp
- Adicionado novo estado Hurt ao player state machine
- Criado Hit e Hurt boxes
- State machine escuta o evento de player hurt para mudar o estado
- Adicionado inimigo básico para teste de hurt/hit boxes
- Sistema de hp integrado com hit box e hud

### Problemas encontrados
- Hurt State faz o player correr para uma direção oposta a esperada, muito rápido e pra muito longe. Knockback precisa ser ajustado de acordo

### Próxima sessão
- Corrigir knockback
- Inventário para arma
- Evento para equipar arma

## Data: 18/08/2026

### Objetivo da sessão
- Corrigir knockback
- Inventário para arma
- Evento para equipar arma

### O que foi feito
- Corrigido knockback
- Adicionado vetor de itens no inventário, com customização de item como recurso. Cada item informa qual estado do jogador ele ativa quando utilizado
- Criado espada e testado ação com espada equipada e não equipada, obtendo retorno esperado

### Problemas encontrados
- n/a

### Próxima sessão
- HurtBox para a espada
- Causar dano no inimigo

## Data: 20/08/2026

### Objetivo da sessão
- HurtBox para a espada
- Causar dano no inimigo
- Evento morte para player com zero hp 

### O que foi feito
- Adicionado hurtbox para espada
- Ajustado animações de ataque para mover colisão da espada de acordo
- Criado state death para quando player chega a zero hp
- Criano animação de morte
- State hurt muda para death quando chega a zero hp

### Problemas encontrados
- n/a

### Próxima sessão
- Iniciar fase 4