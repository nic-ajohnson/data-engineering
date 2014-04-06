class UploadsController < ApplicationController

	def index
		@uploads = Upload.order(created_at: :desc)
	end

	def show
		@upload = Upload.find(params[:id])
	end

	def import
		Upload.import(params[:file])
		redirect_to root_url, notice: "File imported."
	end
end
