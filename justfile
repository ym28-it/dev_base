set dotenv-load := true

compose := "docker compose --env-file .env -f dev-base/compose.yml -f compose.stack.yml"

up:
  {{compose}} up -d --build

down:
  {{compose}} down

rebuild:
  {{compose}} build --no-cache

sh:
  {{compose}} exec dev zsh

logs:
  {{compose}} logs -f --tail=200

ps:
  {{compose}} ps

# profile
up-db:
  {{compose}} --profile db up -d

up-cache:
  {{compose}} --profile cache up -d

up-all:
  {{compose}} --profile db --profile cache up -d

