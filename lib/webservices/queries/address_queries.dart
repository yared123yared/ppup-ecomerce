class AddressQueries {
  static const getAddress = '''
    query addressList(\$userId: Int!){
    addressList(userId: \$userId){
        id, 
        userId,
        firstName,
        lastName,
        addressLine,
        addressLine2,
        city,
        state,
        country,
        zipcode,
        addressType
    } 
}
''';

  static const editAddress = '''
    mutation updateAddress(\$id: Int!, \$userId: Int!, \$firstName: String!, \$lastName: String!, \$addressLine: String!, \$addressLine2: String!, \$city: String!, \$state: String!, \$country: String!, \$addressType: String!, \$zipcode: String!){
      updateAddress(
        input:{
            id:\$id,
            userId:\$userId, 
            firstName:\$firstName, 
            lastName:\$lastName,
            addressLine:\$addressLine,
            addressLine2:\$addressLine2,
            city:\$city,
            state:\$state,
            country:\$country,
            addressType:\$addressType,
            zipcode:\$zipcode
        }
    ){ 
        message
    }
}
''';

  static const addAddress = '''
mutation addAddress(\$userId: Int!, \$firstName: String!, \$lastName: String!, \$addressLine: String!, \$addressLine2: String!, \$city: String!, \$state: String!, \$country: String!, \$addressType: String!, \$zipcode: String!){
    addAddress(
        input:{
            userId:\$userId, 
            firstName:\$firstName, 
            lastName:\$lastName,
            addressLine:\$addressLine,
            addressLine2:\$addressLine2,
            city:\$city,
            state:\$state,
            country:\$country,
            addressType:\$addressType,
            zipcode:\$zipcode
        }
    ){ 
        message,
        id
    }
}
''';

  static const deleteAddress = '''
mutation deleteAddress(\$userId: Int!, \$id: Int!){
    deleteAddress(input:{userId:\$userId, id:\$id}){
        message
    }
}
''';

  static const getStateList = '''
query statesList(\$country: String!){
  statesList(country:\$country){
      stateCode, stateName
  } 
}
''';
}
