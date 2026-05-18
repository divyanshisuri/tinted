import SwiftUI

struct WriteReviewView: View {
    let product: Product
    @Environment(\.dismiss) private var dismiss
    @State private var rating = 0
    @State private var reviewText = ""
    @State private var selectedShade = ""
    @State private var selectedTags: Set<String> = []
    @State private var repurchase: Bool? = nil
    @State private var submitted = false

    let skinTags = ["Combo skin", "Oily skin", "Dry skin", "Sensitive skin", "Acne-prone"]
    let toneTags = ["Fair", "Light", "Medium", "Tan", "Deep"]
    let wearTags = ["Full day wear", "Oxidized", "Transferred", "Faded by noon"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {

                    // Product header
                    HStack(spacing: 14) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                            .frame(width: 56, height: 56)
                            .overlay(
                                Image(systemName: "sparkles")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            )
                        VStack(alignment: .leading, spacing: 3) {
                            Text(product.name)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            Text(product.brand)
                                .font(.system(size: 13))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        }
                    }
                    .padding(16)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(16)

                    // Star rating
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Rating")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        HStack(spacing: 12) {
                            ForEach(1..<6) { star in
                                Button {
                                    rating = star
                                } label: {
                                    Image(systemName: star <= rating ? "star.fill" : "star")
                                        .font(.system(size: 32))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                }
                            }
                        }
                    }

                    // Shade used
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Shade used")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        TextField("e.g. 240 Neutral", text: $selectedShade)
                            .font(.system(size: 14))
                            .padding(12)
                            .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                            .cornerRadius(12)
                    }

                    // Written review
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your review")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        ZStack(alignment: .topLeading) {
                            if reviewText.isEmpty {
                                Text("How did it wear? Did it oxidize? Would you repurchase?")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.84, green: 0.82, blue: 0.77))
                                    .padding(12)
                            }
                            TextEditor(text: $reviewText)
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .frame(minHeight: 120)
                                .padding(8)
                                .scrollContentBackground(.hidden)
                        }
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(12)
                    }

                    // Skin tags
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your skin type")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        TagSelector(tags: skinTags, selected: $selectedTags)
                    }

                    // Tone tags
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your tone")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        TagSelector(tags: toneTags, selected: $selectedTags)
                    }

                    // Wear tags
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Wear experience")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        TagSelector(tags: wearTags, selected: $selectedTags)
                    }

                    // Repurchase
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Would you repurchase?")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        HStack(spacing: 12) {
                            RepurchaseButton(label: "Yes", selected: repurchase == true) {
                                repurchase = true
                            }
                            RepurchaseButton(label: "No", selected: repurchase == false) {
                                repurchase = false
                            }
                        }
                    }

                    // Submit
                    Button {
                        submitted = true
                        dismiss()
                    } label: {
                        Text("Publish review")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                rating > 0 && !reviewText.isEmpty
                                ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                : Color(red: 0.84, green: 0.82, blue: 0.77)
                            )
                            .cornerRadius(14)
                    }
                    .disabled(rating == 0 || reviewText.isEmpty)

                    Spacer(minLength: 32)
                }
                .padding(20)
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Write a review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                }
            }
        }
    }
}

// MARK: - Tag Selector
struct TagSelector: View {
    let tags: [String]
    @Binding var selected: Set<String>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Button {
                        if selected.contains(tag) {
                            selected.remove(tag)
                        } else {
                            selected.insert(tag)
                        }
                    } label: {
                        Text(tag)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(
                                selected.contains(tag)
                                ? Color(red: 0.98, green: 0.97, blue: 0.95)
                                : Color(red: 0.07, green: 0.07, blue: 0.07)
                            )
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(
                                selected.contains(tag)
                                ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                : Color(red: 0.98, green: 0.97, blue: 0.95)
                            )
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

// MARK: - Repurchase Button
struct RepurchaseButton: View {
    let label: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(
                    selected
                    ? Color(red: 0.98, green: 0.97, blue: 0.95)
                    : Color(red: 0.07, green: 0.07, blue: 0.07)
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    selected
                    ? Color(red: 0.07, green: 0.07, blue: 0.07)
                    : Color(red: 0.98, green: 0.97, blue: 0.95)
                )
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 0.84, green: 0.82, blue: 0.77), lineWidth: 1)
                )
        }
    }
}
