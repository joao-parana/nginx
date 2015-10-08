# nginx

> Imagem Docker para **NGINX** usando Debian Jessie (version 8),

Este projeto foi testado com a **versão 1.8.2** do Docker

Usado no curso [http://joao-parana.com.br/blog/curso-docker/](http://joao-parana.com.br/blog/curso-docker/) criado para a Escola Linux.

Criando a imagem

    docker built -t HUB-USER-NAME/nginx -f Dockerfile .

Substitua o token `HUB-USER-NAME` pelo seu login em [http://hub.docker.com](http://hub.docker.com)

Usaremos aqui o nome `nginx_jessie` para o Contêiner.
Caso exista algum conteiner com o mesmo nome rodando, 
podemos pará-lo assim:

    docker stop nginx_jessie

> Pode demorar alguns segundos para parar e isto é normal.

Em seguida podemos removê-lo

    docker rm nginx_jessie

Podemos executar o Contêiner iterativamente para obter um help assim:

    docker run --rm -i -t --name nginx_jessie HUB-USER-NAME/nginx

Podemos tambem executar iterativamente assim:

    docker run --rm -i -t --name nginx_jessie \
           -p 8085:80                         \
           -v ./test/site:/var/www/html/site  \
           HUB-USER-NAME/nginx start-all

Ou preferencialmente no modo Daemon assim:

    docker run -d --name nginx_jessie         \
           -p 8085:80                         \
           -v ./test/site:/var/www/html/site  \
           HUB-USER-NAME/nginx start-all

Observe o mapeamento da porta 80 do Apache dentro do contêiner 
para uso externo em 8085. O valor 8085 pode ser alterado a seu critério.
Você pode inclusive usar a porta 80 se tiver direitos para isso e se 
não estiver ocupada.

Também foi definido um diretório no host para ser montado 
em /var/www/html/site

Desta forma os Desenvolvedores poderão modificar os programas 
no computador Host usando as ferramentas visuais adequadas
(IDE, Browser, etc) pois as mudanças refletem imediatamente no 
Contêiner e são vistas pelo runtime do NGINX.

Verificando o Log

    docker logs nginx_jessie

Considere uma função chamada `docker-ip` criada no `.bash_profile` por conveniência. 
Veja o fonte abaixo:

    docker-ip() {
      boot2docker ip 2> /dev/null
    }

Se você estiver usando o **MAC OSX** com Boot2Docker 
poderá executar o comando abaixo para abrir uma sessão como 
root no MySQL:

    open http://$(docker-ip):8085 

No Linux (Ubuntu por exemplo) use assim:

    open http://localhost:8085

Após executar o sistema por um tempo, podemos parar o contêiner 
novamente para manutenção

    docker stop nginx_jessie

e depois iniciá-lo novamente e observar o log

    docker start nginx_jessie && sleep 10 && docker logs nginx_jessie

Observe que **o LOG é acumulativo** 

Você poderá ver o conteúdo do diretório /var/log/nginx executando o comando abaixo:

    docker exec nginx_jessie ls -lat /var/log/nginx

## Diretórios importantes:

    Documentos do site - /var/www/html/site
    Logs do NGINX      - /var/log/nginx/error.log e /var/log/nginx/access.log


#### Mais detalhes sobre Docker no meu Blog: [http://joao-parana.com.br/blog/](http://joao-parana.com.br/blog/)

