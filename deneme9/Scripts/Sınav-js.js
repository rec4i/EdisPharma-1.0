$(document).ready(function () {
 
    function dateAdd(date, interval, units) {
        if (!(date instanceof Date))
            return undefined;
        var ret = new Date(date); //don't change original date
        var checkRollover = function () { if (ret.getDate() != date.getDate()) ret.setDate(0); };
        switch (String(interval).toLowerCase()) {
            case 'year': ret.setFullYear(ret.getFullYear() + units); checkRollover(); break;
            case 'quarter': ret.setMonth(ret.getMonth() + 3 * units); checkRollover(); break;
            case 'month': ret.setMonth(ret.getMonth() + units); checkRollover(); break;
            case 'week': ret.setDate(ret.getDate() + 7 * units); break;
            case 'day': ret.setDate(ret.getDate() + units); break;
            case 'hour': ret.setTime(ret.getTime() + units * 3600000); break;
            case 'minute': ret.setTime(ret.getTime() + units * 60000); break;
            case 'second': ret.setTime(ret.getTime() + units * 1000); break;
            default: ret = undefined; break;
        }
        return ret;
    }

    $.ajax({
        url: 'Sınav.aspx/Sınav_Listesi',
        dataType: 'json',
        type: 'POST',
        data: "{'parametre': '" + "asd" + "'}",
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            var Sınav_Listesi = $('div[id=Sınav_Listesi]')

            var b = 1;
            while (data.d.split('!')[b] != null) {


                c = new Date(data.d.split('!')[b].split('/')[4])
                y = new Date(data.d.split('!')[0]);
                var x = dateAdd(c, 'minute', parseInt(data.d.split('!')[b].split('/')[5]));
                var button_Back = ""





                if (new Date(y) <= new Date(x)) {
                    if (new Date(y) > new Date(c)) {
                        button_Back = "style='background-color:yellow'"
                    }
                }
                else {
                    button_Back = "";
                }
                Sınav_Listesi.append('<div class="alert alert-success alert-dismissible">' +
                    ' <div class="row">' +

                    ' <div class="col-xs-2 ">' +
                    '  <button ' + button_Back + ' type="button" class="btn btn-app" id="Sınava_Gir" value="' + data.d.split('!')[b].split('/')[0] + '" aria-hidden="true"><i class="fa fa-play"></i>Başla</button>' +
                    ' </div>' +
                    ' <div class="col-xs-4 ">' +

                    '<div class="row">' +
                    '  <span>Sınav Tarihi: ' + data.d.split('!')[b].split('/')[4] + '</span>' +
                    '</div>' +
                    ' <div class="row">' +
                    ' <span>Sınav Süresi: ' + data.d.split('!')[b].split('/')[5] + '</span>' +
                    ' </div>' +
                    ' <div class="row">' +
                    ' <span>Deneme Sınavı</span>' +
                    '  </div>' +
                    '   </div>' +

                    '</div>' +
                    '  </div>')

                b++;
            }
            var Sınava_Gir = $('button[id*=Sınava_Gir]');
            Sınava_Gir.click(function () {
                //$.ajax({
                //    url: 'ddldeneme.aspx/Ziyaret_Edilecekler',
                //    dataType: 'json',
                //    type: 'POST',
                //    data: "{'parametre': '""'}",
                //    contentType: 'application/json; charset=utf-8',
                //    success: function (data) {
                //        var b = 0;
                //        while (data.d.split('!')[b] != null) {

                //            Eczane_Frekans_Kontrol_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                //            b++;
                //        }
                //    },
                //    error: function () {

                //        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                //    }
                //});
            });

        },
        error: function () {

            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

        }
    });

});
