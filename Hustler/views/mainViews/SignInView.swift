//
//  SignInView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI

import SwiftUI

struct SignInView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showSignUp = false
    @State private var selectedUserType : UserType = UserType.BUYER
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @Binding var rootScreen :RootView
    
    @EnvironmentObject var dataSource: DataSoruce
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    
    var body: some View {
            VStack {
                Spacer()
                Text("Sign In")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                
                Picker(selection: $selectedUserType, label: Text("User Type")) {
                    ForEach(UserType.allCases, id: \.self) { userType in
                        Text(userType.rawValue.capitalized)
                    }
                }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                Button(action: {
                    signIn()
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                NavigationLink(destination: SignUpView(rootScreen: self.$rootScreen).environmentObject(dataSource).environmentObject(fireAuthHelper), isActive: $showSignUp) {
                    Text("Don't have an account? Sign up.")
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                }
                Spacer()
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
    }
    
    func signIn() {
        if !password.isEmpty && !username.isEmpty {
            // check the currentUserType (BUYER/HUSTLER) from the datasource
            dataSource.currentUserType = selectedUserType
            let email = "\(username)@\(selectedUserType).com"
            // check if the user exists in the firestore
            
            // Authenticate user and set signInSuccess to true
            
            fireAuthHelper.signIn(email: email, password: password) { result in
                switch result {
                case .success(let user):
                    print("User signed in successfully with email: \(user.email ?? "")")
                    self.rootScreen = selectedUserType == .BUYER ? .BUYER_HOME : .HUSTLER_HOME
                case .failure(let error):
                    print("Error while signing in: \(error.localizedDescription)")
                    alertMessage = error.localizedDescription
                    showingAlert = true
                }
            }
        } else {
            // Show an alert if passwords do not match
            alertMessage = "Passwords do not match"
            showingAlert = true
        }
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
