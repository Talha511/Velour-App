// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:velour/utils/appcolors.dart';
// import 'package:velour/utils/appstrings.dart';
// import 'package:velour/widgets/app_loader.dart';
// import 'wallpaper_detail_screen.dart';
//
// class AbstractScreen extends StatelessWidget {
//   const AbstractScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors().backgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//             AppStrings.abstractTitle,
//             style: TextStyle(
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.white
//             )
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 15.w),
//             child: Icon(Icons.brightness_6, color: AppColors().gradientStart, size: 24.sp),
//           )
//         ],
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(15.w),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           mainAxisSpacing: 12.h,
//           crossAxisSpacing: 12.w,
//           childAspectRatio: 0.6,
//         ),
//         itemBuilder: (context, index) {
//           final imageUrl = 'https://picsum.photos/seed/${index+20}/200/350';
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => WallpaperDetailScreen(
//                     imageUrl: imageUrl,
//                     title: 'Abstract Wallpaper ${index + 1}',
//                   ),
//                 ),
//               );
//             },
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12.r),
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Container(
//                     color: AppColors().surfaceColor,
//                     child: const Center(
//                       child: SimpleGradientLoader(),
//                     ),
//                   );
//                 },
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     color: AppColors().surfaceColor,
//                     child: Icon(
//                       Icons.broken_image,
//                       color: AppColors.grey,
//                       size: 30.sp,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velour/screens/wallpaper_detail/wallpaper_detail_screen.dart';
import 'package:velour/utils/appcolors.dart';
import 'package:velour/utils/appstrings.dart';
import 'package:velour/widgets/app_loader.dart';

class AbstractScreen extends StatelessWidget {
  const AbstractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.abstractTitle,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Icon(
              Icons.brightness_6,
              color: AppColors().gradientStart,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(15.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.6,
        ),
        itemCount: 30,
        itemBuilder: (context, index) {
          final imageUrl = 'https://picsum.photos/seed/${index + 20}/200/350';
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WallpaperDetailScreen(
                    imageUrl: imageUrl,
                    title: 'Abstract Wallpaper ${index + 1}',
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: AppColors().surfaceColor,
                    child: const Center(
                      child: ProfessionalLoaderWidget(size: 40),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors().surfaceColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image_outlined,
                          color: AppColors.grey,
                          size: 30.sp,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Error',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}