// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "ds-stimulus-loading"
import { registerControllers } from 'design_system/controllers'

eagerLoadControllersFrom("controllers", application)

// window.Stimulus needs to be defined before importing any Design System Stimulus controllers
registerControllers(application)
