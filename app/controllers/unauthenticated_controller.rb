class UnauthenticatedController < ApplicationController
  skip_before_filter :authenticate!
end
