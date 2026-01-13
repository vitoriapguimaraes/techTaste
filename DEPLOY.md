# Como Fazer Deploy no GitHub Pages

Este projeto está configurado para fazer deploy automático no GitHub Pages usando GitHub Actions.

## 🚀 Deploy Automático

Sempre que você fizer push para a branch `main`, o GitHub Actions irá:

1. Fazer build do projeto Flutter para web
2. Fazer deploy automático no GitHub Pages

## 📋 Passos para Configurar (Primeira Vez)

1. **Vá para as configurações do repositório no GitHub:**

   - Acesse: `https://github.com/vitoriapguimaraes/techTaste/settings/pages`

2. **Configure o GitHub Pages:**

   - Em "Source", selecione: **GitHub Actions**
   - (NÃO selecione "Deploy from a branch")

3. **Faça commit e push deste arquivo:**

   ```bash
   git add .github/workflows/deploy.yml
   git commit -m "Adiciona workflow de deploy automático"
   git push origin main
   ```

4. **Aguarde o deploy:**
   - Vá para a aba "Actions" do repositório
   - Aguarde o workflow completar (leva cerca de 2-3 minutos)
   - Seu app estará disponível em: `https://vitoriapguimaraes.github.io/techTaste/`

## 🔄 Próximos Deploys

Após a configuração inicial, qualquer push para `main` irá automaticamente fazer o deploy!

## 🛠️ Deploy Manual

Se quiser fazer deploy manualmente:

1. Vá para a aba "Actions" no GitHub
2. Selecione o workflow "Deploy Flutter Web to GitHub Pages"
3. Clique em "Run workflow"

## ❌ Solução de Problemas

Se o site ainda mostrar o README:

1. Verifique se o workflow completou com sucesso na aba "Actions"
2. Confirme que a configuração do Pages está em "GitHub Actions" (não "Deploy from a branch")
3. Aguarde alguns minutos para o cache do GitHub atualizar
