class ContentsController < ApplicationController
  before_action :get_content, only: [:show, :destroy]

  def index
    contents = ContentsApi.new(params).get_objs

    render json: contents.as_json
  end

  def show
    render json: @content.as_json(root: true)
  end

  def create
    parser = ContentFromUrlParser.new(content_params[:page_url])

    content = Content.new(parser.contents)

    if content.save
      render json: {message: 'success', content: content.as_json}, status: :created
    else
      render json: {message: 'failed', error: content.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @content.destroy
    render json: {message: 'success'}, status: :no_content
  end

  private
  def content_params
    params.require(:content).permit(:page_url)
  end

  def get_content
    @content = Content.find(params[:id])
  end
end
