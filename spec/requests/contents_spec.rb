require 'rails_helper'

RSpec.describe ContentsController, type: :request do
  describe 'parsing new content from given url' do
    let(:accessible_url) {'http://accessible.url'}
    let(:inaccessible_url) {'http://inaccessible.url'}
    let(:good_url) { {content: {page_url: accessible_url}} }
    let(:bad_url) { {content: {page_url: inaccessible_url}} }

    it 'creates a new content and have success response' do
      expect{post '/contents', params: good_url}.to change(Content, :count).by 1
    end
  end
end
