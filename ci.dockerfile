FROM node:16-alpine

ARG PORT 3001
ARG HOST 0.0.0.0

ENV PORT=${PORT}
ENV HOST=${HOST}

WORKDIR /app

COPY . .

RUN npm install -g json-server

CMD ["./entrypoint.sh"]