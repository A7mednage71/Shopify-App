public protocol CustomerProfileRepository: Sendable {
    func getCustomerProfile() async throws -> CustomerProfile
    func updateCustomerProfile(_ input: CustomerProfileUpdateInput) async throws -> CustomerProfile
}
