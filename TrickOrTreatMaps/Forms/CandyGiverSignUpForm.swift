import SwiftUI
import MapKit

struct CandyGiverSignUpForm: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var address: String = ""
    @State private var selectedCandy: String = ""
    @State private var selectedCandyOptions: [String] = []
    @State private var isShowingError: Bool = false
    @State private var errorMessage: String = ""
    @State private var searchCompleter = MKLocalSearchCompleter()
    @State private var addressSuggestions: [String] = []
    
    let candyOptions = ["Chocolate Bars", "Gummies", "Lollipops", "Hard Candies", "Caramel", "Other"]
    
    var body: some View {
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
            
            
            VStack(alignment: .leading) {
                Text("Additional Candy Types (Multi-Select)")
                ForEach(candyOptions, id: \.self) { option in
                    HStack {
                        Image(systemName: selectedCandyOptions.contains(option) ? "checkmark.square" : "square")
                            .onTapGesture {
                                toggleCandySelection(option)
                            }
                        Text(option)
                    }
                }
            }
            
            Button(action: authenticate) {
                Text("Authenticate")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Text("This is to ensure your safety and the safety of others.")
                .font(.footnote)
                .foregroundColor(.gray)
            
            if isShowingError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
        }
        .padding()
    }
    
    func updateAddressSuggestions() {
            searchCompleter.queryFragment = address
    }
    
    func toggleCandySelection(_ option: String) {
        if selectedCandyOptions.contains(option) {
            selectedCandyOptions.removeAll { $0 == option }
        } else {
            selectedCandyOptions.append(option)
        }
    }
    
    func authenticate() {
        if name.isEmpty || email.isEmpty || password.isEmpty || address.isEmpty || selectedCandy.isEmpty {
            isShowingError = true
            errorMessage = "Please fill in all fields."
        } else {
            // Call authentication service here
            isShowingError = false
            // Proceed with actual sign-up logic
        }
    }
}

struct CandyGiverSignUpForm_Previews: PreviewProvider {
    static var previews: some View {
        CandyGiverSignUpForm()
    }
}
