import Foundation
import SwiftUI
import CoreLocation
import FirebaseAuth

struct AuthView: View {
  // الفاريبلز الي توصلنا للداتابيس
  @EnvironmentObject var dbOrgs: orgDatabaseVM
  @EnvironmentObject var dbTasks: taskDatabaseVM
  @EnvironmentObject var dbProjects: projectDatabaseVM
  @EnvironmentObject var dbMeetings: meetingDatabaseVM
  @EnvironmentObject var userAuthVM: UserAuthVM
  
  var UserAuth = UserAuthVM.sharedauthVM.IsSignedIn
  let locationManager = CLLocationManager()
  var body: some View {
//    SplashView()
    
      if !UserAuth {
          logoView()
      }
      if !UserAuth{
          logoView()
      }
      else {
          TabBar().environmentObject(UserAuthVM()).environmentObject(meetingDatabaseVM()).environmentObject(orgDatabaseVM()).environmentObject(projectDatabaseVM()).environmentObject(taskDatabaseVM()).environmentObject(userDatabaseVM())
      }
  }
}
struct AuthView_Previews: PreviewProvider {
  static var previews: some View {
      AuthView()
  }
}
