class ContentsController < ApplicationController
  def create
    parser = ContentFromUrlParser.new()

    content = parser.get_content

    if content.save
      render json: {message: 'success', content: content.as_json}, status: :created
    else
      render json: {message: 'failed', error: content.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
