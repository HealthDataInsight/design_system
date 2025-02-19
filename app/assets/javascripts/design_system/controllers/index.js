// Import and register all your controllers
import HelloWorldController from "./hello_world_controller"
// import OtherController from "./other_controller"

console.log('loaded')

export const registerControllers = (application) => {
  application.register("ds--hello-world", HelloWorldController)
  // application.register("ds--other", OtherController)
}
