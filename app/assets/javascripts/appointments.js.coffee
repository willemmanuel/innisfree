->
$(document).on 'change', '.house_select', (evt) ->
  $.ajax 'appointments/update_residents',
    type: 'GET'
    dataType: 'script'
    data: {
      house_id: $(".house_select option:selected").val()
    }
  $.ajax 'appointments',
    type: 'GET'
    dataType: 'script'
    data: {
      res_id: ''
      house_id: $('.house_select option:selected').val()
    }
  $.ajax 'appointments/upcoming',
    type: 'GET', 
    data: {
      res_id: ''
      house_id: $('.house_select option:selected').val()
    }
    success: (data, textStatus, jqCHR) ->
      $("#upcoming").html(data); 

$(document).on 'change', '.residents_select', (evt) ->
  $.ajax 'appointments',
    type: 'GET'
    dataType: 'script'
    data: {
      res_id: $(".residents_select option:selected").val()
      house_id: $('.house_select option:selected').val()
    }
  $.ajax 'appointments/upcoming',
    type: 'GET', 
    data: {
      res_id: $(".residents_select option:selected").val()
      house_id: $('.house_select option:selected').val()
    }
    success: (data, textStatus, jqCHR) ->
      $("#upcoming").html(data); 

$(document).on 'ready page:load', ->
  $.ajax 'appointments',
    type: 'GET'
    dataType: 'script'
    data: {
      res_id: $(".residents_select option:selected").val()
      house_id: $('.house_select option:selected').val()
    }

  $("#fullCalendar").fullCalendar {
  	events: 'appointments.json'
  }
