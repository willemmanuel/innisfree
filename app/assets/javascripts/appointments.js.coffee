->
$(document).on 'change', '.house_select', (evt) ->
  $.ajax 'appointments/update_residents',
    type: 'GET'
    dataType: 'script'
    data: {
      house_id: $(".house_select option:selected").val()
    }
    error: (jqXHR, textStatus, errorThrown) ->
   	console.log("AJAC Error")
    success: (data, textStatus, jqCHR) ->
   	console.log("Dynamic house select OK!")

$(document).on 'change', '.residents_select', (evt) ->
  $.ajax 'appointments/update_appointments',
    type: 'GET'
    dataType: 'script'
    data: {
      resident_id: $(".residents_select option:selected").val()
    }
    error: (jqXHR, textStatus, errorThrown) ->
   	console.log("AJAC Error")
    success: (data, textStatus, jqCHR) ->
   	console.log("Dynamic resident select OK!")
  $('#fullCalendar').fullCalendar( 'refetchEvents' )

$(document).on 'ready page:load', ->
  $("#fullCalendar").fullCalendar {
  	events: 'appointments.json'
  }
