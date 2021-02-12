Feature: Smoke test features.

Scenario: Happy Path - Create Project

* def projectCreation = read('features/subsMgmtOn/projects/createProject.feature')
* def data =  read('resources/projects.json')
* def result = call projectCreation data 
