# Cronograma de desenvolvimento do jogo Platformer

1. Fundação do Movimento
2. Game Feel e Polimento do Player
3. Interações com o Mundo
4. Câmera e Leitura de Jogo
5. Level Design (primeiros níveis)
6. Sistema de Iteração e Ferramentas
7. Polimento Final (juice + feedback)

## Sessão 1 (15/04/2026)- Fundação do Movimento

Objetivo:
    Criar um controller básico sólido:
    - andar
    - pular
    - gravidade consistente
    - colisão estável
Fiz:
    - Player com animação de parado e andando
    - anda para esquerda e direita
    - pulo
    - colisão com tilemaplayer
    - gravidade não tão consistente assim
Problema:
    - (fixed) player cai devagar se nenhuma tecla de direção é apertada e cai rápido quando tem input 
    - player não muda direção durante o pulo
    - player pula somente reto quando idle
Hipótese:
    - gravidade não está sendo calculada corretamente
    - talvez precise de um estado dedicado para "caindo"?
Fix:
    - input e fisica eram calculados no mesmo lugar.
    - não havia um estado dedicado pra jump.
    - fisica era calculada no state e no player, gerando inconsistência
    - separado logica de fisica e input para que input seja na classe do player e fisica em cada estado
---

## Sessão 2 (22/04/2026) - Game Feel e Polimento do Player
Objetivo:
    Transformar o movimento funcional em algo prazeroso.
    - Sensação de controle no ar
    - Timing do pulo
    - Responsividade vs realismo
Fiz:
    - ajuste de velocidade horizontal no ar com velocidade menor que no chão
    - coyote time
    - jump buffer
    - altura de pulo variável com botão pressionado
    - velocidade com aceleração, variáveis diferentes para ar e chão
Problema:
    - pulo não responsivo
    - movimento horizontal duro
Hipótese:
    - lógica de pulo e movimento estava espalhado entre os estados
    - estados responsáveis por setar velocidade
Fix:
    - estados agora indicam se player está no ar ou no chão e chamam função no player para atualizar a velocidade de acordo

---
## Sesãso 3 (25/04/2026) - Game Feel e Polimento do Player II
Objetivo:
    Implementar:
    - gravidade subida
    - gravidade descida (mais forte)
    Ajustar:
    - aceleração chão
    - aceleração ar
    - desaceleração
    - gravidade
Fiz:
    - multiplicador de gravidades por estado do pulo (subindo apertando botão, subindo e soltar botão, caindo)
    - ajustei valores para aceleração e gravidade para melhorar o feel
    - adicionei camera que segue o player e ajusta seus limites conforme o uso de tiles no mapa
Problema:
    - player cai muito rápido
Hipótese:
    - sem cap na velocidade de queda
Fix:
    - implementei velocidade máxima de queda e o cap em todos os estados

---
Template
Objetivo:
Fiz:
Problema:
Hipótese:
Fix:
