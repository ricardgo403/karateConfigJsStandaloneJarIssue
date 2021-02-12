function fn() {
  const env = karate.env
  karate.log("karate.env system property was:", env)
  if (!env) {
    env = "dev" // env can be anything: dev, qa, staging, etc.
  }
  const settings = read("configs.json")
  karate.log("settings:", settings)
  
  var config = {
    env: env,
    poseidonHostUrl: settings[env].poseidonHost,
    apolloHostUrl: settings[env].apolloHost,
    oneWayTemplateId: settings[env].oneWayTemplateId,
    scratchTemplateId: settings[env].scratchTemplateId,
  }

  if (env == "stg" || env == "dev" || env == "prd") {
    config.token = read("resources/token.txt")
    config.subOffToken = read("resources/subOffToken.txt")
  }

  karate.configure("connectTimeout", 5000)
  karate.configure("readTimeout", 5000)

  return config
}
