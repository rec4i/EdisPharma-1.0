<%@ Page Title="" Language="C#" MasterPageFile="~/Bs.Master" AutoEventWireup="true" CodeBehind="Bs-Anasayfa.aspx.cs" Inherits="deneme9.Bs_Anasayfa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/compressorjs/1.0.7/compressor.min.js"></script>

    <script type="text/javascript">



        $(document).ready(function () {

            var Today = new Date();
            function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + d.getDate(),
                    year = d.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [year, month, day].join('-');
            }
            var Bu_Gün__ = formatDate(Today)

            $.ajax({
                url: 'Bs-Anasayfa.aspx/Tablo_Doldur',
                type: 'POST',
                data: "{'parametre':'asd'}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",

                success: function (data) {
                    var Kullanıcılar = $('div[id=Kullanıcılar]')
                    var temp = JSON.parse(data.d)
                    for (var i = 0; i < temp.length; i++) {
                        var Toplam_Doktor_Ziy = parseInt(temp[i].Ziy_Bekeleyen_Dok) + parseInt(temp[i].Ziy_Edilen_Dok) + parseInt(temp[i].Ziy_Edilemeyen_Dok);
                        var Doktor_Bekliyen_Ziy_yüz;
                        var Doktor_Edilen_Ziy_yüz;
                        var Doktor_Edilemeyen_Ziy_yüz;
                        if (Toplam_Doktor_Ziy != 0) {
                            Doktor_Bekliyen_Ziy_yüz = (parseInt(temp[i].Ziy_Bekeleyen_Dok) / Toplam_Doktor_Ziy) * 100;
                            Doktor_Edilen_Ziy_yüz = (parseInt(temp[i].Ziy_Edilen_Dok) / Toplam_Doktor_Ziy) * 100;
                            Doktor_Edilemeyen_Ziy_yüz = (parseInt(temp[i].Ziy_Edilemeyen_Dok) / Toplam_Doktor_Ziy) * 100;
                        }
                        else {
                            Doktor_Bekliyen_Ziy_yüz = 0;
                            Doktor_Edilen_Ziy_yüz = 0;
                            Doktor_Edilemeyen_Ziy_yüz = 100;
                        }


                        var Toplam_Eczane_Ziy = parseInt(temp[i].Ziy_Bekeleyen_Ecz) + parseInt(temp[i].Ziy_Edilen_Ecz) + parseInt(temp[i].Ziy_Edilemeyen_Ecz);
                        var Eczane_Bekliyen_Ziy_yüz;
                        var Eczane_Edilen_Ziy_yüz;
                        var Eczane_Edilemeyen_Ziy_yüz;

                        if (Toplam_Eczane_Ziy != 0) {
                            Eczane_Bekliyen_Ziy_yüz = (parseInt(temp[i].Ziy_Bekeleyen_Ecz) / Toplam_Eczane_Ziy) * 100;
                            Eczane_Edilen_Ziy_yüz = (parseInt(temp[i].Ziy_Edilen_Ecz) / Toplam_Eczane_Ziy) * 100;
                            Eczane_Edilemeyen_Ziy_yüz = (parseInt(temp[i].Ziy_Edilemeyen_Ecz) / Toplam_Eczane_Ziy) * 100;
                        }
                        else {
                            Eczane_Bekliyen_Ziy_yüz = 0;
                            Eczane_Edilen_Ziy_yüz = 0;
                            Eczane_Edilemeyen_Ziy_yüz = 100;
                        }
                        var Performas_;
                        if (temp[i].Performans == "") {
                            Performas_ = 0;
                        }
                        else {
                            Performas_ = temp[i].Performans;
                        }

                        var myvar = '<div class="col-md-6">' +
                            '        <!-- Widget: user widget style 1 -->' +
                            '        <div class="box box-widget widget-user-2">' +
                            '            <!-- Add the bg color to the header using any of the bg-* classes -->' +
                            '            <div class="widget-user-header bg-teal">' +
                            '                <div class="row">' +
                            '                    <div class="col-xs-4">' +
                            '                        <div class="widget-user-image" style="padding: 10px">' +
                            '                            <img class="img-circle" style="width:100px; height:100px; " src="' + temp[i].Kullanıcı_Profil_Photo + '" alt="User Avatar" />' +
                            '                        </div>' +
                            '                    </div>' +
                            '                    <div class="col-xs-8">' +
                            '                        <!-- /.widget-user-image -->' +
                            '                        <h3 class="widget-user-username">' + temp[i].Ad + ' ' + temp[i].Soyad + ' </h3>' +
                            '                        <h5 class="widget-user-desc">' + temp[i].Grup_Tam_Ad + ' (' + temp[i].Grup_Kısa_Ad + ')</h5>' +
                            '                        <h5 class="widget-user-desc">Ziyaret Performansı:   % ' + Performas_ + '</h5>' +
                            '                    </div>' +
                            '                </div>' +
                            '            </div>' +
                            '            <div class="box-footer no-padding">' +
                            '                <ul class="nav nav-stacked">' +
                            '                    <li><a href="#">Bugünkü Ziyaret Edeceği Doktor' +
                            '                        <div class="progress">' +
                            '                            <div class="progress-bar progress-bar-red" role="progressbar" style="width: ' + Doktor_Edilemeyen_Ziy_yüz + '%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">' + temp[i].Ziy_Edilemeyen_Dok + '</div>' +
                            '                            <div class="progress-bar progress-bar-yellow" role="progressbar" style="width: ' + Doktor_Bekliyen_Ziy_yüz + '%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">' + temp[i].Ziy_Bekeleyen_Dok + '</div>' +
                            '                            <div class="progress-bar progress-bar-green" role="progressbar" style="width: ' + Doktor_Edilen_Ziy_yüz + '%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">' + temp[i].Ziy_Edilen_Dok + '</div>' +
                            '                        </div>' +
                            '                    </a></li>' +
                            '                     <li><a href="#">Bugünkü Ziyaret Edeceği Eczane' +
                            '                        <div class="progress">' +
                            '                            <div class="progress-bar progress-bar-red" role="progressbar" style="width: ' + Eczane_Edilemeyen_Ziy_yüz + '%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">' + temp[i].Ziy_Edilemeyen_Ecz + '</div>' +
                            '                            <div class="progress-bar progress-bar-yellow" role="progressbar" style="width: ' + Eczane_Bekliyen_Ziy_yüz + '%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">' + temp[i].Ziy_Bekeleyen_Ecz + '</div>' +
                            '                            <div class="progress-bar progress-bar-aqua" role="progressbar" style="width: ' + Eczane_Edilen_Ziy_yüz + '%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">' + temp[i].Ziy_Edilen_Ecz + '</div>' +
                            '                        </div>' +
                            '                    </a></li>' +
                            '                    <li>' +
                            '                        <a><div id="Tsm_Son_Yapılan_islem_" Kullanıcı_Id="' + temp[i].Kullanıcı_Id+'"></div></a>'+
                            '                     </li>' +
                            '                    <li><a id="Koçluk_Formu_Modal_Aç" value="' + temp[i].Kullanıcı_Id + '">Koçluk Formu (Yeni Bir Tane Oluşturmak İçin Tıklayın)</a></li>' +
                            '                    <li><a id="Ziyaret_Detay" value="' + temp[i].Kullanıcı_Id + '">Bugünkü Ziyaretleri (Detay İçin Tıklayın) <span class="pull-right badge bg-green">Toplam Ziyaret:  ' + temp[i].Bu_Gun_Ziy_Toplam + '</span></a></li>' +
                            '                     <li><a href="' + "/Tsm-Sipariş-Raporu.aspx?x=" + Bu_Gün__ + "&y=" + Bu_Gün__ + "&z=" + temp[i].Kullanıcı_Id + "" + '">Bugünkü Verdiği Siparişleri (Detay İçin Tıklayın)<span class="pull-right badge bg-aqua">Toplam Sipariş:   ' + temp[i].Bu_Gun_Sip_Toplam + '</span></a></li>' +
                            '                </ul>' +
                            '            </div>' +
                            '        </div>' +
                            '        <!-- /.widget-user -->' +
                            '    </div>';
                        Kullanıcılar.append(myvar);
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            

            Tabloyu_Doldur();
            function Tabloyu_Doldur() {
             
                $('div[id*=Tsm_Son_Yapılan_islem_]').each(function () {
                   
                    $(this).empty();
                    $(this).append('<table id="example" class="display"  style="width: 100%">' +
                        '<thead>' +
                        '<tr>' +
                        '<th>İşlem Tipi</th>' +
                        '<th>İşlem Tarihi</th>' +
                        '</tr>' +
                        '</thead>' +
                        '<tbody id="Tbody_' + $(this).attr('Kullanıcı_Id') + '">' +
                        '</tbody>' +
                        '<tfoot>' +
                        ' <tr>' +
                        '<th></th>' +
                        '<th></th>' +
                        '</tr>' +
                        '</tfoot>' +
                        '</table>'
                    );



                    $.ajax({
                        url: 'Bs-Anasayfa.aspx/Son_Yapılan_İslem',
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'parametre': '" + "-" + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var temp = JSON.parse(data.d)

                            for (var i = 0; i < temp.length; i++) {

                                var Tbody = $('tbody[id=Tbody_' + temp[i].Kullanıcı_ıd + ']')
                             
                                Tbody.append(
                                    '<tr>' +
                                    '<td>' + temp[i].İşlem_Tipi+'</td>' +
                                    '<td>' + temp[i].İşlem_Tarihi + '</td>' +
                                    '</tr>' 
                                  
                                )
                              
                            }

                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                   
                })

                
                $('*#example').dataTable({

                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },

                });
         

               

            }//Promosyon_Getir
            function Urunleri_Doldur() {
                var Urun_1 = $('select[id=Urun_1]')
                var Urun_2 = $('select[id=Urun_2]')
                var Urun_3 = $('select[id=Urun_3]')
                $.ajax({
                    url: 'Takvim.aspx/Urunleri_Getir',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + "-" + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Urun_1.empty();
                        Urun_2.empty();
                        Urun_3.empty();
                        Urun_1.append('<option value="0" >Urunler</option>')
                        Urun_2.append('<option value="0" >Urunler</option>')
                        Urun_3.append('<option value="0" >Urunler</option>')

                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Urun_1.append('<option value="' + data.d.split('!')[b].split('-')[0] + '">' + data.d.split('!')[b].split('-')[1] + '</option >');

                            Urun_2.append('<option value="' + data.d.split('!')[b].split('-')[0] + '">' + data.d.split('!')[b].split('-')[1] + '</option >');

                            Urun_3.append('<option value="' + data.d.split('!')[b].split('-')[0] + '">' + data.d.split('!')[b].split('-')[1] + '</option >');
                            b++;
                        }


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            }
            var Ziyaret_Detay = $('a[id=Ziyaret_Detay]')

            Ziyaret_Detay.click(function () {


                var Doktor_Ziyaret_Tablo = $('tbody[id=Doktor_Ziyaret_Tablo]')
                var Eczane_Ziyaret_Tablo = $('tbody[id=Eczane_Ziyaret_Tablo]')
                $.ajax({
                    url: 'Bs-Anasayfa.aspx/Ziyaret_Tablosu',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'parametre': '" + $(this).attr("value") + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)

                        if (temp.length > 0) {
                            Doktor_Ziyaret_Tablo.empty();
                            Eczane_Ziyaret_Tablo.empty();

                            for (var i = 0; i < temp.length; i++) {
                                if (temp[i].Ziyaret_Detay_cins == "0") {
                                    var label_str = ""
                                    if (temp[i].Ziyaret_Durumu == "0") {//Ziyaret_Durumu

                                        label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                                    }
                                    else if (temp[i].Ziyaret_Durumu == "1") {
                                        label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
                                    }
                                    else if (temp[i].Ziyaret_Durumu == "2") {
                                        label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
                                    }


                                    Doktor_Ziyaret_Tablo.append("<tr><td>" + temp[i].Doktor_Ad + "</td><td>" + temp[i].Unite_Txt + "</td><td>" + temp[i].Brans_Txt + "</td><td>" + temp[i].TownName + "</td>" + label_str + "<td><a value='" + temp[i].Ziy_Dty_ID + "' data-toggle='modal' data-dismiss='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");

                                }
                                else {
                                    var label_str = ""
                                    if (temp[i].Ziyaret_Durumu == "0") {//Ziyaret_Durumu

                                        label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                                    }
                                    else if (temp[i].Ziyaret_Durumu == "1") {
                                        label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
                                    }
                                    else if (temp[i].Ziyaret_Durumu == "2") {
                                        label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
                                    }


                                    Eczane_Ziyaret_Tablo.append("<tr><td>" + temp[i].Eczane_Adı + "</td><td>" + temp[i].TownName + "</td>" + label_str + "<td><a value='" + temp[i].Ziy_Dty_ID + "' data-toggle='modal'data-dismiss='modal' data-target='#Ziyaret_Detay' id='Ziyareti_Güncelle'><i class='fa fa fa-search'></i></a></td></tr>");

                                }

                            }
                        }

                        $('div[id=Ziyaret_Modal]').modal('show')
                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });

            $(document).on('click', "a[id=Ziyareti_Güncelle]", function () {


                var Ziyaret_Durumu = $('select[id=Ziyaret_Durumu]')
                var Urun_1 = $('select[id=Urun_1]')
                var Urun_2 = $('select[id=Urun_2]')
                var Urun_3 = $('select[id=Urun_3]')
                var Ziyaret_notu = $('textarea[id=Ziyaret_notu]')
                var Ziyareti_Guncelle = $('button[id=Ziyareti_Guncelle_Btn]')
                Urun_1.empty();
                Urun_2.empty();
                Urun_3.empty();


                Ziyaret_notu.parent().removeAttr('class')
                Ziyaret_notu.parent().attr('class', 'form-group')

                Urun_1.parent().removeAttr('class')
                Urun_1.parent().attr('class', 'form-group')

                Urun_2.parent().removeAttr('class')
                Urun_2.parent().attr('class', 'form-group')

                Urun_3.parent().removeAttr('class')
                Urun_3.parent().attr('class', 'form-group')



                Ziyareti_Guncelle.attr('value', '' + $(this).attr('value') + '')

                $.ajax({
                    url: 'Takvim.aspx/Ziyaret_Detay',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).attr('value') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Urun_1.removeAttr('disabled')
                        Urun_2.removeAttr('disabled')
                        Urun_3.removeAttr('disabled')



                        if (data.d == "0") {

                            $("#Ziyaret_Durumu option[value='0']").attr("selected", true);

                            Urun_1.attr('disabled', 'disabled')
                            Urun_2.attr('disabled', 'disabled')
                            Urun_3.attr('disabled', 'disabled')
                            Ziyaret_notu.attr('disabled', 'disabled')
                            Ziyaret_notu.val("")
                        }
                        if (data.d == "1") {


                            $("#Ziyaret_Durumu").val('1')
                            Urun_1.removeAttr('disabled')
                            Urun_2.removeAttr('disabled')
                            Urun_3.removeAttr('disabled')
                            Ziyaret_notu.removeAttr('disabled')
                            Ziyaret_notu.val("")
                            Urunleri_Doldur()
                            $.ajax({
                                url: 'Takvim.aspx/Ziyaret_Detayını_Getir',
                                dataType: 'json',
                                async: true,
                                type: 'POST',
                                data: "{'parametre': '" + $('button[id=Ziyareti_Guncelle_Btn]').attr('value') + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {
                                    $("#Urun_1 option[value='" + data.d.split('-')[0] + "']").attr("selected", true);
                                    $("#Urun_2 option[value='" + data.d.split('-')[1] + "']").attr("selected", true);
                                    $("#Urun_3 option[value='" + data.d.split('-')[2] + "']").attr("selected", true);
                                    Ziyaret_notu.val(data.d.split('-')[3])

                                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });




                        }
                        if (data.d == "2") {

                            $("#Ziyaret_Durumu").val('2')
                            Urun_1.attr('disabled', 'disabled')
                            Urun_2.attr('disabled', 'disabled')
                            Urun_3.attr('disabled', 'disabled')
                            Ziyaret_notu.removeAttr('disabled')
                            Ziyaret_notu.val("")
                            $.ajax({
                                url: 'Takvim.aspx/Ziyaret_Detayını_Getir',
                                dataType: 'json',
                                async: true,
                                type: 'POST',
                                data: "{'parametre': '" + $('button[id=Ziyareti_Guncelle_Btn]').attr('value') + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {

                                    Ziyaret_notu.val(data.d.split('-')[3])

                                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });
                        }


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            });

            var Ziyaret_Modal_kapat = $('button[id=Ziyareti_Guncelle_Btn]')

            var Doktor_Data = [];
            var Eczane_Data = [];
            $.ajax({
                url: 'Bs-Anasayfa.aspx/Ziyaret_Grafik_Doldur',
                type: 'POST',
                data: "{'parametre': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var temp = JSON.parse(data.d)
                    Doktor_Data.push(temp[0].Edilen)
                    Doktor_Data.push(temp[0].Bekleyen)
                    Doktor_Data.push(temp[0].Edilmeyen)

                    Eczane_Data.push(temp[1].Edilen)
                    Eczane_Data.push(temp[1].Bekleyen)
                    Eczane_Data.push(temp[1].Edilmeyen)



                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });



            var ctx = document.getElementById('Ziyaret_Edilecek_Doktor');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Ziyaret Edilen Doktor', 'Ziyaret Bekleyen Doktor', 'Ziyaret Edilemeyen Doktor'],
                    datasets: [{
                        height: 10,
                        width: 10,
                        data: Doktor_Data,
                        backgroundColor: [
                            'rgba(0, 166, 90, 0.4)',
                            'rgba(243, 156, 18, 0.65)',
                            'rgba(221, 75, 57, 0.65)',
                        ],
                        borderColor: [
                            'rgba(0, 166, 90, 1)',

                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    tooltips: {
                        callbacks: {
                            label: function (tooltipItem) {
                                return tooltipItem.yLabel;
                            }
                        }
                    },

                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                            }
                        }]
                    }
                }
            });
            var ctx = document.getElementById('Ziyaret_Edilecek_Eczane');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Ziyaret Edilen Eczane', 'Ziyaret Bekleyen Eczane', 'Ziyaret Edilemeyen Eczane'],
                    datasets: [{
                        height: 10,
                        width: 10,
                        data: Eczane_Data,
                        backgroundColor: [
                            'rgba(26, 213, 255, 0.60)',
                            'rgba(243, 156, 18, 0.65)',
                            'rgba(221, 75, 57, 0.65)',
                        ],
                        borderColor: [
                            'rgba(26, 213, 255, 1)',
                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    tooltips: {
                        callbacks: {
                            label: function (tooltipItem) {
                                return tooltipItem.yLabel;
                            }
                        }
                    },

                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                            }
                        }]
                    }
                }
            });

            $('#Ziyaret_Detay').on('hidden.bs.modal', function () {
                $('div[id=Ziyaret_Modal]').modal('show')
            })


            var Adet_Labels = [];
            var Adet_Data = [];
            $.ajax({
                url: 'Bs-Anasayfa.aspx/Adet_Tablo_Doldur',
                type: 'POST',
                data: "{'parametre': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    for (var i = 0; i < temp.length; i++) {
                        Adet_Labels.push(temp[i].Gun)
                        Adet_Data.push(temp[i].Adet)
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            var ctx = document.getElementById('Bu_Ay_Toplam_Siparişlerim');
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: Adet_Labels,
                    datasets: [{
                        fill: false,
                        height: 10,
                        width: 10,
                        data: Adet_Data,
                        backgroundColor: [
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',


                        ],
                        borderColor: [
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',

                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    tooltips: {
                        callbacks: {
                            label: function (tooltipItem) {
                                return tooltipItem.yLabel;
                            }
                        }
                    },

                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            });
            var Ciro_Labels = [];
            var Ciro_Data = [];

            $.ajax({
                url: 'Bs-Anasayfa.aspx/Ciro_Tablo_Doldur',
                type: 'POST',
                data: "{'parametre': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var temp = JSON.parse(data.d)


                    for (var i = 0; i < temp.length; i++) {
                        Ciro_Labels.push(temp[i].Gun)
                        Ciro_Data.push(parseInt(temp[i].Ciro))
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            var ctx = document.getElementById('Bu_Ay_Toplam_Cirom');
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: Ciro_Labels,
                    datasets: [{
                        fill: false,
                        height: 10,
                        width: 10,
                        data: Ciro_Data,
                        backgroundColor: [
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',


                        ],
                        borderColor: [
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',

                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    tooltips: {
                        callbacks: {
                            label: function (tooltipItem) {
                                return tooltipItem.yLabel;
                            }
                        }
                    },

                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                callback: function (value, index, values) {
                                    return value + '₺';
                                }

                            }
                        }]
                    }
                }
            });











            var Koçluk_Formu_Modal_Aç = $('a[id=Koçluk_Formu_Modal_Aç]');
            Koçluk_Formu_Modal_Aç.click(function () {
                $('#Koçluk_Formu_Modal').modal('show');
                $('#Koçluk_Formu_Modal').find('button[id=Koçluk_Formu_Modal_Formu_Gönder]').attr('value', $(this).attr('value'))


                $('[name*=Resim_Ekle_Button_Name_]').each(function () {
                    var Dış = $(this).parent().parent().parent().find('div[id*=Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim]')
                    Dış.empty();
                })

                $('*#Soru_TextBox').each(function () {
                    $(this).val('')
                })



                $('*#Soru_Cevap_Select').each(function () {
                    $(this).val('0')
                   
                })

            });



            $.ajax({
                url: 'Bs-Anasayfa.aspx/Koçluk_Formu_Soru',
                type: 'POST',
                data: "{'parametre': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var Koçluk_Formu_Soruları = $('div[id=Koçluk_Formu_Soruları]')
                    var temp = JSON.parse(data.d)

                    $.ajax({
                        url: 'Bs-Anasayfa.aspx/Koçluk_Formu_Soru_Baslık',
                        type: 'POST',
                        data: "{'parametre': ''}",
                        async: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var temp = JSON.parse(data.d)
                            var Koçluk_Formu_Soruları = $('div[id=Koçluk_Formu_Soruları]')

                            for (var i = 0; i < temp.length; i++) {
                                var myvar = '<div class="row">' +
                                    '                                <div class="col-xs-12" style="text-align: center">' +
                                    '                                    <label>' + temp[i].Baslık_Txt + '</label>' +
                                    '                                </div>' +
                                    '                            </div>';
                                Koçluk_Formu_Soruları.append(myvar)
                                Koçluk_Formu_Soruları.append('<div id="Koçluk_Formu_Baslık_' + temp[i].Koçluk_Formu_Soru_Başlık_Id + '">')

                                Koçluk_Formu_Soruları.append('</div>')
                            }


                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                    for (var i = 0; i < temp.length; i++) {

                        var Soru = '';

                        if (temp[i].Soru_Cins == "1") {


                            var Soru = '<div class="row">' +
                                '                            <div class="col-xs-12">' +
                                '                                <label>' + temp[i].Soru_Text + '</label>' +
                                '                            </div>' +
                                '                        </div>' +
                                '                        <div class="row">' +
                                '                            <div class="col-xs-10">' +
                                '                                <div class="form-group">' +
                                '                                <select Soru_Id="' + temp[i].Koçluk_Formu_Soru_Id + '" id="Soru_Cevap_Select" class="form-control">' +
                                '                                        <option value="0">Lütfen Bir Derece Seçiniz</option>' +
                                '                                        <option value="1">Zayıf</option>' +
                                '                                        <option value="2">Gelişmeli</option>' +
                                '                                        <option value="3">Orta</option>' +
                                '                                        <option value="4">İyi</option>' +
                                '                                        <option value="5">Çok İyi</option>' +
                                '                                    </select>' +
                                '                                </div>' +
                                '                            </div>' +
                                '                            <div class="col-xs-2">' +
                                '                                <fieldset class="form-group">' +
                                '                                    <a href="javascript:void(0)" name="Resim_Ekle_Button_Name_' + temp[i].Koçluk_Formu_Soru_Id +'" class="btn btn-block btn-default" onclick="$(\'#input_Button_' + temp[i].Koçluk_Formu_Soru_Id + '\').click()">Resim Ekle</a>' +
                                '                                    <input Soru_Id="' + temp[i].Koçluk_Formu_Soru_Id + '" type="file" id="input_Button_' + temp[i].Koçluk_Formu_Soru_Id + '" name="pro-image" accept="image/*" style="display: none;" class="form-control" multiple />' +
                                '                                </fieldset>' +
                                '                            </div>' +
                                '                            <div id="Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim' + temp[i].Koçluk_Formu_Soru_Id + '"></div>' +
                                '                        </div>';


                            var Koçluk_Formu_Soruları_Baslık = Koçluk_Formu_Soruları.find('div[id=Koçluk_Formu_Baslık_' + temp[i].Soru_Baslık + ']')
                            Koçluk_Formu_Soruları_Baslık.append(Soru)

                            $(".preview-images-zone").sortable();

                            $(document).on('click', '#Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Cancel', function () {

                                let no = $(this).data('no');
                                $(this).parent().remove();
                               

                            });

                            var pro_image = $('#input_Button_' + temp[i].Koçluk_Formu_Soru_Id)
                            pro_image.change(function () {
                                var Resimler = $('div[id=Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim' + $(this).attr('Soru_Id') + ']')
                                var Tekrarmı = Resimler.find('div[id=Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Zone_' + $(this).attr('Soru_Id') + ']').each(function () { }).length
                                if (Tekrarmı<1) {
                                    var myvar = '<div class="col-xs-12">' +
                                        '                                <div class="preview-images-zone" id="Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Zone_' + $(this).attr('Soru_Id') + '" style>' +
                                        '                                </div>' +
                                        '                            </div>';
                                    var Resimler = $('div[id=Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim' + $(this).attr('Soru_Id') + ']')
                                    Resimler.append(myvar)
                                }
                              
                            });


                            var Buton_id = 'input_Button_' + temp[i].Koçluk_Formu_Soru_Id
                            document.getElementById(Buton_id).addEventListener('change', function () {

                                var num_1 = 0;
                                if (window.File && window.FileList && window.FileReader) {
                                    var files = event.target.files; //FileList object
                                    var output = $("#Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Zone_" + $(this).attr('Soru_Id'));
                                    var Soru_İd = $(this).attr('Soru_Id')
                                    for (let i = 0; i < files.length; i++) {
                                        var file = files[i];
                                        if (!file.type.match('image')) continue;

                                        var picReader = new FileReader();

                                        picReader.addEventListener('load', function (event) {
                                            var picFile = event.target;
                                            var html = '<div id="Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Zone_Silmek_için_' + Soru_İd + '_' + num_1 + '" class="preview-image">' +
                                                '<div id="Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Cancel" Soru_Id="' + Soru_İd + '" class="image-cancel" data-no="' + num_1 + '">x</div>' +
                                                '<div class="image-zone"><img Soru_Id="' + Soru_İd + '" id="Resimli_Soru" src="' + picFile.result + '"></div>' +

                                                '</div>';

                                            output.append(html);
                                            num_1 = num_1 + 1;
                                        });

                                        picReader.readAsDataURL(file);
                                        var reader = new FileReader();
                                        reader.onload = function (e) {
                                            var binaryString;// = e.target.result;
                                            if (!e) {
                                                binaryString = reader.content;
                                            }
                                            else {
                                                binaryString = e.target.result;
                                            }
                                            resim = "";
                                            resim = window.btoa(binaryString);

                                            var obj = {
                                                id: num_1,
                                                resim
                                            }



                                            



                                        };
                                        reader.readAsBinaryString(file);
                                    }
                                    $("#pro-image").val('');

                                } else {
                                    console.log('Browser not support');
                                }
                            }

                                , false);


                        }

                        if (temp[i].Soru_Cins == "2") {

                            Soru = '<div class="row">' +
                                '                        <div class="col-xs-12">' +
                                '                            <label>' + temp[i].Soru_Text + '</label>' +
                                '                        </div>' +
                                '                    </div>' +
                                '' +
                                '                    <div class="row">' +
                                '                        <div class="col-xs-12">' +
                                '                            <div class="form-group">' +
                                '' +
                                '                                <select Soru_Id="' + temp[i].Koçluk_Formu_Soru_Id + '" id="Soru_Cevap_Select" class="form-control">' +
                                '                                    <option value="0">Lütfen Bir Derece Seçiniz</option>' +
                                '                                    <option value="1">Zayıf</option>' +
                                '                                    <option value="2">Gelişmeli</option>' +
                                '                                    <option value="3">Orta</option>' +
                                '                                    <option value="4">İyi</option>' +
                                '                                    <option value="5">Çok İyi</option>' +
                                '                                </select>' +
                                '                            </div>' +
                                '                        </div>' +
                                '                    </div>';




                            var Koçluk_Formu_Soruları_Baslık = Koçluk_Formu_Soruları.find('div[id=Koçluk_Formu_Baslık_' + temp[i].Soru_Baslık + ']')
                            Koçluk_Formu_Soruları_Baslık.append(Soru)

                        }
                        if (temp[i].Soru_Cins == "3") {



                            var myvar = '<div class="row">' +
                                '                        <div class="col-xs-12">' +
                                '                            <label>' + temp[i].Soru_Text + '</label>' +
                                '                        </div>' +
                                '                    </div>' +
                                '                    <div class="row">' +
                                '                        <div class="col-xs-12">' +
                                '                            <div class="form-group">' +
                                '                                <textarea class="form-control" Soru_Id="' + temp[i].Koçluk_Formu_Soru_Id + '" id="Soru_TextBox" rows="3"></textarea>' +
                                '                            </div>' +
                                '                        </div>' +
                                '                    </div>';

                            var Koçluk_Formu_Soruları_Baslık = Koçluk_Formu_Soruları.find('div[id=Koçluk_Formu_Baslık_' + temp[i].Soru_Baslık + ']')
                            Koçluk_Formu_Soruları_Baslık.append(myvar)

                        }



                    }










                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });









            var Koçluk_Formu_Modal_Formu_Gönder = $('button[id=Koçluk_Formu_Modal_Formu_Gönder]')
            Koçluk_Formu_Modal_Formu_Gönder.click(function () {
              
                var Gönderilsinmi = true;

                var Gogderilecek_Class = {
                   
                    Puanlamalar: [
                    ],

                    Textboxlar: [],
                }
                $('[name*=Resim_Ekle_Button_Name_]').each(function () {
                    var Dış = $(this).parent().parent().parent().find('div[id*=Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim]')
            
                    var iç = Dış.find('div[id*=Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Zone_]')
                    var iç_resim = iç.find('img[id=Resimli_Soru]').each(function () { }).length
                    if (Dış.html() == "") {
                        $(this).attr('class', 'btn btn-danger')
                        Gönderilsinmi = false;
                    }
                    else {
                        $(this).attr('class', 'btn btn-default')
                    }
                    if (iç_resim < 1) {
                        Gönderilsinmi = false;
                        $(this).attr('class', 'btn btn-danger')
                    }
                    else {
                        $(this).attr('class', 'btn btn-default')
                    }
                  

                }).length
                
                $('*#Soru_TextBox').each(function () {

                    if ($(this).val() == "") {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class','form-group has-error')

                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }
                    var obj = {};
                    obj['Soru_Id'] = $(this).attr('soru_id');
                    obj['Notlar'] = $(this).val();


                    Gogderilecek_Class.Textboxlar.push(obj)

                }).length

               
                console.log(Gogderilecek_Class.Resimler)
                $('*#Soru_Cevap_Select').each(function () {
                    if ($(this).val() == "0") {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }
                    var obj = {};
                    obj['Soru_Id'] = $(this).attr('soru_id');
                    obj['Cevap'] = $(this).find('option:selected').val();


                    Gogderilecek_Class.Puanlamalar.push(obj)
                }).length
               
                
              

                //#region 
                if (Gönderilsinmi==true) {
                    $.ajax({
                        url: 'Bs-Anasayfa.aspx/Koçluk_Formu_Soru_Gönder',
                        type: 'POST',
                        data: "{'Bilgiler': '" + JSON.stringify(Gogderilecek_Class) + "'," +

                            "'Kullanıcı_Id':'" + $(this).attr('value') + "'}",
                        async: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            var temp = JSON.parse(data.d)

                            $('*#Resimli_Soru').each(function () {
                                var Koçluk_Formu_Detay_Id_ = "";
                                for (var i = 0; i < temp.length; i++) {
                                    if (temp[i].Koçluk_Formu_Soru_Id == $(this).attr('soru_id')) {
                                        Koçluk_Formu_Detay_Id_= temp[i].Koçluk_Formu_Detay_Id
                                    }
                                }
                                $.ajax({
                                    url: 'Bs-Anasayfa.aspx/Koçluk_Formu_Resimleri_Db_Yaz',
                                    type: 'POST',
                                    data: "{'Koçluk_Formu_Detay_Id': '" + Koçluk_Formu_Detay_Id_ + "'," +
                                        "'Src':'" + $(this).attr('src') + "'}",
                                    async: false,
                                    dataType: "json",
                                    contentType: "application/json; charset=utf-8",
                                    success: function (data) {



                                    },
                                    error: function () {

                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }

                                });

                            });



                            $('#Koçluk_Formu_Modal').modal('toggle')

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });


                }
               
                //#endregion

              // $('#Koçluk_Formu_Modal').modal('toggle')
                
           });

        });
        

       
    </script>
    <style>
        .preview-images-zone {
            width: 100%;
            border: 1px solid #ddd;
            min-height: 180px;
            display: flex;
            padding: 5px 5px 0px 5px;
            position: relative;
            overflow: auto;
        }

            .preview-images-zone > .preview-image:first-child {
                height: 25%;
                width: 25%;
                position: relative;
                margin-right: 5px;
            }

            .preview-images-zone > .preview-image {
                height: 10%;
                width: 10%;
                position: relative;
                margin-right: 5px;
                float: left;
                margin-bottom: 5px;
            }

                .preview-images-zone > .preview-image > .image-zone {
                    width: 100%;
                    height: 100%;
                }

                    .preview-images-zone > .preview-image > .image-zone > img {
                        width: 100%;
                        height: 100%;
                    }

                .preview-images-zone > .preview-image > .tools-edit-image {
                    position: absolute;
                    z-index: 100;
                    color: #fff;
                    bottom: 0;
                    width: 100%;
                    text-align: center;
                    margin-bottom: 10px;
                    display: none;
                }

                .preview-images-zone > .preview-image > .image-cancel {
                    font-size: 18px;
                    position: absolute;
                    top: 0;
                    right: 0;
                    font-weight: bold;
                    margin-right: 10px;
                    cursor: pointer;
                    display: none;
                    z-index: 100;
                }

        .preview-image:hover > .image-zone {
            cursor: move;
            opacity: .5;
        }

        .preview-image:hover > .tools-edit-image,
        .preview-image:hover > .image-cancel {
            display: block;
        }

        .ui-sortable-helper {
            width: 90px !important;
            height: 90px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Koçluk_Formu_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Koçluk_Formu_Modal_Baslık" class="modal-title">Koçluk Formu</h4>
                </div>
                <div class=" modal-body">

                    <div id="Koçluk_Formu_Soruları">
                       
                    </div>
                </div>
             

                <div class="modal-footer">
                    <button type="button" id="Koçluk_Formu_Modal_Kapat" class="btn btn-default" data-dismiss="modal">Kapat</button>
                    <button type="button" id="Koçluk_Formu_Modal_Formu_Gönder" class="btn btn-primary">Formu Gönder</button>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div id="Ziyaret_Detay" class="modal fade" tabindex="-2" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Modal Header</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Ziyaret Durumu</label>
                            <select id="Ziyaret_Durumu" class="form-control">
                                <option value="0">Ziayeret Bekleniyor</option>
                                <option value="1">Ziayeret Edildi</option>
                                <option value="2">Ziyaret Edilmedi</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Çalışılan Ürün 1</label>
                            <select id="Urun_1" class="form-control">
                                <option>Ürünler</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Çalışılan Ürün 2</label>
                            <select id="Urun_2" class="form-control">
                                <option>Ürünler</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Çalışılan Ürün 3</label>
                            <select id="Urun_3" class="form-control">
                                <option>Ürünler</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Ziyaret Notu</label>
                            <textarea id="Ziyaret_notu" class="form-control" rows="3" placeholder="Lütfen Bir not bırakınız ..."></textarea>
                        </div>


                    </div>
                    <div class="modal-footer">
                        <button type="button" id="Ziyareti_Guncelle_Btn" class="btn btn-default" data-dismiss="modal">Kapat</button>
                    </div>
                </div>

            </div>
        </div>

        <div id="Ziyaret_Modal" class="modal fade" role="dialog">
            <div class="modal-dialog modal-lg">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 id="Modal_başlık" class="modal-title">Ziyaret Edilecek Doktor/Eczane</h4>
                    </div>
                    <div id="Modal_Body" class="modal-body">
                        <div class="box box-default collapsed-box">
                            <div style="background-color: #d2d6de !important" class="box-header with-border">
                                <h3 class="box-title">Ziyaret Edilecek Doktorlar</h3>

                                <div class="box-tools pull-right">
                                    <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                                <!-- /.box-tools -->
                            </div>
                            <!-- /.box-header -->

                            <div id="Doktor_Body" class="box-body" style="display: none;">
                                <div class="box">

                                    <div class="box-body table-responsive no-padding">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Doktor Adı</th>
                                                    <th>Unite</th>
                                                    <th>Branş</th>
                                                    <th>Brick</th>
                                                    <th>Ziyaret Durumu</th>
                                                    <th>İncele</th>
                                                </tr>
                                            </thead>
                                            <tbody id="Doktor_Ziyaret_Tablo">
                                                <tr>
                                                    <td style="text-align: center; background-color: #f9f9f9;" colspan="6">Tabloda herhangi bir veri mevcut değil </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                        <div class="box box-default collapsed-box">
                            <div style="background-color: #d2d6de !important" class="box-header with-border">
                                <h3 class="box-title">Ziyaret Edilecek Eczaneler</h3>

                                <div class="box-tools pull-right">
                                    <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                                <!-- /.box-tools -->
                            </div>
                            <!-- /.box-header -->
                            <div id="Eczane_Body" class="box-body" style="display: none;">

                                <div class="box">

                                    <div class="box-body table-responsive no-padding">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Eczane Adı</th>
                                                    <th>Brick</th>
                                                    <th>Ziyaret Durumu</th>
                                                    <th>İncele</th>

                                                </tr>
                                            </thead>
                                            <tbody id="Eczane_Ziyaret_Tablo">

                                                <tr>
                                                    <td style="text-align: center; background-color: #f9f9f9;" colspan="6">Tabloda herhangi bir veri mevcut değil </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- /.box-body -->
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="Ziyaret_Modal_kapat" class="btn btn-default" data-dismiss="modal">Kapat</button>
                    </div>
                </div>

            </div>
        </div>

        <div class="col-lg-6 col-lg-12">
            <div class="box">
                <div class="box-header with-border">
                    <i class="fa fa-bar-chart-o"></i>

                    <h3 class="box-title">Bu Ay Yaptığın Toplam Adet Tablosu</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="card">
                        <div class="card-body">
                            <canvas id="Bu_Ay_Toplam_Siparişlerim"></canvas>
                        </div>
                    </div>
                </div>
                <!-- /.box-body-->
            </div>
        </div>
        <div class="col-lg-6 col-lg-12">
            <div class="box">
                <div class="box-header with-border">
                    <i class="fa fa-bar-chart-o"></i>

                    <h3 class="box-title">Bu Ay Yaptığın Toplam Ciro Tablosu</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="card">
                        <div class="card-body">
                            <canvas id="Bu_Ay_Toplam_Cirom"></canvas>
                        </div>
                    </div>
                </div>
                <!-- /.box-body-->
            </div>
        </div>
        <div class="col-lg-6 col-xs-12">
            <div class="box">
                <div class="box-header with-border">
                    <i class="fa fa-bar-chart-o"></i>

                    <h3 class="box-title">Bugünkü Ziyaret Edilecek Doktorlar</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="card">
                        <div class="card-body">
                            <canvas id="Ziyaret_Edilecek_Doktor"></canvas>
                        </div>
                    </div>
                </div>
                <!-- /.box-body-->
            </div>
        </div>
        <div class="col-lg-6 col-xs-12">
            <div class="box">
                <div class="box-header with-border">
                    <i class="fa fa-bar-chart-o"></i>

                    <h3 class="box-title">Bugünkü Ziyaret Edilecek Eczaneler</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="card">
                        <div class="card-body">
                            <canvas id="Ziyaret_Edilecek_Eczane"></canvas>
                        </div>
                    </div>
                </div>
                <!-- /.box-body-->
            </div>
        </div>
    </div>

    <div class="row">
        <div id="Kullanıcılar">
        </div>
    </div>


</asp:Content>
