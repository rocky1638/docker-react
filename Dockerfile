# first build stage
FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build

# copy build folder over onto fresh nginx image
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
