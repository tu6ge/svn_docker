# This is a SVN docker
you can push code to docker

volume /wwwroot

code auto to /wwwroot dir

这是一个svn服务端的docker
可以支持自动部署代码

配置参数有
  环境变量
    SVN_USER svn账号
    SVN_PASS svn账号密码
  挂载目录
    /wwwroot 代码自动部署到这个目录
  端口号
    3690
