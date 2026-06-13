#!/bin/bash

# Diretórios
PDF_DIR="./pdfs"
MD_DIR="./markdown"
RESUMOS_DIR="./resumos"

# Cria pastas se não existirem
mkdir -p "$MD_DIR" "$RESUMOS_DIR"

# Instalar dependências (se não tiver)
sudo apt update
sudo apt install -y poppler-utils pandoc

# Remove arquivos antigos de resumos individuais
rm -f "$RESUMOS_DIR"/*_abstract.md
rm -f "$RESUMOS_DIR"/resumos_completos.md

echo "=========================================="
echo "📄 Convertendo PDFs para Markdown (leve e sequencial)"
echo "=========================================="

total=$(ls -1 "$PDF_DIR"/*.pdf 2>/dev/null | wc -l)
if [ "$total" -eq 0 ]; then
    echo "❌ Nenhum PDF encontrado em $PDF_DIR"
    exit 1
fi
echo "Total de PDFs: $total"

count=0
for pdf in "$PDF_DIR"/*.pdf; do
    [ ! -f "$pdf" ] && continue
    count=$((count+1))
    nome=$(basename "$pdf" .pdf)
    echo "[$count/$total] Processando: $nome"

    # 1. Converte PDF completo para Markdown (texto puro via pandoc)
    pdftotext -layout "$pdf" - 2>/dev/null | \
        pandoc -f markdown -t markdown > "$MD_DIR/${nome}.md"
    echo "   ✅ Markdown completo salvo em $MD_DIR/${nome}.md"

    # 2. Extrai abstract (primeiras 5 páginas, procura padrão)
    abstract=$(pdftotext -f 1 -l 5 "$pdf" - 2>/dev/null | \
        awk '/^[Aa]bstract/ {flag=1} flag {print} /^[0-9]+\./ {if(flag) exit}' | head -30)

    if [ -z "$abstract" ]; then
        abstract=$(pdftotext -f 1 -l 5 "$pdf" - 2>/dev/null | \
            grep -A 20 -i "^abstract" | head -25)
    fi

    if [ -z "$abstract" ]; then
        abstract="**[Abstract não encontrado no PDF]**"
    fi

    # 3. Salva abstract individual
    abstract_file="$RESUMOS_DIR/${nome}_abstract.md"
    cat > "$abstract_file" <<EOF
# Abstract do artigo: $nome

**Arquivo original:** `$nome.pdf`

## Abstract

$abstract

---
*Extraído em $(date '+%Y-%m-%d %H:%M:%S')*
EOF
    echo "   📝 Abstract individual salvo em $abstract_file"

    # 4. Acrescenta ao consolidado
    cat >> "$RESUMOS_DIR/resumos_completos.md" <<EOF
## $count. $nome

**Arquivo:** `$nome.pdf`

**Abstract:**
$abstract

---

EOF

done

echo "=========================================="
echo "🎉 Concluído! Processados $count artigos."
echo "📁 Markdown completos:   $MD_DIR"
echo "📄 Abstracts individuais: $RESUMOS_DIR/*_abstract.md"
echo "📚 Resumo consolidado:    $RESUMOS_DIR/resumos_completos.md"
echo "=========================================="
