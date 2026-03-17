import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:issue_tracker/Class/issue_manager.dart';
import 'package:issue_tracker/Screens/add_issue.dart';
import 'package:issue_tracker/Screens/issues.dart';
import 'package:issue_tracker/Screens/resolved_issues.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn1;
  late Animation<double> _fadeIn2;
  late Animation<double> _fadeIn3;
  late Animation<Offset> _slide1;
  late Animation<Offset> _slide2;
  late Animation<Offset> _slide3;

  @override
  void initState() {
    super.initState();
    // Provider will handle notifying widgets; no manual listener needed.

    // Animation controller for staggered entrance
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Define fade and slide animations with staggered intervals
    _fadeIn1 = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut));
    _fadeIn2 = CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6, curve: Curves.easeOut));
    _fadeIn3 = CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeOut));

    _slide1 = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(_fadeIn1);
    _slide2 = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(_fadeIn2);
    _slide3 = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(_fadeIn3);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Issue Tracker",
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                _buildAnimatedCard(
                  animation: _fadeIn1,
                  slide: _slide1,
                  child: _buildAddIssueCard(),
                ),
                const SizedBox(height: 25),
                _buildAnimatedCard(
                  animation: _fadeIn2,
                  slide: _slide2,
                  child: _buildPendingIssuesCard(),
                ),
                const SizedBox(height: 25),
                _buildAnimatedCard(
                  animation: _fadeIn3,
                  slide: _slide3,
                  child: _buildResolvedIssuesCard(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Wraps each card with fade + slide animation
  Widget _buildAnimatedCard({
    required Animation<double> animation,
    required Animation<Offset> slide,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: slide,
        child: child,
      ),
    );
  }

  // Add Issue Card – Blue gradient background
  Widget _buildAddIssueCard() {
    return _buildCard(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AddIssue()));
      },
      gradient: LinearGradient(
        colors: [Colors.blue[400]!, Colors.blue[700]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icons.add_circle_outline,
      title: 'Add New Issue',
      subtitle: 'Create a new issue ticket',
      buttonText: 'Add Issue',
    );
  }

  // Pending Issues Card – White with blue border
  Widget _buildPendingIssuesCard() {
    final pendingCount = context.watch<IssueManager>().issues.where((issue) => issue.status == 'Open' || issue.status == 'In Progress').length;

    return _buildCard(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewIssues()));
      },
      borderColor: Colors.blue[700]!,
      icon: Icons.pending_actions,
      title: 'Pending Issues',
      subtitle: '$pendingCount issue${pendingCount != 1 ? 's' : ''} awaiting',
      buttonText: 'View Issues',
      count: pendingCount,
    );
  }

  // Resolved Issues Card – White with blue border
  Widget _buildResolvedIssuesCard() {
    final resolvedCount = context.watch<IssueManager>().issues.where((issue) => issue.status == 'Resolved').length;

    return _buildCard(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ResolvedIssues()));
      },
      borderColor: Colors.blue[700]!,
      icon: Icons.check_circle_outline,
      title: 'Resolved Issues',
      subtitle: '$resolvedCount issue${resolvedCount != 1 ? 's' : ''} completed',
      buttonText: 'View Resolved',
      count: resolvedCount,
    );
  }

  // Reusable card builder with consistent styling and tap animation
  Widget _buildCard({
    required VoidCallback onTap,
    Color? borderColor,
    Gradient? gradient,
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    int? count,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.0),
      duration: const Duration(milliseconds: 150),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: gradient == null ? Colors.white : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            border: borderColor != null ? Border.all(color: borderColor, width: 1.5) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.blue.withOpacity(0.2),
              highlightColor: Colors.blue.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          icon,
                          size: 32,
                          color: gradient != null ? Colors.white : Colors.blue[700],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: gradient != null ? Colors.white : Colors.blue[900],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: gradient != null ? Colors.white.withOpacity(0.9) : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (count != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: gradient != null ? Colors.white : Colors.blue[50],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              count.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: gradient != null ? Colors.blue[700] : Colors.blue[700],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: gradient != null ? Colors.white : Colors.blue[50],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                buttonText,
                                style: TextStyle(
                                  color: gradient != null ? Colors.blue[700] : Colors.blue[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 18,
                                color: gradient != null ? Colors.blue[700] : Colors.blue[700],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}