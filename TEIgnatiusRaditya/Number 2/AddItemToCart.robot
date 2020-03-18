*** Settings ***
Resource          ./resources.robot
Test Teardown     Close Browser

*** Test Case ***

Add An Item To Cart
    Open Homepage
    Login                     yegrbonband@gmail.com     testengineerbl0000
    Search With Keyword       Tas
    Choose An Item
    Verify Chosen Item Page
    Click Tambahkan ke Keranjang
    Verify Item Added To Cart


*** Keywords ***

Open Homepage
    Open Browser        http://www.bukalapak.com        Chrome

Login
    [Arguments]     ${email}      ${password}
    Sleep           5
    Wait Until Element Is Visible         sizzle=.c-btn.js-track-login        timeout=5
    Click Element                         sizzle=.c-btn.js-track-login
    Sleep           3
    Wait Until Element Is Visible         sizzle=#user_session_username       timeout=5
    Input Text                            sizzle=#user_session_username       ${email}
    Wait Until Element Is Visible         sizzle=#user_session_password       timeout=5
    Input Text                            sizzle=#user_session_password       ${password}
    Click Element                         sizzle=.c-btn--spinner__text:contains("Login")
    Sleep           5

Search With Keyword
    [Arguments]     ${item}
    Sleep           10
    Wait Until Element Is Visible          sizzle=#v-omnisearch__input         timeout=5
    Input Text                             sizzle=#v-omnisearch__input         ${item}
    Press Keys                             sizzle=#v-omnisearch__input          \ue007

Choose An Item
    ${total_item}=              Get Length       sizzle=.product__name
    ${item_number}              Evaluate         random.randint(0,${total_item}-1)      modules=random
    Scroll Element Into View                     sizzle=.product__name:nth(${item_number})
    ${item_name}=               Get Text         sizzle=.product__name:nth(${item_number})
    Click Element                                sizzle=.product__name:nth(${item_number})
    Set Test Variable           ${item_name}

Verify Chosen Item Page
    Sleep           10
    Wait Until Element Is Visible                sizzle=.c-product-detail__name       timeout=5
    ${chosen_item_name}=        Get Text         sizzle=.c-product-detail__name
    Should Be True          '${item_name}'=='${chosen_item_name}'

Click Tambahkan ke Keranjang
    Scroll Element Into View                sizzle=.c-btn--spinner__text:contains("Tambahkan ke Keranjang")
    Click Item                              sizzle=.c-btn--spinner__text:contains("Tambahkan ke Keranjang")

Verify Item Added To Cart
    Sleep           10
    Wait Until Element Is Visible           sizzle=.c-dialog__panel__title            timeout=5
    ${item_in_cart}=            Get Text    sizzle=.c-cart-dialog__item__name a
    Should Be True                          '${item_in_cart}'=='chosen_item_name'
    Click Element                           sizzle=.c-cart-dialog__cart-button
    Wait Until Element Is Visible           sizzle=.bl-text--subheading-1:contains("Keranjang belanja")
    Wait Until Element Is Visible           sizzle=.qa-item-name:contains("${item_in_cart}")
