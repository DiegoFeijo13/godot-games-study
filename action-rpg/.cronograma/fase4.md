# Action RPG 2D — Diário de Desenvolvimento

# Fase 4 — IA

## Checklist
- [x] Patrulha
- [ ] Perseguição
- [x] Ataque
- [ ] Retorno
- [ ] Três tipos de inimigo

## Critério
IA fluida e diversificada

---

# Diário de Desenvolvimento - Fase 4

## Data: 20/08/2026

### Objetivo da sessão
- Criar classe base para inimigos
- Implementar movimento e ataque do octorock

### O que foi feito
- EnemyStateMachine
- EnemyStateIdle
- EnemyStateWander
- EnemyStateDestroy

### Problemas encontrados
- n/a

### Próxima sessão
- Implementar ataque do octorock

## Data: 24/08/2026

### Objetivo da sessão
- Generalizar Enemy e criar resource do Octorock
- Implementar ataque do Octorock

### O que foi feito
- Adicionado classe EnemyData para armazenar dados dos inimigos 
- Adaptado Enemy para ler de EnemyData
- Adicionado EnemyStateShoot para o Octorock
- Adicionado Bullet para ser disparada no estado shoot

### Problemas encontrados
- n/a

### Próxima sessão
- Criar inimigo que persegue jogador

> Template
```
## Data: 20/08/2026

### Objetivo da sessão
- 

### O que foi feito
- 

### Problemas encontrados
- 

### Próxima sessão
- 
```