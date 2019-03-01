# Build phase
FROM node:alpine AS builder

WORKDIR /app
COPY package.json .
# RUN npm config set proxy http://proxy.adnovum.vn:3128/
RUN npm install
COPY . .
RUN npm run build

# Run phase from the output '/app/build'
FROM nginx

WORKDIR /usr/share/nginx/html
COPY --from=builder /app/build .

# No need to specify the default command here because the nginx container is going to start up the service for us.
# It's going to take care of the command for us automatically.
