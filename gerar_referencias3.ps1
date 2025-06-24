# Script PowerShell para gerar referencias3.txt com 10.000 acessos
# 500 ciclos de páginas 0 a 19

Write-Host "Gerando referencias3.txt com 10.000 referências..."

# Limpa ou cria o arquivo
"" | Out-File -FilePath "referencias3.txt" -Encoding UTF8

# Gera o padrão: 500 ciclos de 0 a 19
for ($i = 1; $i -le 500; $i++) {
    for ($j = 0; $j -le 19; $j++) {
        $j | Out-File -FilePath "referencias3.txt" -Append -Encoding UTF8
    }
    
    # Mostra progresso a cada 100 ciclos
    if ($i % 100 -eq 0) {
        Write-Host "Progresso: $i/500 ciclos completados"
    }
}

Write-Host "referencias3.txt gerado com 10.000 referências (500 ciclos de 0-19)."
Write-Host "Arquivo pronto para uso nos testes!"
