# Working Resources List (user-requested tracking for removal after session)

Last updated: 2026-10-18 (device-confirmed build installed; user installed emulator; Xcode installed; design assets merged)

## Installed / Added by User During This Session
- Xcode (macOS App Store / developer download) — for iOS device/simulator builds
- Android SDK / Emulator (installed by user at /Users/rajput-hemant/Library/Android/sdk) — emulator now working (was missing earlier)
- T3 Code device integration (user installed, device RZCW70616TX linked)
- Current installed APK: build/app/outputs/flutter-apk/app-debug.apk (version 0.2.5, versionCode 7), built Oct 18 01:26
- Icon assets added to repo: android adaptive icon (mipmap-anydpi-v26/ic_launcher.xml + drawable + values), iOS AppIcon.appiconset (1024 + 1024-dark), assets/images/app_icon.png (512x512 PNG, theme-aligned: light #005EB2 / dark #A7C8FF / neutral #2D3237)
- Design files added: design/app-icon/app-icon-master.svg, README.md
- Cleaned leftover worktree: /Users/rajput-hemant/.t3/worktrees/calculator/t3-5e3610df (returned/removed)

## Not Yet Removed / Pending
- GitHub issues #134 (calc precision), #73 (text selection caret), #199 (release APK dependency info block) — confirmed fixed on device but NOT yet closed (user: close after release)
- User confirmation needed: 8-row scientific grid OK? Cut keys for 6-row? Scientific mode test result on physical device?
- Design reference captured 2026-10-18 via heavy-wrapped adb: device RZCW70616TX, system calculator (com.android.calculator2) screen captured, saved design/reference/reference.png (1080x2340 PNG, 87365 bytes)

## What to Remove After Session (per user instruction)
- Any temporary .env / build artifacts outside repo control
- Leftover .t3 worktrees (already returned; verify with `git worktree list`)
- Installed APK from device (optional: `adb uninstall com.capybara.calculator`)
- Emulator/SDK installation (only if user wants it removed)

## Device access rules (user, 2026-10-18)

- An emulator is connected to T3 code devices. Any subagent may use it for testing its fixes.
- Mutual exclusion: only ONE agent or subagent may access a device (emulator or physical RZCW70616TX) at a time.
- Enforcement: every device-touching command (adb install, screencap, am start, flutter devices checks) must go through the `heavy` wrapper, which is a machine-wide single-slot lock. Same rule as builds/tests.
