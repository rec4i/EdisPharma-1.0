<%@ Page Title="" Language="C#" MasterPageFile="~/b.Master" AutoEventWireup="true" CodeBehind="B-Anasayfa.aspx.cs" Inherits="deneme9.B_Anasayfa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>

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

            var Bölge = $('select[id=Bölge]')
            $.ajax({
                url: 'B-Tsm-Ziyaret-Raporlama.aspx/Bolge_Listesi',
                type: 'POST',
                data: "{'Şehir_Id': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsdata = JSON.parse(data.d)

                    Bölge.empty();

                    for (var i = 0; i < parsdata.length; i++) {
                        Bölge.append('<option value="' + parsdata[i].Bolge_Id + '">' + parsdata[i].Bolge_Ad + '</option>')
                    }


                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });
            try {
                if (window.location.href.split('?').length > 0) {
                    Bölge.val(window.location.href.split('?')[1].split('=')[1])
                }
            }
            catch (err) {
                Bölge.val(Bölge.find('option:first').attr('value'))

            }
            var Bölge_Secili = Bölge.find('option:selected').attr("value")
            var cal_set = $('input[id=cal_set]')
            cal_set.on('click', function () {
                var Bölge_Secili = Bölge.find('option:selected').attr("value")
                window.location.href = "B-Anasayfa.aspx?x=" + Bölge_Secili

            });

            
        
           
         
            
            $.ajax({
                url: 'B-Anasayfa.aspx/Tablo_Doldur',
                type: 'POST',
                data: "{'parametre':'" + Bölge_Secili + "'}",
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
                            '                    <li><a id="Ziyaret_Detay" value="' + temp[i].Kullanıcı_Id + '">Bugünkü Ziyaretleri (Detay İçin Tıklayın) <span class="pull-right badge bg-green">Toplam Ziyaret:  ' + temp[i].Bu_Gun_Ziy_Toplam + '</span></a></li>' +
                            '                     <li><a href="' + "/B-Tsm-Sipariş-Raporlama.aspx?x=" + Bu_Gün__ + "&y=" + Bu_Gün__ + "&z=" + temp[i].Kullanıcı_Id + "" + '">Bugünkü Verdiği Siparişleri (Detay İçin Tıklayın)<span class="pull-right badge bg-aqua">Toplam Sipariş:   ' + temp[i].Bu_Gun_Sip_Toplam + '</span></a></li>' +
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
                url: 'B-Anasayfa.aspx/Ziyaret_Grafik_Doldur',
                type: 'POST',
                data: "{'parametre': '" + Bölge_Secili+"'}",
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
                url: 'B-Anasayfa.aspx/Adet_Tablo_Doldur',
                type: 'POST',
                data: "{'parametre': '" + Bölge_Secili+"'}",
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
                url: 'B-Anasayfa.aspx/Ciro_Tablo_Doldur',
                type: 'POST',
                data: "{'parametre': '" + Bölge_Secili + "'}",
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

        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box">
        <div class="box-body">
            <div class="row">
                <div class="col-xs-12">
                    <label>Bölge</label>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-10">
                    <div class="form-group">
                        <%--// has-error--%>
                        <select id="Bölge" class="form-control">
                        </select>
                    </div>
                </div>
                <div class="col-xs-2 ">
                    <div class="form-group">
                        <input id="cal_set" type="button" class="btn btn-block btn-info" value="SET" />
                    </div>
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
