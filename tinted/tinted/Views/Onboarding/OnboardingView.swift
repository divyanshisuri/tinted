import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        ZStack {
            Color(red: 0.97, green: 0.95, blue: 0.93).ignoresSafeArea()

            switch currentStep {
            case 0: WelcomeStep(onNext: { currentStep = 1 })
            case 1: SkinTypeStep(onNext: { currentStep = 2 })
            case 2: ConcernsStep(onNext: { currentStep = 3 })
            case 3: AvoidStep(onNext: { currentStep = 4 })
            case 4: GoalStep(onNext: { hasCompletedOnboarding = true })
            default: WelcomeStep(onNext: { currentStep = 1 })
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentStep)
    }
}

// MARK: - Progress Bar
struct OnboardingProgress: View {
    let current: Int
    let total: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<total, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(
                        i <= current
                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                        : Color(red: 0.84, green: 0.82, blue: 0.77)
                    )
                    .frame(height: 3)
            }
        }
        .padding(.horizontal, 24)
    }
}

// MARK: - Step 1: Welcome
struct WelcomeStep: View {
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Spacer()

            VStack(alignment: .leading, spacing: 24) {

                // Logo mark
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: "sparkles")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )

                VStack(alignment: .leading, spacing: 12) {
                    Text("Your beauty shelf,\nfinally personal.")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        .lineSpacing(4)

                    Text("Reviews, ingredient checks, skin-tone matching, and routine reminders in one calm app.")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        .lineSpacing(5)
                }

                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Text("Personal fit first. No fear-based scoring.")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                }
            }
            .padding(.horizontal, 28)

            Spacer()

            VStack(spacing: 12) {
                Button(action: onNext) {
                    HStack(spacing: 10) {
                        Image(systemName: "applelogo")
                            .font(.system(size: 15))
                        Text("Continue with Apple")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .cornerRadius(14)
                }

                Button(action: onNext) {
                    Text("Continue with Email")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color(red: 0.84, green: 0.82, blue: 0.77), lineWidth: 1)
                        )
                }

                Button(action: onNext) {
                    Text("Already have an account? Log in")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 52)
        }
    }
}

// MARK: - Step 2: Skin Type
struct SkinTypeStep: View {
    let onNext: () -> Void
    @State private var selected: Set<String> = []
    let options = ["Oily", "Dry", "Combo", "Normal", "Sensitive"]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OnboardingProgress(current: 0, total: 4)
                .padding(.top, 64)

            VStack(alignment: .leading, spacing: 10) {
                Text("Build your profile")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Text("Used for shade, ingredient, and routine matching.")
                    .font(.system(size: 15))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    .lineSpacing(3)
            }
            .padding(.horizontal, 24)
            .padding(.top, 36)

            VStack(alignment: .leading, spacing: 16) {
                Text("Skin type")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    .padding(.horizontal, 24)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(options, id: \.self) { option in
                            OnboardingChip(
                                label: option,
                                isSelected: selected.contains(option)
                            ) {
                                if selected.contains(option) {
                                    selected.remove(option)
                                } else {
                                    selected.insert(option)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding(.top, 40)

            Spacer()

            Button(action: onNext) {
                Text("Continue")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 52)
        }
    }
}

// MARK: - Step 3: Concerns
struct ConcernsStep: View {
    let onNext: () -> Void
    @State private var selected: Set<String> = []
    let options = ["Acne", "Texture", "Dark spots", "Redness", "Dryness", "Oiliness", "Sensitivity", "Aging"]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OnboardingProgress(current: 1, total: 4)
                .padding(.top, 64)

            VStack(alignment: .leading, spacing: 10) {
                Text("What are your\nmain concerns?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .lineSpacing(4)
                Text("We'll filter reviews and flag ingredients that matter to you.")
                    .font(.system(size: 15))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    .lineSpacing(3)
            }
            .padding(.horizontal, 24)
            .padding(.top, 36)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 12
            ) {
                ForEach(options, id: \.self) { option in
                    OnboardingChip(
                        label: option,
                        isSelected: selected.contains(option)
                    ) {
                        if selected.contains(option) {
                            selected.remove(option)
                        } else {
                            selected.insert(option)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 36)

            Spacer()

            Button(action: onNext) {
                Text("Continue")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 52)
        }
    }
}

// MARK: - Step 4: Avoid List
struct AvoidStep: View {
    let onNext: () -> Void
    @State private var selected: Set<String> = []
    let options = ["Fragrance", "Coconut oil", "Drying alcohols", "Essential oils", "Parabens", "Sulfates", "Silicones", "Retinoids"]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OnboardingProgress(current: 2, total: 4)
                .padding(.top, 64)

            VStack(alignment: .leading, spacing: 10) {
                Text("Anything you\nwant to avoid?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .lineSpacing(4)
                Text("We'll flag these in every ingredient scan and product review.")
                    .font(.system(size: 15))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    .lineSpacing(3)
            }
            .padding(.horizontal, 24)
            .padding(.top, 36)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 12
            ) {
                ForEach(options, id: \.self) { option in
                    OnboardingChip(
                        label: option,
                        isSelected: selected.contains(option)
                    ) {
                        if selected.contains(option) {
                            selected.remove(option)
                        } else {
                            selected.insert(option)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 36)

            Spacer()

            Button(action: onNext) {
                Text("Continue")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 52)
        }
    }
}

// MARK: - Step 5: Goal
struct GoalStep: View {
    let onNext: () -> Void
    @State private var selected: String? = nil
    let options: [(String, String)] = [
        ("Everyday glow", "Hydrated, natural, effortless"),
        ("Sensitive safe", "Calm, barrier-first, no irritants"),
        ("Acne control", "Clear skin, non-comedogenic picks"),
        ("Anti-aging", "Firming, brightening, retinol-friendly")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OnboardingProgress(current: 3, total: 4)
                .padding(.top, 64)

            VStack(alignment: .leading, spacing: 10) {
                Text("What's your\nbeauty goal?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .lineSpacing(4)
                Text("This shapes your home feed and routine suggestions.")
                    .font(.system(size: 15))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    .lineSpacing(3)
            }
            .padding(.horizontal, 24)
            .padding(.top, 36)

            VStack(spacing: 12) {
                ForEach(options, id: \.0) { option in
                    Button {
                        selected = option.0
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(option.0)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                Text(option.1)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            }
                            Spacer()
                            Image(systemName: selected == option.0 ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        }
                        .padding(16)
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(
                                    selected == option.0
                                    ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                    : Color.clear,
                                    lineWidth: 1.5
                                )
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 36)

            Spacer()

            Button(action: onNext) {
                Text("Create my profile")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        selected != nil
                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                        : Color(red: 0.84, green: 0.82, blue: 0.77)
                    )
                    .cornerRadius(14)
            }
            .disabled(selected == nil)
            .padding(.horizontal, 24)
            .padding(.bottom, 52)
        }
    }
}

// MARK: - Onboarding Chip
struct OnboardingChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(
                    isSelected
                    ? Color(red: 0.98, green: 0.97, blue: 0.95)
                    : Color(red: 0.07, green: 0.07, blue: 0.07)
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    isSelected
                    ? Color(red: 0.07, green: 0.07, blue: 0.07)
                    : Color(red: 0.98, green: 0.97, blue: 0.95)
                )
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isSelected
                            ? Color.clear
                            : Color(red: 0.84, green: 0.82, blue: 0.77),
                            lineWidth: 1
                        )
                )
        }
        .buttonStyle(.plain)
    }
}
