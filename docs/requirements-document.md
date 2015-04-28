# SLP Requirements Document
#### Last updated 3/23/2015

### Innisfree Village

Nonprofit overview: Lifesharing at Innisfree means that residents and their volunteer caregivers live as families in the community’s 15 houses. In this close-knit environment, people develop profound relationships based on mutual needs, respect, and love.

##### Contacts: 

Monika Kohler, monika@innisfreevillage.org, 434-823-5400
Wes, 434-566-4007
Emily, 919-724-7206
Eric, netadmin@innisfreevillage.org 

##### Website: 
www.innisfreevillage.org, http://pegasus.cs.virginia.edu/innisfree

##### System summary: 
A system to manage the scheduling of the resident's appointments in the community, as well as manage the signing out of vehicles.

##### Development notes:
One of the volunteers, Eric has programming experience. He will attend customer meetings with possible, and part of our plan for delivering the final system will be training him to configure and edit.

##### Confidentiality notes:
The names of the residents are slightly confidential. The medical evaluations that are in the system are highly confidential. We will be keeping resident names since they are needed for identification purposes. We will also have a field for appointment type, allowing the user to select if this is a psychiatrist appointment, dentist appointment, etc. Medical evaluations will not be stored in the system. However, important notes on allergies or other needs can be stored in a notes field for a specific resident or appointment. 
Description

##### From the customer:
```
Innisfree has about 40 residents and 40 volunteers/staff. We have a lot of overlapping schedules from medical 
appointments to scheduled activities to car sign-outs, meetings, and staff availability. It would be nice to 
have a system of organization for these things that would mean the ability to input a standing appointment 
for a specific resident at a specific location through out the year. It would be helpful if reminders of these 
appointments were emailed to our medical coordinator as well as the volunteer responsible for transportation to 
put everyone on the same page. It would be helpful to have reminders for irregular appointments that need to be 
made. Also seeing appointments while making an appointment at the doctor’s office to be able to coordinate 
appointments so that we would need to make fewer trips to town. Reports for each resident and the activities
they had through out the year. Since each house at Innisfree has a different combination of coworkers and 
volunteers, having a profile for each house and their specific needs could mean that if a new person wanted 
to get a feel for the flow of the house, they could see all this information in one profile as opposed 
to many pages of dense reading.

Innisfree Village is a residential community for individuals with intellectual disabilities; those individuals
are called “residents” or “co-workers”. Innisfree has about 10 residential buildings (houses), and about 40
residents. Volunteers stay in one house for one year, and are tasked with caring for their 4 
co-workers/residents. There are around 20 volunteers, 2 per house. In addition, there are about 5 staff, and 
about 6 workstation heads. A workstation is where the residents go for their daily activities, such as the 
bakery, woodshop, etc. Some staff members live on the property, but not all; all volunteers live on the property, 
and none of the workstation heads live on the property. The residents have various appointments 
(medical, legal, etc.) in the community, and the volunteers will transport them as needed. Currently, they 
schedule appointments on a paper calendar, and sign out cars with a sign-out sheet. Each volunteer has a set of 
physicians to go to, which are the set of physicians that their set of residents need. A staff member is the 
one in charge of making appointments in the community, and s/he writes the appointment info on paper and hands 
it to the volunteers.The system is to create a scheduling system that will manage the scheduling of appointments 
and, following that, car reservations.

```
###Features

-	Standard web portal features: ability to log in, have accounts created, reset password, update profile
  -	Users will be the staff (about 15), volunteers (about 20), and workstation heads
  -	The staff users will have permission to create, update, read, and destroy any entity in the system, but the volunteers will only have create, update, and destroy for their specific house
  -	Workstation heads will have read-only access to the calendar to see where missing co-workers may be on that day

-	There will be a set of (configurable) houses, and each house will have a number of volunteers assigned to them (currently average of 2 per house)

-	Likewise, the residents will have profiles in the system, and will be assigned to a given houses (currently 4 per house)
  -	Note that medical information will not be directly kept in the database, but one can easily infer such from the type of appointment

-	Scheduling is somewhat similar to Google calendar. You will have a monthly view where you can see appoints at a high level. At this level, you will only see how many appointments are on a given day. You can then use a weekly view or a daily view to see more details. The staff scheduler would enter appointments into the system, and the volunteers could then view it.
  -	We used a calendar Gem from Ruby
  -	Each calendar entry will be tagged with the resident who went, the physician who was visited (and thus the physician type)
  -	Physicians and physician categories can also be entered, and then easily searched for when creating an appointment
  -	There will be a “notes” field where the volunteer will enter text; this will be readable, at a minimum, by the other volunteer in the house
  -	For an appointment, we will consider the assigned physician and appointment type (dentist, psychologist) in order to provide appropriate medical data without revealing sensitive medical information
  -	The staff scheduler typically makes appointments, but the volunteers can make them as well (especially follow-up appointments).
  -	There are usually no more than 4 or so appointments on a given day; they try for Tuesday appointments, but that doesn't always work out. Carpooling is a potential option, but it is too complex to be added to the system due to the challenges of caring for multiple residents at a time.

-	Follow-up appointments
  -	Volunteers can make them directly, and many will do so, via their smartphone, from the physician's office
  -	This implies that there will need to be a viable mobile interface, but this will likely have limited functionality
  -	About half of the volunteers have smart phones, so an easy web-based data entry form is desired. Some have tablets as well.
  -	Volunteers can also enter reminders to make a certain type of appointment in a certain amount of time. A reminder will be shown to the relevant volunteer(s) and the staff scheduler within a certain time period prior to its due date (that time period should be configurable).
  -	They would like reminders via email, even if it requires sending a lot of emails
  -	To find the volunteer, first find the resident that the reminder is for, find the house that s/he is in, and then find the volunteers for that house. This is necessary because, for 6-month or 12-month follow-up appointments, the volunteers might rotate, as the volunteers come and go (about 1 year each)

-	Other calendars: they would like to have separate calendars for looking at volunteer time off, car sign-out, and workstation activities

-	We need to use clear language for volunteers who may be coming from out-of-country

-	Data generation
  -	Data export to CSV for system backup. PDF format is the preferred format.
  -	Reports
  - For each resident, which categories of physicians they went to in a given time period (a year, for example)
  - Need to generate reports based on specific houses, physicians, appointment type, and a date range

-	A volunteer's view should default to his/her appointments (specifically, the appointments for the residents of his/her house), allowing for easy access to said data. The volunteer should be able to view all appointments (or appointments of other houses, etc.)
  -	The system should track edits to appointments so that, if changes were made incorrectly, one can easily go back to fix them
  -	When creating an appointment, you should be able to see all other appointments, but you should be able to filter them (by date, by type, etc.)

-	Car sign-out
  -	8 or so vehicles (configurable), and any of the staff or volunteers can sign them out for a given period. They are used for transporting co-workers to appointments, attending private events, volunteer use on days off, etc.
  -	While important, this feature is secondary to the other scheduling
  -	System needs to handle car sign-out, notify others of conflicting car requests, and allow for changes to a car reservation in the event of traffic or bad weather
  -	The system need to track the duration that the car will be gone
  -	We also need to keep a monthly view for looking at car scheduling
  -	Would like to have a callable phone number on the appointment screen


#### Requirements: Minimum

- Basic web portal features
- Basic scheduling of appointments, notifications to volunteers
- Basic report generation, graph generation, etc.

#### Requirements: Desired

- Mobile interface
- All the scheduling and web portal features described above
- The car sign-out functionality
