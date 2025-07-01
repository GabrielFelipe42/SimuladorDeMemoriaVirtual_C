# Script PowerShell para automatizar os testes do simulador de memória virtual

$EXEC = ".\simula_memoria_virtual.exe"
$ARQUIVOS = @("referencias1.txt", "referencias2.txt", "referencias3.txt")
$QUADROS = 1..7
$OUTPUT = "resultados.txt"

# Limpa ou cria arquivo de resultados
"Resultados da simulacao:" | Out-File -FilePath $OUTPUT -Encoding UTF8
"==========================" | Out-File -FilePath $OUTPUT -Append -Encoding UTF8

Write-Host "Iniciando simulacoes..."

# Loop pelos arquivos
foreach ($ARQ in $ARQUIVOS) {
    Write-Host "Processando arquivo: $ARQ"
    
    "`nArquivo: $ARQ" | Out-File -FilePath $OUTPUT -Append -Encoding UTF8
    "--------------------------" | Out-File -FilePath $OUTPUT -Append -Encoding UTF8
    
    # Loop pelos números de quadros
    foreach ($QTD in $QUADROS) {
        Write-Host "  Testando com $QTD quadros..."
        
        $RESULT = Get-Content $ARQ | & $EXEC $QTD
        $RESULT | Out-File -FilePath $OUTPUT -Append -Encoding UTF8
    }
}

"`nConcluido! - Arquivo $OUTPUT" | Out-File -FilePath $OUTPUT -Append -Encoding UTF8
Write-Host "`nConcluido - Arquivo $OUTPUT"
