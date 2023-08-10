import { application } from "./application"

import CookieButtonsController from "./cookie_buttons_controller"
application.register("cookie-buttons", CookieButtonsController)

import CookiesController from "./cookies_controller"
application.register("cookies", CookiesController)

import ReloadController from "./reload_controller"
application.register("reload", ReloadController)

import RemovalsController from "./removals_controller"
application.register("removals", RemovalsController)
