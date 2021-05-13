# 🅿️arking App
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
## Task Lists
- [ ] 1. **Login screen** @sharmohit
- [ ] 2. Create account screen @JavteshGBC
##
