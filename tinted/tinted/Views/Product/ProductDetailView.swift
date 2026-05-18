import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var isSaved = false
    @State private var showingAddToRoutine = false
    @State private var showingWriteReview = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // Product image
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                    .frame(height: 280)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 48))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            Text(product.category)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        }
                    )

                VStack(alignment: .leading, spacing: 24) {

                    // Name + brand + save
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(product.name)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            Text(product.brand)
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            Text("$\(Int(product.price))")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .padding(.top, 2)
                        }
                        Spacer()
                        Button {
                            isSaved.toggle()
                        } label: {
                            Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        }
                    }

                    // Rating
                    HStack(spacing: 6) {
                        HStack(spacing: 3) {
                            ForEach(0..<5) { i in
                                Image(systemName: i < Int(product.rating) ? "star.fill" : "star")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            }
                        }
                        Text(String(format: "%.1f", product.rating))
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        Text("· \(product.reviewCount) reviews")
                            .font(.system(size: 13))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    }

                    // Fit score card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Your fit score")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                Text("\(product.fitScore)%")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 4) {
                                if product.isRoutineSafe {
                                    Label("Routine safe", systemImage: "checkmark.circle.fill")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                } else {
                                    Label("Check routine", systemImage: "exclamationmark.circle")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(Color(red: 0.75, green: 0.45, blue: 0.20))
                                }
                                if let shade = product.matchedShade {
                                    Text("Shade: \(shade)")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                }
                            }
                        }

                        // Fit score bar
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                                    .frame(height: 6)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
                                    .frame(width: geo.size.width * CGFloat(product.fitScore) / 100, height: 6)
                            }
                        }
                        .frame(height: 6)
                    }
                    .padding(16)
                    .background(Color(red: 0.94, green: 0.91, blue: 0.87))
                    .cornerRadius(16)

                    // Tags
                    if !product.tags.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Key notes")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            FlowLayout(tags: product.tags)
                        }
                    }

                    // Description
                    if !product.description.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("About")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            Text(product.description)
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .lineSpacing(4)
                        }
                    }

                    // People like you
                    VStack(alignment: .leading, spacing: 12) {
                        Text("People like you said...")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))

                        VStack(spacing: 12) {
                            MockReviewRow(
                                name: "divya",
                                tone: "medium neutral",
                                text: "Perfect shade match, no oxidizing. Wore all day without touching up.",
                                rating: 5
                            )
                            Divider()
                            MockReviewRow(
                                name: "sara_k",
                                tone: "medium neutral · combo",
                                text: "Love the finish. A little dewy but nothing setting spray can't fix.",
                                rating: 4
                            )
                        }
                        .padding(16)
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(16)
                    }

                    // CTAs
                    VStack(spacing: 12) {
                        Button {
                            isSaved = true
                        } label: {
                            Text("Add to shelf")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .cornerRadius(14)
                        }

                        Button {
                            showingAddToRoutine = true
                        } label: {
                            Text("Add to routine calendar")
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
                        
                        Button {
                            showingWriteReview = true
                        } label: {
                            Text("Write a review")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                        }
                        .sheet(isPresented: $showingWriteReview) {
                            WriteReviewView(product: product)
                        }
                    }

                    Spacer(minLength: 32)
                }
                .padding(20)
            }
        }
        .background(Color(red: 0.97, green: 0.95, blue: 0.93))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Flow Layout for tags
struct FlowLayout: View {
    let tags: [String]

    var body: some View {
        var width: CGFloat = 0
        var rows: [[String]] = [[]]

        return GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                ForEach(tags, id: \.self) { tag in
                    TagChip(text: tag)
                        .alignmentGuide(.leading) { d in
                            if width + d.width > geo.size.width {
                                width = 0
                                rows[rows.count - 1].append(tag)
                            }
                            let result = width
                            width = tag == tags.last ? 0 : width + d.width + 8
                            return -result
                        }
                }
            }
        }
        .frame(height: CGFloat(tags.count / 3 + 1) * 36)
    }
}

struct TagChip: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(red: 0.94, green: 0.91, blue: 0.87))
            .cornerRadius(20)
    }
}

// MARK: - Mock Review Row
struct MockReviewRow: View {
    let name: String
    let tone: String
    let text: String
    let rating: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Text(String(name.prefix(1)).uppercased())
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    )
                VStack(alignment: .leading, spacing: 2) {
                    Text("@\(name)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Text(tone)
                        .font(.system(size: 11))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                Spacer()
                HStack(spacing: 2) {
                    ForEach(0..<5) { i in
                        Image(systemName: i < rating ? "star.fill" : "star")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    }
                }
            }
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                .lineSpacing(3)
        }
    }
}
