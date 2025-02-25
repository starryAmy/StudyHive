// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
import LoadMoreController from "controllers/load_more_controller";
import MessageController from "controllers/message_controller";
import BlackboardController from "controllers/blackboard_controller";
import FollowController from "controllers/follow_controller";
import GiphyController from "controllers/giphy_controller";
import VoteController from "controllers/vote_controller";
eagerLoadControllersFrom("controllers", application);
application.register("load-more", LoadMoreController);
application.register("message", MessageController);
application.register("blackboard", BlackboardController);
application.register("follow", FollowController);
application.register("vote", VoteController);
application.register("giphy", GiphyController);
