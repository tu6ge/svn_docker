#!/bin/sh

if [ -n "$SVN_USER" -a -n "$SVN_PASS" ]
then
	echo ${SVN_USER} "=" ${SVN_PASS} >> /svnrepo/conf/passwd
	echo ${SVN_USER} "=rw" >> /svnrepo/conf/authz
	echo "#!/bin/sh" > /svnrepo/hooks/post-commit
	echo "export LANG=zh_CN.UTF-8" >> /svnrepo/hooks/post-commit
	echo "/usr/bin/svn update /wwwroot --username ${SVN_USER} --password ${SVN_PASS} --no-auth-cache --non-interactive || exit 1" >> /svnrepo/hooks/post-commit
	echo exit 0 >> /svnrepo/hooks/post-commit
	chmod +x /svnrepo/hooks/post-commit
	svnserve -d -r /svnrepo
	sleep 2
	cp /wwwroot
	svn checkout svn://127.0.0.1 /wwwroot --username ${SVN_USER} --password ${SVN_PASS} --no-auth-cache
	killall svnserve
else
	echo "user or pass is empty"
	exit 1
fi

exec "$@"
