Feature: User creation as authenticated user
  Th use case is defined in the anonymous feature

  Background:
    Given I set headers:
      | Accept        | application/vnd.renraku+json; version=1 |
      | Authorization | Token token="already-generated-token" |
      | Content-Type  | application/json |

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
    Then the response status should be "401"
    Then the JSON response should be:
      """
      { "error_code": "authenticated", "error_message": "You have to log out to perform this action" }
      """
