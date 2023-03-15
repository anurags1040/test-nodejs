
FROM node:14


WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

ENV PORT=3000
ENV API_HOST=http://api:4000

EXPOSE 3000

CMD [ "npm", "start" ]