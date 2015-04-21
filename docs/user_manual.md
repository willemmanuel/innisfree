# Innisfree Village Scheduling User Manual
## Table of Contents
- Basic Information
  - Navigation
  - Roles
- Workstation Head Role
- Volunteer Role
- Administrator Role

## Basic Information
#### Navigation
Navigating the system is done by clicking internal links shown in navigation bar at the top of each page, as show in the screenshot below. \todo{insert screenshot}. This navigation bar contains links to home page that shows appointments, as well as to the house list, the doctor list, the car reservation system and the list of system users. On smaller screens, this navigation bar will collapse to a single button that can be clicked to reveal the entire bar.

In addition to using this navigation bar, there are number of links on each page. For instance, on the home page, users are shown a list of the upcoming appointments. Each line of this list contains several links, as shown below. \todo{insert screenshot}. The first few links take you to a brief profile for that co-worker, doctor or volunteer. The fourth link "Details" will take you to the appointment details page, allowing for simple navigation to each appointment.

#### Roles
There are 3 basic roles in this system; the workstation head role, the volunteer role and the administrator role. The workstation head role has the least privileges, and can only see the appointment schedule to determine if a co-worker is not present due to an appointment. Volunteers more power, able to view all appointments and create, edit, and cancel appointments for residents in their house. Administrators have the most priviledges, as they are able to view, create, edit, cancel, and delete all appointments. Admin users are also able to create and edit residents, houses, doctors, and users and run reports.

## Workstation Head Role
#### Appointments (Home screen)
\todo{screenshot of home page - upcoming:1, monthly:2, weekly:3, house:4, resident: 5}
This homepage allows for viewing appointments. Ten upcoming appointments, sorted by date, are displayed in a list \todo{1} above a calendar that provides a monthly \todo{2} or weekly view \todo{3} for appointments. This list of 10 appointments is paginated, so you can click the buttons at the bottom of the list to see future appointments.

Just above the list of upcoming appointments are two dropdown boxes. These dropdowns are used to filter the list of upcoming appointments and the calendar view. The house dropdown \todo{4} allows you to only see appointments for the selected house, while the resident dropdown \todo{5} shows only the appointments for the selected co-worker.

To view a single appointment, you can click the "details" link for that appointment from the list of appointments. You can also click on a calendar day, and then click the "details" link for the desired appointment. This single appointment view shows the same information as the list of upcoming appointments, but also provides a Google Map window to show where the doctor is located.

#### Houses
This provides a listing of all Innisfree houses, along with the house's phone number and the volunteers and co-workers living there. Full-time staff members are in the "Office Staff" house, while workstation volunteers are in the "Workstations" house.

Clicking on the name of a co-worker on this page will take you to their upcoming appointments. To see the contact information for a staff member or volunteer, simply click on their name.

#### Doctors
This page provides a listing of all of the medical coordinator approved doctors. This list can be sorted by doctor name, type, address and phone number, by clicking on the heading of each column. Clicking on the address of a doctor will bring that location up in Google Maps.

#### Users
This page provides a listing of all the scheduling system users. To sort this list by name, simply click on the column heading "Name." This list can also be sorted by house, email address, phone number, and role.

#### My Profile
This page shows information about the currently logged in user. To change your name, phone number, email address, email preferences, or password, simply navigate to this page and click the "Edit My Profile" link. Then, fill in the requried field and click the "Update User" button.

#### Cars
This page shows car reservations.

##### Making a Car Reservation
To make a new reservation, click the "New Reservation" button. Then, use the user drop-down to select the user who is reserving this car, use date picker to select the date for your reservation, and use the time drop-downs to select start and end times. Once you've done this, click the "See Available Cars" button. This will take you to page that shows you your reservation details. This page also has a drop-down menu that lets you select which car you would like to reserve, and a text field where you can put the purpose for your reservation. This allows other volunteers to ride with you if possible. Once you've filled out the fields on this page, click the "Save Reservation" button. This will save your reservation and take you back to the calendar to view it.

##### Deleting a Car Reservation
To delete a reservation, click on it in the calendar. This will take you to the individual reservation page. On this page, click the "Delete Reservation" link and click "OK" on the pop-up window. Your reservation will be deleted and the reservation calendar will no longer show it.


## Volunteer Role
#### Appointments
In addition to viewing appointments (as shown in the Appointments section for [Workstation Heads](#appointments)), volunteers can also create or edit appointments for co-workers in their house.

##### Creating a New Appointment
To create a new appointment, click the "New Appointment" button on the appointments page. Use the drop-down boxes to fill in the form, and then click the "Create Appointment" button. The "Resident", "Doctor", and "Appointment type" fields must be filled out before an appointment can be created.

The Resident and Volunteer drop-down boxes only show Residents and Volunteers in the same house as the user creating the appointments. This page also contains the paginated list of upcoming appointments, so volunteers can coordinate appointments if possible.

Once the appointment is created, the user is taken to the individual appointment page for that appointment. You can edit an appointment by clicking the "Edit" link under the appointment information, or go back the the main appointments page by clicking the "Back to Appointments" link. You can also continue creating appointments by using the "New Appointment" button, or set a reminder to schedule an additional appointment by using the "Set Reminder to Schedule Follow-Up Appointment" button.

##### Editing an Existing Appointment
To edit an appointment, you must go to the individual appointment page for that appointment and then click the "Edit" link. This will allow you to update the resident, doctor, volunteer, date, time, appointment type and notes for that appointment. Once you have changed the desired fields, you simply need to click the "Update Appointment" button for your changes to be submitted.

The drop-down boxes on this page have the same restrictions as on the new appointment page, and the "Resident", "Doctor", and "Appointment type" fields must be filled out before the appointment can be updated.

#### Houses, Doctors, Users, My Profile, Cars
See these entries under the [Workstation Head Role](#workstation-head-role)

## Administrator Role

#### Cars
See this entry under the [Workstation Head Role](#workstation-head-role-cars) to create and delete reservations

In addition to creating and deleting car reservations, administrator users can manage cars by clicking the "Manage Cars" link next to the title of the "Car Reservations" page.

##### Creating a New Car
To create a new car, click the "New Car" button on the Manage Cars page, then enter the car name and click "Create Car."

##### Editing a Car
To change the name of an existing car, click the "Edit car" link on the Manage Cars page for the car you want to edit. Then, type the new car name in the name field and click "Update Car."

##### Deleting a Car
To remove a car from the system, click the "delete car" link on the Manage Cars page for the car you want to delete. The car will then be deleted.

