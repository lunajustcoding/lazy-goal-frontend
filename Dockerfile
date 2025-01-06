FROM node:18

ENV NPM_HOME="/npm"

ENV ATH="$NPM_HOME:$PATH"

RUN corepack enable

EXPOSE 5174

WORKDIR /var/www/app

COPY . /var/www/app

RUN npm install

RUN if [! -e "./package.json"] ; then RUN npm init ;fi

CMD [ "npm", "run", "dev" ]