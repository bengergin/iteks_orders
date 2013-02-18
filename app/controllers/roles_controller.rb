class RolesController < ApplicationController
  def new
    @role = Role.new
    render :partial => @role if request.xhr?
  end
end
