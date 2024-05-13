class WatchesController < ApplicationController
  before_action :set_watch, only: %i[ show update destroy ]
  before_action :authenticate_user! , only: %i[ create update destroy ]
  before_action :check_user, only: %i[ update destroy ]
  # GET /watches
  def index
    @watches = Watch.all
    category = params[:category]
    price_gte = params[:price_gte]
    price_lte = params[:price_lte]
    name = params[:name]

    @watches = @watches.where(category: category) if category.present?
    @watches = @watches.where('price >= ?', price_gte.to_f) if price_gte.present?
    @watches = @watches.where('price <= ?', price_lte.to_f) if price_lte.present?
    @watches = @watches.where("name like ?", "%#{name}%") if name.present?

    render json: @watches
  end

  # GET /watches/1
  def show
    render json: @watch
  end

  # POST /watches
  def create
    @watch = Watch.new(watch_params)

    if @watch.save
      render json: @watch, status: :created, location: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /watches/1
  def update
    if @watch.update(watch_params)
      render json: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # DELETE /watches/1
  def destroy
    @watch.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watch
      @watch = Watch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def watch_json
      params.require(:watch).permit(:name, :description, :category, :price, :url)
    end
    def watch_params
      params.require(:watch).permit(:name, :description, :category, :price, :url, :user_id)
    end

  def check_user
    watch_id = @watch.id
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      user_id = jwt_payload['sub']
      current_user = User.find_by(id: user_id)
      if current_user.present?
        watch = Watch.find(watch_id)
        watch_user_id = watch.user_id.to_s
        if watch_user_id != user_id
          render json: {error: 'Unauthorized', message: 'You do not have permission to access this data'}, status: :unauthorized
        end
      else
        render json: {error: 'Unauthorized', message: 'You do not have permission to access this data'}, status: :unauthorized
      end
    end
  end
end
