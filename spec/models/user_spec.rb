require 'spec_helper'

describe User, 'associations' do
  it { should have_many(:identities) }
end

describe User, '#from_omniauth' do
  let(:auth_github) {
    {
      'provider' => 'github',
      'uid' => '123',
      'info' => {
        'nickname' => 'jayroh',
        'email' => 'joel@example.com',
      }
    }
  }

  it 'finds user when they exist' do
    user = create(:user, email: 'joel@example.com')

    User.from_omniauth(auth_github).should eq user
  end

  it 'creates a user when they do not exist yet' do
    user = User.from_omniauth(auth_github)

    user.should be_valid
    user.should be_persisted
    user.name.should eq 'jayroh'
  end
end


describe User do
  describe '.email' do
    it 'will be valid' do
      shaun = build_stubbed(:user, email: 'shaun@example.com')
      shaun.should be_valid
    end

    it 'will not be valid' do
      shaun = build_stubbed(:user, email: 'shaun.com')
      shaun.should_not be_valid
    end
  end
end
