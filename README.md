# ros2_ws
Windows + VS Code + WSL2 (Ubuntu) + Docker を利用した ROS2 開発用 ワークスペース

## Windowsの環境
- VS Code
- VS Code 拡張機能 Python, C/C++, GitLens
- WSL2 (Ubuntu)
- Docker Desktop


## Docker Desktop の設定
- インストール時に per-user installation を選択  
- インストール後に Docker Desktop を起動して設定
    - Settings → Resources → WSL Integration → Enable integration with my default WSL distro → ON
    - Settings → Resources → WSL Integration → Ubuntu → ON

## WSL2 (Ubuntu) の環境
- git
- 本リポジトリのクローン
- docker-compose.yml 中のコンテナ名 container_name は他の作成済みのコンテナと重複しないように設定する。

## VSCode で作業 
- VSCode で ros2_ws フォルダを開く:

    ros2_ws フォルダにいる状態でコマンド`code .`を実行する。
```bash
cd ~/ros2_ws
code .
```

- コンテナ起動
```bash
docker compose up -d
```

- コンテナに入る
```bash
docker exec -it ros2_dev bash
```

- コンテナから出る
```bash
exit
```
または (ctrl + d キー)

- 停止
```bash
docker compose stop
```
- 再起動
```bash
docker compose start
```

- ROS2 ノードをデバッグモードで起動

    Python の場合

    VS Code の launch.json で：
```json
{
    "name": "ROS2 Python Debug",
    "type": "python",
    "request": "attach",
    "connect": {
        "host": "localhost",
        "port": 5678
    }
}
```
コンテナ内で：
```bash
python3 -m debugpy --listen 0.0.0.0:5678 your_node.py
```
C++ の場合

VS Code の C++ デバッガでコンテナ内プロセスに attach できる。


- src フォルダはコンテナ内外で共有される設定になっている。git の操作はコンテナ外で行うほうが管理しやすい。


- Powershell ターミナルのプロンプトを短くしたい場合は以下のコマンドを実行する。
```bash
function Prompt { "$(Split-Path -Leaf $PWD)> " }
```
