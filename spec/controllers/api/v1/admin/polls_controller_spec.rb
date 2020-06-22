require 'rails_helper'

RSpec.describe Api::V1::Admin::PollsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_moderator) { create(:event_moderator_example, event: event, user: user) }
  let(:poll) { create(:poll, room: room, event: event) }
  let(:poll_two) { create(:poll, room: room, event: event) }
  let(:poll_three) { create(:poll, room: room, event: event) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, params: { event_id: event.id, room_id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before do
        post :create, params: {
          event_id: event.id,
          room_id: room.id,
          title: 'New title',
          options_attributes: attributes_for_list(:poll_option, 3)
        }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not created' do
      before do
        post :create, params: {
          event_id: event.id,
          room_id: room.id,
          title: '',
          options_attributes: attributes_for_list(:poll_option, 3)
        }, format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { event_id: event.id, room_id: room.id, id: poll.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #update' do
    context 'when is successfully updated' do
      before do
        patch :update, params: {
          event_id: event.id,
          room_id: room.id,
          id: poll.id,
          title: 'Update title'
        }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not updated' do
      before do
        patch :update, params: {
          event_id: event.id,
          room_id: room.id,
          id: poll.id,
          title: ''
        }, format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { event_id: event.id, room_id: room.id, id: poll.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #reorder' do
    before do
      patch :reorder, params: { event_id: event.id, room_id: room.id, polls: [{ id: poll.id, list_order: 2 }, { id: poll_two.id, list_order: 3 }, { id: poll_three.id, list_order: 1 }] }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #publish' do
    before do
      patch :publish, params: { event_id: event.id, room_id: room.id, id: poll.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #open' do
    before do
      patch :open, params: { event_id: event.id, room_id: room.id, id: poll.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #display_results' do
    before do
      patch :display_results, params: {
        event_id: event.id,
        room_id: room.id,
        id: poll.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #destroy_option' do
    before do
      patch :display_results, params: {
        event_id: event.id,
        room_id: room.id,
        id: poll.id,
        option_id: poll.options.first
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
