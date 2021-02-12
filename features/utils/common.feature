@ignore
Feature:

Scenario:
* def getDate =
  """
  function() {
    var DateTimeFormatter = Java.type('java.time.format.DateTimeFormatter');
    var dtf = DateTimeFormatter.ISO_ZONED_DATE_TIME;
    var myNow = java.time.ZonedDateTime.now();
    myNow = myNow.plusMinutes(5);
    var ldt = myNow;
    return ldt.format(dtf);
  } 
  """

* def sleep = function(millis){ java.lang.Thread.sleep(millis) }
* def random = function(max){ return Math.floor(Math.random() * max) }
* def now = function(){ return java.lang.System.currentTimeMillis() }
