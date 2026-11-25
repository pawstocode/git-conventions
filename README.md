# Git Conventions

提供可由其他 Git 專案引用的 commit message 範本與格式檢查 hook。安裝後，Git 會使用本 repo 的範本，並在建立 commit 時檢查訊息格式。

## 目前規範

### Header

格式：

```text
<type>(<scope>)!: <subject>
```

- `type` 必填，可用值：`feat`、`fix`、`docs`、`style`、`refactor`、`perf`、`test`、`chore`。
- `scope` 選填，用來標示受影響的模組或範圍。
- `!` 選填，表示不相容變更，可放在 `type` 或 `scope` 後。
- `subject` 必填，建議使用祈使語氣且結尾不加句號。
- Header 建議不超過 50 字元，最多 72 字元。

範例：

```text
fix(foup): 修正條碼掃描問題
feat(scheduler)!: 新增派工優先權演算法
```

#### Type 定義

| Type | 定義 |
| --- | --- |
| `feat` | 新增功能 |
| `fix` | 修復 Bug |
| `docs` | 文件修改 |
| `style` | 不影響程式邏輯的格式調整（空白、縮排、分號等） |
| `refactor` | 程式碼重構（不新增功能、不修復 Bug） |
| `perf` | 效能優化 |
| `test` | 新增或修改測試 |
| `chore` | 建置流程、套件或輔助工具變動 |

### Body 與 Footer

- Body、Footer 選填；若有內容，Header 後必須空一行。
- Body 建議說明變更內容與原因，每行建議不超過 72 字元。
- Footer 可用來補充 Issue 關聯或其他資訊，例如 `Refs: #123`、`Closes: #123` 或 `BREAKING CHANGE: ...`。

目前 hook 會檢查：
1. Header 格式
2. subject 非空
3. subject 不以中英文句號結尾
4. Header 不超過 72 字元
5. Body/Footer 前的空行

祈使語氣、建議字數和 Body 行長目前是撰寫建議，不會由 hook 強制檢查。

## 安裝
1. 在專案的local端執行以下命令，並新增commit，將其push到遠端

	```bash
	git submodule add https://github.com/pawstocode/git-conventions.git tools/git-conventions
	```

2. 在clone套用設定的專案時使用--recursive
	```bash
	git clone --recursive <url>
	```

3. Windows 可執行安裝腳本：

	```bat
	tools\git-conventions\setup.bat
	```

	macOS、Linux 或其他環境可在專案根目錄手動設定：
	
	```bash
	git config --local core.hooksPath tools/git-conventions/.githooks
	git config --local commit.template tools/git-conventions/.gitmessage
	```

安裝後，`core.hooksPath` 與 `commit.template` 會寫入該專案的本機 Git 設定，不會影響其他專案。Hook 需要 Bash 環境；Windows 請使用 Git for Windows 提供的 Bash。

> 安裝會覆寫該專案原有的 `core.hooksPath` 和 `commit.template` 設定。如原本有自訂值，請先記錄，之後解除安裝時才能還原。

> 如果在 IDE 建立 commit 時出現 `/usr/bin/env: 'bash': No such file or directory` 的錯誤，請確認環境變數中的 Path 是否加入了 Git 底下的 bin 資料夾路徑（預設為C:\Program Files\Git\bin）。

## 解除安裝

在套用設定的專案根目錄執行：

```bash
git config --local --unset core.hooksPath
git config --local --unset commit.template
```

若安裝前已有自訂設定，請改為還原原值，不要直接 unset。若也要移除 submodule，先確認沒有需要保留的本地修改，再依 Git submodule 的移除流程刪除 `tools/git-conventions`。

```bash
git submodule deinit -- tools/git-conventions
git rm -- tools/git-conventions
```
