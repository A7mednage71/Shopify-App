//
//  OrderRowSkeletonView.swift
//
//  Created by Esraa Ehab on 07/07/2026.
//

import SwiftUI
import Common
import Shimmer

struct OrderRowSkeletonView: View {
    var body: some View {
        HStack(spacing: 12) {
            // Left image placeholder
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 66, height: 66)

            VStack(alignment: .leading, spacing: 6) {
                // Name placeholder
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 16)
                    .frame(maxWidth: 100)

                // Date placeholder
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 12)
                    .frame(maxWidth: 140)

                // Action hint placeholder
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 12)
                    .frame(maxWidth: 80)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            VStack(alignment: .trailing, spacing: 10) {
                // Status badge placeholder
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 70, height: 22)

                // Price placeholder
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 14)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.appBackgroundWhite)
        )
        .redacted(reason: .placeholder)
        .shimmering()
    }
}
