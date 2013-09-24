Feature: Organization detail as anonymous user
  Th use case is defined in the authenticated feature

  Background:
    Given I set headers:
      | Accept       | application/vnd.renraku+json; version=1 |
      | Content-Type | application/json |

  Scenario: Unauthorized organization detail
    When I send a GET request to "/organizations/fanaticio.json"
    Then the response status should be "401"
    Then the JSON response should be:
      """
      { "error_code": "not_authenticated", "error_message": "You have to log in to perform this action" }
      """
