class ContentsController < ApplicationController

  def index
    contents = Content.all

    render json: {contents: contents.as_json}
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

  private
  def content_params
    params.require(:content).permit(:page_url)
  end
end
