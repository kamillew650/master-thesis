FROM node:16.17-alpine

WORKDIR /usr/app

COPY package.json ./

RUN yarn install

COPY . .

EXPOSE 4000

CMD ["node", "index.js"]