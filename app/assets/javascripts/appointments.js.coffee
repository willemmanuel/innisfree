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

$(document).on 'ready page:load', ->
  $("#fullCalendar").fullCalendar {
  	events: 'appointments.json'
  }
