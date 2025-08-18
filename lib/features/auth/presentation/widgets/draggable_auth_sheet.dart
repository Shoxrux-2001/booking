import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/features/auth/presentation/widgets/login_form.dart';
import 'package:restaurant/features/auth/presentation/widgets/register_form.dart';
import 'package:restaurant/features/auth/presentation/viewmodels/auth_viewmodel.dart';

void showDraggableAuthSheet(BuildContext context, {int initialPage = 0}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return AuthSheetContent(
            scrollController: scrollController,
            initialPage: initialPage,
          );
        },
      ),
    ),
  );
}

class AuthSheetContent extends StatefulWidget {
  final ScrollController scrollController;
  final int initialPage;

  const AuthSheetContent({
    super.key,
    required this.scrollController,
    this.initialPage = 0,
  });

  @override
  _AuthSheetContentState createState() => _AuthSheetContentState();
}

class _AuthSheetContentState extends State<AuthSheetContent> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: _currentPage == 0 ? Colors.green : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 2,
                        width: 40,
                        color: _currentPage == 0
                            ? Colors.green
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          color: _currentPage == 1 ? Colors.green : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 2,
                        width: 40,
                        color: _currentPage == 1
                            ? Colors.green
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                LoginForm(
                  onSwitch: () => _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                RegisterForm(
                  onSwitch: () => _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
