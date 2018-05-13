# Custom JS for the admin area
#= require datatables

$ ->
  $('#appointments-datatable').dataTable
    processing: true
    serverSide: true
    order: [[0, "asc"]]
    ajax: $('#appointments-datatable').data('source')
    pagingType: 'full_numbers'
    columns: [
      {data: 'date'}
      {data: 'dentist_id'}
      {data: 'patient_id'}
      {data: 'duration'}
      {data: 'fee_paid'}
    ]

    initComplete: ->
      @api().columns([1, 2]).every ->
        column = this
        select = $('<select class="form-control form-control-sm"><option value=""></option></select>').appendTo($(column.footer()).empty()).on('change', ->
          val = $.fn.dataTable.util.escapeRegex($(this).val())
          column.search((if val then '^' + val + '$' else ''), true, false).draw()
          return
        )
        column.data().unique().sort().each (d, j) ->
          select.append '<option value="' + d + '">' + d + '</option>'
          return
        return
      return
