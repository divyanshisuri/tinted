import SwiftUI

struct MeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Me")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        .padding(.horizontal, 16)
                    Text("Profile · Shelf · Routines")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        .padding(.horizontal, 16)
                }
                .padding(.top, 24)
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Me")
        }
    }
}
