class PostingsController < ApplicationController

  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    if params[:search].present?
      @postings = Posting.near(params[:search], 30)
    else
      @postings = Posting.all
    end
  end

  def edit
    @posting = Posting.find(params[:id])
  end

  def show
    @posting = Posting.find(params[:id])
  end

  def new
    @posting = Posting.new
  end

  def create
    @posting = Posting.new(posting_params)
    # @posting.created_at = Time.current
    @posting.user_id = current_user.id
    if @posting.save
      redirect_to @posting
    else
      render 'new'
    end
  end

  def update
    @posting = Posting.find(params[:id])

    if @posting.update(posting_params)
      redirect_to @posting
    else
      render 'edit'
    end
  end

  def destroy
    @posting = Posting.find(params[:id])
    @posting.destroy

    redirect_to postings_path
  end

  private
    def posting_params
      params.require(:posting).permit(:location, :expertise, :commitment, :ensemble)
    end
end
