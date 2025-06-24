# Script PowerShell para automatizar os testes do simulador de memória virtual

# Configurações
$EXEC = ".\simula_memoria_virtual.exe"
$ARQUIVOS = @("referencias1.txt", "referencias2.txt", "referencias3.txt")
$QUADROS = 1..7
$OUTPUT = "resultados.txt"

# Limpa ou cria arquivo de resultados
"Resultados da simulação:" | Out-File -FilePath $OUTPUT -Encoding UTF8
"==========================" | Out-File -FilePath $OUTPUT -Append -Encoding UTF8

Write-Host "Iniciando simulações..."

# Loop pelos arquivos
foreach ($ARQ in $ARQUIVOS) {
    Write-Host "Processando arquivo: $ARQ"
    
    "`nArquivo: $ARQ" | Out-File -FilePath $OUTPUT -Append -Encoding UTF8
    "--------------------------" | Out-File -FilePath $OUTPUT -Append -Encoding UTF8
    
    # Loop pelos números de quadros
    foreach ($QTD in $QUADROS) {
        Write-Host "  Testando com $QTD quadros..."
        
        # Executa o simulador
        $RESULT = Get-Content $ARQ | & $EXEC $QTD
        $RESULT | Out-File -FilePath $OUTPUT -Append -Encoding UTF8
    }
}

"`nSimulações concluídas! Verifique o arquivo $OUTPUT" | Out-File -FilePath $OUTPUT -Append -Encoding UTF8
Write-Host "`nSimulações concluídas! Verifique o arquivo $OUTPUT"
