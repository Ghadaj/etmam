import Foundation
import SwiftUI
import CoreLocation
struct AuthView: View {
  // الفاريبلز الي توصلنا للداتابيس
  @EnvironmentObject var dbOrgs: orgDatabaseVM
  @EnvironmentObject var dbTasks: taskDatabaseVM
  @EnvironmentObject var dbProjects: projectDatabaseVM
  @EnvironmentObject var dbMeetings: meetingDatabaseVM
  var UserAuth = UserAuthVM.sharedauthVM.IsSignedIn
  let locationManager = CLLocationManager()
  var body: some View {
    if !UserAuth {
      NavigationView{
        ScrollView{
          VStack(alignment:.leading) {
            NavigationLink("sign in",destination: SignInView())
            NavigationLink("sign up",destination: SignUpView())
          }
        }
      }
    }
    else {
      Today()
    }
  }
}
struct AuthView_Previews: PreviewProvider {
  static var previews: some View {
    AuthView()
  }
}
