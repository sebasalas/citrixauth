tell application "Citrix Secure Access"
    activate
end tell

-- Wait dynamically for the first window to appear
tell application "System Events"
    tell process "Citrix Secure Access"
        repeat until (exists window "Citrix Secure Access")
            delay 0.5 -- Check every 0.5 seconds
        end repeat

        -- Wait dynamically for the "Connect" button to appear
        tell window "Citrix Secure Access"
            repeat until (exists button "Connect")
                delay 0.5 -- Check every 0.5 seconds
            end repeat

            -- Click the "Connect" button
            click button "Connect"
        end tell

        -- Wait dynamically for the login window to appear
        repeat until (exists window "Citrix Secure Access auth")
            delay 0.5 -- Check every 0.5 seconds
        end repeat

        -- Wait dynamically for the input fields to appear
        tell window "Citrix Secure Access auth"
            repeat until (exists group 3 of group 1 of UI element 1 of scroll area 1 of group 1 of group 1)
                delay 0.5 -- Check every 0.5 seconds
            end repeat

            -- Enter the username
            tell group 3 of group 1 of UI element 1 of scroll area 1 of group 1 of group 1
                set value of text field 1 to "user"
            end tell

            -- Enter the password
            tell group 5 of group 1 of UI element 1 of scroll area 1 of group 1 of group 1
                set value of text field 1 to "password"
            end tell

            -- Retrieve the OTP using the `get_token.sh` script
            set otpCode to do shell script "~/Documents/citrixauth/utils/get_token.sh | tail -n 1"

            -- Enter the OTP into the passcode field
            tell group 7 of group 1 of UI element 1 of scroll area 1 of group 1 of group 1
                set value of text field 1 to otpCode
            end tell
        end tell
    end tell
end tell

-- Fallback: Simulate pressing the "Return" key
tell application "System Events"
    delay 0.5 -- Ensure all fields are filled before pressing Return
    key code 36 -- Press Return key
    -- log "Simulated Return key press to submit the form."
end tell
