require 'rails_helper'

include CarrierWave::Test::Matchers

describe Api::V1::ImagesController, type: :controller do
  before do
    authenticate_user
  end

  describe 'GET "index"' do
    it 'should returns all user images' do
      FactoryBot.create_list(:image, 5, user: @user)
      get :index, format: :json
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)['data']
      expect(parsed_response.length).to eq(5)
    end
  end

  describe 'POST "create"' do
    before do
      @image = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='
    end

    context 'correct params format' do
      it 'should create an image and resize it according to params' do
        expect { post :create, params: { image: { width: 200,
                                                  height: 300,
                                                  file: @image } }
        }.to change { Image.count }.by(1)
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body)['data']
        expect(parsed_response['id']).to eq(Image.last.id.to_s)
        expect(parsed_response['type']).to eq('images')
        expect(parsed_response['attributes']['width']).to eq(200)
        expect(parsed_response['attributes']['height']).to eq(300)
        expect(Image.last.file.resized).to have_dimensions(200, 300)
      end
    end

    context 'incorrect params format' do
      it 'should returns an error if incorrect width or height is submitted' do
        post :create, params: { image: { file: @image } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)['errors']
        expect(parsed_response[0]['source']['pointer']).to eq('/data/attributes/width')
        expect(parsed_response[0]['detail']).to eq("can't be blank")
        expect(parsed_response[1]['source']['pointer']).to eq('/data/attributes/width')
        expect(parsed_response[1]['detail']).to eq('is not a number')
        expect(parsed_response[2]['source']['pointer']).to eq('/data/attributes/height')
        expect(parsed_response[2]['detail']).to eq("can't be blank")
        expect(parsed_response[3]['source']['pointer']).to eq('/data/attributes/height')
        expect(parsed_response[3]['detail']).to eq('is not a number')
      end

      it 'should returns an error if zero width or height is submitted' do
        post :create, params: { image: { width: 0, height: 0, file: @image } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)['errors']
        expect(parsed_response[2]['source']['pointer']).to eq('/data/attributes/width')
        expect(parsed_response[2]['detail']).to eq('must be greater than 0')
        expect(parsed_response[3]['source']['pointer']).to eq('/data/attributes/height')
        expect(parsed_response[3]['detail']).to eq('must be greater than 0')
      end

      it 'should returns an error if file is not submitted' do
        post :create, params: { image: { width: 200, height: 200 } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)['errors']
        expect(parsed_response[0]['source']['pointer']).to eq('/data/attributes/file')
        expect(parsed_response[0]['detail']).to eq("can't be blank")
      end
    end

    describe 'PUT "update"' do
      before do
        @image = create(:image, user: @user)
      end

      context 'correct update params' do
        it 'should update image according to new params' do
          put :update, params: { id: @image, image: { width: 500, height: 700 } }
          expect(response).to have_http_status(:success)
          parsed_response = JSON.parse(response.body)['data']
          expect(parsed_response['id']).to eq(@image.id.to_s)
          expect(parsed_response['type']).to eq('images')
          expect(parsed_response['attributes']['width']).to eq(500)
          expect(parsed_response['attributes']['height']).to eq(700)
          expect(@image.file.resized).to have_dimensions(500, 700)
        end
      end

      context 'incorrect update params' do
        it 'should returns an error if incorrect width or height is submitted' do
          put :update, params: { id: @image, image: { width: 'qwerty', height: 'qwerty' } }
          expect(response).to have_http_status(:unprocessable_entity)
          parsed_response = JSON.parse(response.body)['errors']
          expect(parsed_response[0]['source']['pointer']).to eq('/data/attributes/width')
          expect(parsed_response[0]['detail']).to eq('is not a number')
          expect(parsed_response[1]['source']['pointer']).to eq('/data/attributes/height')
          expect(parsed_response[1]['detail']).to eq('is not a number')
        end
      end
    end
  end
end
