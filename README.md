# My Cobot Pro 600 操作サンプル

このリポジトリは、My Cobot Pro 600の操作サンプルです。Docker Composeを使用して環境をセットアップし、ロボットを動かすための手順を示しています。

#under construction
現在サンプルのみ，機能追加中

## 目次
- [Dockerコンフィグ](#Dockerコンフィグ)
- [使用方法](#使用方法)
- [起動方法](#起動方法)

## 使用方法

このサンプルは、Docker Composeを使用してMy Cobot Pro 600の操作環境をセットアップします。以下の手順で環境を構築し、ロボットを起動します。

## Dockerコンフィグ
docker-composeファイルの16,17行ROS_MASTER_URIとROS_IPを使用しているPCのIPアドレスに変更してください

nvidia gpuを搭載していない環境ではdocker-composeの22-28をコメントアウトします
また，Dockerfileの１行目をコメントアウトし４行目のコメントを解除します

## 起動方法

1. **Dockerイメージのビルド**

    最初に、Docker Composeを使用して必要なDockerイメージをビルドします。

    ```bash
    docker compose build
    ```

2. **Xサーバーへのアクセス権を設定**

    GUIを使用するために、Xサーバーへのアクセス権をローカルに設定します。

    ```bash
    xhost local:
    ```

3. **コンテナの起動**

    Docker Composeを使用して、コンテナを起動します。

    ```bash
    docker compose up
    ```

    これで、My Cobot Pro 600の操作が可能になります。

## トラブルシューティング

- **GUIが表示されない場合**

    Xサーバーへのアクセス権が正しく設定されているか確認してください。

    ```bash
    xhost local:
    ```

- **起動時にエラーが発生する場合**

    DockerやDocker Composeのバージョンが最新であるか確認してください。また、必要なポートやデバイスにアクセスできる権限があるか確認してください。
