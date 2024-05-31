import SwiftUI
import Auth0

struct MainView: View {
    @State var user: User?

    var body: some View {
        if let user = self.user {
            TabView {
                HomeView().tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                  }
                ContentView().tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Contacts")
                  }
                VStack {
                    ProfileView(user: user)
                    Button("Logout", action: self.logout)
                }.tabItem {
                    Image(systemName: "person.circle")
                    Text("Account")
                  }
            }
        } else {
            VStack {
                HeroView()
                Button("Login", action: self.login)
            }
        }
    }
}

extension MainView {
    func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                    case .success(let credentials):
                        self.user = User(from: credentials.idToken)
                    case .failure(let error):
                        print("Failed with: \(error)")
                }
            }
    }

    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                    case .success:
                        self.user = nil
                    case .failure(let error):
                        print("Failed with: \(error)")
                    }
            }
    }
}
