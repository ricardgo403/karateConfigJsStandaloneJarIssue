Feature: Create Projects

Scenario: Happy Path - Create projects
* def utils = call read('features/utils/common.feature')
* print name

* eval utils.sleep(myRandom * 1000)
* def uName = name + utils.now()
* print "The generated name is ", uName
* print "Tags: ", tags
* def myJson = { name: "#(uName)", type: '#(type)', description: '##(description)', tags: '#(tags)' }

* header Authorization = token
Given url poseidonHostUrl
  And path "v1", "projects"
  And request myJson
  When method post
  Then status 201
  And match response contains { id: '#notnull', name: '#string' }

* string projectId = response.id

* header Authorization = token
Given url poseidonHostUrl
  And path "v1", "projects", projectId
  When method get
  Then status 200
  And match response contains { id: '#(projectId)', name: '#string' }

* header Authorization = token
Given url poseidonHostUrl
  And path "v1", "projects", projectId, 'archive'
  And request ''
  When method put
  Then status 200
