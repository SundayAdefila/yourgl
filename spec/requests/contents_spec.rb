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

      context 'when paginate is set true in request' do
        # NOTE: per_page is defaulted to 2 in application.rb
        before do
          @contents = create_list(:content, 9)
        end

        it 'returns only the set "per_page" number of contents' do
          get '/contents?paginate=true'
          expect(JSON.parse(response.body)['contents'].count).to eq 2
        end

        it 'returns the correct contents for a given page' do
          get '/contents?paginate=true&page_count=3'
          expect(JSON.parse(response.body)['contents'].map{|c| c['id']}).to eq [@contents[6].id, @contents[7].id]
        end

        it 'sets "next_page" to true when not on last page' do
          get '/contents?paginate=true&page_count=3'
          expect(JSON.parse(response.body)['next_page']).to be_truthy
        end

        it 'sets "next_page" to false when not on last page' do
          get '/contents?paginate=true&page_count=4'
          expect(JSON.parse(response.body)['next_page']).to be_falsey
        end
      end
    end

    describe 'deleting an existing content from the system' do
      it 'should work' do
        content = create(:content)
        expect{delete "/contents/#{content.id}"}.to change(Content, :count).by -1
      end
    end

    describe 'viewing a single previously saved content' do
      it 'should work' do
        content = create(:content)
        get "/contents/#{content.id}"
        resp = JSON.parse(response.body)['content']

        content.attributes.except('created_at', 'updated_at').each do |attr, value|
          expect(resp[attr]).to eq value
        end
      end
    end
  end
end
