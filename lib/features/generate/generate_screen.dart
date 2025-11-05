import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/providers/templates_provider.dart';

class GenerateScreen extends ConsumerStatefulWidget {
  const GenerateScreen({
    required this.templateId,
    super.key,
  });

  final String templateId;

  @override
  ConsumerState<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends ConsumerState<GenerateScreen> {
  int _currentStep = 0;
  String? _selectedAspectRatio;

  @override
  Widget build(BuildContext context) {
    final templateAsync = ref.watch(templateByIdProvider(widget.templateId));

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Generate'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
      body: templateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (template) {
          if (template == null) {
            return const Center(child: Text('Template not found'));
          }

          return Column(
            children: [
              // Stepper header
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                color: AppColors.surface,
                child: Row(
                  children: [
                    _StepIndicator(
                      label: 'Assets',
                      isActive: _currentStep == 0,
                      isCompleted: _currentStep > 0,
                    ),
                    _StepDivider(isCompleted: _currentStep > 0),
                    _StepIndicator(
                      label: 'Options',
                      isActive: _currentStep == 1,
                      isCompleted: _currentStep > 1,
                    ),
                    _StepDivider(isCompleted: _currentStep > 1),
                    _StepIndicator(
                      label: 'Summary',
                      isActive: _currentStep == 2,
                      isCompleted: false,
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: _buildStepContent(template),
              ),
              // Bottom bar
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(color: AppColors.stroke),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      if (_currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() => _currentStep--);
                            },
                            child: const Text('Back'),
                          ),
                        ),
                      if (_currentStep > 0) const SizedBox(width: AppSpacing.md),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentStep < 2) {
                              setState(() => _currentStep++);
                            } else {
                              // Generate
                              _showGeneratingDialog(context);
                            }
                          },
                          child: Text(
                            _currentStep == 2 ? 'Generate' : 'Continue',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStepContent(template) {
    switch (_currentStep) {
      case 0:
        return _buildAssetsStep();
      case 1:
        return _buildOptionsStep(template);
      case 2:
        return _buildSummaryStep(template);
      default:
        return Container();
    }
  }

  Widget _buildAssetsStep() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.stroke, width: 2),
            ),
            child: const Icon(
              Icons.add_photo_alternate,
              size: 48,
              color: AppColors.text2,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text(
            'Upload Your Media',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Choose a photo or video from your gallery',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.text2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsStep(template) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aspect Ratio',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: template.aspectRatios.map<Widget>((ar) {
              final isSelected = _selectedAspectRatio == ar;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedAspectRatio = ar);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.lime : AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.lime : AppColors.stroke,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    ar,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.bg : AppColors.text,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStep(template) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SummaryItem(
            label: 'Template',
            value: template.title,
          ),
          _SummaryItem(
            label: 'Aspect Ratio',
            value: _selectedAspectRatio ?? template.aspectRatios.first,
          ),
          _SummaryItem(
            label: 'Cost',
            value: '${template.creditCost} credits',
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.blue, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Generation typically takes 10-30 seconds',
                    style: TextStyle(fontSize: 13, color: AppColors.text2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showGeneratingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          if (context.mounted) {
            context.pop();
            context.go('/result/cr_demo');
          }
        });
        return AlertDialog(
          backgroundColor: AppColors.card,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Generating...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.label,
    required this.isActive,
    required this.isCompleted,
  });

  final String label;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive || isCompleted ? AppColors.lime : AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive || isCompleted ? AppColors.lime : AppColors.stroke,
              width: 2,
            ),
          ),
          child: Icon(
            isCompleted ? Icons.check : Icons.circle,
            size: 16,
            color: isActive || isCompleted ? AppColors.bg : AppColors.text2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? AppColors.text : AppColors.text2,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _StepDivider extends StatelessWidget {
  const _StepDivider({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20),
        color: isCompleted ? AppColors.lime : AppColors.stroke,
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.text2,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
