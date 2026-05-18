import SwiftUI

struct DiscoverView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    let categories = ["All", "Makeup", "Skincare", "Safe for me"]
    let products = Product.mockProducts

    var filtered: [Product] {
        let byCategory = selectedCategory == "All" ? products
            : selectedCategory == "Safe for me" ? products.filter { $0.isRoutineSafe }
            : products.filter { $0.category == selectedCategory }
        if searchText.isEmpty { return byCategory }
        return byCategory.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.brand.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Search bar
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        TextField("Search products, ingredients, shades...", text: $searchText)
                            .font(.system(size: 14))
                    }
                    .padding(12)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(14)
                    .padding(.horizontal, 20)

                    // Category filters
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories, id: \.self) { cat in
                                Button {
                                    selectedCategory = cat
                                } label: {
                                    Text(cat)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(
                                            selectedCategory == cat
                                            ? Color(red: 0.98, green: 0.97, blue: 0.95)
                                            : Color(red: 0.07, green: 0.07, blue: 0.07)
                                        )
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 7)
                                        .background(
                                            selectedCategory == cat
                                            ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                            : Color(red: 0.98, green: 0.97, blue: 0.95)
                                        )
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    // Ingredient of the week
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredient of the week")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            .padding(.horizontal, 20)

                        HStack(spacing: 14) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Text("N")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Niacinamide")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                Text("Brightens, minimizes pores, supports barrier")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        }
                        .padding(16)
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }

                    // Product grid
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("Routine-safe picks")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            Spacer()
                            Button("Filter") {}
                                .font(.system(size: 13))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        }
                        .padding(.horizontal, 20)

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 14),
                                GridItem(.flexible(), spacing: 14)
                            ],
                            spacing: 14
                        ) {
                            ForEach(filtered) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    ProductCard(product: product)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer(minLength: 32)
                }
                .padding(.top, 16)
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Discover")
        }
    }
}
