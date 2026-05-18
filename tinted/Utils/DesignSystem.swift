import SwiftUI

// MARK: - Colors
extension Color {
    static let tintedOffWhite = Color(hex: "F7F3EC")
    static let tintedPaper    = Color(hex: "FBF8F2")
    static let tintedInk      = Color(hex: "111111")
    static let tintedBeige    = Color(hex: "EFE8DE")
    static let tintedLine     = Color(hex: "D8D0C4")
    static let tintedMuted    = Color(hex: "9A9186")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:  (a,r,g,b) = (255,(int>>8)*17,(int>>4 & 0xF)*17,(int & 0xF)*17)
        case 6:  (a,r,g,b) = (255,int>>16,int>>8 & 0xFF,int & 0xFF)
        case 8:  (a,r,g,b) = (int>>24,int>>16 & 0xFF,int>>8 & 0xFF,int & 0xFF)
        default: (a,r,g,b) = (255,0,0,0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255, opacity: Double(a)/255)
    }
}

// MARK: - Typography
extension Font {
    static let tintedDisplay  = Font.system(size: 32, weight: .bold)
    static let tintedTitle    = Font.system(size: 22, weight: .bold)
    static let tintedHeadline = Font.system(size: 17, weight: .semibold)
    static let tintedBody     = Font.system(size: 15, weight: .regular)
    static let tintedCaption  = Font.system(size: 12, weight: .regular)
    static let tintedLabel    = Font.system(size: 11, weight: .medium)
}

// MARK: - Spacing
struct TintedSpacing {
    static let xs: CGFloat  = 4
    static let sm: CGFloat  = 8
    static let md: CGFloat  = 16
    static let lg: CGFloat  = 24
    static let xl: CGFloat  = 32
    static let xxl: CGFloat = 48
}

// MARK: - Corner Radius
struct TintedRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 14
    static let lg: CGFloat = 20
    static let xl: CGFloat = 28
}

// MARK: - Primary Button
struct TintedPrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.tintedHeadline)
            .foregroundColor(.tintedPaper)
            .frame(maxWidth: .infinity)
            .padding(.vertical, TintedSpacing.md)
            .background(Color.tintedInk)
            .cornerRadius(TintedRadius.md)
    }
}

// MARK: - Secondary Button
struct TintedSecondaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.tintedHeadline)
            .foregroundColor(.tintedInk)
            .frame(maxWidth: .infinity)
            .padding(.vertical, TintedSpacing.md)
            .background(Color.tintedPaper)
            .cornerRadius(TintedRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: TintedRadius.md)
                    .stroke(Color.tintedLine, lineWidth: 1)
            )
    }
}

extension View {
    func tintedPrimaryButton() -> some View { self.modifier(TintedPrimaryButton()) }
    func tintedSecondaryButton() -> some View { self.modifier(TintedSecondaryButton()) }
}

// MARK: - Card Style
struct TintedCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.tintedPaper)
            .cornerRadius(TintedRadius.lg)
            .shadow(color: Color.tintedInk.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

extension View {
    func tintedCard() -> some View { self.modifier(TintedCard()) }
}