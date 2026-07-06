import SwiftUI
import Common


struct SortAndFilterSearch: View {
    
    var leadingLabel: String = HomeStrings.Category.sectionTitle
    var onSortTap: (() -> Void)? = nil
    var onFilterTap: (() -> Void)? = nil
    var isSortEnabled: Bool = true
    var isFilterEnabled: Bool = true

    var body: some View {
        HStack {

            Text(leadingLabel)
                .sectionTitleStyle()

            Spacer()

            // Sort Button
            Button(action: { onSortTap?() }) {
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
            .disabled(!isSortEnabled)
            .opacity(isSortEnabled ? 1.0 : 0.5)
            .anchorPreference(key: SortButtonAnchorKey.self, value: .bounds) { $0 }


            // Filter Button
            Button(action: { onFilterTap?() }) {
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
            .disabled(!isFilterEnabled)
            .opacity(isFilterEnabled ? 1.0 : 0.5)
        }
        .padding(.horizontal, 16)
    }
}

