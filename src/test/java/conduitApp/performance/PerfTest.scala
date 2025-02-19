package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

import conduitApp.performance.createTokens.CreateTokens

class PerfTest extends Simulation {

  CreateTokens.createAccessTokens()

  val protocol = karateProtocol(
    "/api/articles/{articleId}" -> Nil
  )

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
  //protocol.runner.karateEnv("perf")

  val csvFeeder = csv("articles.csv").circular()

  val tokenFeeder = Iterator.continually {
  Map("token" -> CreateTokens.getNextToken)
}

  val createArticle = scenario("Create and delete article")
  .feed(tokenFeeder)
  .feed(csvFeeder)
  .exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))

  setUp(
    createArticle.inject(
        atOnceUsers(1),
        nothingFor(4),
        constantUsersPerSec(1).during(3),
        // constantUsersPerSec(2).during(10),
        // rampUsersPerSec(2).to(10).during(20.seconds),
        // nothingFor(5),
        // constantUsersPerSec(1).during(5)
        ).protocols(protocol)
  )

}