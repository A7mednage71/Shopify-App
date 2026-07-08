struct ProfileInformationForm: Equatable {
    var firstName = ""
    var lastName = ""
    var phone = ""

    init() {}

    init(profile: CustomerProfile) {
        self.firstName = profile.firstName ?? ""
        self.lastName = profile.lastName ?? ""
        self.phone = profile.phone ?? ""
    }

    var updateInput: CustomerProfileUpdateInput {
        CustomerProfileUpdateInput(
            firstName: firstName,
            lastName: lastName,
            phone: phone
        )
    }
}
