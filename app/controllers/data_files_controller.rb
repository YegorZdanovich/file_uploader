class DataFilesController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :is_users_file?, only: [:destroy]

  def index
    @files = DataFile.all.lifo
  end

  def new
    @file = DataFile.new
  end

  def create
    @user = current_user
    @file = @user.data_files.create(params_for_create)
    if @file.save
      flash[:notice] = t('file.create')
      redirect_to root_path
    else
      flash[:error] = @file.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

  def destroy
    @file = DataFile.find(params[:id])
    if @file.destroy
      flash[:notice] = t('file.destroy')
    else
      flash[:error] = @file.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end

  def download_file
    @file = DataFile.find(params[:id])
    send_file @file.file.path,
              filename: File.basename(@file.file.path),
              type: @file.file.content_type,
              url_based_filename: true
  end

  private

  def params_for_create
    if params[:data_file].present?
      params.require(:data_file).permit(:file)
    end
  end

  def is_users_file?
    unless DataFile.find(params[:id]).user_id == current_user.id
      flash[:error] = t('file.cannot.destroy')
      redirect_to root_path
    end
  end
end
