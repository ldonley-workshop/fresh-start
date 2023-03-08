FROM node:18-alpine as BUILDER
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=BUILDER /app/dist /usr/share/nginx/html
