FROM alpine:3.6

RUN echo "https://mirrors.aliyun.com/alpine/v3.6/main/" > /etc/apk/repositories \
	&& echo "https://mirrors.aliyun.com/alpine/v3.6/community/" >> /etc/apk/repositories \
	&& apk update \
	&& apk --update add subversion

WORKDIR /

RUN cd / \
	&& mkdir /svnrepo \
	&& svnadmin create /svnrepo
RUN sleep 3
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY conf/svnserve.conf /svnrepo/conf/svnserve.conf
COPY conf/passwd /svnrepo/conf/passwd
COPY conf/authz /svnrepo/conf/authz
RUN mkdir wwwroot 
ENTRYPOINT ["./entrypoint.sh"]

#VOLUME /svnrepo
VOLUME /wwwroot
EXPOSE 3690

CMD ["svnserve","-d","--foreground","-r","/svnrepo"]
