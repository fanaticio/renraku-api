Feature: User creation as anonymous user
  A user must have at least an organization, and an organization must have a creator.
  So, when a guest wants to create an account, he has to create his organization

  Background:
    Given I set headers:
      | Accept       | application/vnd.renraku+json; version=1 |
      | Content-Type | application/json |

  Scenario: User creation
    When I send a POST request to "/users.json" with the following:
      """
      {
        "organization_name": "awesome-account",
        "user": {
          "login":    "jdoe",
          "email":    "john.doe@mail.com",
          "password": "pa55w0rd"
        }
      }
      """
    Then the response status should be "200"
    Then the JSON response should be:
      """
      { "login": "jdoe", "auth_token": "generated-token", "organizations": [{ "name": "awesome-account" }] }
      """

  Scenario: User creation error missing parameter
    When I send a POST request to "/users.json" with the following:
      """
      { "organization_name": "awesome-account", "user": { "login": "jdoe", "password": "pa55w0rd" }}
      """
    Then the response status should be "400"
    Then the JSON response should be:
      """
      {
        "error_code":    "missing_parameters",
        "error_message": "You forgot to send some parameters",
        "fields":  [
          { "field": "email", "message": "is required" }
        ]
      }
      """

  Scenario: User creation error unpermitted parameter
    When I send a POST request to "/users.json" with the following:
      """
      {
        "organization_name": "awesome-account",
        "user": {
          "login":    "jdoe",
          "email":    "john.doe@mail.com",
          "password": "pa55w0rd"
        },
        "unexpected": "parameter"
      }
      """
    Then the response status should be "400"
    Then the JSON response should be:
      """
      {
        "error_code":    "unpermitted_parameters",
        "error_message": "You add some unexpected parameters",
        "fields":  [
          { "field": "unexpected", "message": "is not permitted" }
        ]
      }
      """

  Scenario: User creation error when user with same email already exist
    When I send a POST request to "/users.json" with the following:
      """
      {
        "organization_name": "awesome-account",
        "user": {
          "login":    "jdoe",
          "email":    "already-taken@mail.com",
          "password": "pa55w0rd"
        }
      }
      """
    Then the response status should be "403"
    Then the JSON response should be:
      """
      {
        "error_code":    "validation",
        "error_message": "Some fields cannot be validated",
        "fields": [
          { "email": ["is already taken"] }
        ]
      }
      """

  Scenario: User creation error when user with same login already exist
    When I send a POST request to "/users.json" with the following:
      """
      {
        "organization_name": "awesome-account",
        "user": {
          "login":    "ataken",
          "email":    "john.doe@mail.com",
          "password": "pa55w0rd"
        }
      }
      """
    Then the response status should be "403"
    Then the JSON response should be:
      """
      {
        "error_code":    "validation",
        "error_message": "Some fields cannot be validated",
        "fields": [
          { "login": ["is already taken"] }
        ]
      }
      """

  Scenario: User creation error when user already create this organization
    When I send a POST request to "/users.json" with the following:
      """
      {
        "organization_name": "already-taken-account",
        "user": {
          "login":    "jdoe",
          "email":    "john.doe@mail.com",
          "password": "pa55w0rd"
        }
      }
      """
    Then the response status should be "403"
    Then the JSON response should be:
      """
      {
        "error_code":    "validation",
        "error_message": "Some fields cannot be validated",
        "fields": [
          { "organization_name": ["is already taken"] }
        ]
      }
      """

  Scenario: User creation error when user use a too short password
    When I send a POST request to "/users.json" with the following:
      """
      {
        "organization_name": "awesome-account",
        "user": {
          "login":    "jdoe",
          "email":    "john.doe@mail.com",
          "password": "short"
        }
      }
      """
    Then the response status should be "403"
    Then the JSON response should be:
      """
      {
        "error_code":    "validation",
        "error_message": "Some fields cannot be validated",
        "fields": [
          { "password": ["is too short (minimum is 8 characters)"] }
        ]
      }
      """
