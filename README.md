# i🅿️ark
&nbsp;
## App Requirements
Create an iOS application for the Parking App with the following functionalities:
### User Profile  
  Your app must provide appropriate interface to sign-up, sign-in, sign-out, update profile and delete
  account. Consider requesting name, email, password, contact number and car plate number from
  user when they create their account.
  If you are inclined and interested in adding profile picture functionality, you may add that in your
  app. However, it is not the official requirement of the project. No additional grades will be awarded
  or deducted for including (or not including) this functionality.
### Add Parking
The add parking facility should allow the user to create a new parking record with the following
information.
- Building code (exactly 5 alphanumeric characters)
- No. of hours intended to park (1-hour or less, 4-hour, 12-hour, 24-hour)
- Car License Plate Number (min 2, max 8 alphanumeric characters)
- Suit no. of host (min 2, max 5 alphanumeric characters)
- Parking location (street address, lat and lng)
- Date and time of parking (use system date/time)  
  
You should allow the user to input the parking location in two ways:
- Enter street name [In this case the app should obtain location coordinates using geocoding]
- Use current location of the device [In this case the app should use reverse geocoding to obtain
street address]  
  
After accepting and verifying all information, all parking information must be saved to database. You
must use either CoreData or Cloud Firestore to save the records. When adding the parking
information in the database, make sure that you associate the record with the currently logged in
user.
### View Parking
This facility will allow the user to view the list of all the parking they have made. You should display
the list with most recent parking first. You should also display the detail view of each parking when
user taps on any item of the list. When displaying detail view, display all the information about the
parking in appropriate format. In the detail view of parking, allow the user to open the parking
location on map and display the route to the parking location from the current location of the device.
##
&nbsp;
## Screenshots
<img src = "https://github.com/sharmohit/parking-app/blob/master/Images/ParkingApp_ERD.png" alt="ParkingApp ERD" width="695" height="440"/>
<img src = "https://github.com/sharmohit/parking-app/blob/master/Images/ParkingApp_Firebase_Console.png" alt="ParkingApp Firebase Console" width="695" height="340"/>
<img src = "https://github.com/sharmohit/parking-app/blob/master/Images/ParkingApp_Xcode.png" alt="ParkingApp Xcode Project" width="695" height="320"/>
<table style="width:100%">
  <tr>
    <th>Login UI</th>
    <th>Create Account UI</th>
    <th>Home View UI</th>
  </tr>
  <tr>
    <td><img src = "https://github.com/sharmohit/parking-app/blob/master/Images/01_iPark_LoginUI.png" alt="Login UI" width="205" height="443"/></td>
    <td><img src = "https://github.com/sharmohit/parking-app/blob/master/Images/02_iPark_CreateAccountUI.png" alt="Create Account UI" width="205" height="443"/></td>
    <td><img src = "https://github.com/sharmohit/parking-app/blob/master/Images/03_iPark_HomeViewUI.png" alt="Home View UI" width="205" height="443"/></td>
  </tr>
</table>
<table style="width:100%">
  <tr>
    <th>Add Parking UI</th>
    <th>Update Profile UI</th>
    <th>Parking Detail UI</th>
  </tr>
  <tr>
    <td><img src = "https://github.com/sharmohit/parking-app/blob/master/Images/04_iPark_AddParkingUI.png" alt="Add Parking UI" width="205" height="443"/</td>
    <td><img src = "https://github.com/sharmohit/parking-app/blob/master/Images/05_iPark_UpdateProfileUI.png" alt="Update Profile UI" width="205" height="443"/></td>
    <td><img src = "https://github.com/sharmohit/parking-app/blob/master/Images/06_iPark_ParkingDetailUI.png" alt="Parking Detail UI" width="205" height="443"/></td>
  </tr>
</table>
<table style="width:100%">
  <tr>
    <th>Parking Map UI</th>
  </tr>
  <tr>
    <td><img src = "https://github.com/sharmohit/parking-app/blob/master/Images/07_iPark_ParkingMapUI.png" alt="Parking Map UI" width="205" height="443"/</td>
  </tr>
</table>

##
&nbsp;
## Task Lists
- [x] 1. Create Sign-In Screen @MohitSharma(101342267)
  - [x] Design sign-in screen
  - [x] Login and validate user with firestore
  - [x] Implement remember me
  - [x] Link sign-up and home screens

- [x] 2. Create Sign-Up Screen UI @JavteshSinghBhullar(101348129)
  - [x] Design sign-up screen
  - [x] Validate user input
  - [x] Create user account with firestore
  - [x] Link sign-in and home screens

- [x] 3. Create Add Parking Screen UI @MohitSharma(101342267)
  - [x] Design add parking screen
  - [x] Fetch and convert user location
  - [x] Validate user input
  - [x] Add parking with firestore

- [x] 4. Create Update Profile Screen UI @JavteshSinghBhullar(101348129)
  - [x] Design update profile screen
  - [x] Fetch user input
  - [x] Validate user input
  - [x] Update user profile with firestore
  - [x] Delete user profile
  - [x] Logout user profile
  
- [x] 5. Configure Firestore Console and Firebase in Project @MohitSharma(101342267)
  - [x] Create firebase app and configure firestore
  - [x] Add GoogleService-Info.plist in Xcode project
  - [x] Configure firebase and install pods in Xcode project 
  - [x] Test firestore with test data

- [x] 6. Create Parking Detail View Screen UI @JavteshSinghBhullar(101348129)
  - [x] Design parking detail view screen
  - [x] Fetch parking detail from firestore
  - [x] Display parking detail

- [x] 7. Create Home and Parking View Screen UI @MohitSharma(101342267)
  - [x] Design home and parking view screen
  - [x] Create tabbed home screen
  - [x] Link navigation controller with view/add parking and profile screen, 
  - [x] Implement table view for view parking screen
  - [x] Fetch user parking from firestore
  - [x] Link home and parking detail view screens

- [x] 8. Design Final UI with illustrations for all UI Screens @JavteshSinghBhullar(101348129)
  - [x] SignUp Screen
  - [x] Update Screen
  - [x] Login Screen
  - [x] Home Screen
  - [x] Add Parking
  - [x] parking detail
  
- [x] 9. Add location service @MohitSharma(101342267)
  - [x] Create MapView Screen 
  - [x] Implement location controller
  - [x] Implement reverse geocoding
  - [x] Implement location geocoding
  - [x] Implement and show route on map
##
