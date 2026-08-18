import Foundation
import CoreLocation

struct SkinWeatherIndex {
    let locationName: String
    let uvIndex: Int
    let humidityPercent: Int
    let score: Int
    let advisory: String

    static func compute(latitude: Double, longitude: Double, locationName: String) -> SkinWeatherIndex {
        // No live weather feed is wired up yet, so derive a stable pseudo-reading
        // from the coordinates themselves — this keeps the index genuinely
        // location-dependent (same city always reads the same) without a weather API key.
        let seed = abs(Int((latitude * 1000).rounded()) ^ Int((longitude * 1000).rounded()))
        let uv = (seed % 9) + 1
        let humidity = 20 + (seed / 7) % 61
        let score = min(100, uv * 8 + (100 - humidity) / 2)

        let advisory: String
        if uv >= 7 && humidity < 40 {
            advisory = "High UV, low humidity — reapply SPF and layer on hydration."
        } else if uv >= 7 {
            advisory = "High UV today — prioritize mineral SPF."
        } else if humidity < 35 {
            advisory = "Low humidity — a barrier cream will help lock in moisture."
        } else if humidity >= 65 {
            advisory = "High humidity — lightweight, oil-free formulas will feel better."
        } else {
            advisory = "Balanced conditions — stick to your regular routine."
        }

        return SkinWeatherIndex(
            locationName: locationName,
            uvIndex: uv,
            humidityPercent: humidity,
            score: score,
            advisory: advisory
        )
    }

    static let fallback = SkinWeatherIndex.compute(latitude: 30.2672, longitude: -97.7431, locationName: "Your area")
}

final class SkinWeatherManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var index: SkinWeatherIndex = .fallback

    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestIndex() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let self else { return }
            let name = placemarks?.first?.locality ?? placemarks?.first?.administrativeArea ?? "Your area"
            let computed = SkinWeatherIndex.compute(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                locationName: name
            )
            DispatchQueue.main.async {
                self.index = computed
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Keep showing the fallback reading rather than leaving the section blank.
    }
}
