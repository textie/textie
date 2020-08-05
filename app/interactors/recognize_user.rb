class RecognizeUser
  include Interactor::Organizer

  organize RecognizeUser::AuthenticateByJwt
end
