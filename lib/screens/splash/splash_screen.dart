// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:velour/utils/appcolors.dart';
// import 'package:velour/utils/appstrings.dart';
// import 'package:velour/widgets/app_loader.dart';
// import 'home_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     );
//
//     _fadeController.forward();
//     _navigateToHome();
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     super.dispose();
//   }
//
//   void _navigateToHome() async {
//     await Future.delayed(const Duration(seconds: 10));
//     if (mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final colors = AppColors();
//     final List<String> imageUrls = List.generate(
//       15,
//           (index) => 'https://picsum.photos/id/${index + 20}/400/600',
//     );
//
//     return Scaffold(
//       backgroundColor: colors.backgroundColor,
//       body: Stack(
//         children: [
//           // Background images
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.w),
//             child: MasonryGridView.count(
//               crossAxisCount: 3,
//               mainAxisSpacing: 12.h,
//               crossAxisSpacing: 12.w,
//               itemCount: imageUrls.length,
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(16.r),
//                   child: Image.network(
//                     imageUrls[index],
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           // Gradient overlay
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   colors.splashOverlay,
//                   colors.splashOverlay.withValues(alpha: 0.85),
//                   colors.splashOverlay,
//                 ],
//               ),
//             ),
//           ),
//
//           // Main content
//           FadeTransition(
//             opacity: _fadeAnimation,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // App Title with subtle shadow
//                   Text(
//                     AppStrings.splashTitle,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColors.white,
//                       fontSize: 42.sp,
//                       fontWeight: FontWeight.w900,
//                       letterSpacing: 2,
//                       height: 1.2,
//                       shadows: [
//                         Shadow(
//                           blurRadius: 30.0,
//                           color: Colors.black.withValues(alpha: 0.6),
//                           offset: const Offset(0, 10),
//                         ),
//                         Shadow(
//                           blurRadius: 10.0,
//                           color: Colors.black.withValues(alpha: 0.4),
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   SizedBox(height: 60.h),
//
//                   // Professional circular progress loader
//                   const ProfessionalLoaderWidget(),
//
//                   SizedBox(height: 30.h),
//
//                   // Loading text
//                   Text(
//                     'Loading amazing wallpapers...',
//                     style: TextStyle(
//                       color: AppColors.white.withValues(alpha: 0.85),
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 0.5,
//                       shadows: [
//                         Shadow(
//                           blurRadius: 8.0,
//                           color: Colors.black.withValues(alpha: 0.4),
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:velour/utils/appcolors.dart';
import 'package:velour/utils/appstrings.dart';
import 'package:velour/widgets/app_loader.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _fadeController.forward();
    _navigateToHome();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 10));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final List<String> imageUrls = List.generate(
      15,
          (index) => 'https://picsum.photos/id/${index + 20}/400/600',
    );

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: Stack(
        children: [
          // Background images
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: MasonryGridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              itemCount: imageUrls.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colors.splashOverlay,
                  colors.splashOverlay.withValues(alpha: 0.85),
                  colors.splashOverlay,
                ],
              ),
            ),
          ),

          // Main content
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Title with subtle shadow
                  Text(
                    AppStrings.splashTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 42.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 30.0,
                          color: Colors.black.withValues(alpha: 0.6),
                          offset: const Offset(0, 10),
                        ),
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withValues(alpha: 0.4),
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 60.h),

                  // Professional circular progress loader
                  const ProfessionalLoaderWidget(),

                  SizedBox(height: 30.h),

                  // Loading text
                  Text(
                    'Loading amazing wallpapers...',
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.85),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black.withValues(alpha: 0.4),
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}