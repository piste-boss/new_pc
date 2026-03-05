# MacBook 移行計画書

## 概要
- **移行元**: MacBook Air (13-inch, 2017) / Intel Core i5 / 8GB / macOS 12.7.6 Monterey
- **移行先**: MacBook Pro 14-inch M5 / 32GB / 1TB
- **納品日**: 2026年3月6日

---

## 事前準備（本日中に実施）

### 1. 移行元の現状確認・整理

#### 1-1. macOSバージョン確認
- macOS 12.7.6 Monterey → 確認済み
- 移行アシスタントとの互換性: 問題なし

#### 1-2. ストレージ使用量の確認
- リンゴメニュー > このMacについて > ストレージ
- 不要なファイル・アプリを削除して移行データ量を減らす
  - ゴミ箱を空にする
  - 不要なダウンロードファイル削除
  - 使っていないアプリの削除
  - キャッシュの削除（~/Library/Caches）

#### 1-3. 重要データのバックアップ（外付けドライブなし）
外付けHDD/SSDがないため、以下の方法でバックアップ：

**クラウドにバックアップ:**
- iCloud Drive に書類・デスクトップを同期（システム設定 > Apple ID > iCloud > iCloud Drive）
- Google Drive / Dropbox 等があればそちらにも重要ファイルをコピー
- 写真は iCloud写真 で同期

**開発環境の設定を保存（最重要）:**
- SSH鍵（~/.ssh/id_ed25519, id_ed25519.pub）→ クラウドの暗号化ストレージにコピー
- dotfiles → クラウドまたはGitリポジトリにpush:
  - ~/.zshrc
  - ~/.zprofile
  - ~/.gitconfig
  - ~/.bashrc
  - ~/.bash_profile
  - ~/.npmrc
- Homebrew のインストール済みパッケージ一覧を保存:
  ```
  brew list --formula > ~/brewlist_formula.txt
  brew list --cask > ~/brewlist_cask.txt
  ```
- npm グローバルパッケージ一覧:
  ```
  npm list -g --depth=0 > ~/npm_global.txt
  ```
- pip パッケージ一覧:
  ```
  pip freeze > ~/pip_packages.txt
  ```

**開発プロジェクトのバックアップ（重要）:**

ホームディレクトリに約65個のプロジェクトフォルダあり（合計約40GB）。

*Gitリモート(GitHub)に接続済み（24リポジトリ）— push済みか確認:*
| プロジェクト | リモート |
|---|---|
| AI-dr | github.com/piste-boss/AI-dr |
| AI_コンサル | github.com/piste-boss/AI_consul |
| Threads_piste | github.com/piste-boss/threads_piste |
| arukamo-review | github.com/piste-boss/arukamo-review |
| fitness_manager | github.com/piste-boss/fitness_manager |
| ishigaki_activityclub_review | github.com/piste-boss/ishigaki_activityclub_review |
| lp_heatmap | github.com/piste-boss/lp_heatmap |
| mail-auto-ai-system | github.com/piste-boss/mail-auto-ai-system |
| nagomi_review | github.com/piste-boss/nagomi_review |
| nako_takasu_review | github.com/piste-boss/nako_takasu_review |
| oisoya_review | github.com/piste-boss/oisoya_review |
| piste-lp-40 | github.com/piste-boss/piste-lp-40 |
| piste-lp | github.com/piste-boss/piste-lp |
| piste-reserve | github.com/piste-boss/piste-reserve |
| piste_review | github.com/piste-boss/pisete_review |
| repo_oisoya_review | github.com/piste-boss/oisoya_review |
| repo_sora_prompt_generator | github.com/piste-boss/sora_prompt_generator |
| reservation-system | github.com/piste-boss/reviews |
| review-gpt-LP | github.com/piste-boss/review-gpt-LP |
| review-gpt | github.com/piste-boss/review-gpt |
| reviews | github.com/piste-boss/reviews |
| sora_prompt_generator | github.com/piste-boss/sora_prompt_generator |
| threads_ai | github.com/piste-boss/threads_ai |
| x_ai / x_piste | github.com/piste-boss/x_piste |

**未コミットの変更があるリポジトリ（要注意！移行前に必ず対応）:**
- Threads_piste
- afiri（リモートなし — GitHubにpushされていない！）
- lp_heatmap
- reservation-system
- x_ai
- x_piste

→ 上記は `git add . && git commit && git push` で最新をGitHubに反映すること

*Gitリポジトリでないフォルダ（移行アシスタントで転送される）:*
ai_google_ads, apps-script, backend-gas, codex-projects, dev, FX,
homebrew, insta_piste, mkdir, netlify, node_modules, oiso-review-router,
oisoya_review_broken, oisoya_review_prev, piste_hp_analys, plans,
scripts, skill_manager, stripe_AI, suguru-project, supabase,
threads_protein, tmp, tools, work, docs, bin, cd

→ これらは移行アシスタントで自動転送されるが、特に重要なものはiCloudにもコピー推奨

**ブラウザ:**
- Chrome: Googleアカウントで同期されていれば自動復元
- Safari: iCloudで同期されていれば自動復元

#### 1-5. アカウント情報の棚卸し
- Apple ID / パスワード確認
- 各種アプリのライセンスキー・ログイン情報
- Wi-Fiパスワード
- メールアカウント設定（IMAP/SMTPサーバー情報）

#### 1-6. アプリのライセンス解除（必要なもの）
- デバイス数制限のあるアプリはライセンスを解除しておく
  - Adobe系、Office系、その他有料アプリ

---

## 移行当日（3月6日）

### 2. 新MacBook Proの初期セットアップ

#### 方法A: 移行アシスタントを使う（推奨）
最もシンプルで確実な方法。

**手順:**
1. 新MacBook Proの電源を入れ、初期設定を開始
2. 「情報の転送方法」で「Mac、Time Machineバックアップ、または起動ディスクから」を選択
3. 移行元の選択:
   - **方法A-1: Wi-Fi経由で直接転送** ← 推奨（外付けドライブなしの場合）
     - 両方を同じWi-Fiに接続
     - データ量によっては数時間かかる場合あり
     - 両Mac共に電源に接続しておくこと
   - **方法A-2: USB-C to USB-Aケーブルで直接転送** ← 最速
     - ケーブルがあれば最も速い
     - USB-C to USB-Aケーブルまたはアダプタが必要
4. 転送する項目を選択（ユーザーアカウント、アプリ、設定、書類）
5. 転送完了まで待つ

**注意点:**
- Intel → Apple Silicon への移行なので、一部アプリはRosetta 2経由で動作
- Rosetta 2は初回起動時に自動インストールされる
- 32bitアプリは動作しない（macOS Catalina以降非対応）

#### 方法B: クリーンインストール + 手動移行
環境をきれいにしたい場合。手間はかかるが、ゴミが引き継がれない。

---

### 3. 移行後の確認・セットアップ

#### 3-1. 基本確認
- [ ] Apple IDでサインイン済み
- [ ] iCloud同期が正常
- [ ] Wi-Fi接続
- [ ] Bluetooth機器のペアリング
- [ ] プリンタ設定

#### 3-2. macOSの設定調整
- [ ] システム設定 > トラックパッド（タップでクリック等）
- [ ] システム設定 > キーボード（入力ソース、ショートカット）
- [ ] システム設定 > ディスプレイ（解像度、Night Shift）
- [ ] システム設定 > Dock（サイズ、位置）
- [ ] FileVault（ディスク暗号化）が有効か確認
- [ ] ファイアウォール有効化

#### 3-3. アプリの動作確認
- [ ] 移行したアプリが正常起動するか一つずつ確認
- [ ] Apple Silicon対応版がある場合はアップデート
  - アクティビティモニタ > 「種類」列で Rosetta かネイティブか確認
- [ ] ライセンス認証が必要なアプリを再認証

#### 3-4. 開発環境の再構築
移行アシスタントで引き継がれても、Intel版のバイナリはそのまま使えない場合が多い。
**Homebrewは新規インストールし直すのが推奨。**

- [ ] Xcode Command Line Tools: `xcode-select --install`
- [ ] Homebrew 新規インストール（Apple Silicon用: /opt/homebrew）
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- [ ] 旧Macで保存した brewlist から再インストール:
  ```
  xargs brew install < ~/brewlist_formula.txt
  xargs brew install --cask < ~/brewlist_cask.txt
  ```
- [ ] Node.js（nvm or volta 推奨）
- [ ] Python（pyenv 推奨）
- [ ] Git設定確認: `git config --list`
- [ ] SSH鍵の配置と権限設定: `chmod 600 ~/.ssh/id_*`
- [ ] Docker Desktop（Apple Silicon版を公式サイトからDL）
- [ ] IDE / エディタ（VS Code等は設定同期機能あり）
- [ ] シェル設定（.zshrc）のパス修正
  - `/usr/local/bin` → `/opt/homebrew/bin` に変更が必要な箇所がないか確認

---

## 4. 移行完了後

#### 4-1. 旧Macの処理
- 移行が完全に成功したことを確認するまで旧Macのデータは消さない（最低1〜2週間）
- 問題なければ旧Macを初期化:
  1. Apple IDからサインアウト
  2. iCloudからサインアウト
  3. iMessage/FaceTimeからサインアウト
  4. Bluetoothペアリング解除
  5. macOSを再インストール（リカバリモード）
  6. 「すべてのコンテンツと設定を消去」

#### 4-2. バックアップ体制の構築
- Time Machineを新Macで設定
- クラウドバックアップも併用推奨

---

## 必要なもの（チェックリスト）

- [ ] Wi-Fi環境（安定した回線）
- [ ] Apple IDとパスワード
- [ ] 各種アプリのライセンス情報
- [ ] 電源アダプタ（両Mac分）
- [ ] （あれば便利）USB-C to USB-Aケーブル ※転送高速化

---

## Intel → Apple Silicon 移行の注意点

| 項目 | 詳細 |
|------|------|
| 32bitアプリ | 動作不可。代替アプリを探す必要あり |
| Rosetta 2 | 多くのIntel用アプリはRosetta 2で動作する |
| Homebrew | パスが `/usr/local` → `/opt/homebrew` に変わる |
| カーネル拡張 | 一部のkextは動作しない可能性あり |
| 仮想化 | Parallels等はARM版Windowsのみ対応 |
| 周辺機器 | ドライバがApple Silicon対応か要確認 |

---

## 推奨する移行方法

外付けドライブがないため、**Wi-Fi経由の移行アシスタント + 開発環境の手動再構築** を推奨。

### 本日（3/5）やること
1. **【最優先】未コミットの変更をpush** — 以下6リポジトリ:
   - Threads_piste, lp_heatmap, reservation-system, x_ai, x_piste
   - afiri（リモートなし → GitHubに新規リポジトリ作成してpush）
2. **全Gitリポジトリの最新をpush** — ローカルだけにあるコミットがないか確認
3. `brew list`, `npm list -g`, `pip freeze` でパッケージ一覧を保存
4. SSH鍵・dotfilesをクラウドまたはGitに保存
5. iCloud Drive同期を有効にして重要ファイルをクラウドに上げる
6. 不要ファイルを削除してデータ量を減らす（Wi-Fi転送を速くするため）
   - ~/Downloads（989MB）の整理
   - ~/node_modules（164MB）は削除可能（後で `npm install` で復元）
   - ~/tmp の中身を確認して不要なら削除
7. アプリのライセンス情報・アカウント情報を確認

### 明日（3/6）やること
1. 新Macの初期設定で移行アシスタント → Wi-Fi経由で旧Macから転送
2. 転送完了後、Homebrewを新規インストール（Apple Silicon版）
3. 開発ツールを再インストール
4. アプリの動作確認・ライセンス再認証
