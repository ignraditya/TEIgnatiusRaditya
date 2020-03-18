*** Settings ***
Resource        ./resources.robot

*** Test Case ***

Point A Test Case
    Verify Get Response Status    https://jsonplaceholder.typicode.com/posts
    Verify Get Response Type

Point B Test Case
    Post An Item        {"title" : "recommendation" , "body" : "motorcycle" , "userId" : 12}
    Verify Post Status

*** Keywords ***

Verify Get Response Status
    [Arguments]     ${URL}
    GET             ${URL}                 timeout=5
    Integer         response status        200

Verify Get Response Type
    Integer         response body 0 userId
    Integer         response body 0 id
    String          response body 0 title
    String          response body 0 body

Post An Item
    [Arguments]     ${user_input}
    POST            https://jsonplaceholder.typicode.com/posts      ${user_input}

Verify Post Status
    Integer         response status       201
    String          response body title   recommendation
    String          response body body    motorcycle
    Integer         response body userId  12
