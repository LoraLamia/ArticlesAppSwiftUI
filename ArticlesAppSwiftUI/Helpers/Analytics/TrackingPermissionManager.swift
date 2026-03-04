import Foundation
import AppTrackingTransparency
import FirebaseAnalytics

@Observable
final class TrackingPermissionManager {

    func askToTrackIfNeeded() async {
        let currentStatus = ATTrackingManager.trackingAuthorizationStatus
        
        if currentStatus == .notDetermined {
            try? await Task.sleep(nanoseconds: 800_000_000)
            let status = await ATTrackingManager.requestTrackingAuthorization()
            configureAnalytics(for: status)
        } else {
            configureAnalytics(for: currentStatus)
        }
    }

    private func configureAnalytics(for status: ATTrackingManager.AuthorizationStatus) {
        let isAuthorized = status == .authorized
        Analytics.setAnalyticsCollectionEnabled(isAuthorized)
    }
}
