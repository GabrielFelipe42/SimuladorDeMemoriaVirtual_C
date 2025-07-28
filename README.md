SIMULADOR DE MEMÓRIA VIRTUAL - DOCUMENTAÇÃO DO CÓDIGO FONTE

==============================================================================
1. VISÃO GERAL
==============================================================================

O programa simula_memoria_virtual.c implementa um simulador dos três principais 
algoritmos de substituição de páginas utilizados no gerenciamento de memória 
virtual: FIFO (First In, First Out), LRU (Least Recently Used) e OPT 
(Algoritmo Ótimo). O simulador permite comparar a eficiência destes algoritmos 
através da contagem de page faults gerados para diferentes configurações de 
memória.

==============================================================================
2. ESTRUTURA DO CÓDIGO
==============================================================================

2.1 Bibliotecas e Definições
-----------------------------
#include <stdio.h>
#include <stdlib.h>
#define MAX_REFS 100000

- stdio.h: Funções de entrada/saída (scanf, printf, fprintf)
- stdlib.h: Funções utilitárias (atoi)
- MAX_REFS: Limite máximo de referências que podem ser processadas

2.2 Função Principal (main)
---------------------------
A função main realiza:
1. Validação de argumentos: Verifica se o número de quadros foi fornecido
2. Leitura de entrada: Le as referências de páginas da entrada padrão (stdin)
3. Execução dos algoritmos: Chama as três funções de simulação
4. Exibição de resultados: Apresenta os page faults de cada algoritmo formatados

==============================================================================
3. IMPLEMENTAÇÃO DOS ALGORITMOS
==============================================================================

3.1 Algoritmo FIFO (First In, First Out)
----------------------------------------
int simula_fifo(int frames, int* refs, int n_refs)

Princípio: Remove a página mais antiga na memória quando necessário substituir.

Estruturas de dados:
- memoria[frames]: Array representando os quadros de memória
- pos: Índice circular para controle da ordem de inserção

Funcionamento:
1. Inicializa todos os quadros com -1 (vazio)
2. Para cada referência:
   - Verifica se a página já está na memória
   - Se não estiver: substitui a página na posição pos e incrementa page_faults
   - Atualiza pos de forma circular: pos = (pos + 1) % frames

Complexidade: O(n_refs × frames) para verificação de presença na memória

3.2 Algoritmo LRU (Least Recently Used)
---------------------------------------
int simula_lru(int frames, int* refs, int n_refs)

Princípio: Remove a página menos recentemente utilizada quando necessário 
substituir.

Estruturas de dados:
- memoria[frames]: Array dos quadros de memória
- ultima_vez[frames]: Array que armazena o timestamp do último acesso de cada quadro

Funcionamento:
1. Inicializa memória e timestamps com -1
2. Para cada referência:
   - Se a página está na memória: atualiza seu timestamp
   - Se não está: encontra o quadro com menor timestamp (LRU) e o substitui
   - Incrementa page_faults quando há substituição

Complexidade: O(n_refs × frames) para busca e determinação do LRU

3.3 Algoritmo OPT (Ótimo)
-------------------------
int simula_opt(int frames, int* refs, int n_refs)

Princípio: Remove a página que será referenciada mais distante no futuro 
(ou nunca mais).

Estruturas de dados:
- memoria[frames]: Array dos quadros de memória
- distancia: Posição da próxima ocorrência de cada página

Funcionamento:
1. Para cada referência que causa page fault:
   - Examina cada página na memória
   - Procura a próxima ocorrência de cada página nas referências futuras
   - Se uma página nunca mais será usada: a escolhe imediatamente
   - Caso contrário: escolhe a página com maior distância futura

Complexidade: O(n_refs × frames × n_refs) devido à busca futura para cada página

==============================================================================
4. ANÁLISE COMPARATIVA DOS ALGORITMOS
==============================================================================

4.1 FIFO
--------
- Vantagens: Simples implementação, baixo overhead
- Desvantagens: Não considera frequência de uso, pode apresentar anomalia de Belady
- Uso recomendado: Sistemas com restrições de memória e processamento

4.2 LRU
-------
- Vantagens: Boa aproximação do comportamento ideal, considera localidade temporal
- Desvantagens: Overhead para manter timestamps
- Uso recomendado: Sistemas com boa localidade temporal de referência

4.3 OPT
-------
- Vantagens: Teoricamente ótimo, menor número de page faults possível
- Desvantagens: Impraticável (requer conhecimento do futuro)
- Uso recomendado: Apenas para comparação e análise teórica

==============================================================================
5. FORMATO DE ENTRADA E SAÍDA
==============================================================================

5.1 Entrada
-----------
- Linha de comando: ./programa <numero_quadros>
- Stdin: Uma referência de página por linha (números inteiros)

5.2 Saída
---------
    X quadros, Y refs: FIFO: Z PFs, LRU: W PFs, OPT: V PFs

Onde:
- X = número de quadros de memória
- Y = total de referências processadas  
- Z, W, V = page faults para FIFO, LRU e OPT respectivamente

==============================================================================
6. CASOS DE TESTE E VALIDAÇÃO
==============================================================================

O programa foi testado com três cenários distintos:

1. referencias1.txt (24 refs): Padrão pequeno e variado
2. referencias2.txt (30 refs): Padrão médio com características mistas
3. referencias3.txt (10.000 refs): Padrão sequencial cíclico (0-19 repetido)

6.1 Resultados Destacados
--------------------------
Com o padrão sequencial cíclico, observou-se que:
- FIFO e LRU apresentaram performance crítica (quase 100% de page faults)
- OPT demonstrou superioridade significativa mesmo em condições adversas
- A escolha do algoritmo é fortemente dependente do padrão de acesso

==============================================================================
7. EXEMPLOS DE EXECUÇÃO
==============================================================================

Compilação:
gcc simula_memoria_virtual.c -o simula_memoria_virtual

Execução (Linux/Unix):
./simula_memoria_virtual 4 < referencias.txt

Execução (Windows PowerShell):
Get-Content referencias.txt | .\simula_memoria_virtual.exe 4

Exemplo de saída:
    4 quadros,      24 refs: FIFO:    12 PFs, LRU:    11 PFs, OPT:     9 PFs

==============================================================================
8. RESULTADOS EXPERIMENTAIS
==============================================================================

8.1 Referencias1.txt (24 referências)
-------------------------------------
Quadros | FIFO | LRU | OPT
--------|------|-----|----
   1    |  20  | 20  | 20
   2    |  17  | 17  | 15
   3    |  15  | 14  | 11
   4    |  12  | 11  |  9
   5    |  10  |  9  |  8
   6    |   8  |  8  |  8
   7    |   8  |  8  |  8

8.2 Referencias3.txt (10.000 referências - padrão cíclico)
----------------------------------------------------------
Quadros | FIFO  | LRU   | OPT
--------|-------|-------|-------
   1    | 10000 | 10000 | 10000
   2    | 10000 | 10000 |  9474
   3    | 10000 | 10000 |  8948
   4    | 10000 | 10000 |  8422
   5    | 10000 | 10000 |  7896
   6    | 10000 | 10000 |  7370
   7    | 10000 | 10000 |  6845

==============================================================================
9. CONCLUSÕES TÉCNICAS
==============================================================================

O simulador demonstra que:

1. Não existe algoritmo universalmente superior - a eficiência depende do workload
2. Padrões sequenciais podem ser problemáticos para FIFO e LRU com memória limitada
3. OPT serve como baseline teórico para avaliar algoritmos práticos
4. A quantidade de memória influencia dramaticamente a performance de todos os algoritmos
5. O padrão de acesso às páginas é um fator crítico na escolha do algoritmo

==============================================================================
10. CARACTERÍSTICAS TÉCNICAS DA IMPLEMENTAÇÃO
==============================================================================

- Linguagem: C (padrão ANSI C)
- Compilador testado: GCC 14.2.0
- Plataformas: Windows (MSYS2/MinGW), Linux, macOS
- Memória: Suporte até 100.000 referências
- Entrada: Leitura via stdin (redirecionamento de arquivo)
- Saída: Formato padronizado com alinhamento de colunas
- Validação: Verificação de argumentos de linha de comando

==============================================================================

Trabalho desenvolvido para a disciplina de Sistemas Operacionais
Implementação de algoritmos de substituição de páginas em memória virtual
