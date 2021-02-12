Feature: Create Projects

Scenario: Unhappy Path - Create projects
* print name
* print "Tags: ", tags
* def myJson = { name: "##(name)", type: '##(type)', description: '##(description)', tags: '#(tags)' }

* header Authorization = token
Given url poseidonHostUrl
  And path "v1", "projects"
  And request myJson
  When method post
  Then assert responseStatus == 400 || responseStatus == 401 || responseStatus == 403

* def uploadStatusCode = responseStatus