import { application } from "./application"

import ReloadController from "./reload_controller"
application.register("reload", ReloadController)

import RemovalsController from "./removals_controller"
application.register("removals", RemovalsController)

import CookiesController from "./cookies_controller"
application.register("cookies", CookiesController)
