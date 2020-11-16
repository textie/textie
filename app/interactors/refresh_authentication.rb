class RefreshAuthentication
  include Interactor::Organizer

  organize RefreshAuthentication::FindUserByRefreshToken,
           LoginUser::GenerateAccessToken,
           RefreshAuthentication::CreateRefreshToken
end
