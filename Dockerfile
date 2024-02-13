# Stage 1: Build the application
FROM node: AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Stage 2: Create a smaller image for production
FROM node:alpine
WORKDIR /app
COPY --from=build /app/package*.json ./
COPY --from=build /app/dist ./dist
RUN npm ci --only=production
EXPOSE 3000
CMD ["node", "dist/main"]