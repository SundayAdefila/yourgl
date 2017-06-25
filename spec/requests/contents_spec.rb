require 'rails_helper'

RSpec.describe ContentsController, type: :request do
  describe 'parsing new content from given url' do
    let(:accessible_url) {'http://accessible.url'}
    let(:inaccessible_url) {'http://inaccessible.url'}

    it 'creates a new content and have success response' do
      expect{post '/contents', page_url: accessible_url}.to change(Content, :count).by 1
    end
  end
end
