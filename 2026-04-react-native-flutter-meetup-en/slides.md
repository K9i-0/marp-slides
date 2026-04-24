---
marp: true
theme: custom
paginate: true
lang: en
footer: "React Native & Flutter Meetup - 2026/04/24"
---

<!-- _class: title -->
<!-- _paginate: false -->

# My AI-driven side project

# passed 500 GitHub stars

## Lessons learned

## Kota Hayashi

<p style="margin-top: 28px; font-size: 0.62em;">
  <a href="https://k9i-0.github.io/marp-slides/2026-04-react-native-flutter-meetup/">Japanese version</a>
</p>

---

## About me

<div style="display: grid; grid-template-columns: 1fr 44%; gap: 40px; align-items: center;">
  <div>
    <h3>Kota Hayashi</h3>
    <ul>
      <li>Company: Yumemi</li>
      <li>Flutter experience: about 5 years professionally</li>
      <li>X: <a href="https://x.com/K9i_apps">https://x.com/K9i_apps</a></li>
    </ul>
  </div>
  <img src="./images/x.png" alt="X profile screenshot" style="width: 100%; border-radius: 18px; box-shadow: 0 12px 32px rgba(0, 0, 0, 0.22);" />
</div>

---

## What I built

<div style="display: grid; grid-template-columns: 1fr 260px; gap: 36px; align-items: start;">
  <div>
    <h3>CC Pocket</h3>
    <ul>
      <li><strong>An app for controlling Codex and Claude from a phone</strong></li>
      <li>Built for a native experience, not a terminal UI</li>
      <li>A personal Flutter app</li>
      <li>Released the iOS version on <strong>2026/03/06</strong></li>
    </ul>
  </div>
  <div style="text-align: center;">
    <img src="./images/github-qr.png" alt="CC Pocket GitHub repository QR code" style="width: 220px; height: 220px;" />
    <p style="margin: 10px 0 0; font-size: 0.68em;"><a href="https://github.com/K9i-0/ccpocket">GitHub repository</a></p>
  </div>
</div>

<img src="./images/ccpocket-github-star.png" alt="CC Pocket GitHub repository card" style="display: block; width: 66%; margin: 4px auto 0; border-radius: 10px;" />

---

## App screens

<div style="display: grid; grid-template-columns: 1fr 280px; gap: 22px; align-items: center; margin-top: -8px;">
  <img src="./images/ipad_screenshot.png" alt="CC Pocket iPad screenshot" style="width: 100%; max-height: 520px; object-fit: contain;" />
  <img src="./images/iphone_screenshot.png" alt="CC Pocket iPhone screenshot" style="width: 100%; max-height: 520px; object-fit: contain;" />
</div>

---

## Early traction

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 32px; align-items: center;">
  <div>

| Metric                    | Number         |
| ------------------------- | -------------- |
| GitHub Stars              | **626**        |
| App Store reviews (Japan) | **21 / 4.8**   |
| Google Play reviews       | **10 / 5.0**   |

- A strong start about two months after launch
- The UI/UX feedback has been especially positive
- AI helped me achieve both **speed and polish**

  </div>
  <img src="./images/app-store.png" alt="App Store review screenshot" style="width: 100%; border-radius: 12px; box-shadow: 0 12px 32px rgba(0, 0, 0, 0.22);" />

</div>

---

## CC Pocket architecture

<div style="display: grid; grid-template-columns: 1.05fr 0.95fr; gap: 34px; align-items: center;">
  <div style="display: grid; grid-template-columns: 1fr; gap: 14px;">
    <div style="border: 2px solid #1e88e5; border-radius: 12px; padding: 16px 22px;">
      <strong>Mobile / macOS app</strong>
      <div style="font-size: 0.72em; color: #555;">Flutter / client</div>
    </div>
    <div style="text-align: center; font-size: 0.78em; color: #555;">Communicates via WebSocket<br />Devices connect through Tailscale, etc.</div>
    <div style="border: 2px solid #43a047; border-radius: 12px; padding: 16px 22px;">
      <strong>Bridge server</strong>
      <div style="font-size: 0.72em; color: #555;">Self-hosted on Mac / TypeScript</div>
      <div style="font-size: 0.72em; color: #555;">Manages Codex / Claude sessions</div>
    </div>
    <div style="display: grid; grid-template-columns: 1fr 1.45fr; gap: 14px; align-items: center;">
      <div style="text-align: center; font-size: 0.72em; color: #555;">Registers device tokens<br />Sends notifications via FCM</div>
      <div style="border: 2px solid #f9ab00; border-radius: 12px; padding: 14px 18px;">
        <strong>Firebase / FCM</strong>
        <div style="font-size: 0.72em; color: #555;">TypeScript / notifications</div>
      </div>
    </div>
  </div>
  <div>
    <ul>
      <li>Run the Bridge on a Mac to control Codex / Claude</li>
      <li>Connect from a phone to operate AI sessions remotely</li>
      <li>Use Firebase only for notifications</li>
    </ul>
  </div>
</div>

---

## Why Flutter

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 36px; align-items: start;">
  <ul>
    <li>I had built SwiftUI macOS apps, React Ink TUI tools, and more with AI-driven development</li>
    <li>They looked good and got some early attention on social media</li>
    <li>But the UX was not polished enough, so I stopped using them myself</li>
  </ul>
  <ul>
    <li>To ship quality, <strong>you need both AI and real understanding of the chosen technology</strong></li>
    <li><strong>I put familiar Flutter at the center of the product</strong></li>
    <li>For surrounding pieces like the Bridge, I used TypeScript</li>
  </ul>
</div>

---

## AI tools I used

| Tool        | Main role                                          |
| ----------- | -------------------------------------------------- |
| Claude Code | Early design, implementation, environment setup    |
| Codex       | Current main tool, from design through coding      |
| Antigravity | Final UI polish and asset generation               |

- I did not rely on a single tool; I **used each one for its strengths**

---

## Main development: Claude Code and Codex

- I used AI for almost everything: design, implementation, and environment setup
- Early on, I used **Claude Code**
- Now I have mostly moved to **Codex**
- Model quality is good enough for practical use in both cases

Plan history:

1. Claude Max $100
2. Claude Max $100 + Codex Plus $20
3. Claude Pro $20 + Codex Pro $100
4. Codex Pro $100

---

## Why Codex is my main tool now

- The biggest reason is **cost performance**
- In my workflow, at the same price range, **Codex gave me more usage headroom**

### A major difference: tolerance for third-party tools

- Codex: subscription tokens can be used from third-party tools
- Claude: third-party usage became a terms-of-service violation

Third-party tools include OpenClaw, OpenCode, and CC Pocket itself

---

## Antigravity handled design

- The **multimodal strength** of Gemini-family models feels important here
- The generated code quality is low
- But if you think of it as a **designer who can write a little code**, it is very capable
- It was especially useful for app icons, generated assets, and final UI adjustments

Antigravity contributed a lot to the positive feedback on CC Pocket's UI/UX

- By the way, being from Google does not make it magically better with Flutter...

---

## Supporting tech that worked well with AI

- **shorebird**
  Easy remote device testing and convenient OTA-style updates
- **marionette mcp**
  Important for letting AI verify the UI by itself
- **BLoC**
  Easier for AI to handle than overly flexible state management
- **GitHub Actions**
  Easy for AI to automate because errors are available through CLI and API

I will cover these in the following slides

---

## shorebird

- [https://shorebird.dev/](https://shorebird.dev/)
- An OTA (Over The Air update) tool for Flutter
- Lets you release without app store review
  - Avoids losing AI's productivity gains to review delays
- Also useful when you cannot connect directly to a Mac for device testing
  - Much faster than distributing through TestFlight

### OTA support may matter a lot in AI-first development

- Honestly, Expo probably has a better experience in this area

---

## marionette mcp

- [https://pub.dev/packages/marionette_mcp](https://pub.dev/packages/marionette_mcp)
- A Playwright MCP-like tool for Flutter
- In AI-driven development, giving AI ways to verify work is important
  - Feedback loops such as lint, unit tests, and E2E tests
  - Recently this might be called harness engineering?
- More details in these articles and slides
  - [Automate Store screenshots and UI verification with Marionette MCP call_custom_extension](https://zenn.dev/yumemi_inc/articles/20260326_marionette_mcp_call_custom_extension)
  - [Run a UI verification feedback loop for Flutter apps with MCP](https://k9i-0.github.io/flutter_deck_template/fluttergakkai_9/#/title)

---

## BLoC

- Riverpod and BLoC are both popular state management options in Flutter
- With Riverpod, I felt AI-generated code was less stable because the style is very flexible
- After switching to BLoC, state management has been reliable even when I mostly delegate it to AI

My impression is that stricter rules reduce generation stress and fit AI better, though I have not used BLoC deeply enough to make a stronger claim

---

## GitHub Actions

- Because the project is public, using it for free is a big advantage
- Beyond that:
  - Error details are available through CLI and API, so AI can work with them easily
  - When choosing CI/CD tools, avoid services where important information is only visible in the GUI

---

## Summary

- Even in AI-driven development, understanding the chosen technology matters
  - A good balance is to center the product on **technology you know well** while adopting new tools around it
- Claude Code / Codex for main development, Antigravity for design worked well
  - If I had to recommend only one for individual developers, I would recommend Codex
- I also introduced supporting technologies
  - OTA updates and feedback loops are especially important
