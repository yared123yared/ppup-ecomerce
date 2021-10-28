class ShopQueries {
  static const String getCategories = '''
query categoriesByStore{
  categoriesByStore{
      categories{
        id,
        name,
        title,
        mainImageHash,
        notes
      }
      totalRecords
  } 
}
  ''';

  static const String getSubCategories = '''
query categoriesByStore(\$cat1: String!){
  categoriesByStore(cat1: \$cat1){
      categories{
        id,
        name,
        title,
        mainImageHash,
        notes
      }
      totalRecords
  } 
}
  ''';

  static const String getProducts = '''
query productByStore(\$start: Int!, \$maxRows: Int!, \$sortBy: String!, \$sortDirection: String!, \$startPrice: String, \$endPrice: String){
  productByStore(
    start: \$start
    maxRows: \$maxRows
    sortBy: \$sortBy
    sortDirection: \$sortDirection
    startPrice: \$startPrice
    endPrice: \$endPrice
  ) {
    products {
      id
      name
      primaryImageHref
      title
      finalCost
      variantCount
      brief
      tags
      brandName
      brandTitle
    }
    totalRecords
  }
}
  ''';

  static const String getProductsByCategory = '''
query productByStore(\$start: Int!, \$maxRows: Int!, \$sortBy: String!, \$sortDirection: String!, \$categories: String!, \$startPrice: String!, \$endPrice: String!){
  productByStore(
    categories: \$categories
    start: \$start
    maxRows: \$maxRows
    sortBy: \$sortBy
    sortDirection: \$sortDirection
    startPrice: \$startPrice
    endPrice: \$endPrice
  ) {
    products {
      id
      name
      primaryImageHref
      title
      finalCost
      variantCount
      brief
      tags
      brandName
      brandTitle
    }
    totalRecords
  }
}
  ''';

  static const String getProductDetails = '''
  query productDetails(\$productId: String!){
  productDetails(productId:\$productId){
        products{
            id,
            name,
            primaryImageHref,
            title,
            variantCount,
            content,
            tags,
            supplerName
            brandName,
            brandTitle
            productParameters{
                name
                displayType
                parameterOptions {
                    name
                    title
                    imageHash
                }
            }
        }
        productSkus{
            id
            name
            title
            imageHash
            baseCount
            finalCost
            options{
                Carrier
                Size
                Color
            }
        }
  } 
}
  ''';

  static const String getSearchedProduct = '''
query productByStore(\$start: Int!, \$maxRows: Int!, \$search: String!){
  productByStore(
    start: \$start
    maxRows: \$maxRows
    search: \$search
  ) {
    products {
      id
      name
      primaryImageHref
      title
      finalCost
      variantCount
      brief
      tags
      brandName
      brandTitle
    }
    totalRecords
  }
}
  ''';
}
