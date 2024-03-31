FROM node:17-alpine AS base

USER root

FROM base AS deps
RUN apk add --no-cache libc6-compat

WORKDIR /FRONTEND
COPY package.json ./
RUN yarn install

FROM base AS builder
WORKDIR /FRONTEND
COPY --from=deps /FRONTEND/node_modules ./node_modules
COPY . .

RUN yarn run build


CMD ["yarn", "start"]