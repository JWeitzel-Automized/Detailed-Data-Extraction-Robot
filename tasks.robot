*** Settings ***
Documentation       Perform a detailed extraction of the Davco data.

Library             RPA.Browser.Selenium    auto_close=${FALSE}
Library             RPA.HTTP
Library             RPA.Windows
Library             RPA.Tables


*** Tasks ***
Extract the detailed data
    Open the web browser
    Log in
    Navigate to companies
    ${companies_list}=    Use the companies CSV
    FOR    ${company}    IN    @{companies_list}
        Go to company page    ${company}[ID]
        Get documents
        BREAK
    END


*** Keywords ***
Open the web browser
    Open Available Browser    https://app.centerpointconnect.com/#!/login

Log in
    Wait Until Element Is Visible    email
    Input Text    email    Jhedrick@davcoroofing.com
    Input Password    password    JoHe8057
    Click Button    Sign in

Navigate to companies
    Wait Until Element Is Visible    //a[contains(@href, '/#!/home')]    timeout=20secs
    Go To    https://app.centerpointconnect.com/#!/companies

Use the companies CSV
    ${companies_list}=    Read table from CSV    companies-3-2023-05-01.csv
    RETURN    ${companies_list}

Go to company page
    [Arguments]    ${ID}
    Go To    https://app.centerpointconnect.com/#!/companies/${ID}

Get documents
