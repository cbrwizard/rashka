class ReasonsController < ApplicationController
  include Admin

  before_action :allow_access?, on: [:index_admin, :show, :edit, :new, :create, :update, :destroy]

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
        format.html { redirect_to @reason, notice: 'Успешно добавил причину.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @reason = Reason.find(params[:id])

    respond_to do |format|
      if @reason.update_attributes(reason_params)
        format.html { redirect_to @reason, notice: 'Успешно обновил причину.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @reason = Reason.find(params[:id])
    @reason.destroy

    respond_to do |format|
      format.html { redirect_to index_admin_reasons_path, notice: 'Успешно удалил причину.' }
    end
  end

  private

  def reason_params
    params.require(:reason).permit(:text)
  end
end
