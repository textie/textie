class RefreshAuthentication
  include Interactor::Organizer

  organize RefreshAuthentication::FindRefreshToken,
           RefreshAuthentication::ExposeUser,
           RefreshAuthentication::DestroyRefreshToken,
           LoginUser::GenerateAccessToken,
           RefreshAuthentication::CreateRefreshToken
end
