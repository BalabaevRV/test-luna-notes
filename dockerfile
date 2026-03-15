# Dockerfile
FROM node:24-alpine

WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package*.json ./
RUN npm install

# Копируем все файлы (включая .output)
COPY . .

# Проверяем что файл на месте
RUN ls -la .output/server/

# Открываем порт
EXPOSE 3000

# ПРОСТАЯ КОМАНДА - работает всегда
CMD node .output/server/index.mjs