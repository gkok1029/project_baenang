let CalenderModule = ( ()=>{
    function createCalender(){
        
        let calender = $('<div>').addClass("calender-container").append(
            $('<div>').append(
                $('<div>'),
                $('<table>').addClass("calender-table calender-table-bordered").append(
                    $('<thead>').append(
                        $('<tr>').append(
                            $('<th>').text("일"),
                            $('<th>').text("월"),
                            $('<th>').text("화"),
                            $('<th>').text("수"),
                            $('<th>').text("목"),
                            $('<th>').text("금"),
                            $('<th>').text("토"),
                        )
                    )
                ),
                $('<tbody>').attr("id","tb_body")
            )
        )

        return calender;
    }
})();