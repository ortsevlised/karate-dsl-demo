package performance
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol("users/{}"->Nil)

 // protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val createUser = scenario("create").exec(karateFeature("classpath:features/users/CreateUser.feature"))
 // val delete = scenario("delete").exec(karateFeature("classpath:mock/cats-delete.feature@name=delete"))

  setUp(
    createUser.inject(
      nothingFor(4.seconds), // 1
      atOnceUsers(10), // 2
      rampUsers(10).during(5.seconds), // 3
      constantUsersPerSec(20).during(15.seconds), // 4
      constantUsersPerSec(20).during(15.seconds).randomized, // 5
      rampUsersPerSec(10).to(20).during(10.seconds), // 6
      rampUsersPerSec(10).to(20).during(10.seconds).randomized, // 7
      heavisideUsers(1000).during(20.seconds) // 8
    ).protocols(protocol)
  )

}