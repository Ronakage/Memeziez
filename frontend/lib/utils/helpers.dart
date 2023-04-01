

class Helpers{
  static String getDifferenceInTime(DateTime oldDate){
    DateTime currentDate = DateTime.now();
    int diff = currentDate.difference(oldDate).inDays;
    if(diff > 365){
      return "${diff/365} years ago";
    }
    else if(diff > 30){
      return "${diff/30} months ago";
    }
    else if(diff > 7){
      return "${diff/7} weeks ago";
    }
    else if(diff > 1){
      return "$diff days ago";
    }
    else{
      diff = currentDate.difference(oldDate).inHours;
      if(diff >= 1){
        return "$diff hours ago";
      }
      else{
        diff = currentDate.difference(oldDate).inMinutes;
        if(diff >= 1){
          return "$diff minutes ago";
        }
        else {
          diff = currentDate.difference(oldDate).inSeconds;
          return "$diff seconds ago";
        }
      }
    }
  }

  static String getProfilePictureURL(String username) => "https://api.dicebear.com/6.x/initials/svg?seed=$username/png";
}