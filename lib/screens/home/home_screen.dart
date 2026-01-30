import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velour/screens/wallpaper_detail/wallpaper_detail_screen.dart';
import 'package:velour/utils/appcolors.dart';
import 'package:velour/utils/appstrings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showSearchFilter = false;
  int _selectedChipIndex = 0;

  void _toggleSearchFilter() {
    setState(() {
      _showSearchFilter = !_showSearchFilter;
    });
  }

  void _onChipSelected(int index) {
    setState(() {
      _selectedChipIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors().backgroundColor,
      drawer: const _AppDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                _HomeHeader(
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                  onSearchTap: _toggleSearchFilter,
                ),
                _CategoryChips(
                  selectedIndex: _selectedChipIndex,
                  onChipTap: _onChipSelected,
                ),
                const _SectionTitle(title: AppStrings.labelSectionTitlePopular),
                const _PopularHorizontalList(),
                const _SectionTitle(title: AppStrings.catLive),
                const _LiveWallpapersGrid(),
                const _SectionTitle(title: AppStrings.labelSectionTitleCategories),
                const _CategoryGrid(),
              ],
            ),
            if (_showSearchFilter)
              _SearchFilterPanel(onClose: _toggleSearchFilter),
          ],
        ),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();

    return Drawer(
      backgroundColor: colors.backgroundColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 20.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.gradientStart, colors.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundColor: AppColors.white,
                  child: Icon(Icons.person, size: 40.sp, color: colors.gradientEnd),
                ),
                SizedBox(height: 12.h),
                Text(
                  AppStrings.drawerTitle,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.drawerSubtitle,
                  style: TextStyle(
                    color: AppColors.white70,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.person_outline,
                  title: AppStrings.menuProfile,
                  onTap: () {},
                ),
                _DrawerItem(
                  icon: Icons.favorite_border,
                  title: AppStrings.menuFavorites,
                  onTap: () {},
                ),
                _DrawerItem(
                  icon: Icons.download_outlined,
                  title: AppStrings.menuDownloads,
                  onTap: () {},
                ),
                Divider(color: AppColors.grey.withValues(alpha: 0.3), height: 1),
                _DrawerItem(
                  icon: Icons.category_outlined,
                  title: AppStrings.menuCategories,
                  onTap: () {},
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  title: AppStrings.menuSettings,
                  onTap: () {},
                ),
                Divider(color: AppColors.grey.withValues(alpha: 0.3), height: 1),
                _DrawerItem(
                  icon: Icons.star_border,
                  title: AppStrings.menuRateApp,
                  onTap: () {},
                ),
                _DrawerItem(
                  icon: Icons.share_outlined,
                  title: AppStrings.menuShare,
                  onTap: () {},
                ),
                Divider(color: AppColors.grey.withValues(alpha: 0.3), height: 1),
                _DrawerItem(
                  icon: Icons.info_outline,
                  title: AppStrings.menuAbout,
                  onTap: () {},
                ),
                _DrawerItem(
                  icon: Icons.privacy_tip_outlined,
                  title: AppStrings.menuPrivacy,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.white70, size: 24.sp),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 14.sp,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
    );
  }
}

class _SearchFilterPanel extends StatefulWidget {
  final VoidCallback onClose;

  const _SearchFilterPanel({required this.onClose});

  @override
  State<_SearchFilterPanel> createState() => _SearchFilterPanelState();
}

class _SearchFilterPanelState extends State<_SearchFilterPanel> {
  String selectedCategory = AppStrings.filterCatAll;
  String selectedColor = AppStrings.filterColorAll;
  String selectedResolution = AppStrings.filterResAll;

  final List<String> categories = [
    AppStrings.filterCatAll,
    AppStrings.filterCatAbstract,
    AppStrings.filterCatNature,
    AppStrings.filterCatAnimals,
    AppStrings.filterCatCars,
    AppStrings.filterCatSpace,
  ];

  final List<String> colors = [
    AppStrings.filterColorAll,
    AppStrings.filterColorRed,
    AppStrings.filterColorBlue,
    AppStrings.filterColorGreen,
    AppStrings.filterColorYellow,
    AppStrings.filterColorBlack,
    AppStrings.filterColorWhite,
  ];

  final List<String> resolutions = [
    AppStrings.filterResAll,
    AppStrings.filterResHD,
    AppStrings.filterResFullHD,
    AppStrings.filterRes4K,
    AppStrings.filterRes8K,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();

    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 80.h, left: 20.w, right: 20.w),
          decoration: BoxDecoration(
            color: colors.surfaceColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.filterTitle,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: AppColors.white),
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.grey.withValues(alpha: 0.3), height: 1),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.filterByCategory,
                      style: TextStyle(
                        color: AppColors.white70,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: categories.map((cat) {
                        bool isSelected = selectedCategory == cat;
                        return GestureDetector(
                          onTap: () => setState(() => selectedCategory = cat),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              gradient: isSelected
                                  ? LinearGradient(
                                colors: [colors.gradientStart, colors.gradientEnd],
                              )
                                  : null,
                              color: isSelected ? null : colors.backgroundColor,
                            ),
                            child: Text(
                              cat,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      AppStrings.filterByColor,
                      style: TextStyle(
                        color: AppColors.white70,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: this.colors.map((color) {
                        bool isSelected = selectedColor == color;
                        return GestureDetector(
                          onTap: () => setState(() => selectedColor = color),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              gradient: isSelected
                                  ? LinearGradient(
                                colors: [colors.gradientStart, colors.gradientEnd],
                              )
                                  : null,
                              color: isSelected ? null : colors.backgroundColor,
                            ),
                            child: Text(
                              color,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      AppStrings.filterByResolution,
                      style: TextStyle(
                        color: AppColors.white70,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: resolutions.map((res) {
                        bool isSelected = selectedResolution == res;
                        return GestureDetector(
                          onTap: () => setState(() => selectedResolution = res),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              gradient: isSelected
                                  ? LinearGradient(
                                colors: [colors.gradientStart, colors.gradientEnd],
                              )
                                  : null,
                              color: isSelected ? null : colors.backgroundColor,
                            ),
                            child: Text(
                              res,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedCategory = AppStrings.filterCatAll;
                                selectedColor = AppStrings.filterColorAll;
                                selectedResolution = AppStrings.filterResAll;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              side: BorderSide(color: AppColors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              AppStrings.btnClearFilter,
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [colors.gradientStart, colors.gradientEnd],
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ElevatedButton(
                              onPressed: widget.onClose,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                AppStrings.btnApplyFilter,
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onSearchTap;

  const _HomeHeader({
    required this.onMenuTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onMenuTap,
                  child: Icon(Icons.menu, color: AppColors.white, size: 28.sp),
                ),
                GestureDetector(
                  onTap: onSearchTap,
                  child: Icon(Icons.search, color: AppColors.white, size: 28.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              AppStrings.labelHome,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            // Divider under Home text
            Container(
              height: 3.h,
              width: 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors().gradientStart,
                    AppColors().gradientEnd,
                  ],
                ),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChipTap;

  const _CategoryChips({
    required this.selectedIndex,
    required this.onChipTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final chips = [
      AppStrings.catAll,
      AppStrings.catRecommend,
      AppStrings.catLive,
      AppStrings.catPopular
    ];

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 45.h,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.horizontal,
          itemCount: chips.length,
          separatorBuilder: (_, _) => SizedBox(width: 10.w),
          itemBuilder: (context, index) {
            bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                onChipTap(index);
                // Navigate to category screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryWallpaperScreen(
                      category: chips[index],
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(929.r),
                  gradient: isSelected
                      ? LinearGradient(
                    colors: [colors.gradientStart, colors.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: isSelected ? null : colors.surfaceColor,
                ),
                child: Text(
                  chips[index],
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext methodContext) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  methodContext,
                  MaterialPageRoute(
                    builder: (context) => CategoryWallpaperScreen(
                      category: title,
                    ),
                  ),
                );
              },
              child: Icon(Icons.arrow_forward_ios, color: AppColors.grey, size: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopularHorizontalList extends StatelessWidget {
  const _PopularHorizontalList();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 250.h,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          separatorBuilder: (_, _) => SizedBox(width: 15.w),
          itemBuilder: (context, index) {
            final imageUrl = 'https://picsum.photos/seed/${index + 100}/300/500';
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperDetailScreen(
                      imageUrl: imageUrl,
                      title: 'Popular Wallpaper ${index + 1}',
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.network(
                  imageUrl,
                  width: 180.w,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final List<String> gridNames = [
      AppStrings.gridCatFeatured,
      AppStrings.gridCatRecommended,
      AppStrings.gridCatTraditional,
      AppStrings.gridCatTexture,
    ];

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 15.w,
          childAspectRatio: 1.5,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryWallpaperScreen(
                      category: gridNames[index],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(
                      'https://picsum.photos/seed/${index + 50}/400/300',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: colors.overlayDark,
                    ),
                  ),
                  Positioned(
                    bottom: 10.h,
                    left: 10.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gridNames[index],
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          AppStrings.labelWallpaperCount,
                          style: TextStyle(
                            color: AppColors.white70,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          childCount: gridNames.length,
        ),
      ),
    );
  }
}

// Live Wallpapers Grid Section
class _LiveWallpapersGrid extends StatelessWidget {
  const _LiveWallpapersGrid();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.65,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final imageUrl = 'https://picsum.photos/seed/${index + 200}/300/500';
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperDetailScreen(
                      imageUrl: imageUrl,
                      title: 'Live Wallpaper ${index + 1}',
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                    // Live indicator badge
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors().gradientStart,
                              AppColors().gradientEnd,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_circle_filled,
                              color: AppColors.white,
                              size: 12.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: 6,
        ),
      ),
    );
  }
}

// Category Wallpaper Screen - Shows filtered wallpapers based on category
class CategoryWallpaperScreen extends StatelessWidget {
  final String category;

  const CategoryWallpaperScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors().backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          category,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15.h,
            crossAxisSpacing: 15.w,
            childAspectRatio: 0.65,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            final imageUrl = 'https://picsum.photos/seed/${category.hashCode + index}/300/500';
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperDetailScreen(
                      imageUrl: imageUrl,
                      title: '$category ${index + 1}',
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                    // Gradient overlay at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: AppColors.white,
                              size: 18.sp,
                            ),
                            Icon(
                              Icons.download_outlined,
                              color: AppColors.white,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}