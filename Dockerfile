# there is no "as builder" because AWS will fail
# due to this. We have to use --from=0 in next step.
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <--- Build output directory inside container
# second FROM statement tells to terminate previous successive block.
FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html

# Default command of nginx container is starting nginx so we don't
# have to specify this explicitly.

