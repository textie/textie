class RefreshAuthentication
  include Interactor::Organizer

  organize RefreshAuthentication::FindUserByRefreshToken,
           RefreshAuthentication::CheckAccessToken,
           LoginUser::GenerateAccessToken,
           RefreshAuthentication::CreateRefreshToken
end
