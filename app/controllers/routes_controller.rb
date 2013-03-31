class RoutesController < ApplicationController
  def latest
    @routes = Route.latest

    respond_to do |format|
      format.atom # renders latest.atom.builder
    end
  end
end
