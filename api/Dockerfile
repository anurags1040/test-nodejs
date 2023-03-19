FROM node:14

COPY ./bin /app/bin
COPY ./app.js /app/
COPY ./package.json /app/
WORKDIR /app
RUN npm install

EXPOSE 8080
ENV PORT=8080
ENV DB=peak-apparatus-379619:us-central1:private-instance-7124d943=tcp:3306

HEALTHCHECK --interval=10s --timeout=3s \
    CMD curl -f -s http://localhost:8080/api/status

ENTRYPOINT ["npm", "start"]