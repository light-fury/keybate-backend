require 'rails_helper'

RSpec.describe AnswerPolicy do
  subject { described_class.new(user, answer) }
  
  let(:user) { create(:user) }
  let(:non_attendee) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_user) { create(:event_user_example, event: event, user: user) }
  let(:poll) { create(:poll, room: room, event: event) }
  let(:option) { create(:poll_option, poll: poll) }
  let(:answer) { create(:poll_answer, user: user, poll: poll) }

  context "for a room attendee" do
    let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }

    it { is_expected.to permit_action(:index)    }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:destroy) }
  end

  context "for a non-attendee" do
    it { is_expected.to forbid_action(:index)    }
    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
  end
end
