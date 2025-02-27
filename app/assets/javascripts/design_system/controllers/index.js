// Import and register all your controllers
import Timeago from "@stimulus-components/timeago";

import HelloWorldController from "./hello_world_controller"
// import OtherController from "./other_controller"

export const registerControllers = (application) => {
  application.register("ds--hello-world", HelloWorldController)
  // application.register("ds--other", OtherController)
  application.register("timeago", Timeago);
}
