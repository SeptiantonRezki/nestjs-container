FROM node:alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR /app
COPY . .
RUN npm i
RUN npm run start
