// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "ds-stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import { registerControllers } from "design_system/controllers"
registerControllers(application)
