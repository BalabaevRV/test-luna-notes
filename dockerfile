# Dockerfile
FROM node:24-alpine as builder

WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./
RUN npm ci

# Копируем исходники и собираем
COPY . .
RUN npm run build

# Этап 2: Финальный образ
FROM node:24-alpine

WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Копируем собранное приложение из этапа builder
COPY --from=builder /app/.output /app/.output

# Устанавливаем только production зависимости (с использованием package-lock.json)
RUN npm ci --omit=dev

# Создаем непривилегированного пользователя
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chown -R nodejs:nodejs /app

USER nodejs

EXPOSE 3000

CMD ["node", ".output/server/index.mjs"]