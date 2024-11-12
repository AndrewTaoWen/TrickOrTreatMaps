import SwiftUI
import MapKit

struct UserSignUpForm: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var address: String = ""
    @State private var isShowingError: Bool = false
    @State private var errorMessage: String = ""
    @State private var searchCompleter = MKLocalSearchCompleter()
    @State private var addressSuggestions: [String] = []
    
    let candyOptions = ["Chocolate Bars", "Gummies", "Lollipops", "Hard Candies", "Caramel", "Other"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 40)
                
                TextField("Full Name", text: $name)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .autocapitalization(.words)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .textContentType(.newPassword)
                
                VStack(alignment: .leading) {
                    TextField("Address", text: $address, onEditingChanged: { _ in
                        updateAddressSuggestions()
                    })
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    
                    if !addressSuggestions.isEmpty {
                        List(addressSuggestions, id: \.self) { suggestion in
                            Text(suggestion)
                                .onTapGesture {
                                    address = suggestion
                                    addressSuggestions = []
                                }
                        }
                        .frame(height: 100)
                    }
                }
                
                Button("Sign Up") {
                    if name.isEmpty || email.isEmpty || password.isEmpty || address.isEmpty {
                        errorMessage = "Please fill in all fields."
                    } else {
                        AuthService.shared.signUp(name: name, email: email, password: password, userType: "treater", candyTypes: [], address: address) { result in
                            switch result {
                            case .success:
                                errorMessage = "Account created successfully!"
                            case .failure(let error):
                                errorMessage = error.localizedDescription
                            }
                            print(errorMessage)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    func updateAddressSuggestions() {
        searchCompleter.queryFragment = address
    }
}

struct UserSignUpForm_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpForm()
    }
}
