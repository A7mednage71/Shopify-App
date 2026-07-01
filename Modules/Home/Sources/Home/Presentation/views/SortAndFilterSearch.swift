import SwiftUI
import Common

// MARK: - Sort, Filter & Search Header Bar
// Always visible on the Home screen.
// Leading label shows "All Featured" by default, or a search-result count when searching.

struct SortAndFilterSearch: View {
    /// The label displayed on the leading side.
    /// Pass a custom string (e.g. "12 results") when searching; defaults to "All Featured".
    var leadingLabel: String = HomeStrings.Category.sectionTitle

    var body: some View {
        HStack {
            // Leading — single text label
            Text(leadingLabel)
                .sectionTitleStyle()

            Spacer()

            // Sort Button
            Button(action: {}) {
                HStack(spacing: 4) {
                    Text(HomeStrings.Category.sortButton)
                        .font(.buttonSmall)
                        .foregroundColor(.appTextSecondary)

                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 11))
                        .foregroundColor(.appTextSecondary)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.appBackgroundWhite)
                .cornerRadius(6)
                .shadow(color: Color.appCardShadow, radius: 4, x: 0, y: 1)
            }

            // Filter Button
            Button(action: {}) {
                HStack(spacing: 4) {
                    Text(HomeStrings.Category.filterButton)
                        .font(.buttonSmall)
                        .foregroundColor(.appTextSecondary)
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.system(size: 11))
                        .foregroundColor(.appTextSecondary)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.appBackgroundWhite)
                .cornerRadius(6)
                .shadow(color: Color.appCardShadow, radius: 4, x: 0, y: 1)
            }
        }
        .padding(.horizontal, 16)
    }
}

