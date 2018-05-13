// Custom JS for the admin area
//= require datatables
/*
$(document).ready(function() {
  var table = $('#appointments-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": $('#appointments-datatable').data('source'),
    "pagingType": "full_numbers",
    "columns": [
      {"data": "date"},
      {"data": "dentist_id"},
      {"data": "patient_id"},
      {"data": "duration"},
      {"data": "fee_paid"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  initComplete: function () {
      table.columns().every( function () {
          var column = this;
          var select = $('<select><option value=""></option></select>')
              .appendTo( $(column.footer()).empty() )
              .on( 'change', function () {
                  var val = $.fn.dataTable.util.escapeRegex(
                      $(this).val()
                  );

                  column
                      .search( val ? '^'+val+'$' : '', true, false )
                      .draw();
              } );

          column.data().unique().sort().each( function ( d, j ) {
              select.append( '<option value="'+d+'">'+d+'</option>' )
          } );
      } );
  }
});*/