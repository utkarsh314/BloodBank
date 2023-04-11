$(document).ready(function(){
    $('.chk input').on('change',function(){
        var value = $(this).parent('td').next('td').html();
        value = parseInt(value);
        if(this.checked == true) {
            $("#amount").html( parseInt($("#amount").html()) + value );
        }
        else {
            $("#amount").html( parseInt($("#amount").html()) - value );
        }
    });

    $('#selectAll').click(function(e){
        var table= $(e.target).closest('table');
        $('td input:checkbox',table).prop('checked',this.checked);
        selectAllAmount(e);
    });

    $('#selectAll1').click(function(e){
        var table= $(e.target).closest('table');
        $('td input:checkbox',table).prop('checked',this.checked);
    });
    $('#selectAll2').click(function(e){
        var table= $(e.target).closest('table');
        $('td input:checkbox',table).prop('checked',this.checked);
    });
    $('.chkcount input').on('change',function(){
        var value = $(this).parent('td').next('td').html();
        value = parseInt(value);
        if(this.checked == true) {
            $("#selectedcount").html( parseInt($("#selectedcount").html()) + 1 );
        }
        else {
            $("#selectedcount").html( parseInt($("#selectedcount").html()) - 1 );
        }
    });
});

function selectAllAmount(e) {
    var valueContainer = $(e.target).closest('table')[0];
        // console.log($(e).parent('th'));
    // while (valueContainer.children('tr').next('tr')) {
    //     console.log(valueContainer.children('tr').children('td:last-child').html());
    // }
    var value = 0;
    var tableId = valueContainer.id;
    var tableTr = document.querySelectorAll('#' + tableId + ' > tbody > tr');
    for (i = 0; i < tableTr.length; i++) {
        value += parseInt($(tableTr[i]).children('td')[4].innerHTML.trim());
    }
    if(e.target.checked == true) {
        $("#amount").html( value );
    }
    else {
        $("#amount").html( 0 );
    }
}

// const sortTable = (tableId, index) => {
//   let table = document.getElementById(tableId);
//   let switching = true;
//
//   while(switching) {
//     switching = false;
//     let rows = table.rows;
//     let i;
//     for (i = 2; i < rows.length - 1; i++) {
//       shouldSwitch = false;
//
//       one = rows[i].getElementsByTagName("td")[index];
//       two = rows[i+1].getElementsByTagName("td")[index];
//       // oneScore = rows[i].getElementsByTagName("td")[1];
//       // twoScore = rows[i+1].getElementsByTagName("td")[1];
//       if (one.innerHTML.toLowerCase() > two.innerHTML.toLowerCase()) {
//         shouldSwitch = true;
//         break;
//       }
//     }
//     if (shouldSwitch) {
//       rows[i].parentNode.insertBefore(rows[i+1], rows[i]);
//       switching = true;
//     }
//   }
// }
//
// window.addEventListener('DOMContentLoaded', (event) => {
//     let table = document.getElementById("sorting_without_pagination");
//     let rows = table.rows;
//
//     let numOfColumns = rows[2].childElementCount;
//
//     let theads = rows[1].children;
//     for (let i = 1; i <= 6; i++) {
//         theads[i].addEventListener("click", sortTable("sorting_without_pagination", i))
//     }
//
// });
