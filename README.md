# ros2_ws
Windows + VS Code + WSL2 (Ubuntu) + Docker を利用した ROS2 開発用 ワークスペース

ワークスペース構築後には .git を削除したほうが他の git リポジトリを内部に作成する際に安全


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
- docker-compose.yml 中の container_name (コンテナ名) は他の作成済みのコンテナと重複しないように設定する。

## VSCode で作業 
### VS Code で ros2_ws フォルダを開く
ros2_ws フォルダにいる状態でコマンド`code .`を実行する。
```bash
cd ~/ros2_ws
code .
```

## Docker で作業
### コンテナの起動
```bash
docker compose up -d
```

### コンテナに入る
```bash
docker exec -it ros2_dev bash
```

### コンテナから出る
```bash
exit
```
または (ctrl + d キー)

### コンテナの停止
```bash
docker compose stop
```
### コンテナの再起動
```bash
docker compose start
```

## ROS2 ノードをデバッグモードで起動
書きかけの不完全な項目

### Python の場合
python パッケージ debugpy がインストールされていなければ　debugpy をインストールする。
```bash
pip install debugpy
```
docker-compose.yml中に以下は不要かもしれない。
```yml
    ports:
      # python debug port
      - "5678:5678"
```
VS Code 用の .vscode/launch.json の設定
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: Remote Attach",
      "type": "python",
      "request": "attach",
      "connect": {
        "host": "localhost",
        "port": 5678
      },
      "pathMappings": [
        {
          "localRoot": "${workspaceFolder}/src",
          "remoteRoot": "/ros2_ws/src"
        }
      ],
      "justMyCode": false
    }
  ]
}
```
コンテナ内のターミナルで、デバッグしたいファイルをデバッグモードで実行する。
```bash
python3 -Xfrozen_modules=off -m debugpy --wait-for-client --listen 0.0.0.0:5678 main.py
```
この後に VS code の左端のパネルにある実行とデバッグ（虫と▷）から Python: Remote Attach を選択してデバッグを開始する。


### C++ の場合
VS Code の C++ デバッガでコンテナ内プロセスに attach できる。

VS Code 用の .vscode/launch.json の設定
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "ROS2 C++ Attach",
            "type": "cppdbg",
            "request": "attach",
            "program": "/usr/bin/gdb",
            "processId": "${command:pickProcess}",
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty printing",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "sourceFileMap": {
                "/ros2_ws/src": "${workspaceFolder}/src"
            }
        }
    ]
}
```

## Git の操作
src フォルダはコンテナ内外で共有される設定になっている。ファイルの編集と git の操作はコンテナ外で行うほうが管理しやすいかもしれない。コンテナの内と外の両方でファイル編集を行うと操作権の取得が面倒かもしれない。


## Powershell ターミナルのプロンプトを短くしたい場合
ターミナルで以下のコマンドを実行する。
```bash
function Prompt { "$(Split-Path -Leaf $PWD)> " }
```
