# Antigravity Account Switcher for macOS (`agyacc`)

[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg?style=flat-square)](https://apple.com/macos)
[![Shell](https://img.shields.io/badge/shell-bash-4EAA25.svg?style=flat-square)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![Google Antigravity](https://img.shields.io/badge/Antigravity-IDE-4285F4.svg?style=flat-square)](https://antigravity.google)

A fast, reliable, zero-dependency command-line utility to manage and seamlessly switch between multiple **Google Antigravity** accounts on macOS. 

Switch profiles with **1 command** without losing your active sessions or opening a browser to re-authenticate.

---

## ⚡ Features

- **🚀 1-Command Fast Switch**: Switch between accounts instantly by profile name (`agyacc work`), full email (`agyacc user@gmail.com`), or email username (`agyacc user`).
- **📧 Smart Email Resolution**: Automatically maps email addresses and prefixes to the correct saved profile—no need to remember exact custom profile names.
- **🔄 Dual-Sync Session Management**: Keeps both the **macOS Keychain** (`security`) and local on-disk OAuth cache (`~/.gemini/jetski-standalone-oauth-token`) synchronized to prevent session rollbacks or auto-login loops.
- **🛡️ Crash-Proof & Multi-User Safe**: Uses native AppleScript events with user-isolated process management (`-u $UID`), preventing cross-user conflicts on shared MacBooks with Fast User Switching.
- **✨ Auto-Refresh Resilient Status**: Decodes token claims and refresh tokens so the active indicator (`● active`) remains accurate even after Google auto-refreshes the OAuth access token.
- **🔒 Secure by Design**: Stored tokens are backed up locally with strict permissions (`chmod 600`). Zero external network calls or tracking.
- **🎨 Modern CLI Experience**: ANSI colored terminal output, clean subcommand syntax, and linked email display in profile lists.

---

## 📦 Installation

### Quick Install (One-Liner)

Run the following command in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/mak0099/antigravity-account-switcher-macos/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/mak0099/antigravity-account-switcher-macos.git
cd antigravity-account-switcher-macos
chmod +x bin/agyacc
sudo cp bin/agyacc /usr/local/bin/agyacc
```

Verify installation:
```bash
agyacc version
```

---

## 🚀 Quick Start (2-Account Setup)

### Step 1: Save your 1st Account
Make sure you are logged into Antigravity with your primary Google account, then run:
```bash
agyacc save work
```

### Step 2: Clear Session & Login with 2nd Account
Clear the current credentials to prepare for the second login:
```bash
agyacc new
```
Antigravity will relaunch with a clean slate. Complete the normal sign-in flow in your browser with your secondary Google account.

### Step 3: Save your 2nd Account
Once signed in, save this session:
```bash
agyacc save personal
```

---

## 🪄 Instant Switching

Switch accounts anytime using any of the following formats:

```bash
# By profile name:
agyacc work
agyacc personal

# By full Google email address:
agyacc john.doe@gmail.com

# By email username (prefix before @):
agyacc john.doe
```

### Check Active Profile & Accounts:
Run `agyacc` with no arguments to view all profiles, associated Google accounts, and the currently active session:

```bash
agyacc
```

Example output:
```text
Available Profiles:
----------------------------------------
    personal (john.personal@gmail.com)
  ● work (john.work@gmail.com) (active)
----------------------------------------

Current Session Status:
  Active Profile : work (john.work@gmail.com)
```

---

## 📖 Command Reference

| Command | Description |
| :--- | :--- |
| `agyacc <name\|email>` | Fast-switch directly by profile name, full email, or username prefix. |
| `agyacc` or `agyacc list` | List all saved profiles with linked Google emails and active status. |
| `agyacc save <name>` | Save current login session under `<name>`. |
| `agyacc switch <name\|email>` | Switch to account and relaunch Antigravity. |
| `agyacc new` | Clear all Keychain and on-disk session tokens for a clean login. |
| `agyacc rm <name\|email>` | Delete a saved profile. |
| `agyacc rename <old> <new>` | Rename an existing profile. |
| `agyacc status` | Display the currently active profile and linked email. |
| `agyacc version` | Display tool version. |
| `agyacc help` | Show help and usage instructions. |

---

## ⚙️ How It Works Under the Hood

1. **Keychain & Token Cache Integration**: Antigravity stores OAuth tokens in macOS Keychain (`service: "gemini"`, `account: "antigravity"` via Go keyring base64) and mirrors them in `~/.gemini/jetski-standalone-oauth-token`.
2. **Session Persistence**: When running `agyacc save <name>`, the token payload is stored inside a protected directory (`~/.antigravity_profiles/` with `chmod 600`).
3. **Dual-Sync on Switch**: Upon switching, `agyacc` updates both the macOS Keychain and decodes the payload into `~/.gemini/jetski-standalone-oauth-token`, ensuring both the language server and the Electron UI read the exact same credentials.
4. **Graceful App Restart**: Signals Antigravity to quit gracefully via AppleScript, waits until the process has completely deregistered from LaunchServices, and relaunches the app.

---

## 🗑️ Uninstallation

To remove `agyacc` from your system:

```bash
curl -fsSL https://raw.githubusercontent.com/mak0099/antigravity-account-switcher-macos/main/uninstall.sh | bash
```

Or delete the binary manually:
```bash
sudo rm -f /usr/local/bin/agyacc
```

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
