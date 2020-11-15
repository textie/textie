class LoginUser
  include Interactor::Organizer

  organize LoginUser::AuthenticateUser,
           LoginUser::GenerateAccessToken,
           RefreshAuthentication::CreateRefreshToken
end
