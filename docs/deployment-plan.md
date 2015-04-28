## Deployment Plan

We are currently leaning towards hosting our application using Heroku, which is compatible with Ruby. We are still evaluating whether or not the free plan will be sufficient for their needs, as it puts fairly tight limits on speed and the number of database records we can have. 

We may need another service to handle the domain name; however, they already own www.innisfreevillage.org so we may be able to use this. We are hoping to start setting this deployment in March, in order to avoid paying for an unnecessary month of service if we choose against the free plan.

We have spoken with the customer, Monika, and she is aware that she may need to pay for hosting and acquire the necessary pieces. They are currently using Bluehost for their organization’s web page. They also have a server, but it is not up and running at this time, so we do not know if this is a viable option. They have a technical lead, Eric, with whom we will be meeting on Friday, 1/30. He will let us know the timeline for setting up their server; we may leave them instructions for hosting the application on the server so that they can eventually discontinue a third-party hosting option.

Since they own the www.innisfreevillage.org domain, they prefer the application to be under this domain.  And they would like the application to be accessible from their organization’s home page (with the proper login credentials).

***Update 02/09/2014***
Our application will be deployed to Innisfree Village’s BlueHost account. The URL used will be a subdomain of their current URL (http://something.innisfreevillage.org). We will use their existing SQL server on BlueHost.

***Update 03/23/2014***
Our application has been deployed to Bluehost. The URL is http://schedule.volunteerinnisfree.org/ per their request in our last customer meeting.
