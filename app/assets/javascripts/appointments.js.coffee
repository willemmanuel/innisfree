$(document).ready ->
  $("#fullCalendar").fullCalendar {
  	events: '/appointments.json'
  }
  return