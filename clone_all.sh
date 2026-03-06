#!/bin/bash
# 新MacでGitHubから全リポジトリを一括clone
# 使い方: bash clone_all.sh

cd ~

repos=(
  "git@github.com:piste-boss/AI-dr.git"
  "git@github.com:piste-boss/AI_consul.git AI_コンサル"
  "git@github.com:piste-boss/threads_piste.git Threads_piste"
  "git@github.com:piste-boss/afiri.git"
  "git@github.com:piste-boss/arukamo-review.git"
  "git@github.com:piste-boss/fitness_manager.git"
  "git@github.com:piste-boss/ishigaki_activityclub_review.git"
  "git@github.com:piste-boss/lp_heatmap.git"
  "git@github.com:piste-boss/mail-auto-ai-system.git"
  "git@github.com:piste-boss/nagomi_review.git"
  "git@github.com:piste-boss/nako_takasu_review.git"
  "git@github.com:piste-boss/oisoya_review.git"
  "git@github.com:piste-boss/piste-lp.git"
  "git@github.com:piste-boss/piste-lp-40.git"
  "git@github.com:piste-boss/piste-reserve.git"
  "git@github.com:piste-boss/pisete_review.git piste_review"
  "git@github.com:piste-boss/oisoya_review.git repo_oisoya_review"
  "git@github.com:piste-boss/sora_prompt_generator.git repo_sora_prompt_generator"
  "git@github.com:piste-boss/reviews.git reservation-system"
  "git@github.com:piste-boss/review-gpt.git"
  "git@github.com:piste-boss/review-gpt-LP.git"
  "git@github.com:piste-boss/reviews.git"
  "git@github.com:piste-boss/sora_prompt_generator.git"
  "git@github.com:piste-boss/threads_ai.git"
  "git@github.com:piste-boss/x_piste.git x_ai"
  "git@github.com:piste-boss/x_piste.git x_piste"
  "git@github.com:piste-boss/new_pc.git PC引っ越し"
)

for entry in "${repos[@]}"; do
  url=$(echo "$entry" | awk '{print $1}')
  dir=$(echo "$entry" | awk '{print $2}')

  if [ -z "$dir" ]; then
    echo ">>> Cloning $url"
    git clone "$url"
  else
    echo ">>> Cloning $url -> $dir"
    git clone "$url" "$dir"
  fi
  echo ""
done

echo "=== 完了 ==="
echo "cloneされたリポジトリ数: ${#repos[@]}"
