# Action RPG 2D — Diário de Desenvolvimento

# Fase 4 — IA

## Checklist
- [x] Patrulha
- [x] Perseguição
- [x] Ataque
- [x] Retorno
- [x] Três tipos de inimigo
- [x] Reposicionamento de inimigos ao mudar de mapa

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

## Data: 28/08/2026

### Objetivo da sessão
- Criar inimigo que persegue jogador

### O que foi feito
- Criado moblin, que persegue o jogador quando entra na sua área de visão. Desiste da perseguição quando sai da área.

### Problemas encontrados
- Moblin pode ficar nas estremidades do mapa quando jogador foge para outro mapa, impedindo assim a volta. Necessário sistema de reposicionamento de inimigos quando mudar de mapas.

### Próxima sessão
- Criar Keese e Stalfos

## Data: 06/09/2026

### Objetivo da sessão
- Criar Keese e Stalfos

### O que foi feito
- Criado Keese e Stalfos

### Problemas encontrados
- n/a

### Próxima sessão
- Armazenar posições de inimigos e reposicioná-los ao recarregar mapa

## Data: 07/09/2026

### Objetivo da sessão
- Resetar inimigos ao trocar de mapa

### O que foi feito
- Remake do load de mapas com movimento de camera. Agora apenas o mapa atual fica carregado em memória, e o mapa anterior é descarregado ao fim do movimento de câmera na transição.

### Problemas encontrados
- n/a

### Próxima sessão
- Iniciar fase 5