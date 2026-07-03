import Foundation

extension HomeViewModel {
    func loadProducts(for vendor: String) async {
        isVendorProductsLoading = true
        vendorProductsError = nil
        do {
            self.vendorProducts = try await getProductsByVendorUseCase.execute(vendor: vendor)
        } catch {
            self.vendorProductsError = error.localizedDescription
        }
        isVendorProductsLoading = false
    }
}
