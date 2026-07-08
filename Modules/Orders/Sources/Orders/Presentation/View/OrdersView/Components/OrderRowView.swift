//
//  OrderRowView.swift
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common

struct OrderRowView: View {
    let order: Order

    // MARK: - Shared Date Formatter (created once, not per render)
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy - hh:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    private var orderStatus: OrderStatus {
        switch order.fulfillmentStatus.uppercased() {
        case "FULFILLED", "DELIVERED":
            return .delivered
        case "UNFULFILLED", "PENDING":
            return .pending
        default:
            return .inProgress
        }
    }

    private var formattedDate: String {
        Self.dateFormatter.string(from: order.processedAt)
    }

    var body: some View {
        HStack(spacing: 12) {
            imageStack

            VStack(alignment: .leading, spacing: 4) {
                Text(order.name)
                    .font(AppFonts.callout.weight(.bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(formattedDate)
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.textSecondary)

                Text(L10n.Orders.tapToView)
                    .font(AppFonts.footnote)
                    .foregroundColor(AppColors.textTertiary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 10) {
                statusBadge

                HStack(spacing: 8) {
                    PriceView(
                        priceInUSD: order.totalPrice.orderPriceViewValue,
                        font: AppFonts.caption,
                        color: AppColors.textSecondary
                    )

                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppColors.border)
                }
            }
        }
        .padding(14)
        .background(cardBackground)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(L10n.Orders.orderAccessibilityLabel(order.name, orderStatus.text))
    }

    // MARK: - Subviews

    private var statusBadge: some View {
        Text(orderStatus.text)
            .font(AppFonts.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Capsule().fill(orderStatus.color.opacity(0.12)))
            .foregroundColor(orderStatus.color)
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.appBackgroundWhite)
            .overlay(alignment: .leading) {
                Rectangle()
                    .fill(orderStatus.color)
                    .frame(width: 4)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: AppColors.shadow.opacity(0.08), radius: 6, x: 0, y: 2)
    }

    private var imageStack: some View {
        let count = order.lineItems.count

        return Group {
            if count == 0 {
                ZStack(alignment: .topLeading) {
                    Circle()
                        .fill(orderStatus.color.opacity(0.12))
                        .frame(width: 66, height: 66)
                        .overlay(
                            Image(systemName: "shippingbox")
                                .font(.system(size: 26))
                                .foregroundColor(orderStatus.color)
                        )
                        .offset(x: 0, y: 11)

                    imageStatusBadge
                        .offset(x: 54, y: 65)
                }
                .frame(width: 88, height: 88)
            } else if count == 1 {
                ZStack(alignment: .topLeading) {
                    itemImage(url: order.lineItems[0].imageURL, size: 66)
                        .offset(x: 0, y: 11)

                    imageStatusBadge
                        .offset(x: 54, y: 65)
                }
                .frame(width: 88, height: 88)
            } else {
                ZStack(alignment: .topLeading) {
                    // Main large image on the left (aligned to leading of 88pt container)
                    itemImage(url: order.lineItems[0].imageURL, size: 66)
                        .offset(x: 0, y: 11)
                        .zIndex(3)

                    if count == 2 {
                        itemImage(url: order.lineItems[1].imageURL, size: 36)
                            .offset(x: 48, y: 38)
                            .shadow(color: AppColors.shadow.opacity(0.15), radius: 2)
                            .zIndex(1)

                        imageStatusBadge
                            .offset(x: 72, y: 62)
                            .zIndex(4)
                    } else if count == 3 {
                        itemImage(url: order.lineItems[1].imageURL, size: 36)
                            .offset(x: 40, y: 8)
                            .zIndex(2)

                        itemImage(url: order.lineItems[2].imageURL, size: 36)
                            .offset(x: 50, y: 42)
                            .zIndex(1)

                        imageStatusBadge
                            .offset(x: 74, y: 66)
                            .zIndex(4)
                    } else {
                        // count > 3
                        itemImage(url: order.lineItems[1].imageURL, size: 36)
                            .offset(x: 40, y: 8)
                            .zIndex(2)

                        Circle()
                            .fill(AppColors.backgroundSecondary)
                            .frame(width: 36, height: 36)
                            .overlay(
                                Text("+\(count - 2)")
                                    .font(AppFonts.caption.weight(.bold))
                                    .foregroundColor(AppColors.textSecondary)
                                    .minimumScaleFactor(0.6)
                            )
                            .overlay(
                                Circle()
                                    .stroke(AppColors.border, lineWidth: 1)
                            )
                            .shadow(color: AppColors.shadow.opacity(0.12), radius: 2)
                            .offset(x: 50, y: 42)
                            .zIndex(1)

                        imageStatusBadge
                            .offset(x: 74, y: 66)
                            .zIndex(4)
                    }
                }
                .frame(width: 88, height: 88)
            }
        }
    }

    private var imageStatusBadge: some View {
        Circle()
            .fill(orderStatus.color)
            .frame(width: 16, height: 16)
            .overlay(
                Image(systemName: orderStatus.iconName)
                    .font(.system(size: 7.5, weight: .bold))
                    .foregroundColor(.white)
            )
            .shadow(color: AppColors.shadow.opacity(0.2), radius: 1, x: 0, y: 1)
    }

    private func itemImage(url: String?, size: CGFloat) -> some View {
        CachedImage(urlString: url, failureImageName: "product_placeholder")
            .frame(width: size, height: size)
            .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.appBackgroundWhite, lineWidth: 1.5)
        )
        .shadow(color: AppColors.shadow.opacity(0.12), radius: 2, x: 0, y: 1.5)
    }
}
