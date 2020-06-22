require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe 'GET #show' do
    before do
      get :show, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #update' do
    context 'when is successfully updated' do
      before do
        patch :update, params: { first_name: 'Brice' }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    # context 'when is not updated' do
    #   before do
    #     patch :update, params: { email: '' }, format: :json
    #   end
    #
    #   it { expect(response).to have_http_status(422) }
    # end
  end
end
