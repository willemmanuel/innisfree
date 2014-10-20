$(document).on 'ready page:load', ->
  $("#fullCalendar").fullCalendar {
  	events: 'appointments.json'
  }
  return