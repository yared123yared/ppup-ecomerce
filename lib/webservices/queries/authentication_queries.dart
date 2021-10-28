class AuthQueries {
  static const login = '''
query login(\$email: String!, \$password: String!) {
  login(email: \$email, password: \$password) {
    id
    termsAndConditionsAccepted
    accessToken
    tokenType
    expiresIn
    refreshToken
    userRoles
    message
    statusCode
    firstName
    lastName
    email
  }
}

''';

  static const updateTermsAndConditions = '''
mutation updateTerms(\$userId: Int!, \$isAccepted: Boolean!){
    updateProfile(userId: \$userId, isAccepted: \$isAccepted){
        userId,
        isAccepted,
        firstTimeBonus
    }
}

''';

  static const checkSessionStatus = '''
query isSessionActive{
    isSessionActive{
        status
    }
}
''';
}
