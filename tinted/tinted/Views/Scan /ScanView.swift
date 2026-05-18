import SwiftUI

struct ScanView: View {
    @State private var selectedScanner: ScannerType? = nil
    @State private var showIngredientResult = false
    @State private var pastedIngredients = ""
    @State private var showPasteInput = false

    enum ScannerType { case ingredient, skinTone }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Header
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Scanner")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        Text("Choose what you want to check.")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    // Scanner options
                    VStack(spacing: 14) {
                        ScannerOptionCard(
                            icon: "barcode.viewfinder",
                            title: "Ingredient scanner",
                            subtitle: "Barcode, label photo, or ingredient paste",
                            isSelected: selectedScanner == .ingredient
                        ) {
                            selectedScanner = .ingredient
                        }

                        ScannerOptionCard(
                            icon: "face.smiling",
                            title: "Skin-tone scanner",
                            subtitle: "Estimate tone, undertone, and shade matches",
                            isSelected: selectedScanner == .skinTone
                        ) {
                            selectedScanner = .skinTone
                        }
                    }
                    .padding(.horizontal, 20)

                    // Ingredient scanner expanded
                    if selectedScanner == .ingredient {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("How would you like to scan?")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                .padding(.horizontal, 20)

                            VStack(spacing: 12) {
                                ScanActionButton(
                                    icon: "barcode.viewfinder",
                                    label: "Scan barcode"
                                ) {
                                    showIngredientResult = true
                                }

                                ScanActionButton(
                                    icon: "camera",
                                    label: "Take photo of label"
                                ) {
                                    showIngredientResult = true
                                }

                                ScanActionButton(
                                    icon: "doc.text",
                                    label: "Paste ingredient list"
                                ) {
                                    showPasteInput = true
                                }

                                ScanActionButton(
                                    icon: "magnifyingglass",
                                    label: "Search product name"
                                ) {
                                    showIngredientResult = true
                                }
                            }
                            .padding(.horizontal, 20)

                            if showPasteInput {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Paste your ingredient list")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))

                                    ZStack(alignment: .topLeading) {
                                        if pastedIngredients.isEmpty {
                                            Text("Water, Niacinamide, Glycerin, Fragrance...")
                                                .font(.system(size: 13))
                                                .foregroundColor(Color(red: 0.84, green: 0.82, blue: 0.77))
                                                .padding(12)
                                        }
                                        TextEditor(text: $pastedIngredients)
                                            .font(.system(size: 13))
                                            .frame(minHeight: 100)
                                            .padding(8)
                                            .scrollContentBackground(.hidden)
                                    }
                                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                                    .cornerRadius(12)

                                    Button {
                                        showIngredientResult = true
                                    } label: {
                                        Text("Analyze ingredients")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 14)
                                            .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                                            .cornerRadius(12)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }

                    // Skin tone scanner expanded
                    if selectedScanner == .skinTone {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Skin-tone match")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                .padding(.horizontal, 20)

                            VStack(spacing: 12) {
                                ScanActionButton(
                                    icon: "camera.fill",
                                    label: "Scan my skin"
                                ) {}

                                ScanActionButton(
                                    icon: "photo",
                                    label: "Upload a photo instead"
                                ) {}
                            }
                            .padding(.horizontal, 20)

                            Text("Use even lighting. Results are suggestions, not guarantees.")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                .padding(.horizontal, 20)
                        }
                    }

                    // Recent scans
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Recent scans")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(.horizontal, 20)

                        VStack(spacing: 0) {
                            RecentScanRow(
                                name: "Gentle Exfoliant",
                                result: "Use carefully",
                                icon: "exclamationmark.circle",
                                iconColor: Color(red: 0.75, green: 0.45, blue: 0.20)
                            )
                            Divider().padding(.horizontal, 20)
                            RecentScanRow(
                                name: "Barrier Cream",
                                result: "Good fit · 94%",
                                icon: "checkmark.circle.fill",
                                iconColor: Color(red: 0.07, green: 0.07, blue: 0.07)
                            )
                            Divider().padding(.horizontal, 20)
                            RecentScanRow(
                                name: "Cloud Serum",
                                result: "Good fit · 82%",
                                icon: "checkmark.circle.fill",
                                iconColor: Color(red: 0.07, green: 0.07, blue: 0.07)
                            )
                        }
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }

                    Spacer(minLength: 32)
                }
                .padding(.top, 16)
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Scan")
            .sheet(isPresented: $showIngredientResult) {
                IngredientResultView()
            }
        }
    }
}

// MARK: - Scanner Option Card
struct ScannerOptionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        isSelected
                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                        : Color(red: 0.94, green: 0.91, blue: 0.87)
                    )
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 20))
                            .foregroundColor(
                                isSelected
                                ? Color(red: 0.98, green: 0.97, blue: 0.95)
                                : Color(red: 0.07, green: 0.07, blue: 0.07)
                            )
                    )

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "chevron.right")
                    .font(.system(size: 16))
                    .foregroundColor(
                        isSelected
                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                        : Color(red: 0.60, green: 0.57, blue: 0.53)
                    )
            }
            .padding(16)
            .background(Color(red: 0.98, green: 0.97, blue: 0.95))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected
                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                        : Color.clear,
                        lineWidth: 1.5
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Scan Action Button
struct ScanActionButton: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .frame(width: 24)
                Text(label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
            }
            .padding(16)
            .background(Color(red: 0.98, green: 0.97, blue: 0.95))
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Recent Scan Row
struct RecentScanRow: View {
    let name: String
    let result: String
    let icon: String
    let iconColor: Color

    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Text(result)
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
            }
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(iconColor)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

// MARK: - Ingredient Result View
struct IngredientResultView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Fit score
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Personal fit score")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))

                        HStack(alignment: .bottom, spacing: 8) {
                            Text("82%")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            Text("good fit, use slowly")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                .padding(.bottom, 8)
                        }

                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                                    .frame(height: 8)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
                                    .frame(width: geo.size.width * 0.82, height: 8)
                            }
                        }
                        .frame(height: 8)
                    }
                    .padding(20)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(20)

                    // Why it fits
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Why it fits")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))

                        VStack(alignment: .leading, spacing: 8) {
                            IngredientRow(name: "Niacinamide", type: "Active", note: "Supports barrier goals", isGood: true)
                            Divider()
                            IngredientRow(name: "Glycerin", type: "Humectant", note: "Hydrating, barrier safe", isGood: true)
                            Divider()
                            IngredientRow(name: "Ceramides", type: "Barrier support", note: "Strengthens skin barrier", isGood: true)
                        }
                        .padding(16)
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(16)
                    }

                    // Routine warning
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Routine warning")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.75, green: 0.45, blue: 0.20))

                        HStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.75, green: 0.45, blue: 0.20))
                            Text("Do not layer with exfoliating acid tonight. Move to alternate nights.")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineSpacing(3)
                        }
                        .padding(16)
                        .background(Color(red: 0.98, green: 0.95, blue: 0.90))
                        .cornerRadius(16)
                    }

                    // Ingredient breakdown
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredient breakdown")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))

                        VStack(alignment: .leading, spacing: 8) {
                            IngredientRow(name: "Fragrance", type: "Fragrance", note: "May irritate sensitive skin", isGood: false)
                            Divider()
                            IngredientRow(name: "Salicylic Acid", type: "Exfoliant", note: "Don't layer with retinol", isGood: false)
                            Divider()
                            IngredientRow(name: "Panthenol", type: "Conditioning", note: "Soothing, safe for most", isGood: true)
                        }
                        .padding(16)
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(16)
                    }

                    // Actions
                    VStack(spacing: 12) {
                        Button {} label: {
                            Text("Add to calendar")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .cornerRadius(14)
                        }

                        Button {} label: {
                            Text("Compare with another product")
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
                    }

                    Spacer(minLength: 32)
                }
                .padding(20)
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Ingredient results")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                }
            }
        }
    }
}

// MARK: - Ingredient Row
struct IngredientRow: View {
    let name: String
    let type: String
    let note: String
    let isGood: Bool

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(
                    isGood
                    ? Color(red: 0.07, green: 0.07, blue: 0.07)
                    : Color(red: 0.75, green: 0.45, blue: 0.20)
                )
                .frame(width: 8, height: 8)
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(name)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Text("· \(type)")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                Text(note)
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
            }
            Spacer()
        }
    }
}
