FROM node:latest as buildstage

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine as stage-of-production

COPY --from=buildstage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
