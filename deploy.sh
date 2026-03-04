#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Iniciando deploy...${NC}"

if [ ! -d ".git" ]; then
  echo -e "${RED}❌ Isso não é um repositório Git.${NC}"
  exit 1
fi

if [[ -z $(git status -s) ]]; then
  echo -e "${BLUE}⚠️ Nenhuma alteração detectada.${NC}"
  exit 0
fi

echo "Digite a mensagem do commit:"
read mensagem

git add .
git commit -m "$mensagem"

if [ $? -ne 0 ]; then
  echo -e "${RED}❌ Erro no commit.${NC}"
  exit 1
fi

git pull --rebase

if [ $? -ne 0 ]; then
  echo -e "${RED}⚠️ Conflito detectado. Resolva manualmente.${NC}"
  exit 1
fi

git push

if [ $? -ne 0 ]; then
  echo -e "${RED}❌ Erro no push.${NC}"
  exit 1
fi

echo -e "${GREEN}✅ Deploy concluído com sucesso!${NC}"