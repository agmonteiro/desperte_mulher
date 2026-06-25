import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../controllers/quiz_controller.dart';
import '../widgets/question_card.dart';
import '../widgets/score_header.dart';
import 'result_screen.dart';

class QuizShellScreen extends StatefulWidget {
  final QuizController controller;

  const QuizShellScreen({
    super.key,
    required this.controller,
  });

  @override
  State<QuizShellScreen> createState() => _QuizShellScreenState();
}

class _QuizShellScreenState extends State<QuizShellScreen> {
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    widget.controller.loadQuiz().then((_) {
      if (!mounted) return;
      _pageController = PageController();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final currentPageValid = widget.controller.isCurrentPageValid();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Desperta Mulher'),
            centerTitle: true,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: widget.controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : widget.controller.errorMessage != null
                        ? Center(
                            child: Text(
                              widget.controller.errorMessage!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        : widget.controller.currentPageIndex >= widget.controller.pages.length
                            ? ResultScreen(
                                controller: widget.controller,
                                onRestart: () {
                                  widget.controller.reset();
                                  _pageController?.jumpToPage(0);
                                  setState(() {});
                                },
                              )
                            : Column(
                                children: [
                                  ScoreHeader(
                                    selectedAnswersCount: widget.controller.selectedAnswersCount,
                                    threatLevel: widget.controller.threatLevel,
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: PageView.builder(
                                      controller: _pageController,
                                      onPageChanged: widget.controller.setCurrentPage,
                                      itemCount: widget.controller.pages.length,
                                      itemBuilder: (context, index) {
                                        final page = widget.controller.pages[index];

                                        return SingleChildScrollView(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                page.title,
                                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                      fontWeight: FontWeight.w800,
                                                      color: const Color(0xFF4A235A),
                                                    ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                page.description,
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: const Color(0xFF4A235A).withOpacity(0.8),
                                                    ),
                                              ),
                                              const SizedBox(height: 12),
                                              ...page.questions.map(
                                                (question) => QuestionCard(
                                                  pageId: page.id,
                                                  question: question,
                                                  controller: widget.controller,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      if (widget.controller.currentPageIndex > 0)
                                        OutlinedButton(
                                          onPressed: () {
                                            _pageController?.previousPage(
                                              duration: const Duration(milliseconds: 220),
                                              curve: Curves.easeOut,
                                            );
                                          },
                                          child: const Text('Voltar'),
                                        ),
                                      const Spacer(),
                                      FilledButton(
                                        onPressed: currentPageValid
                                            ? () {
                                                final isLastPage =
                                                    widget.controller.currentPageIndex ==
                                                    widget.controller.pages.length - 1;

                                                if (isLastPage) {
                                                  widget.controller.showResult();
                                                } else {
                                                  _pageController?.nextPage(
                                                    duration: const Duration(milliseconds: 220),
                                                    curve: Curves.easeOut,
                                                  );
                                                }
                                              }
                                            : null,
                                        child: Text(
                                          widget.controller.currentPageIndex ==
                                                  widget.controller.pages.length - 1
                                              ? 'Ver resultado'
                                              : 'Próxima página',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
              ),
            ),
          ),
        );
      },
    );
  }
}
