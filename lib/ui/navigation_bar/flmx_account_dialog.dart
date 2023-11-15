// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../controllers/flmx_account_cubit.dart';
// import '../../models/api_response.dart';
// import '../../models/flmx/flmx_profile.dart';
// import '../../resources/krs_locale.dart';
// import '../loading_indicator.dart';

// class FlmxAccountDialog extends StatelessWidget {
//   const FlmxAccountDialog({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final locale = KrsLocale.of(context);
    
//     return BlocProvider(
//       create: (context) => FlmxAccountCubit(),
//       child: BlocBuilder<FlmxAccountCubit, ApiResponse<FlmxProfile>>(
//         builder: (context, state) {
          
//           if (state.isLoading) {
//             return const LoadingIndicator();
//           }

//           if (!state.isSuccess) {

//             return ListView(
//               shrinkWrap: true,
//               children: [

//                 const Text('Перейдите на страницу filmix.ac/console и введите код:',
//                   textAlign: TextAlign.center,
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 4.0,
//                   ),
//                   child: Text(context.read<FlmxAccountCubit>().userCode.toUpperCase(),
//                     style: const TextStyle(
//                       fontSize: 32.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),

//                 const Text('после добавления устройства на сайте, нажмите кнопку "Активировать"',
//                   textAlign: TextAlign.center,
//                 ),

//                 const SizedBox(height: 12.0),

//                 FilledButton.tonal(
//                   autofocus: true,
//                   onPressed: () {
//                     /// пробуем получить профиль пользователя
//                     context.read<FlmxAccountCubit>().getProfile();
//                   },
//                   child: const Text('Активировать'),
//                 ),

//                 const SizedBox(height: 4.0),

//                 FilledButton.tonal(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(locale.cancel),
//                 ),
//               ],
//             );

//           }

//           final user = state.asData.data;

//           return ListView(
//             shrinkWrap: true,
//             children: [
//               const Text('Ваше устройство активировано на аккаунте',
//                 textAlign: TextAlign.center,
//               ),

//               Text(user.userData.displayName,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 12.0),

//               Text('PRO неактивен',
//                 style: TextStyle(
//                   color: user.userData.isPro ? null : theme.colorScheme.error,
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 12.0),

//               FilledButton.tonal(
//                 autofocus: true,
//                 onPressed: () {
//                   /// пробуем получить профиль пользователя
//                   context.read<FlmxAccountCubit>().getProfile();
//                 },
//                 child: const Text('Деактивировать'),
//               ),

//               const SizedBox(height: 4.0),

//               FilledButton.tonal(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(locale.cancel),
//               ),
//             ],
//           );
          
//         },
//       )
//     );
//   }
// }