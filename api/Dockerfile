FROM node:14


ENV PORT=3000 \
    DB=$DB_NAME \
    DBUSER=$DB_USER \
    DBPASS=$DB_PASSWORD \
    DBHOST=$DB_HOST \
    DBPORT=3306


WORKDIR /app


COPY ./package.json ./
RUN npm install


COPY . .


EXPOSE 3000
CMD [ "npm", "start" ]
