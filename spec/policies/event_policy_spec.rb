require 'rails_helper'

RSpec.describe EventPolicy do
  subject { described_class.new(user, event) }

  let(:user) { create(:user) }
  let(:event) { create(:event) }

  context "for an event moderator" do
    let!(:event_moderator) { create(:event_moderator_example, event: event, user: user) }

    it { is_expected.to permit_action(:index)    }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:destroy) }
  end

  context "for an event attendee" do
    let!(:event_user) { create(:event_user_example, event: event, user: user) }

    it { is_expected.to permit_action(:index)    }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "for a non-moderator and non-attendee" do
    it { is_expected.to forbid_action(:index)    }
    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
  end
end
