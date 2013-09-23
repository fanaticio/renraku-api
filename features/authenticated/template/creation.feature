Feature: Template creation as authn=enticated user
  Th use case is defined in the authenticated feature

  Background:
    Given I set headers:
      | Accept        | application/vnd.renraku+json; version=1 |
      | Authorization | Token token="already-generated-token" |
      | Content-Type  | application/json |

  Scenario: template creation without variables
    When I send a POST request to "/organizations/already-taken-account/templates.json" with the following:
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
    Then the response status should be "200"
    Then the JSON response should be:
      """
      { "name": "contact" }
      """

  Scenario: template creation with variables
    When I send a POST request to "/organizations/already-taken-account/templates.json" with the following:
      """
      {
        "template": {
          "name":      "contact",
          "from":      "john.doe@mail.com",
          "body_html": "<p>Some html</p>",
          "body_text": "Some text",
          "subject":   "Thanks to contact us",
          "variables": [
            { "name": "fullname" },
            { "name": "signature", "default_value": "Your admin" }
          ]
        }
      }
      """
    Then the response status should be "200"
    Then the JSON response should be:
      """
      { "name": "contact" }
      """

  Scenario: template creation error missing parameter
    When I send a POST request to "/organizations/already-taken-account/templates.json" with the following:
      """
      {
        "template": {
          "name":      "contact",
          "body_html": "<p>Some html</p>",
          "body_text": "Some text",
          "subject":   "Thanks to contact us"
        }
      }
      """
    Then the response status should be "400"
    Then the JSON response should be:
      """
      {
        "error_code":    "missing_parameters",
        "error_message": "You forgot to send some parameters",
        "fields": [
          { "field": "from", "message": "is required" }
        ]
      }
      """

  Scenario: template creation error unpermitted parameter
    When I send a POST request to "/organizations/already-taken-account/templates.json" with the following:
      """
      {
        "template": {
          "name":      "contact",
          "body_html": "<p>Some html</p>",
          "body_text": "Some text",
          "subject":   "Thanks to contact us",
          "another":   "parameter"
        }
      }
      """
    Then the response status should be "400"
    Then the JSON response should be:
      """
      {
        "error_code":    "unpermitted_parameters",
        "error_message": "You add some unexpected parameters",
        "fields": [
          { "field": "another", "message": "is not permitted" }
        ]
      }
      """

  Scenario: template creation error bad organization
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
