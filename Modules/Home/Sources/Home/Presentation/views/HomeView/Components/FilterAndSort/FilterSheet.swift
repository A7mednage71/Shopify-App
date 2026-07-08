import SwiftUI
import UIKit
import Common

struct FilterSheet: View {
    @Binding var filterState: FilterState
    let availableVendors: [String]
    let availableProductTypes: [String]
    let availableTags: [String]
    let priceBounds: ClosedRange<Double>
    var onApply: () -> Void
    var onReset: () -> Void

    @Environment(\.dismiss) var dismiss
    @State private var currentRange: ClosedRange<Double> = 0...2000

    private var activeFilterCount: Int {
        var count = 0
        // Price filter counts as active if it deviates from priceBounds
        if abs((filterState.minPrice ?? priceBounds.lowerBound) - priceBounds.lowerBound) > 0.01 ||
           abs((filterState.maxPrice ?? priceBounds.upperBound) - priceBounds.upperBound) > 0.01 {
            count += 1
        }
        if filterState.inStockOnly { count += 1 }
        count += filterState.selectedVendors.count
        count += filterState.selectedProductTypes.count
        count += filterState.selectedTags.count
        return count
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.appBackgroundGray
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        priceSection
                        inStockSection

                        if !availableVendors.isEmpty {
                            FilterSection(
                                title: L10n.Home.filterBrands,
                                systemImage: "tag",
                                options: availableVendors,
                                selectedOptions: $filterState.selectedVendors
                            )
                        }

                        if !availableProductTypes.isEmpty {
                            FilterSection(
                                title: L10n.Home.filterCategoryTypes,
                                systemImage: "square.grid.2x2",
                                options: availableProductTypes,
                                selectedOptions: $filterState.selectedProductTypes
                            )
                        }

                        if !availableTags.isEmpty {
                            FilterSection(
                                title: L10n.Home.filterTags,
                                systemImage: "number",
                                options: availableTags,
                                selectedOptions: $filterState.selectedTags
                            )
                        }

                        // Reserve space so content doesn't sit under the sticky footer
                        Color.clear.frame(height: 84)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                }

                footer
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            currentRange = priceBounds
                            onReset()
                        }
                    } label: {
                        Text(L10n.Home.filterReset)
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(activeFilterCount > 0 ? Color.appPrimaryPink : Color.appTextTertiary)
                    .disabled(activeFilterCount == 0)
                }

                ToolbarItem(placement: .principal) {
                    VStack(spacing: 2) {
                        Text(L10n.Home.filterTitle)
                            .font(.headline)
                            .foregroundColor(.appTextPrimary)
                        if activeFilterCount > 0 {
                            Text("\(activeFilterCount) active")
                                .font(.caption2)
                                .foregroundColor(.appPrimaryOrange)
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                            .font(.title3)
                    }
                }
            }
            .onAppear {
                let defaultMin = priceBounds.lowerBound
                let defaultMax = priceBounds.upperBound
                let currentMin = filterState.minPrice ?? defaultMin
                let currentMax = filterState.maxPrice ?? defaultMax
                
                // Ensure initial range is within the bounds limits
                let clampedMin = max(defaultMin, min(currentMin, defaultMax))
                let clampedMax = min(defaultMax, max(currentMax, defaultMin))
                
                currentRange = clampedMin...clampedMax
            }
        }
    }

    // MARK: - Price Range

    private var priceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                sectionHeader(title: L10n.Home.filterPriceRange, systemImage: "dollarsign.circle")
                Spacer()
                Text("$\(Int(currentRange.lowerBound)) - $\(Int(currentRange.upperBound))")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.appPrimaryOrange)
            }

            RangeSlider(
                range: $currentRange,
                bounds: priceBounds
            )
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }
    }

    // MARK: - In Stock

    private var inStockSection: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.seal")
                .foregroundColor(.appPrimaryOrange)
                .font(.title3)

            VStack(alignment: .leading, spacing: 2) {
                Text(L10n.Home.filterInStockOnly)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.appTextPrimary)
                Text(L10n.Home.filterHideSoldOut)
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
            }

            Spacer()

            Toggle("", isOn: $filterState.inStockOnly.animation(.spring(response: 0.3, dampingFraction: 0.8)))
                .labelsHidden()
                .tint(Color.appPrimaryOrange)
        }
        .padding(14)
        .background(Color.appBackgroundWhite)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.appBorderLight, lineWidth: 1)
        )
    }

    // MARK: - Sticky Footer

    private var footer: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.appBorderLight)
            Button {
                filterState.minPrice = currentRange.lowerBound
                filterState.maxPrice = currentRange.upperBound
                onApply()
                dismiss()
            } label: {
                HStack(spacing: 8) {
                    Text(L10n.Home.filterApply)
                        .fontWeight(.semibold)
                        .font(.buttonPrimary)
                    if activeFilterCount > 0 {
                        Text("\(activeFilterCount)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.appTextWhite.opacity(0.25))
                            .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundColor(.appTextWhite)
                .background(Color.appPrimaryOrange)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 8)
        }
        .background(Color.appBackgroundWhite)
    }

    // MARK: - Helpers

    private func sectionHeader(title: String, systemImage: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: systemImage)
                .foregroundColor(.appPrimaryOrange)
                .font(.subheadline)
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.appTextPrimary)
        }
    }
}

// MARK: - Range Slider Component

struct RangeSlider: View {
    @Binding var range: ClosedRange<Double>
    let bounds: ClosedRange<Double>

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let boundsRange = max(1.0, bounds.upperBound - bounds.lowerBound)
            
            // Map bounds to offsets (0 to width)
            let leftOffset = CGFloat((range.lowerBound - bounds.lowerBound) / boundsRange) * width
            let rightOffset = CGFloat((range.upperBound - bounds.lowerBound) / boundsRange) * width

            ZStack(alignment: .leading) {
                // Background Track
                Capsule()
                    .fill(Color.appBorderLight)
                    .frame(height: 4)

                // Active Track
                Capsule()
                    .fill(Color.appPrimaryOrange)
                    .frame(width: max(0.0, rightOffset - leftOffset), height: 6)
                    .offset(x: leftOffset)

                // Left Thumb
                Circle()
                    .fill(Color.white)
                    .frame(width: 24, height: 24)
                    .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 2)
                    .overlay(
                        Circle().stroke(Color.appPrimaryOrange, lineWidth: 1.5)
                    )
                    .offset(x: leftOffset - 12)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let proposedOffset = value.location.x
                                let proposedValue = Double(proposedOffset / width) * boundsRange + bounds.lowerBound
                                // Make sure left thumb is clamped and doesn't cross right thumb minus small step
                                let step = boundsRange * 0.05
                                let clampedValue = min(max(proposedValue, bounds.lowerBound), range.upperBound - step)
                                range = clampedValue...range.upperBound
                            }
                    )

                // Right Thumb
                Circle()
                    .fill(Color.white)
                    .frame(width: 24, height: 24)
                    .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 2)
                    .overlay(
                        Circle().stroke(Color.appPrimaryOrange, lineWidth: 1.5)
                    )
                    .offset(x: rightOffset - 12)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let proposedOffset = value.location.x
                                let proposedValue = Double(proposedOffset / width) * boundsRange + bounds.lowerBound
                                // Make sure right thumb is clamped and doesn't cross left thumb plus small step
                                let step = boundsRange * 0.05
                                let clampedValue = max(min(proposedValue, bounds.upperBound), range.lowerBound + step)
                                range = range.lowerBound...clampedValue
                            }
                    )
            }
        }
        .frame(height: 24)
    }
}

// MARK: - Filter Section

struct FilterSection: View {
    let title: String
    let systemImage: String
    let options: [String]
    @Binding var selectedOptions: Set<String>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: systemImage)
                        .foregroundColor(.appPrimaryOrange)
                        .font(.subheadline)
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.appTextPrimary)

                    if !selectedOptions.isEmpty {
                        Text("\(selectedOptions.count)")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.appPrimaryOrange)
                            .foregroundColor(.appTextWhite)
                            .clipShape(Capsule())
                    }
                }

                Spacer()

                if !selectedOptions.isEmpty {
                    Button(L10n.Home.filterClear) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            selectedOptions.removeAll()
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.appPrimaryOrange)
                }
            }

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 92), spacing: 8)], alignment: .leading, spacing: 8) {
                ForEach(options, id: \.self) { option in
                    FilterChip(title: option, isSelected: selectedOptions.contains(option)) {
                        toggle(option)
                    }
                }
            }
        }
    }

    private func toggle(_ option: String) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            if selectedOptions.contains(option) {
                selectedOptions.remove(option)
            } else {
                selectedOptions.insert(option)
            }
        }
    }
}

// MARK: - Chip

private struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 11, weight: .bold))
                        .transition(.scale.combined(with: .opacity))
                }
                Text(title)
                    .font(.buttonSmall)
                    .lineLimit(1)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? Color.appPrimaryOrange : Color.appBackgroundWhite)
            .foregroundColor(isSelected ? .white : .appTextSecondary)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.appPrimaryOrange : Color.appBorderLight, lineWidth: 1)
            )
        }
        .buttonStyle(ChipButtonStyle())
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}

private struct ChipButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
