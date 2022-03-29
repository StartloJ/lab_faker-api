# How to use JSON-SERVER to mock-up API application

We use nodeJS framework to create application mock-up with Json-server. Now, we're prepared json data.  

## Step to run this lab

1. In workspace, You should create `Dockerfile` with nodeJS.

```dockerfile
FROM node:16-alpine

ARG PORT 3001
ARG HOST 0.0.0.0

ENV PORT=${PORT}
ENV HOST=${HOST}

WORKDIR /app

COPY . .

RUN npm install -g json-server

CMD ["json-servr", "--host ${HOST}", "--port ${PORT}", "db.json"]
```

2. You can create `db.json` for handle api request and response them to source. You will create file from this structure.  

```json
{
    "<URL path>": {
        "key1": "value1",
        "key1": "value1",
        "key1": "value1",
        ...
    }
}
```

Example  

```json
{
    "profile": {
        "name": "typicode"
    },
    "hello": {
        "name": "kitty"
    }
}
```

3. Run mock-up application with docker command like this:  

```bash
docker build -t opsta/mockup:0.17-alpine .
docker run -it -d -p 3005:3005 opsta/mockup:0.17-alpine
```

4. If it work, it will return not empty json data.

```bash
$ curl http://localhost:3005/hello
{
  "name": "kitty"
}
$ curl -XGET http://127.0.0.1:3005/profile
{
  "name": "typicode"
}
```
