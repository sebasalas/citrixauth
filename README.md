# Citrix Secure Access Automation

> Note: This project is intended for internal or enterprise use, as it requires credentials and configuration files typically provided by your organization.

This project automates the login process for **Citrix Secure Access** on macOS using AppleScript and `expect`. AppleScript is used to control UI interactions, while `expect` handles terminal automation such as entering passwords or responding to prompts.

It performs the following steps:

- Clicking the "Connect" or "Conectar" button.
- Filling in the username, password, and one-time password (OTP).
- Submitting the form using the `Return` key.

The scripts are designed to securely externalize sensitive information and make them configurable for different users. The paths to configuration files are determined dynamically, making the scripts more portable and easier to manage.

## Features

- Automates the full Citrix login process.
- Dynamically waits for UI elements to load.
- Uses a secure OTP generation script (`stoken`).
- Supports configurable credentials and dynamic path resolution through `config.sh`, improving portability across systems.

## Prerequisites

1. **macOS** with support for AppleScript and `expect`.

    - AppleScript can be executed via the `osascript` command, which should be available by default.
    - Make sure both `osascript` and `expect` are available in your terminal by running:

     ```bash
     which osascript
     which expect
     ```

2. **Install and configure `stoken` for OTP generation:**

   `stoken` is used to generate the temporary one-time password (OTP) for authentication. Follow these steps:

   > Note: The `.sdtid` file is typically provided by your organization for RSA token-based authentication.

   1. Install `stoken`:

      ```bash
      brew install stoken
      ```

   2. In the directory where your `.sdtid` token file is located, run:

      ```bash
      stoken import --file=FILENAME.sdtid --force
      ```

   3. You will be prompted to create a **master password**. This password will be required each time you want to generate a token.

   4. To test the setup:

      ```bash
      stoken
      ```

      Enter your password when prompted. A token should be displayed if everything is set up correctly.

   For more information, visit the [stoken GitHub page](https://github.com/stoken-dev/stoken).

3. A working Citrix Secure Access installation. You can download it from your organization's internal software portal or the official Citrix site, depending on your enterprise setup.

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
export TOKEN_PASSWORD="YOUR_STOKEN_PASSWORD"  # Your stoken password used to unlock OTPs
export CITRIX_SCRIPT_DIR="$HOME/Documents/citrixauth"  # Path to the project directory
```

The scripts dynamically locate `config.sh` and other files using the `CITRIX_SCRIPT_DIR` variable. Ensure this variable is correctly set in `config.sh` and matches the project location on your system.

> Important: Never commit `config.sh` to version control, as it contains sensitive information. Confirm that `utils/config.sh` is listed in `.gitignore`.

3. Make the script executable:

```bash
chmod +x utils/get_token.sh
```

## Usage

1. Load the configuration file to set environment variables:

```bash
source utils/config.sh
```

2. Launch the automation script:

```bash
osascript citrixauth.scpt
```

## Workflow Overview

- The script launches Citrix Secure Access.
- It uses AppleScript to detect when the login window is ready.
- It securely retrieves credentials and OTP from environment variables or helper scripts.
- It silently simulates keyboard input to fill in the login form and submits it, requiring no user interaction once running.

## Troubleshooting

### Error: "execution error: System Events got an error: osascript is not allowed assistive access."

If you encounter this error, it means your terminal application (e.g., Terminal, iTerm2) does not have the necessary permissions to use assistive access. To resolve this:

1. Open **System Settings** on your Mac.
2. Go to **Privacy & Security** > **Accessibility**.
3. Locate your terminal application (e.g., Terminal, iTerm2) in the list.

   - If it’s not listed, click the `+` button, and manually add it from the `/Applications` folder.

4. Enable the checkbox next to your terminal application to grant it permission.
5. Re-run the command:

```bash
osascript citrixauth.scpt
```

## File Structure

```bash
citrixauth/
├── citrixauth.scpt # Main AppleScript automation
├── utils/
│   ├── get_token.sh # OTP retrieval using `stoken`
│   ├── config.sh # User-specific configuration (excluded from Git)
└── README.md # Project documentation
```

> Note: The `config.sh` file must be created manually by each user and should never be committed to the repository.

## Security Best Practices

- **Do not share your `config.sh` file**. It contains sensitive credentials.
- Use configuration files to keep credentials secure and easy to manage.
- **Always add `utils/config.sh` to `.gitignore`** to prevent accidental uploads.
