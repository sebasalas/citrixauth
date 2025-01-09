# Citrix Secure Access Automation

This project automates the login process for **Citrix Secure Access** on macOS using AppleScript and `expect`. It handles:

- Clicking the "Connect" or "Conectar" button.
- Filling in the username, password, and one-time password (OTP).
- Submitting the form using the `Return` key.

The scripts are designed to securely externalize sensitive information and make them configurable for different users. The paths to configuration files are determined dynamically, making the scripts more portable and easier to manage.

## Features

- Automates the full Citrix login process.
- Dynamically waits for UI elements to load.
- Uses a secure OTP generation script (`stoken`).
- Supports configurable credentials through `config.sh`.
- Dynamic path resolution for locating configuration files, eliminating hardcoded paths.

## Prerequisites

1.  **macOS** with support for AppleScript and `expect`.

2.  `stoken` installed for OTP generation. Install it with:

```bash
brew install stoken
```
For more information about stoken and its functionality, visit the [stoken GitHub page](https://github.com/stoken-dev/stoken).

3. A working Citrix Secure Access installation.

## Installation

1. Clone the repository:
```bash
git clone https://github.com/sebasalas/citrixauth.git
cd citrixauth
```

2. Create and edit the `utils/config.sh` file to include your credentials:
```bash
# utils/config.sh
export CITRIX_USER="YOUR_USERNAME"  # Your Citrix username
export CITRIX_PASSWORD="YOUR_PASSWORD"  # Your Citrix password
export TOKEN_PASSWORD="YOUR_STOKEN_PASSWORD"  # Your stoken password
export CITRIX_SCRIPT_DIR="$HOME/Documents/citrixauth"  # Path to the project directory
```
The scripts dynamically locate `config.sh` and other files using the `CITRIX_SCRIPT_DIR` variable. Ensure this variable is correctly set in `config.sh` and matches the project location on your system.

3. Make the script executable:
```bash
chmod +x utils/get_token.sh
```

## Usage
1. Source the configuration file to load credentials:
```bash
source utils/config.sh
```
2. Run the AppleScript:
```bash
osascript citrixauth.scpt
```
3. After running the script, it will:
- Open Citrix Secure Access.
- Wait for UI elements dynamically.
- Automate the login process.

## File Structure
```bash
citrixauth/
├── citrixauth.scpt # Main AppleScript automation
├── utils/
│ ├── get_token.sh # OTP retrieval using `stoken`
│ ├── config.sh # User-specific configuration (excluded from Git)
└── README.md # Project documentation
```

## Security Considerations

-  **Do not share your `config.sh` file**. It contains sensitive credentials.
- Use configuration files to keep credentials secure and easy to manage.
- **Always add `utils/config.sh` to `.gitignore`** to prevent accidental uploads.
