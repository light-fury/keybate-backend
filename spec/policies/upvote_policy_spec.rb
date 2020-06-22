require 'rails_helper'

RSpec.describe UpvotePolicy do
  subject { described_class.new(user, upvote) }

  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let(:question) { create(:question, room: room, event: event) }
  let(:upvote) { create(:question_upvote, user: user, question: question) }

  context "for a room attendee" do
    let!(:event_user) { create(:event_user_example, event: event, user: user) }
    let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }

    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:destroy) }
  end

  context "for a non-attendee" do
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:destroy) }
  end
end
