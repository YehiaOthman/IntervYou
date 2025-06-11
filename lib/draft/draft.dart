// bottomNavigationBar: Container(
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.white.withOpacity(0.8),
// blurRadius: 13,
// spreadRadius: -2,
// offset: Offset(0, 2.5),
// blurStyle: BlurStyle.solid,
// ),
// ],
// ),
// child: BottomNavigationBar(
// backgroundColor: Colors.black,
// currentIndex: selectedIndex,
// onTap: (index) {
// setState(() {
// selectedIndex = index;
// });
// },
// selectedItemColor: ColorsManger.secondaryColor,
// unselectedItemColor: ColorsManger.txtFillColor,
// selectedLabelStyle: TextStyle(fontSize: 12),
// unselectedLabelStyle: TextStyle(fontSize: 12),
// items: [
// BottomNavigationBarItem(
// icon: SvgPicture.asset(
// AssetsManager.home,
// width: 25,
// height: 25,
// color: selectedIndex == 0
// ? ColorsManger.secondaryColor
//     : ColorsManger.txtFillColor,
// ),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: SvgPicture.asset(
// AssetsManager.blogs,
// width: 20,
// height: 20,
// color: selectedIndex == 1
// ? ColorsManger.secondaryColor
//     : ColorsManger.txtFillColor,
// ),
// label: 'Blogs',
// ),
// BottomNavigationBarItem(
// icon: SvgPicture.asset(
// AssetsManager.learn,
// width: 25,
// height: 25,
// color: selectedIndex == 2
// ? ColorsManger.secondaryColor
//     : ColorsManger.txtFillColor,
// ),
// label: 'Learning',
// ),
// BottomNavigationBarItem(
// icon: SvgPicture.asset(
// AssetsManager.profile,
// width: 25,
// height: 25,
// color: selectedIndex == 3
// ? ColorsManger.secondaryColor
//     : ColorsManger.txtFillColor,
// ),
// label: 'Profile',
// ),
// ],
// ),
// ),