class LoginUser
  include Interactor::Organizer

  organize LoginUser::FindUserByEmail,
           LoginUser::AuthenticateByPassword,
           LoginUser::GenerateJwt
end
