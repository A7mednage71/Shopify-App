//
//  OrderDetailsStatusTimeline.swift
//

import SwiftUI
import Common

struct OrderDetailsStatusTimeline: View {
    let currentStatus: OrderStatus

    private var steps: [(label: String, icon: String)] {
        [
            (L10n.Orders.timelinePlaced, "checkmark.circle.fill"),
            (L10n.Orders.timelineProcessing, "gear.circle.fill"),
            (L10n.Orders.timelineShipped, "bicycle.circle.fill"),
            (L10n.Orders.timelineDelivered, "house.circle.fill")
        ]
    }

    private var doneCount: Int {
        switch currentStatus {
        case .pending:    return 1
        case .inProgress: return 2
        case .delivered:  return 4
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(L10n.Orders.tracking)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(AppColors.textPrimary)

            HStack(alignment: .top, spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                    let isDone = index < doneCount
                    let isLast = index == steps.count - 1

                    VStack(spacing: 6) {
                        Image(systemName: step.icon)
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundColor(isDone ? currentStatus.color : AppColors.border)
                            .frame(width: 34, height: 34)

                        Text(step.label)
                            .font(.system(size: 11, weight: isDone ? .bold : .regular, design: .rounded))
                            .foregroundColor(isDone ? AppColors.textPrimary : AppColors.textTertiary)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity)

                    if !isLast {
                        Rectangle()
                            .fill(index < doneCount - 1 ? currentStatus.color : AppColors.border)
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 16)
                    }
                }
            }
        }
        .padding(16)
        .background(AppColors.background)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: AppColors.shadow.opacity(0.07), radius: 8, x: 0, y: 3)
    }
}
