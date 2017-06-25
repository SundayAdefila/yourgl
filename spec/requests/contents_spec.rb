require 'rails_helper'

RSpec.describe ContentsController, type: :request do
  describe 'parsing new content from given url' do
    let(:accessible_url) {'http://accessible.url'}
    let(:inaccessible_url) {'http://inaccessible.url'}
    let(:good_url) { {content: {page_url: accessible_url}} }
    let(:bad_url) { {content: {page_url: inaccessible_url}} }

    it 'creates a new content and have success response' do
      expect{
        post '/contents', params: good_url
        resp = JSON.parse(response.body)
        expect(resp['message']).to eq 'success'
      }.to change(Content, :count).by 1
    end

    it 'should have a failed response message when supplied url is in-accessible' do
      expect{
        post '/contents', params: bad_url
        resp = JSON.parse(response.body)
        expect(resp['message']).to eq 'failed'
      }.not_to change(Content, :count)
    end

    describe 'getting existing parsed contents' do
      it 'returns all existing contents from db by default' do
        create_list(:content, 5)
        get '/contents'

        expect(JSON.parse(response.body)['contents'].count).to eq 5
      end
    end
  end
end
