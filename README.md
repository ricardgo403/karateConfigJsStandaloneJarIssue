# Issue in Karate 0.9.9.RC4 (2021-02-09) Standalone Jar

## Description
- I followed the developer guide provided by intuit/karate repo to build the jar, and till this point, everything looked great, because all the unit tests passed and the built was successful. [Build JAR](https://github.com/intuit/karate/wiki/Developer-Guide#build-standalone-jar-and-zip)


- Then I tried to run my already built and functional test suites with this JAR, but unfortunately, it didn't go as expected.

- The issue is when running using the following command:

```bash
java -jar karate.jar -e=dev smoke.feature
```

The run is stopped by an error, an exception thrown when reading from within the **karate-config.js** file some *JSON* and *txt* files.

```bash
ERROR com.intuit.karate - smoke.feature:5
* def projectCreation = read('features/subsMgmtOn/projects/createProject.feature')
smoke.feature:3
karate-config.js
>>>> js failed:
01: function fn() {
    ...
}
<<<<
org.graalvm.polyglot.PolyglotException: java.io.FileNotFoundException: null/configs.json (No such file or directory)
- com.intuit.karate.resource.FileResource.getStream(FileResource.java:94)
- com.intuit.karate.core.ScenarioFileReader.readFileAsStream(ScenarioFileReader.java:101)
- com.intuit.karate.core.ScenarioFileReader.readFileAsString(ScenarioFileReader.java:97)
- com.intuit.karate.core.ScenarioFileReader.readFile(ScenarioFileReader.java:53)
- com.intuit.karate.core.ScenarioEngine.lambda$new$0(ScenarioEngine.java:115)
- <js>.fn(Unnamed:7)
```

And as you can see the file **configs.json** is on the root path, in the latest stable version there was no problem with it.

So to me, the expected result was running the already known command and expect that all the features passed successfully.

It seems to me that the problem might be in the read function because when I asked about it a solution was provided, that was adding the *file:* prefix to the file path string; it worked. But then, when the smoke.feature called the features files it threw the same error/exception.

```bash
10:54:38.066 [main]  ERROR com.intuit.karate - smoke.feature:5
* def projectCreation = read('features/subsMgmtOn/projects/createProject.feature')
>>>> js failed:
01: read('features/subsMgmtOn/projects/createProject.feature')
<<<<
org.graalvm.polyglot.PolyglotException: java.io.FileNotFoundException: null/features/subsMgmtOn/projects/createProject.feature (No such file or directory)
- com.intuit.karate.resource.FileResource.getStream(FileResource.java:94)
- com.intuit.karate.core.FeatureParser.parse(FeatureParser.java:73)
- com.intuit.karate.core.Feature.read(Feature.java:66)
- com.intuit.karate.core.ScenarioFileReader.readFile(ScenarioFileReader.java:64)
- com.intuit.karate.core.ScenarioEngine.lambda$new$0(ScenarioEngine.java:115)
- <js>.:program(Unnamed:1)
```