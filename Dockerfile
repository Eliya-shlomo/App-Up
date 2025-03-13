FROM nginx:latest

#copy my conf to the container conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

#copy my index to the container share html
COPY index.html /usr/share/nginx/html/

EXPOSE 80

CMD [ "nginx" , "-g" , "deamon off;" ]
