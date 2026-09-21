# Antigravity Account Switcher for macOS (`agyacc`)

[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg?style=flat-square)](https://apple.com/macos)
[![Shell](https://img.shields.io/badge/shell-bash-4EAA25.svg?style=flat-square)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![Google Antigravity](https://img.shields.io/badge/Antigravity-IDE-4285F4.svg?style=flat-square)](https://antigravity.google)

A fast, reliable, zero-dependency command-line utility to manage and seamlessly switch between multiple **Google Antigravity** accounts on macOS. 

Switch profiles with **1 command** without losing your active sessions or opening a browser to re-authenticate.

---

## ⚡ Features

- **🚀 1-Command Fast Switch**: Switch between accounts instantly (`agyacc work` or `agyacc personal`).
- **🛡️ Crash-Proof Shutdown**: Uses native AppleScript events to gracefully quit Antigravity, preventing language server disconnects and unexpected server crashes.
- **🔒 Secure by Design**: Stored tokens are backed up locally with strict permissions (`chmod 600`) and managed via native **macOS Keychain** (`security`). Zero external network calls.
- **🔄 No Browser Re-Login**: Tokens are saved locally, eliminating repetitive OAuth browser pop-ups.
- **🎨 Modern CLI Experience**: ANSI colored terminal output, interactive confirmations, active profile indicators (`● active`), and intuitive subcommand syntax.

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
Clear the current Keychain credentials to prepare for the second login:
```bash
agyacc new
```
Antigravity will relaunch. Complete the normal sign-in flow in the browser with your secondary Google account.

### Step 3: Save your 2nd Account
Once signed in, save this session:
```bash
agyacc save personal
```

---

## 🪄 Instant Switching

Now you are fully configured! Switch accounts anytime using a single command:

```bash
agyacc work      # Instantly switches to the 'work' profile
agyacc personal  # Instantly switches to the 'personal' profile
```

You can also view all saved profiles and see which one is currently active:
```bash
agyacc
```

Example output:
```text
Available Profiles:
----------------------------------------
  ● personal (active)
    work
----------------------------------------

Current Session Status:
  Active Profile : personal
```

---

## 📖 Command Reference

| Command | Description |
| :--- | :--- |
| `agyacc <profile>` | Fast-switch directly to the specified profile. |
| `agyacc` or `agyacc list` | List all saved profiles with current active status. |
| `agyacc save <name>` | Save current Keychain session under `<name>`. |
| `agyacc switch <name>` | Switch to `<name>` and relaunch Antigravity. |
| `agyacc new` | Clear current credentials and prepare for a fresh login. |
| `agyacc rm <name>` | Delete a saved profile. |
| `agyacc rename <old> <new>` | Rename an existing profile. |
| `agyacc status` | Display the currently active profile name. |
| `agyacc version` | Display tool version. |
| `agyacc help` | Show help and usage instructions. |

---

## ⚙️ How It Works Under the Hood

1. **Keychain Integration**: Antigravity on macOS stores auth session tokens inside the macOS Keychain under service `gemini` and account `antigravity`.
2. **Session Persistence**: When you run `agyacc save <name>`, the token is extracted using `security find-generic-password` and stored inside a protected directory (`~/.config/antigravity_profiles/` with `chmod 600`).
3. **Graceful App Restart**: Upon switching, `agyacc` instructs Antigravity to quit gracefully via AppleScript (`osascript -e 'quit app "Antigravity"'`), ensuring child processes and language servers terminate cleanly without corrupting open workspaces or displaying server crash alerts.
4. **Credential Swap**: It updates the Keychain entry with `security add-generic-password -U` and relaunches the application with the new credentials loaded.

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
