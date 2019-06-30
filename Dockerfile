# first build stage
FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build

# copy build folder over onto fresh nginx image
FROM nginx
EXPOSE 80 # for aws to know which port to forward through
COPY --from=builder /app/build /usr/share/nginx/html
