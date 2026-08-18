import SwiftUI

struct FeedView: View {
    @State private var selectedTab = "Community"
    let tabs = ["Community", "Following"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Tab switcher
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            VStack(spacing: 8) {
                                Text(tab)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(
                                        selectedTab == tab
                                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                        : Color(red: 0.60, green: 0.57, blue: 0.53)
                                    )
                                Rectangle()
                                    .fill(
                                        selectedTab == tab
                                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                        : Color.clear
                                    )
                                    .frame(height: 1.5)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .background(Color(red: 0.97, green: 0.95, blue: 0.93))

                Divider()

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        if selectedTab == "Community" {
                            CommunityTabView()
                        } else {
                            FollowingTabView()
                        }
                        Spacer(minLength: 32)
                    }
                    .padding(.top, 16)
                }
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Feed")
        }
    }
}

// MARK: - Community Tab

struct CommunityTabView: View {
    @State private var threads: [CommunityThread] = CommunityThread.mockThreads

    var body: some View {
        VStack(spacing: 0) {
            ForEach($threads) { $thread in
                NavigationLink(destination: ThreadDetailView(thread: $thread)) {
                    ThreadCard(thread: $thread)
                }
                .buttonStyle(.plain)
                Divider().padding(.horizontal, 20)
            }
        }
    }
}

struct ThreadCard: View {
    @Binding var thread: CommunityThread

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Circle()
                    .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text(thread.authorInitial)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    )
                VStack(alignment: .leading, spacing: 1) {
                    Text(thread.author)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Text(thread.tag)
                        .font(.system(size: 11))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                Spacer()
            }

            Text(thread.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                .multilineTextAlignment(.leading)

            Text(thread.preview)
                .font(.system(size: 13))
                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            HStack(spacing: 20) {
                Button {
                    thread.isUpvoted.toggle()
                    thread.upvotes += thread.isUpvoted ? 1 : -1
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: thread.isUpvoted ? "arrow.up.circle.fill" : "arrow.up.circle")
                            .font(.system(size: 14))
                        Text("\(thread.upvotes)")
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundColor(
                        thread.isUpvoted
                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                        : Color(red: 0.60, green: 0.57, blue: 0.53)
                    )
                }
                .buttonStyle(.plain)

                HStack(spacing: 5) {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 13))
                    Text("\(thread.replyCount)")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

struct ThreadDetailView: View {
    @Binding var thread: CommunityThread
    @State private var replyText = ""
    @State private var replies: [ThreadReply] = []

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 10) {
                            Circle()
                                .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Text(thread.authorInitial)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                )
                            VStack(alignment: .leading, spacing: 1) {
                                Text(thread.author)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                Text(thread.tag)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            }
                        }

                        Text(thread.title)
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))

                        Text(thread.preview)
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))

                        Button {
                            thread.isUpvoted.toggle()
                            thread.upvotes += thread.isUpvoted ? 1 : -1
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: thread.isUpvoted ? "arrow.up.circle.fill" : "arrow.up.circle")
                                    .font(.system(size: 15))
                                Text("\(thread.upvotes)")
                                    .font(.system(size: 13, weight: .medium))
                            }
                            .foregroundColor(
                                thread.isUpvoted
                                ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                : Color(red: 0.60, green: 0.57, blue: 0.53)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)

                    Divider().padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 14) {
                        Text("\(thread.replyCount + replies.count) replies")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            .padding(.horizontal, 20)

                        ForEach(replies) { reply in
                            HStack(alignment: .top, spacing: 10) {
                                Circle()
                                    .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                                    .frame(width: 28, height: 28)
                                    .overlay(
                                        Text(reply.authorInitial)
                                            .font(.system(size: 11, weight: .semibold))
                                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                    )
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(reply.author)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                    Text(reply.text)
                                        .font(.system(size: 13))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .id(reply.id)
                        }
                    }

                    Spacer(minLength: 12)
                }
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .onChange(of: replies.count) { _, _ in
                if let last = replies.last {
                    withAnimation {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 12) {
                TextField("Add a reply...", text: $replyText)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(12)

                Button {
                    let trimmed = replyText.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }
                    replies.append(ThreadReply(author: "you", authorInitial: "Y", text: trimmed))
                    replyText = ""
                } label: {
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
        .navigationTitle("Thread")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Following Tab

struct FollowingTabView: View {
    @State private var items: [FollowFeedItem] = FollowFeedItem.mockItems

    var body: some View {
        VStack(spacing: 14) {
            ForEach($items) { $item in
                FollowCard(item: $item)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct FollowCard: View {
    @Binding var item: FollowFeedItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Circle()
                    .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text(item.authorInitial)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    )
                VStack(alignment: .leading, spacing: 1) {
                    Text(item.author)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Text(item.type.label)
                        .font(.system(size: 11))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                Spacer()
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Text(item.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))

                if let product = item.pinnedProduct {
                    HStack(spacing: 6) {
                        Image(systemName: "pin.fill")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        Text(product)
                            .font(.system(size: 11))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    }
                    .padding(.top, 2)
                }
            }

            EngagementRowView(item: $item)
        }
        .padding(16)
        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
        .cornerRadius(20)
    }
}

struct EngagementRowView: View {
    @Binding var item: FollowFeedItem

    var body: some View {
        HStack(spacing: 20) {
            Button {
                item.isLiked.toggle()
                item.likeCount += item.isLiked ? 1 : -1
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: item.isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 14))
                    Text("\(item.likeCount)")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(
                    item.isLiked
                    ? Color(red: 0.75, green: 0.30, blue: 0.30)
                    : Color(red: 0.60, green: 0.57, blue: 0.53)
                )
            }
            .buttonStyle(.plain)

            HStack(spacing: 5) {
                Image(systemName: "bubble.left")
                    .font(.system(size: 13))
                Text("\(item.commentCount)")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))

            Spacer()

            Button {
                item.isSaved.toggle()
            } label: {
                Image(systemName: item.isSaved ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 14))
                    .foregroundColor(
                        item.isSaved
                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                        : Color(red: 0.60, green: 0.57, blue: 0.53)
                    )
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - Models

struct CommunityThread: Identifiable {
    let id = UUID()
    let author: String
    let authorInitial: String
    let tag: String
    let title: String
    let preview: String
    var upvotes: Int
    var isUpvoted: Bool
    let replyCount: Int

    static let mockThreads: [CommunityThread] = [
        CommunityThread(author: "priya_k", authorInitial: "P", tag: "Dupe check", title: "Is there a cheaper dupe for the Ilia Skin Tint?", preview: "Loving the finish but $32 is steep for a monthly repurchase. Any drugstore alternatives for medium neutral shades?", upvotes: 42, isUpvoted: false, replyCount: 18),
        CommunityThread(author: "maya", authorInitial: "M", tag: "Routine help", title: "Retinol making my barrier freak out — what am I doing wrong?", preview: "Started 2x/week like the app suggested but I'm still getting flaking around my nose. Should I drop to once a week?", upvotes: 31, isUpvoted: true, replyCount: 24),
        CommunityThread(author: "lina", authorInitial: "L", tag: "Shade match", title: "230 vs 240 for tan neutral undertones?", preview: "Quiz matched me at 235 but that's not a real shade. Which way do you round for warm-neutral tan skin?", upvotes: 19, isUpvoted: false, replyCount: 9),
        CommunityThread(author: "sara", authorInitial: "S", tag: "Product find", title: "This fragrance-free cleanser saved my skin", preview: "Switched off my old foaming cleanser after a bad breakout month. Three weeks in and my skin has never been calmer.", upvotes: 56, isUpvoted: false, replyCount: 15),
        CommunityThread(author: "jen.beauty", authorInitial: "J", tag: "Question", title: "Can I layer Cloud Serum under mineral SPF?", preview: "Worried about pilling since both are pretty thick. Anyone found an order that works?", upvotes: 12, isUpvoted: false, replyCount: 6)
    ]
}

struct ThreadReply: Identifiable {
    let id = UUID()
    let author: String
    let authorInitial: String
    let text: String
}

enum FollowItemType {
    case article
    case review
    case productDrop

    var label: String {
        switch self {
        case .article: return "Article"
        case .review: return "Review"
        case .productDrop: return "New drop"
        }
    }
}

struct FollowFeedItem: Identifiable {
    let id = UUID()
    let type: FollowItemType
    let author: String
    let authorInitial: String
    let title: String
    let subtitle: String
    let pinnedProduct: String?
    var likeCount: Int
    var isLiked: Bool
    var commentCount: Int
    var isSaved: Bool

    static let mockItems: [FollowFeedItem] = [
        FollowFeedItem(type: .productDrop, author: "Ilia", authorInitial: "I", title: "New shade range just landed", subtitle: "6 new neutral-undertone shades added to Soft Veil Skin Tint", pinnedProduct: "Soft Veil Skin Tint", likeCount: 128, isLiked: false, commentCount: 22, isSaved: false),
        FollowFeedItem(type: .review, author: "priya_k", authorInitial: "P", title: "3 months with Barrier Cream — full review", subtitle: "Before/after on redness and how it held up through winter", pinnedProduct: "Barrier Cream", likeCount: 64, isLiked: true, commentCount: 11, isSaved: true),
        FollowFeedItem(type: .article, author: "Tinted Editorial", authorInitial: "T", title: "How to actually patch test a new active", subtitle: "A 5-step guide before you introduce retinol, AHA, or vitamin C", pinnedProduct: nil, likeCount: 210, isLiked: false, commentCount: 34, isSaved: false),
        FollowFeedItem(type: .review, author: "maya", authorInitial: "M", title: "Gentle Cleanser is worth the hype", subtitle: "Finally a cleanser that doesn't leave my combo skin tight", pinnedProduct: "Gentle Cleanser", likeCount: 47, isLiked: false, commentCount: 8, isSaved: false),
        FollowFeedItem(type: .article, author: "Tinted Editorial", authorInitial: "T", title: "SPF myths, debunked", subtitle: "No, you don't need to reapply every 2 hours indoors", pinnedProduct: nil, likeCount: 156, isLiked: false, commentCount: 19, isSaved: false)
    ]
}
