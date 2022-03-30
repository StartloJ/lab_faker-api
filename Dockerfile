FROM node:16-alpine

ARG PORT
ARG HOST

ENV PORT=${PORT:-3001}
ENV HOST=${HOST:-0.0.0.0}

RUN npm install -g json-server

COPY entrypoint.sh /

COPY *.json /app/

RUN chown 1000:1000 -R /app

USER 1000

CMD ["/entrypoint.sh"]