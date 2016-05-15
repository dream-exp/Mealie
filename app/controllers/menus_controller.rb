class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @uniq = Menu.select(:category).uniq
    @menus = Menu.all
    render 'menus/index'
  end

  def detail
    @menus = Menu.all
    @menu = Menu.find(params[:id])
    Menu.find(params[:id]).update({:page_view => @menu.page_view + 1})
    render 'menus/detail'
  end

  def category
    @uniq = Menu.select(:category).uniq
    @menus = Menu.where(category: params[:category])
    @category_name = params[:category]
    render 'menus/category'
  end

  def new
    @menu = Menu.new
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @user = Menu.find(params[:id])
    if @menu.update(menu_params)
      redirect_to 'menus/index'
    else
      render 'edit'
    end
  end

  # POST /menus.json
  def create
    @menu = Menu.new(params[:menu].permit(:name, :price, :category, :imageurl, :cal, :allergy, :quantity, :description, :mon, :tue, :wed, :thu, :fri, :page_view, :purchase_count))
    @menu.save
    redirect_to :action => 'index'
  end
  # # GET /menus/1
  # # GET /menus/1.json
  # def show
  # end

  # # GET /menus/new
  # def new
  #   @menu = Menu.new
  # end

  # # GET /menus/1/edit
  # def edit
  # end

  # # POST /menus
  # # POST /menus.json
  # def create
  #   @menu = Menu.new(menu_params)

  #   respond_to do |format|
  #     if @menu.save
  #       format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
  #       format.json { render :show, status: :created, location: @menu }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @menu.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /menus/1
  # # PATCH/PUT /menus/1.json
  # def update
  #   respond_to do |format|
  #     if @menu.update(menu_params)
  #       format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @menu }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @menu.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /menus/1
  # # DELETE /menus/1.json
  # def destroy
  #   @menu.destroy
  #   respond_to do |format|
  #     format.html { redirect_to menus_url, notice: 'Menu was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_menu
  #     @menu = Menu.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def menu_params
  #     params.fetch(:menu, {})
  #   end
end
