FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

# install pm2 globally
RUN npm install -g pm2

COPY . .

EXPOSE 3000

# use pm2-runtime instead of node
CMD ["pm2-runtime", "start", "ecosystem.config.js"]