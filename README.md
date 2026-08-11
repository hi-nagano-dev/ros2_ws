# ros2_ws
Windows + VS Code + WSL2 (Ubuntu) + Docker を利用した ROS2 開発用 ワークスペース

## Windowsの環境
- VS Code
- VS Code 拡張機能 Dev Containers, Python, C/C++, GitLens
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
- 起動した VSCode の左下の「><」アイコン → Reopen in Container (もしくは　コンテナーで再度開く)
- 初回は必要なソフトウェアの準備と Docker イメージのビルドが走る。
- 完了すると コンテナ内で VSCode が動く状態になる。
- src フォルダはコンテナ内外で共有される設定になっている。git の操作はコンテナ外で行うほうが管理しやすい。
- コンテナ外の git 操作で `fatal: detected dubious ownership in repository at '//wsl.localhost/Ubuntu/home/<user>/ros2_ws'` のようなエラーが出る場合は以下のコマンドを実行する。
```bash
git config --global --add safe.directory //wsl.localhost/Ubuntu/home/<user>/ros2_ws
```
- Powershell ターミナルのプロンプトを短くしたい場合は以下のコマンドを実行する。
```bash
function Prompt { "$(Split-Path -Leaf $PWD)> " }
```
