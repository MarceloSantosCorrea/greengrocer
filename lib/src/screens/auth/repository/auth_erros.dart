String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha inválidos';
    case 'Invalid session token':
      return 'Token Inválido';
    default:
      return 'Um erro indefinido ocorreu';
  }
}
