# Estágio 1: Build da Aplicação
FROM node:20-alpine AS builder

WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./
COPY tsconfig*.json ./

# Instalar TODAS as dependências (incluindo devDependencies para build)
RUN npm ci

# Copiar código fonte
COPY src/ ./src/

# O Typescript precisa de um arquivo de config existente para o build
# Vamos copiar o example apenas pra agradar o compilador no build em produção
COPY src/config.example.ts ./src/config.ts

# Compilar Typescript
RUN npm run build

# ==========================================

# Estágio 2: Imagem Limpa de Produção
FROM node:20-alpine AS runner

WORKDIR /app

# Colocando Node in Production environment (otimiza dependências do Express, etc)
ENV NODE_ENV=production

# Copiar apenas os manifestos base novamente
COPY package*.json ./

# Instalar APENAS dependências vitais de Produção (ignorando Jest, Typercript docs...) - Imagem fica leve
RUN npm ci --only=production

# Copiar apenas a posta de código compilado de verdade (Javascript sujo e puro, performático)
COPY --from=builder /app/dist ./dist

# EXPOSE documentation
EXPOSE 443 80

# Comando para rodar a aplicação direta (como definido no seu package.json)
CMD ["npm", "run", "start:direct"]
