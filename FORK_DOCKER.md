# Fork 镜像构建与运行

这个 fork 默认使用 `etoile-7/OpenList-Frontend` 作为前端构建产物来源。

## 推荐流程

1. 先推送 `OpenList-Frontend` 到 GitHub。
2. 等 `Rolling Build` 生成 `rolling` 发布包。
3. 再推送 `OpenList` 到 GitHub。
4. `Beta Release (Docker)` 会构建并推送镜像到：

```bash
ghcr.io/etoile-7/openlist:beta
```

## 运行

```bash
docker pull ghcr.io/etoile-7/openlist:beta
docker run -d --name openlist \
  --restart always \
  -p 5244:5244 \
  -p 5245:5245 \
  -v /etc/openlist:/opt/openlist/data \
  -e TZ=Asia/Shanghai \
  -e UMASK=022 \
  ghcr.io/etoile-7/openlist:beta
```

也可以直接使用仓库里的 `docker-compose.yml`。

## 发布正式 tag

如果推送 `v*` tag，`Release builds (Docker)` 会构建同名镜像 tag。

```bash
git tag v4.2.1-flv-editor
git push origin v4.2.1-flv-editor
```

对应镜像示例：

```bash
docker pull ghcr.io/etoile-7/openlist:v4.2.1-flv-editor
```

