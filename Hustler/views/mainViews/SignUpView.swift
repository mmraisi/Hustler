//
//  SignUpView.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI

import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword: Bool = false
    @State private var selectedUserType : UserType = UserType.BUYER
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @EnvironmentObject var fireAuthHelper: FireAuthHelper
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var rootScreen :RootView
    
    @EnvironmentObject var dataSource: DataSoruce
    
    var body: some View {
            VStack {
                Spacer()
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 200)
                Text("Sign Up")
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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                HStack {
                    if showPassword {
                        TextField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button(action: {
                        showPassword.toggle()
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(Color(UIColor.systemGray))
                    })
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                HStack {
                    if showPassword {
                        TextField("Confirm Password", text: $confirmPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        SecureField("Confirm Password", text: $confirmPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button(action: {
                        showPassword.toggle()
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(Color(UIColor.systemGray))
                    })
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                Button(action: {
                    signUp()
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: 100)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                })
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Already have an account?")
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    })
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
    }
    
    private func signUp(){
        // Sign Up logic here
        // check the currentUserType (BUYER/HUSTLER) from the datasource
        dataSource.currentUserType = selectedUserType
        let email = "\(username)@\(selectedUserType).com"
        // validate and add the user to the firebase auth
        if(isValidEmail(email) && isValidPassword(password) && password == confirmPassword){
            // Sign up the user with Firebase Auth
            fireAuthHelper.signUp(email: email, password: password) { result in
                switch result {
                case .success(_):
                    // Navigate to the ContentView upon successful sign up
                    self.rootScreen = selectedUserType == .BUYER ? .BUYER_HOME : .HUSTLER_HOME
                case .failure(let error):
                    // Display error message
                    alertMessage = error.localizedDescription
                    showingAlert = true
                }
            }
            return
        }
        else{
            alertMessage = "Please enter a valid email and password"
            showingAlert = true
            return
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }

        private func isValidPassword(_ password: String) -> Bool {
            // Add your password validation criteria here
            return password.count >= 6
        }
}


//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
