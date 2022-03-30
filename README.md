# How to use JSON-SERVER to mock-up API application

We use nodeJS framework to create application mock-up with Json-server. Now, we're prepared json data.  

## Step to run this lab

1. In workspace, You should create `Dockerfile` with nodeJS.

   ```dockerfile
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
   docker build -t mockuopsta/mockup-api:v0.1-alpine .
   docker run -it -d -p 3000:3000 mockuopsta/mockup-api:v0.1-alpine
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

## How to deploy to Kubernetes

1. Change image to your image or use my default.

    ```yaml
    image:
      repository: <CHANGE TO YOUR IMAGE>
      tag: <CHANGE IN YOUR TAG>
    ```

2. Change json-server configuration in buttom of `values.yaml` file. It will replace to default configuration file in container image. For variables such as db and routes, you should insert with json structure text like an example.

    ```yaml
    mock-config:
      enabled: <true OR false>
      db: ""
      routes: ""
    ```

    Example

    ```yaml
    mock-config:
      enabled: true
      db: |
        {
            "posts": [
                {
                    "id": 1,
                    "title": "json-server",
                    "author": "typicode"
                }
            ],
            "comments": [
                {
                    "id": 1,
                    "body": "some comment",
                    "postId": 1
                }
            ],
            "profile": {
                "name": "typicode"
            },
            "hello": {
                "name": "kitty"
            }
        }
      routes: |
        {
          "/api/*": "/$1",
          "/:resource/:id/show": "/:resource/:id",
          "/posts/:category": "/posts?category=:category",
          "/articles\\?id=:id": "/posts/:id"
        }
    ```

3. Other configuration, you can read standard document for more details.
