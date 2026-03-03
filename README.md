# 環境構築のベースリポジトリ
新規でプロジェクトを立ち上げる時にはdev_bashをクローンして使用する

dev_bash内にdev_stack_templatesをクローンして必要箇所をコピーして利用する

## 環境構築手順
1. プロジェクトディレクトリ作成
`bash
  mkdir my-project && cd my-project
  git init
  mkdir -p frontend backend dev deploy
`
2. dev_bashをプロジェクトに取り込む
my-project/dev/配下にdev_bash/を配置

`bash
  cp -R /path/to/dev_bash ./dev/dev_bash
`

3. dev_stack テンプレを選んでdev/に展開
例として、monorepo-webを使用

`bash
  # compose override
  cp /path/to/dev-stack-templates/monorepo-web/compose.stack.yml dev/compose.stack.yml

  # templates（.mise.toml / justfile / scripts/ など）
  cp -R /path/to/dev-stack-templates/monorepo-web/templates/* dev/

  # scripts に実行権限
  chmod +x dev/scripts/*.sh
`

4. dev/.envを作成
プロジェクトルートはdev/なので、dev/配下に配置

macOS(UID/GIDは固定でもOK)
`bash
  cat > dev/.env <<'ENV'
  WORKDIR=..
  UID=1000
  GID=1000
  ENV
`

Linux(UID/GIDを自動設定したい場合)
`bash
  printf "WORKDIR=..\nUID=%s\nGID=%s\n" "$(id -u)" "$(id -g)" > dev/.env
`

5. 開発コンテナ起動→シェルへ入る
`bash
  cd dev
  just -f dev-base/justfile up
  just -f dev-base/justfile sh
`

6. コンテナ内で初期セットアップ(doctor→bootstrap)
コンテナ内で：

`bash
  cd /work/dev
  just doctor
  just bootstrap
`

7. 開発を開始
コンテナ内で：

`bash
  cd /work/dev

# backend（Flask）
  just backend-dev

# frontend（Vite想定）
# 別ターミナルで（ホスト側で `just ... sh` をもう1回実行して入る）
  just frontend-dev
`

