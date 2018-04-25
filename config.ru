require './config/environment'

use Rack::MethodOverride
use UserController
use SeedController
run ApplicationController
