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

$(document).on 'click', '#add_type', (evt) ->
 $.ajax 'add_apt_type',
   type: 'GET',
   dataType: 'script'
   data: {
     apt_type: $('#new_apt_type').val()
   }

$(document).on 'click', '#new_apt_type_button', (evt) ->
  $('#newEventModal').modal();

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
  calView = 'month'
  calView = 'listMonth' if $(window).innerWidth() < 981 #for iPhone
  
  console.log(calView)
  console.log($(window).innerWidth())
  
  $.ajax 'appointments',
    type: 'GET'
    dataType: 'script'
    data: {
      res_id: $(".residents_select option:selected").val()
      house_id: $('.house_select option:selected').val()
    }

  $('#fullCalendar').fullCalendar({
    header: { left: 'title', right: "listWeek,#{calView} prev,next"},
    views: {
        listWeek: {
            type: 'listMonth',
            duration: { weeks: 1 },
            buttonText: 'week'
        }
    }
    defaultView: calView,
    events: 'appointments.json',
    eventClick: (calEvent, jsEvent, view) ->
        console.log(calEvent)
        console.log(jsEvent)
        $.ajax 'appointments/appointments_for_day',
          type: 'GET', 
          data: {
            date: calEvent.start.toJSON()
          }
          success: (data, textStatus, jqCHR) ->
            $("#modalBody").html(data); 

        $('#modalTitle').html('Appointments on ' + calEvent.start.format("ddd, MMM Do YYYY"););
        $('#modalBody').html(calEvent.description);
        $('#eventUrl').attr('href',calEvent.url);
        $('#fullCalModal').appendTo("body").modal('show');
        $('.modal-backdrop').css({"z-index":"0"}); # hacky, but it works for now
});
$ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '200px'

$(window).resize ->
  calView = 'month'
  calView = 'listMonth' if $(window).innerWidth() < 981 #based on iPhone
  
  $('#fullCalendar').fullCalendar( 'changeView', calView);
