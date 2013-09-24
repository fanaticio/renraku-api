Feature: Organization detail as authenticated user
  A user can show its organization detail.

  Background:
    Given I set headers:
      | Accept        | application/vnd.renraku+json; version=1 |
      | Authorization | Token token="already-generated-token" |
      | Content-Type  | application/json |

  Scenario: Organization detail
    When I send a GET request to "/organizations/already-taken-account.json"
    Then the response status should be "200"
    Then the JSON response should be:
      """
      { "name": "already-taken-account", "owner": "ataken", "templates": [], "templates_count": 0 }
      """

  Scenario: Organization detail error bad organization
    When I send a GET request to "/organizations/fanaticio.json"
    Then the response status should be "403"
    Then the JSON response should be:
      """
      {
        "error_code":    "validation",
        "error_message": "Some fields cannot be validated",
        "fields": [
          { "organization_name": ["does not exist"] }
        ]
      }
      """
