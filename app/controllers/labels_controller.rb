class LabelsController < ApplicationController

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new
      if @label.save(params_label)
        redirect_to labels_path
      else
        render :new
      end
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(params_label)
      redirect_to labels_path, notice: '更新しました！'
    else
      render :edit
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path
  end

  private
  
  def params_label
    params.require(:label).permit(:label_name)
  end
end
