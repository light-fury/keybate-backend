require 'rails_helper'

RSpec.describe ContactPolicy do
  subject { described_class.new(user, contact) }

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:event) { create(:event) }
  let(:contact) { create(:contact, event: event, from_user: user, to_user: other_user) }

  context "for an event attendee" do
    let!(:event_user) { create(:event_user_example, event: event, user: user) }

    it { is_expected.to permit_action(:create)  }
  end

  context "for a non-attendee" do
    it { is_expected.to forbid_action(:create)  }
  end
end
