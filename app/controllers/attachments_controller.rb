class AttachmentsController < ApplicationController
  
  def destroy
    Attachment.find(params[:id]).destroy
    flash[:notice] = "File deleted successfully."
    redirect_to :back
  end
end