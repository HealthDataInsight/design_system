// Import and register all your controllers
import Timeago from "@stimulus-components/timeago";

import HelloWorldController from "./hello_world_controller"
import ShowPasswordController from "./show_password_controller"

export const registerControllers = (application) => {
  application.register("ds--hello-world", HelloWorldController)
  application.register("ds--show-password", ShowPasswordController)
  application.register("timeago", Timeago);
}
