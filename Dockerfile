FROM node:18

ENV NPM_HOME="/npm"
ENV PATH="$NPM_HOME:$PATH"

WORKDIR /var/www/app

COPY . /var/www/app

RUN corepack enable
RUN npm install

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]
