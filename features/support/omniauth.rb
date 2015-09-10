module OmniAuthMock
  extend self

  def mock_omniauth_providers
    allow(Devise).to receive(:omniauth_providers).and_return([:twitter, :twitter_updated])
  end
end
