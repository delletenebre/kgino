// import 'package:flutter/material.dart';

// class KrsInputDecoration extends InputDecoration {
  
//   KrsInputDecoration({
//     required ThemeData theme,
//     String? errorText,
//     String? hintText,
//     String labelText = '',
//     EdgeInsetsGeometry? contentPadding,
//     IconData? suffixIcon,
//     Function()? onSuffixPressed,
//   }) : super(
//     isCollapsed: true,

//     label: Text(labelText),
    
//     errorText: errorText,
//     hintText: hintText,

//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(48.0),
//     ),

//     // focusedBorder: OutlineInputBorder(
//     //   borderSide: BorderSide(
//     //     color: theme.colorScheme.primary,
//     //   ),
//     // ),
    
//     contentPadding: contentPadding ?? const EdgeInsets.symmetric(
//       vertical: 16.0,
//       horizontal: 16.0,
//     ),
    
//     labelStyle: const TextStyle(
//       fontSize: 13.0,
//     ),

//     hintStyle: TextStyle(
//       color: theme.colorScheme.outline
//     ),

//     suffixIconConstraints: const BoxConstraints(
//       minWidth: 48.0,
//     ),
//     suffixIcon: (suffixIcon != null) ? IconButton(
//       splashRadius: 24.0,
//       onPressed: onSuffixPressed,
//       icon: Icon(suffixIcon,
//         color: theme.colorScheme.outline,
//       ),
//     ) : null,
//   );
// }