->
$(document).on 'change', '.house_select', (evt) ->
  $.ajax 'appointments/update_residents',
    type: 'GET'
    dataType: 'script'
    data: {
      house_id: $(".house_select option:selected").val()
    }
    success: (data, textStatus, jqCHR) ->
    error: (jqXHR, textStatus, errorThrown) ->
   	console.log("AJAC Error")
  $.ajax 'appointments',
    type: 'GET'
    dataType: 'script'
    data: {
      res_id: ''
      house_id: $('.house_select option:selected').val()
    }
    error: (jqXHR, textStatus, errorThrown) ->
   	console.log("AJAC Error")
    success: (data, textStatus, jqCHR) ->
   	console.log("Dynamic resident select OK!")


$(document).on 'change', '.residents_select', (evt) ->
  $.ajax 'appointments',
    type: 'GET'
    dataType: 'script'
    data: {
      res_id: $(".residents_select option:selected").val()
      house_id: $('.house_select option:selected').val()
    }
    error: (jqXHR, textStatus, errorThrown) ->
   	console.log("AJAC Error")
    success: (data, textStatus, jqCHR) ->
   	console.log("Dynamic resident select OK!")

$(document).on 'ready page:load', ->
  $.ajax 'appointments',
    type: 'GET'
    dataType: 'script'
    data: {
      res_id: $(".residents_select option:selected").val()
      house_id: $('.house_select option:selected').val()
    }
    error: (jqXHR, textStatus, errorThrown) ->
   	console.log("AJAC Error")
    success: (data, textStatus, jqCHR) ->
   	console.log("Dynamic resident select OK!")

  $("#fullCalendar").fullCalendar {
  	events: 'appointments.json'
  }
