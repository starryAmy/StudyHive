// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
application.register("load-more", LoadMoreController);
application.register("message", MessageController);
application.register("blackboard", BlackboardController);
application.register("follow", FollowController);
