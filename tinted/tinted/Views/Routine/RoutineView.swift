import SwiftUI

struct RoutineView: View {
    @State private var selectedTab = "Today"
    let tabs = ["Today", "Week"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Tab switcher
                    HStack(spacing: 0) {
                        ForEach(tabs, id: \.self) { tab in
                            Button {
                                selectedTab = tab
                            } label: {
                                Text(tab)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(
                                        selectedTab == tab
                                        ? Color(red: 0.98, green: 0.97, blue: 0.95)
                                        : Color(red: 0.07, green: 0.07, blue: 0.07)
                                    )
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(
                                        selectedTab == tab
                                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                        : Color.clear
                                    )
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(4)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(14)
                    .padding(.horizontal, 20)

                    if selectedTab == "Today" {
                        TodayRoutineView()
                    } else {
                        WeekRoutineView()
                    }
                }
                .padding(.top, 16)
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Routine")
        }
    }
}

// MARK: - Today View
struct TodayRoutineView: View {
    @State private var amSteps: [RoutineStep] = [
        RoutineStep(name: "Gentle Cleanser", brand: "CeraVe", done: true),
        RoutineStep(name: "Cloud Serum", brand: "Summer Fridays", done: true),
        RoutineStep(name: "Invisible Mineral SPF", brand: "Supergoop", done: false)
    ]
    @State private var pmSteps: [RoutineStep] = [
        RoutineStep(name: "Gentle Cleanser", brand: "CeraVe", done: false),
        RoutineStep(name: "Barrier Cream", brand: "Dr. Jart+", done: false, isWarning: true)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            // Warning banner
            HStack(spacing: 12) {
                Image(systemName: "moon.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                VStack(alignment: .leading, spacing: 3) {
                    Text("PM: recovery night")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Text("Skip acids. Use moisturizer only.")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                Spacer()
            }
            .padding(16)
            .background(Color(red: 0.94, green: 0.91, blue: 0.87))
            .cornerRadius(16)
            .padding(.horizontal, 20)

            // AM Routine
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("AM routine")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Spacer()
                    Text("\(amSteps.filter { $0.done }.count)/\(amSteps.count) done")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                .padding(.horizontal, 20)

                VStack(spacing: 0) {
                    ForEach(Array(amSteps.enumerated()), id: \.element.id) { index, step in
                        RoutineStepRow(step: step) {
                            amSteps[index].done.toggle()
                        }
                        if index < amSteps.count - 1 {
                            Divider().padding(.horizontal, 20)
                        }
                    }
                }
                .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                .cornerRadius(20)
                .padding(.horizontal, 20)
            }

            // PM Routine
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("PM routine")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    Spacer()
                    Text("\(pmSteps.filter { $0.done }.count)/\(pmSteps.count) done")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                }
                .padding(.horizontal, 20)

                VStack(spacing: 0) {
                    ForEach(Array(pmSteps.enumerated()), id: \.element.id) { index, step in
                        RoutineStepRow(step: step) {
                            pmSteps[index].done.toggle()
                        }
                        if index < pmSteps.count - 1 {
                            Divider().padding(.horizontal, 20)
                        }
                    }
                }
                .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                .cornerRadius(20)
                .padding(.horizontal, 20)
            }

            // Add product button
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add product to routine")
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(red: 0.84, green: 0.82, blue: 0.77), lineWidth: 1)
                )
            }
            .padding(.horizontal, 20)

            Spacer(minLength: 32)
        }
    }
}

// MARK: - Week View
struct WeekRoutineView: View {
    let days = ["M", "T", "W", "T", "F", "S", "S"]
    let dayTypes = ["spf", "acid", "rest", "spf", "spf", "acid", "spf"]
    @State private var selectedDay = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            // Week strip
            HStack(spacing: 8) {
                ForEach(Array(days.enumerated()), id: \.offset) { index, day in
                    Button {
                        selectedDay = index
                    } label: {
                        VStack(spacing: 6) {
                            Text(day)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(
                                    selectedDay == index
                                    ? Color(red: 0.98, green: 0.97, blue: 0.95)
                                    : Color(red: 0.07, green: 0.07, blue: 0.07)
                                )
                            Text(dayTypes[index])
                                .font(.system(size: 9, weight: .medium))
                                .foregroundColor(
                                    selectedDay == index
                                    ? Color(red: 0.84, green: 0.82, blue: 0.77)
                                    : Color(red: 0.60, green: 0.57, blue: 0.53)
                                )
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(
                            selectedDay == index
                            ? Color(red: 0.07, green: 0.07, blue: 0.07)
                            : Color(red: 0.98, green: 0.97, blue: 0.95)
                        )
                        .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal, 20)

            // Conflict avoided
            VStack(alignment: .leading, spacing: 12) {
                Text("This week")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .padding(.horizontal, 20)

                VStack(spacing: 14) {
                    WeekStatCard(
                        icon: "checkmark.shield.fill",
                        title: "Conflict avoided",
                        subtitle: "Retinol moved away from exfoliation night to protect barrier."
                    )
                    WeekStatCard(
                        icon: "chart.bar.fill",
                        title: "Consistency",
                        subtitle: "You completed 5 of 7 AM routines this week."
                    )
                    WeekStatCard(
                        icon: "sun.max.fill",
                        title: "SPF streak",
                        subtitle: "5 days in a row. Keep it up."
                    )
                }
                .padding(.horizontal, 20)
            }

            // Edit schedule
            Button {} label: {
                Text("Edit schedule")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(red: 0.84, green: 0.82, blue: 0.77), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 20)

            Spacer(minLength: 32)
        }
    }
}

// MARK: - Routine Step Row
struct RoutineStepRow: View {
    let step: RoutineStep
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Button(action: onToggle) {
                Image(systemName: step.done ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundColor(
                        step.done
                        ? Color(red: 0.07, green: 0.07, blue: 0.07)
                        : Color(red: 0.84, green: 0.82, blue: 0.77)
                    )
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(step.name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    .strikethrough(step.done)
                Text(step.brand)
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
            }
            Spacer()
            if step.isWarning {
                Image(systemName: "exclamationmark.circle")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.75, green: 0.45, blue: 0.20))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

// MARK: - Week Stat Card
struct WeekStatCard: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    .lineSpacing(2)
            }
            Spacer()
        }
        .padding(16)
        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
        .cornerRadius(16)
    }
}

// MARK: - Routine Step Model
struct RoutineStep: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    var done: Bool
    var isWarning: Bool = false
}
