# Linux Development Environment Setup Script

Ubuntu/Debian系ディストリビューション向けの開発環境を一括でセットアップするシェルスクリプトです。

## 概要

このスクリプトは、新しいLinux環境で必要な開発ツールやアプリケーションを自動的にインストールします。Web開発、モバイル開発、インフラ管理など、幅広い用途に対応した環境を構築できます。

## インストールされるもの

### 基本ツール
- Chrome ブラウザ
- 日本語入力 (ibus-mozc)
- snap パッケージマネージャー
- MS Editor
- LocalSend
- Yazi (ファイルマネージャー)
- Ghostty (ターミナル)
- CopyQ

### 開発ツール
- Git
- Docker & Docker Compose
- AWS CLI
- Terraform
- Android Studio
- Ollama (LLM実行環境)
- Kiro

### プログラミング言語・ランタイム
- Go
- Node.js & npm
- Python3 & pip
- pnpm

### グローバルnpmパッケージ
- TypeScript
- Astro
- Vite / VitePress
- Vue
- Electron
- Vercel CLI
- Google Gemini CLI
- Salesforce CLI

### データベース
- PostgreSQL
- Redis

### PHP環境
- PHP (MySQL, GD, cURL, XML, mbstring拡張付き)

## 使用方法

### リモートから直接実行

```bash
curl -fsSL https://raw.githubusercontent.com/pyxudev/Install-Debian-dev-env-with-one-script/main/install.sh | bash
```

または

```bash
wget -qO- https://raw.githubusercontent.com/pyxudev/Install-Debian-dev-env-with-one-script/main/install.sh | bash
```

### ダウンロードしてから実行

```bash
# スクリプトをダウンロード
wget https://raw.githubusercontent.com/pyxudev/Install-Debian-dev-env-with-one-script/main/install.sh

# 実行権限を付与
chmod +x install.sh

# 実行
./install.sh
```

## 前提条件

- Ubuntu 20.04以降、またはDebian系ディストリビューション
- インターネット接続
- sudo権限を持つ通常ユーザーアカウント（rootユーザーでは実行不可）

## 注意事項

⚠️ **重要な注意点**

1. **rootユーザーで実行しないでください**  
   セキュリティ上の理由から、このスクリプトはrootユーザーでの実行を拒否します。通常ユーザーで実行してください。

2. **インストールには時間がかかります**  
   環境によりますが、すべてのパッケージのインストールには30分〜1時間程度かかる場合があります。

3. **ログファイル**  
   実行ログは `./install.log` に保存されます。問題が発生した場合はこのファイルを確認してください。

4. **Git設定**  
   初回実行時、Git のユーザー名とメールアドレスの入力を求められます。対話的に設定されます。

5. **手動インストールが必要なもの**  
   以下のツールは手動でインストールする必要があります：
   - Visual Studio Code
   - MySQL（PostgreSQLの代わりに使用する場合）

6. **再起動が必要**  
   スクリプト実行後、特にDockerグループの変更を反映させるため、システムの再起動が推奨されます。

## インストール後の手順

1. **VSCodeのインストール**
   ```bash
   sudo snap install code --classic
   ```

2. **MySQLのインストール（必要な場合）**
   ```bash
   sudo apt install mysql-server -y
   ```

3. **システムの再起動**
   ```bash
   sudo reboot
   ```

4. **Dockerの動作確認**
   ```bash
   docker run hello-world
   ```

## トラブルシューティング

### Dockerがsudoなしで実行できない

再ログインまたは再起動してください：
```bash
sudo reboot
```

### snapパッケージのインストールに失敗する

snapdサービスを再起動してください：
```bash
sudo systemctl restart snapd
```

### pnpmのコマンドが見つからない

シェルを再起動するか、以下を実行してください：
```bash
source ~/.bashrc
```

## カスタマイズ

不要なパッケージがある場合は、スクリプトをダウンロードして該当する行をコメントアウトまたは削除してから実行してください。

## ライセンス

MIT License

## 貢献

バグ報告や機能リクエストは、GitHubのIssuesからお願いします。プルリクエストも歓迎します。
