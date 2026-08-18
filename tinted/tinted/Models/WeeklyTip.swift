import Foundation

struct WeeklyTip {
    let title: String
    let body: String
}

extension WeeklyTip {
    static let all: [WeeklyTip] = [
        WeeklyTip(
            title: "Layer thinnest to thickest",
            body: "Apply serums before creams so lighter formulas can absorb first."
        ),
        WeeklyTip(
            title: "Niacinamide pairs well with retinol",
            body: "It can help reduce the irritation retinol sometimes causes."
        ),
        WeeklyTip(
            title: "SPF is a leave-on step",
            body: "Reapply every 2 hours outdoors — even on cloudy days."
        ),
        WeeklyTip(
            title: "Patch test new actives",
            body: "Wait 48 hours on a small patch of skin before adding a new active to your routine."
        )
    ]

    static var thisWeek: WeeklyTip {
        let week = Calendar.current.component(.weekOfYear, from: Date())
        return all[week % all.count]
    }
}
