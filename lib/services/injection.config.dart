// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/address/address_bloc.dart' as _i13;
import '../bloc/address/country_states_bloc.dart' as _i17;
import '../bloc/auth/check_session_status_bloc.dart' as _i15;
import '../bloc/auth/login_bloc.dart' as _i26;
import '../bloc/auth/update_terms_bloc.dart' as _i12;
import '../bloc/cart/cart_bloc.dart' as _i14;
import '../bloc/connectivity_listner_bloc.dart' as _i3;
import '../bloc/contact_us/contact_us_bloc.dart' as _i16;
import '../bloc/error_handler_bloc.dart' as _i5;
import '../bloc/get_balance_bloc.dart' as _i19;
import '../bloc/get_points_bloc.dart' as _i21;
import '../bloc/get_rewards_summary_bloc.dart' as _i24;
import '../bloc/helpers/pagination_loading_bloc.dart' as _i8;
import '../bloc/render_widget_bloc.dart' as _i9;
import '../bloc/shop/filters_bloc.dart' as _i18;
import '../bloc/shop/get_categores_bloc.dart' as _i20;
import '../bloc/shop/get_product_details_bloc.dart' as _i22;
import '../bloc/shop/get_products_bloc.dart' as _i23;
import '../bloc/shop/get_sub_categories_bloc.dart' as _i25;
import '../bloc/shop/search_products_bloc.dart' as _i11;
import '../utils/hive_helper.dart' as _i7;
import '../utils/logger.dart' as _i4;
import '../webservices/graphql_api_client.dart' as _i6;
import '../webservices/repository.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ConnectivityListnerBloc>(
      () => _i3.ConnectivityListnerBloc(),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i4.DevelopmentLogger>(() => _i4.DevelopmentLogger());
  gh.lazySingleton<_i5.ErrorHandlerBloc>(() => _i5.ErrorHandlerBloc(),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i6.GraphQLApiClient>(() => _i6.GraphQLApiClient());
  gh.lazySingleton<_i7.HiveHelper>(() => _i7.HiveHelper());
  gh.lazySingleton<_i8.PaginationLoadingBloc>(() => _i8.PaginationLoadingBloc(),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i9.RenderWidgetBloc>(() => _i9.RenderWidgetBloc(),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i10.Repository>(
      () => _i10.Repository(get<_i6.GraphQLApiClient>()));
  gh.lazySingleton<_i11.SearchProductsBloc>(
      () => _i11.SearchProductsBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i12.UpdateTermsBloc>(
      () => _i12.UpdateTermsBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i13.AddressBloc>(
      () => _i13.AddressBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i14.CartBloc>(() => _i14.CartBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i15.CheckSessionStatusBloc>(
      () => _i15.CheckSessionStatusBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i16.ContactUsBloc>(
      () => _i16.ContactUsBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i17.CountryStateBloc>(
      () => _i17.CountryStateBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i18.FiltersBloc>(
      () => _i18.FiltersBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i19.GetBalanceBloc>(
      () => _i19.GetBalanceBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i20.GetCategoriesBloc>(
      () => _i20.GetCategoriesBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i21.GetPointsBloc>(
      () => _i21.GetPointsBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i22.GetProductDetailsBloc>(
      () => _i22.GetProductDetailsBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i23.GetProductsBloc>(
      () => _i23.GetProductsBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i24.GetRewardSummaryBloc>(
      () => _i24.GetRewardSummaryBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i25.GetSubCategoriesBloc>(
      () => _i25.GetSubCategoriesBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  gh.lazySingleton<_i26.LoginBloc>(() => _i26.LoginBloc(get<_i10.Repository>()),
      dispose: (i) => i.dispose());
  return get;
}
