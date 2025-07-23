// Import and register all your controllers
import HelloWorldController from './controllers/hello_world_controller'
import ShowPasswordController from './controllers/show_password_controller'
import Timeago from '@stimulus-components/timeago'

// Register design system controllers with Stimulus
export const registerControllers = (application) => {
  application.register('ds--hello-world', HelloWorldController)
  application.register('ds--show-password', ShowPasswordController)
  application.register('timeago', Timeago)
}
