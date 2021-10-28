class ContactUsQueries {
  static const getContactUsList = '''
query contactUsList{
    contactUsList{
        id,
        category,
        email,
        phone      
    }
}
''';

  static const submitContactUs = '''
query contactUs(\$id: Int!, \$subject: String!, \$body: String!){
contactUs(id: \$id, subject: \$subject, body: \$body){
status
message
}
}
''';
}
