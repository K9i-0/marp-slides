---
marp: true
theme: custom
paginate: true
footer: "Marionette MCP call_custom_extension — 2026/03"
---

<!-- _class: title -->
<!-- _paginate: false -->

# Marionette MCP の call_custom_extension

## Store 画像撮影や UI 検証を自動化しよう

---

## Marionette MCP とは

- **LeanCode** が開発する Flutter 特化の MCP
- ボタンのタップやテキスト入力など**ランタイム操作**に特化
- 公式の Dart and Flutter MCP server（コード分析向け）と**併用**がおすすめ

https://pub.dev/packages/marionette_mcp

---

## 😩 AI 操作のつらみ

- AI が検証画面に**たどり着けない**（深い階層）
- 何度もツール呼び出し → **トークン代が嵩む**
- スクショ撮影時の**設定ミス**（テーマ・言語）
- 設定画面の**導線が深く**て AI が苦労する

---

## 💡 call_custom_extension とは

**Flutter アプリに独自の操作を定義して、AI エージェントから呼び出せる仕組み**

| ツール | 役割 |
|--------|------|
| `list_custom_extensions` | 登録済みエクステンション一覧を取得 |
| `call_custom_extension` | エクステンションを実際に呼び出す |

VM Service Extension を MCP 経由で公開する「エスケープハッチ」

---

## Flutter 側の実装

```dart
registerMarionetteExtension(
  name: 'myApp.goToPage',
  description: 'Navigate to a specific page by name.',
  callback: (params) async {
    final page = params['page'];
    if (page == null) {
      return MarionetteExtensionResult.invalidParams('Missing: page');
    }
    navigateTo(page);
    return MarionetteExtensionResult.success({'page': page});
  },
);
```

---

## 初期化

```dart
void main() {
  if (kDebugMode && !kIsWeb) {
    MarionetteBinding.ensureInitialized();
    registerMyExtensions(); // カスタムエクステンションの登録
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }
  // ...
}
```

`kDebugMode` でガードするのでリリースビルドには影響なし

---

## 活用事例：CC Pocket での Store スクショ自動撮影

CC Pocket で登録している 5 つのエクステンション:

| エクステンション | 説明 |
|------------------|------|
| `navigateToStoreScenario` | Store スクショ用シナリオへ直接遷移 |
| `popToRoot` | ホーム画面に戻る |
| `setTheme` | テーマ切替 (light/dark/system) |
| `setLocale` | 言語切替 (en/ja/zh) |
| `navigateToMockScenario` | モックシナリオへ遷移 |

---

## setTheme の実装例

```dart
registerMarionetteExtension(
  name: 'ccpocket.setTheme',
  description: 'Switch the app theme. '
      'Values: "light", "dark", "system".',
  callback: (params) async {
    final theme = params['theme'];
    final mode = switch (theme?.toLowerCase()) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => null,
    };
    if (mode == null) { /* エラー返却 */ }
    ctx.read<SettingsCubit>().setThemeMode(mode);
    return MarionetteExtensionResult.success({'theme': theme});
  },
);
```

---

## 自動化フロー

```text
1. ccpocket.setTheme      → ライトテーマに設定
2. ccpocket.setLocale      → 言語を設定
3. ccpocket.navigateToStoreScenario → シナリオに遷移
4. 描画完了を待って xcrun simctl io booted screenshot
5. ccpocket.popToRoot      → ホーム画面に戻す
6. 3-5 を全シナリオ分繰り返す
```

設定画面を開く → 探す → タップ… が **一発で完了**

---

## LLM 活用 Tips

- 名前は明確に: `goToPage` ❌ → `ccpocket.navigateToStoreScenario` ✅
- **アプリ名をプレフィックス**にして識別しやすく
- `description` をしっかり書く（AI に書かせると良い）
- **プロンプトに「このエクステンションを使え」と明記**が最も効果的

---

<!-- _class: dark -->

## まとめ

- **call_custom_extension** で AI が苦手な操作をショートカットできる
- Flutter 側は `registerMarionetteExtension()` を呼ぶだけ
- **Store スクショ撮影**の完全自動化も実現可能
- エクステンション名の工夫とプロンプトへの明記が大事

---

<!-- _class: dark -->

## ありがとうございました

試してみてね ☝️

https://pub.dev/packages/marionette_mcp
