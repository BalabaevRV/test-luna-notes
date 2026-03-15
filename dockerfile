# Dockerfile
# Этап сборки
FROM node:18-alpine AS builder

WORKDIR /app

# Копируем файлы зависимостей
COPY package*.json ./
COPY yarn.lock* ./
COPY pnpm-lock.yaml* ./

# Устанавливаем зависимости
RUN npm ci || npm install

# Копируем исходный код
COPY . .

# Собираем приложение
RUN npm run build

# Этап production
FROM node:18-alpine

WORKDIR /app

# Копируем собранное приложение из этапа builder
COPY --from=builder /app/.output /app/.output
COPY --from=builder /app/package.json /app/package.json

# Устанавливаем production зависимости
RUN npm ci --only=production || npm install --production

# Создаем пользователя без root прав
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs

# Порт на котором работает приложение
EXPOSE 3000

# Запускаем приложение
CMD ["node", ".output/server/index.mjs"]