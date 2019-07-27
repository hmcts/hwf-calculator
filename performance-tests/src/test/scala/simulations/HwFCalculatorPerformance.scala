package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._
import com.typesafe.config._



class HwFCalculatorPerformance extends Simulation
with HttpConfiguration
{
  val conf = ConfigFactory.load()
  val baseurl = conf.getString("baseUrl")
  val httpconf = httpProtocol.baseURL(baseurl).disableCaching

  val scenario1 = scenario("Happy Path for the Help with Fees Calculator")

    .exec(http("Start Session")
        .get("/"))


    //////  Marital Status  //////

    .exec(http("Marital Status")
        .put("/calculation/marital_status")
        .formParam("calculation[marital_status]", "single")
        .check(status.is(200)))


    //////  Court or Tribunal Fee //////

    .exec(http("Court or Tribunal Fee")
        .put("/calculation/fee")
        .formParam("calculation[fee]", "3000")
        .check(status.is(200)))


    //////  Date of Birth  //////

    .exec(http("Date of Birth")
        .put("/calculation/date_of_birth")
        .formParam("calculation[date_of_birth[day]]", "07")
        .formParam("calculation[date_of_birth[month]]", "02")
        .formParam("calculation[date_of_birth[year]]", "1984")
        .check(status.is(200)))


    //////  Savings and Investments  //////        

    .exec(http("Savings and Investments")
        .put("/calculation/disposable_capital")
        .formParam("calculation[disposable_capital]", "300")
        .check(status.is(200)))


    //////  Benefits Received  //////        

    .exec(http("Benefits Received")
        .put("/calculation/benefits_received")
        .formParam("calculation[benefits_received]", "dont_know")
        .check(status.is(200)))


    //////  Dependant Children  //////        

    .exec(http("Dependant Children")
        .put("/calculation/number_of_children")
        .formParam("calculation[number_of_children]", "3")
        .check(status.is(200)))


    //////  Total Income  //////        

    .exec(http("Total Income")
        .put("/calculation/total_income")
        .formParam("calculation[total_income]", "2700")
        .check(status.is(200)))


    //////  Return to Help with fees home page  //////        

    .exec(http("Return to Help with fees home page")
        .get("/"))
        .check(status.is(200)))

  val userCount = conf.getInt("users")
  val durationInSeconds  = conf.getLong("duration")

  setUp(
    scenario1.inject(rampUsers(userCount) over (durationInSeconds seconds)).protocols(httpconf)
  )

}
