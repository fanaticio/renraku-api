Feature: Template creation as anonymous user
  A user can add a template into an organization. A template can use some variables

  Background:
    Given I set headers:
      | Accept       | application/vnd.renraku+json; version=1 |
      | Content-Type | application/json |

  Scenario: Unauthorized template creation
    When I send a POST request to "/organizations/fanaticio/templates.json" with the following:
      """
      {
        "template": {
          "name":      "contact",
          "from":      "john.doe@mail.com",
          "body_html": "<p>Some html</p>",
          "body_text": "Some text",
          "subject":   "Thanks to contact us"
        }
      }
      """
    Then the response status should be "401"
    Then the JSON response should be:
      """
      { "error_code": "not_authenticated", "error_message": "You have to log in to perform this action" }
      """
