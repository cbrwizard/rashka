class ReasonsController < ApplicationController
  include Admin

  before_action :allow_access?, only: [:index_admin, :show, :edit, :new, :create, :update, :destroy]

  def get_random
    @reason = Reason.random.text

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def index_admin
    @reasons = Reason.all
  end

  def show
    @reason = Reason.find(params[:id])
  end

  def edit
    @reason = Reason.find(params[:id])
  end

  def new
    @reason = Reason.new
  end

  def create
    @reason = Reason.new(reason_params)

    respond_to do |format|
      if @reason.save
        notice = {class: "alert-success", value: 'Успешно добавил причину.' }
        format.html { redirect_to @reason, notice: notice }
      else
        notice = {class: "alert-danger", value: 'Ошибка при добавлении.' }
        format.html { render action: "new", notice: notice }
      end
    end
  end

  def update
    @reason = Reason.find(params[:id])

    respond_to do |format|
      if @reason.update_attributes(reason_params)
        notice = {class: "alert-success", value: 'Успешно обновил причину.' }
        format.html { redirect_to @reason, notice: notice }
      else
        notice = {class: "alert-danger", value: 'Ошибка при редактировании.' }
        format.html { render action: "edit", notice: notice }
      end
    end
  end

  def destroy
    @reason = Reason.find(params[:id])
    @reason.destroy

    respond_to do |format|
      notice = {class: "alert-danger", value: 'Успешно удалил причину.' }
      format.html { redirect_to index_admin_reasons_path, notice: notice }
    end
  end

  private

  def reason_params
    params.require(:reason).permit(:text)
  end
end
