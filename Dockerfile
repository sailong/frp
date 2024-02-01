# 基础镜像
FROM alpine:3
# 作者
LABEL maintainer="simonchang"
# # 定义构建参数
ENV FRP_VERSION 0.54.0
# 构建镜像
RUN cd /root \
    &&  wget --no-check-certificate -c https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    &&  tar zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz  \
    &&  cd frp_${FRP_VERSION}_linux_amd64/ \
    &&  cp frpc /usr/bin/ \
    &&  chmod +x /usr/bin/frpc \
    &&  mkdir -p /etc/frp \
    &&  cd /root \
    &&  rm frp_${FRP_VERSION}_linux_amd64.tar.gz \
    &&  rm -rf frp_${FRP_VERSION}_linux_amd64/
# 暴露端口
EXPOSE \
    7000 \
    7400 
# 挂载配置文件
VOLUME ["/etc/frp/frpc.toml"]
# 执行命令
CMD ["-c", "/etc/frp/frpc.toml"]
# 启动时运行
ENTRYPOINT ["/usr/bin/frpc"]