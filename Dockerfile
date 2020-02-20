FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# output is in /app/build

FROM nginx
EXPOSE 80 # let Elastic beanstalk know we want port 80 mapped
COPY --from=builder /app/build /usr/share/nginx/html
