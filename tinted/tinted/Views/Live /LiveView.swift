import SwiftUI

struct LiveView: View {
    @State private var selectedSession: LiveSession? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {

                    // Live now
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 8, height: 8)
                                Text("LIVE NOW")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(Color.red)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(LiveSession.liveSessions) { session in
                                    LiveSessionCard(session: session, isLive: true)
                                        .frame(width: 280)
                                        .onTapGesture {
                                            selectedSession = session
                                        }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    // Upcoming
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Upcoming")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(.horizontal, 20)

                        VStack(spacing: 0) {
                            ForEach(Array(LiveSession.upcomingSessions.enumerated()), id: \.element.id) { index, session in
                                UpcomingSessionRow(session: session)
                                if index < LiveSession.upcomingSessions.count - 1 {
                                    Divider().padding(.horizontal, 20)
                                }
                            }
                        }
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }

                    // Past replays
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Watch replays")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(LiveSession.replaySessions) { session in
                                    LiveSessionCard(session: session, isLive: false)
                                        .frame(width: 240)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    Spacer(minLength: 32)
                }
                .padding(.top, 16)
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Live")
            .sheet(item: $selectedSession) { session in
                LiveSessionDetailView(session: session)
            }
        }
    }
}

// MARK: - Live Session Card
struct LiveSessionCard: View {
    let session: LiveSession
    let isLive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Thumbnail
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
                .frame(height: 160)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white.opacity(0.8))
                        if isLive {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 6, height: 6)
                                Text("\(session.viewers) watching")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(20)
                        }
                    }
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(session.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Text(session.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                if let product = session.pinnedProduct {
                    HStack(spacing: 6) {
                        Image(systemName: "pin.fill")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        Text(product)
                            .font(.system(size: 11))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    }
                }
            }
        }
        .padding(14)
        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
        .cornerRadius(20)
    }
}

// MARK: - Upcoming Session Row
struct UpcomingSessionRow: View {
    let session: LiveSession

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: "clock")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                )

            VStack(alignment: .leading, spacing: 3) {
                Text(session.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Text(session.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
            }

            Spacer()

            Button {} label: {
                Text("Remind me")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(red: 0.94, green: 0.91, blue: 0.87))
                    .cornerRadius(20)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

// MARK: - Live Session Detail
struct LiveSessionDetailView: View {
    let session: LiveSession
    @Environment(\.dismiss) private var dismiss
    @State private var comment = ""
    let comments: [(String, String)] = [
        ("maya", "does it oxidize?"),
        ("lina", "can you swatch 230?"),
        ("priya_k", "this shade looks perfect on tan skin"),
        ("sara", "what's the coverage level?"),
        ("jen.beauty", "omg the texture looks so good")
    ]

    var body: some View {
        VStack(spacing: 0) {

            // Video area
            Rectangle()
                .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
                .frame(height: 280)
                .overlay(
                    VStack(spacing: 12) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 56))
                            .foregroundColor(.white.opacity(0.8))
                        if let product = session.pinnedProduct {
                            HStack(spacing: 6) {
                                Image(systemName: "pin.fill")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white.opacity(0.7))
                                Text("Pinned: \(product)")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(20)
                        }
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 7, height: 7)
                            Text("\(session.viewers) watching")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                    }
                )

            // Comments
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Comments")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    ForEach(comments, id: \.0) { comment in
                        HStack(alignment: .top, spacing: 10) {
                            Circle()
                                .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Text(String(comment.0.prefix(1)).uppercased())
                                        .font(.system(size: 11, weight: .semibold))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                )
                            VStack(alignment: .leading, spacing: 2) {
                                Text(comment.0)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                Text(comment.1)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))

            // Comment input
            HStack(spacing: 12) {
                TextField("Add a comment...", text: $comment)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(12)

                Button {} label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .frame(width: 42, height: 42)
                        .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
        }
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Live Session Model
struct LiveSession: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let viewers: String
    let pinnedProduct: String?

    static let liveSessions: [LiveSession] = [
        LiveSession(title: "Foundation launch test", subtitle: "Medium neutral skin", viewers: "1.2k", pinnedProduct: "Satin Foundation — Shade 240"),
        LiveSession(title: "Skincare routine for oily skin", subtitle: "Combo + oily skin types", viewers: "847", pinnedProduct: "Cloud Serum")
    ]

    static let upcomingSessions: [LiveSession] = [
        LiveSession(title: "Sensitive-skin routine Q&A", subtitle: "Tonight at 8PM EST", viewers: "0", pinnedProduct: nil),
        LiveSession(title: "New blush launch on tan + neutral skin", subtitle: "Tomorrow at 6PM EST", viewers: "0", pinnedProduct: nil),
        LiveSession(title: "SPF roundup — no white cast picks", subtitle: "Friday at 5PM EST", viewers: "0", pinnedProduct: nil)
    ]

    static let replaySessions: [LiveSession] = [
        LiveSession(title: "Best foundations for combo skin", subtitle: "2.4k watched", viewers: "2.4k", pinnedProduct: "Soft Veil Skin Tint"),
        LiveSession(title: "Retinol 101 — how to start", subtitle: "1.8k watched", viewers: "1.8k", pinnedProduct: "Retinol Cream"),
        LiveSession(title: "SPF myths debunked", subtitle: "3.1k watched", viewers: "3.1k", pinnedProduct: nil)
    ]
}
