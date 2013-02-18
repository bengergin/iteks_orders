class ContractsController < ApplicationController
  
  def destroy
    Contract.find(params[:id]).destroy
    flash[:notice] = "Contract deleted successfully."
    redirect_to :back
  end
end