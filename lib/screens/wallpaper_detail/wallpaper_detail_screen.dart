import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velour/utils/appcolors.dart';
import 'package:velour/utils/appstrings.dart';
import 'package:velour/widgets/app_loader.dart';

class WallpaperDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String title;

  const WallpaperDetailScreen({
    super.key,
    required this.imageUrl,
    this.title = "Wallpaper",
  });

  @override
  State<WallpaperDetailScreen> createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: AppColors.white),
            onPressed: () => _showInfoDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Wallpaper Card with Shading
            Padding(
              padding: EdgeInsets.all(20.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: Container(
                  height: 600.h,
                  decoration: BoxDecoration(
                    color: colors.surfaceColor,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Wallpaper Image with Professional Loader
                      Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: ProfessionalLoaderWidget(size: 60),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.broken_image_outlined,
                                  color: AppColors.white70,
                                  size: 60.sp,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  AppStrings.errorLoadingImage,
                                  style: TextStyle(
                                    color: AppColors.white70,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // Bottom Shading Gradient
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 150.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.5),
                                Colors.black.withValues(alpha: 0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Action Buttons Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Favorite button
                  _ActionButton(
                    icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                    label: AppStrings.btnFavorite,
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite
                                ? AppStrings.addedToFavorites
                                : AppStrings.removedFromFavorites,
                          ),
                          duration: const Duration(seconds: 1),
                          backgroundColor: colors.surfaceColor,
                        ),
                      );
                    },
                    backgroundColor: colors.surfaceColor,
                    isGradient: false,
                  ),

                  SizedBox(width: 20.w),

                  // Download button (with gradient)
                  _ActionButton(
                    icon: Icons.download,
                    label: AppStrings.btnDownload,
                    onTap: _showDownloadDialog,
                    backgroundColor: colors.surfaceColor,
                    isGradient: true,
                  ),

                  SizedBox(width: 20.w),

                  // Share button
                  _ActionButton(
                    icon: Icons.share,
                    label: AppStrings.btnShare,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppStrings.shareWallpaper),
                          duration: const Duration(seconds: 1),
                          backgroundColor: colors.surfaceColor,
                        ),
                      );
                    },
                    backgroundColor: colors.surfaceColor,
                    isGradient: false,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Wallpaper Details Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: colors.surfaceColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.detailsTitle,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    _DetailRow(
                      icon: Icons.image,
                      label: AppStrings.detailResolution,
                      value: AppStrings.defaultResolution,
                    ),
                    SizedBox(height: 12.h),
                    _DetailRow(
                      icon: Icons.storage,
                      label: AppStrings.detailSize,
                      value: AppStrings.defaultSize,
                    ),
                    SizedBox(height: 12.h),
                    _DetailRow(
                      icon: Icons.category,
                      label: AppStrings.detailCategory,
                      value: AppStrings.defaultCategory,
                    ),
                    SizedBox(height: 12.h),
                    _DetailRow(
                      icon: Icons.download_outlined,
                      label: AppStrings.detailDownloads,
                      value: AppStrings.defaultDownloadCount,
                    ),
                    SizedBox(height: 12.h),
                    _DetailRow(
                      icon: Icons.favorite_border,
                      label: AppStrings.detailLikes,
                      value: AppStrings.defaultLikesCount,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Set Wallpaper Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.gradientStart, colors.gradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ElevatedButton(
                  onPressed: _showSetWallpaperDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wallpaper, color: AppColors.white),
                      SizedBox(width: 10.w),
                      Text(
                        AppStrings.btnSetWallpaper,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog() {
    if (!mounted) return;
    final colors = AppColors();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: colors.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, color: colors.gradientStart, size: 48.sp),
              SizedBox(height: 16.h),
              Text(
                AppStrings.infoTitle,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                AppStrings.infoDescription,
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: 14.sp,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(
                  AppStrings.btnGotIt,
                  style: TextStyle(
                    color: colors.gradientEnd,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDownloadDialog() async {
    if (!mounted) return;
    final colors = AppColors();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        backgroundColor: colors.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProfessionalLoaderWidget(size: 80),
              SizedBox(height: 24.h),
              Text(
                AppStrings.downloadingText,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                AppStrings.downloadingWallpaper,
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: 14.sp,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Check if widget is still mounted before using context
    if (!mounted) return;

    // Pop the loading dialog
    Navigator.pop(context);

    // Show success dialog
    _showDownloadSuccessDialog();
  }

  void _showSetWallpaperDialog() {
    if (!mounted) return;
    final colors = AppColors();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: colors.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.setWallpaperTitle,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.setWallpaperMessage,
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              _WallpaperOptionButton(
                icon: Icons.smartphone,
                label: AppStrings.optionHomeScreen,
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showSettingWallpaperDialog(AppStrings.optionHomeScreen);
                },
              ),
              SizedBox(height: 12.h),
              _WallpaperOptionButton(
                icon: Icons.lock_outline,
                label: AppStrings.optionLockScreen,
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showSettingWallpaperDialog(AppStrings.optionLockScreen);
                },
              ),
              SizedBox(height: 12.h),
              _WallpaperOptionButton(
                icon: Icons.devices,
                label: AppStrings.optionBoth,
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showSettingWallpaperDialog(AppStrings.optionBothScreens);
                },
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(
                  AppStrings.btnCancel,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettingWallpaperDialog(String option) async {
    if (!mounted) return;
    final colors = AppColors();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        backgroundColor: colors.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProfessionalLoaderWidget(size: 80),
              SizedBox(height: 24.h),
              Text(
                AppStrings.settingWallpaper,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                '${AppStrings.applyingTo} $option',
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Check if widget is still mounted before using context
    if (!mounted) return;

    // Pop the loading dialog
    Navigator.pop(context);

    // Show success dialog
    _showWallpaperSetSuccessDialog(option);
  }

  void _showWallpaperSetSuccessDialog(String option) {
    if (!mounted) return;
    final colors = AppColors();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: colors.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colors.gradientStart, colors.gradientEnd],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_outline,
                        color: AppColors.white,
                        size: 48.sp,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 24.h),

              Text(
                AppStrings.successTitle,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                '${AppStrings.wallpaperSetSuccessOn} $option!',
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: 14.sp,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.gradientStart, colors.gradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.btnGreat,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDownloadSuccessDialog() {
    if (!mounted) return;
    final colors = AppColors();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: colors.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colors.gradientStart, colors.gradientEnd],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_outline,
                        color: AppColors.white,
                        size: 48.sp,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 24.h),

              Text(
                AppStrings.successTitle,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                AppStrings.downloadSuccessMessage,
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: 14.sp,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.gradientStart, colors.gradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.btnGreat,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final bool isGradient;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.backgroundColor,
    this.isGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              gradient: isGradient
                  ? LinearGradient(
                colors: [colors.gradientStart, colors.gradientEnd],
              )
                  : null,
              color: isGradient ? null : backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: AppColors.white70,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.white70, size: 20.sp),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            color: AppColors.white70,
            fontSize: 14.sp,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _WallpaperOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _WallpaperOptionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.gradientStart, colors.gradientEnd],
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: AppColors.white, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: AppColors.grey, size: 16.sp),
          ],
        ),
      ),
    );
  }
}