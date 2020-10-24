class LoginUser
  include Interactor::Organizer

  organize LoginUser::AuthenticateUser,
           LoginUser::GenerateJwt
end
