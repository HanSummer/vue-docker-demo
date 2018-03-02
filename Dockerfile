# 基础镜像
FROM node:6.10.3-slim

# 安装 Nginx
RUN apt-get update \
    && apt-get install -y nginx

# 指定工作目录
WORKDIR /app

# 将当前目录下的文件全都拷贝到工作目录下
COPY . /app/

# 容器占用端口
EXPOSE 80

# 1. 安装依赖
# 2. 编译
# 3. 把编译好的 dist 下的文件拷贝到 nginx 目录下
# 4. 把工作目录删除以减小镜像体积
RUN npm install \
    && npm run build \
    && cp -r dist/* /var/www/html \
    && rm -rf /app

# 以前台方式启动 nginx
CMD [ "nginx", "-g", "daemon off;"]