class RewardQueries {
  static const getBalance = '''
    query balance(\$userId: String!){
    balance(userId: \$userId){
        balance
    } 
}
''';

  static const getPoints = '''
query points(\$userId: String!, \$startDate: Long!, \$endDate: Long!){
  points(userId: \$userId, startDate:\$startDate, endDate:\$endDate){
      pointsTransactions{
        id,
        date,
        numPoints,
        description
      }
      totalRecords
  } 
}
''';

  static const getRewardsSummery = '''
query rewardsSummary(\$userId: String!, \$startDate: Long!, \$endDate: Long!){
  rewardsSummary(userId: \$userId, startDate:\$startDate, endDate:\$endDate){
        pointsTransactions{
        date,
        numPoints
      }
      totalPoints,
      isFirstTimeUser
  } 
}
''';
}
