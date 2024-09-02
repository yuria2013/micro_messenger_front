# RHEL の最新イメージをベースイメージとして使用
FROM registry.access.redhat.com/ubi8/ubi:latest

# Apache httpd をインストール
RUN dnf -y install httpd && \
    dnf clean all

# HTML ファイルを Apache ディレクトリにコピー
COPY . .

# Web サーバーのためにポート 80 を公開
EXPOSE 80

# フォアグラウンドで Apache を起動
CMD ["httpd", "-D", "FOREGROUND"]
