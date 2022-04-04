<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Eczane-Ara.aspx.cs" Inherits="deneme9.Eczane_Ara" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {

            var Eczane_Listesi = $('select[id=Eczane_Listesi]');
            var Şehir_Listesi = $('select[id=Şehir_Listesi]');
            var Brick_Listesi = $('select[id=Brick_Listesi]');
            var Eczane_Adı = $('select[id=Eczane_Adı]');

            $.ajax({
                url: 'Eczane-Ara.aspx/Eczane_Listeleri', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Eczane_Listesi.empty();
                    var parsdata = JSON.parse(data.d)

                    for (var i = 0; i < parsdata.length; i++) {
                        Eczane_Listesi.append("<option value='" + parsdata[i].Liste_Id + "'>" + parsdata[i].Lİste_Adı + "</option>");
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            $.ajax({
                url: 'Eczane-Ara.aspx/Şehir_Listesi', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Şehir_Listesi.empty();
                    Şehir_Listesi.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")

                    var parsdata = JSON.parse(data.d)

                    for (var i = 0; i < parsdata.length; i++) {
                        Şehir_Listesi.append("<option value='" + parsdata[i].Şehir_Id + "'>" + parsdata[i].Şehir_Adı + "</option>");
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Şehir_Listesi.change(function () {

                $.ajax({
                    url: 'Eczane-Ara.aspx/Brick_Listesi', //doktorları listelerken tersten listele 
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Şehir_Id': '" + $(this).find('option:selected').attr("value") + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Brick_Listesi.empty();
                        Brick_Listesi.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
                        var parsdata = JSON.parse(data.d)

                        for (var i = 0; i < parsdata.length; i++) {
                            Brick_Listesi.append("<option value='" + parsdata[i].Brick_Id + "'>" + parsdata[i].Brick_Adı + "</option>");
                        }
                        if (Şehir_Listesi.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Şehir_Listesi.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            });

            Brick_Listesi.change(function () {

                $.ajax({
                    url: 'Eczane-Ara.aspx/Eczane_Adı_Listesi',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Eczane_Liste_Id': '" + Eczane_Listesi.find('option:selected').attr("value") + "'" +
                        ",'Eczane_Brick_Id':'" + Brick_Listesi.find('option:selected').attr("value") + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Adı.empty();
                        Eczane_Adı.append("<option>-->> Lütfen Eczane Adı Seçiniz <<--</option>");
                        var parsdata = JSON.parse(data.d)

                        for (var i = 0; i < parsdata.length; i++) {
                            Eczane_Adı.append("<option value='" + parsdata[i].Eczane_Id + "'>" + parsdata[i].Eczane_Adı + "</option>");
                        }
                        if (Brick_Listesi.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Brick Seçiniz &lt;&lt;--") {
                            Brick_Listesi.parent().children().find($("select option:first-child")).remove();
                        }

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });
            Eczane_Adı.change(function () {

                if (Eczane_Adı.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Eczane Adı Seçiniz &lt;&lt;--") {
                    Eczane_Adı.parent().children().find($("select option:first-child")).remove();
                }
            });
            var Seçili_Eczaneye_Git = $('button[id=Seçili_Eczaneye_Git]')
            Seçili_Eczaneye_Git.click(function () {
                var Eczane_Adı = $('select[id=Eczane_Adı]');
                if (Eczane_Adı.find('option:selected').attr('value') != "" && Eczane_Adı.find('option:selected').attr('value') != undefined && Eczane_Adı.find('option:selected').attr('value') != "0" && Eczane_Adı.parent().children().find($("select option:first-child")).html() != "--&gt;&gt; Lütfen Eczane Adı Seçiniz &lt;&lt;--") {
                    window.location.href = '/Siparis-Olustur.aspx?Eczane_Id=' + Eczane_Adı.find('option:selected').attr("value") + '';

                }

            });






       
            var Şehir_Listesi_Normal = $('select[id=Şehir_Listesi_Normal]');
            var Brick_Listesi_Normal = $('select[id=Brick_Listesi_Normal]');
            var Eczane_Adı_Normal = $('select[id=Eczane_Adı_Normal]');

         

            $.ajax({
                url: 'Eczane-Ara.aspx/Şehir_Listesi', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Şehir_Listesi_Normal.empty();
                    Şehir_Listesi_Normal.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")

                    var parsdata = JSON.parse(data.d)

                    for (var i = 0; i < parsdata.length; i++) {
                        Şehir_Listesi_Normal.append("<option value='" + parsdata[i].Şehir_Id + "'>" + parsdata[i].Şehir_Adı + "</option>");
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Şehir_Listesi_Normal.change(function () {

                $.ajax({
                    url: 'Eczane-Ara.aspx/Brick_Listesi', //doktorları listelerken tersten listele 
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Şehir_Id': '" + $(this).find('option:selected').attr("value") + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Brick_Listesi_Normal.empty();
                        Brick_Listesi_Normal.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
                        var parsdata = JSON.parse(data.d)

                        for (var i = 0; i < parsdata.length; i++) {
                            Brick_Listesi_Normal.append("<option value='" + parsdata[i].Brick_Id + "'>" + parsdata[i].Brick_Adı + "</option>");
                        }
                        if (Şehir_Listesi_Normal.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Şehir_Listesi_Normal.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            });

            Brick_Listesi_Normal.change(function () {

                $.ajax({
                    url: 'Eczane-Ara.aspx/Eczane_Adı_Listesi_Seçmesiz',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Eczane_Liste_Id': '1'" +
                        ",'Eczane_Brick_Id':'" + Brick_Listesi_Normal.find('option:selected').attr("value") + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Adı_Normal.empty();
                        Eczane_Adı_Normal.append("<option>-->> Lütfen Eczane Adı Seçiniz <<--</option>");
                        var parsdata = JSON.parse(data.d)

                        for (var i = 0; i < parsdata.length; i++) {
                            Eczane_Adı_Normal.append("<option value='" + parsdata[i].Eczane_Id + "'>" + parsdata[i].Eczane_Adı + "</option>");
                        }
                        if (Brick_Listesi_Normal.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Brick Seçiniz &lt;&lt;--") {
                            Brick_Listesi_Normal.parent().children().find($("select option:first-child")).remove();
                        }

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });
            Eczane_Adı_Normal.change(function () {

                if (Eczane_Adı_Normal.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Eczane Adı Seçiniz &lt;&lt;--") {
                    Eczane_Adı_Normal.parent().children().find($("select option:first-child")).remove();
                }
            });
            var Seçili_Eczaneye_Git_Normal = $('button[id=Seçili_Eczaneye_Git_Normal]')
            Seçili_Eczaneye_Git_Normal.click(function () {
           
                var Eczane_Adı_Normal = $('select[id=Eczane_Adı_Normal]');
                if (Eczane_Adı_Normal.find('option:selected').attr('value') != "" && Eczane_Adı_Normal.find('option:selected').attr('value') != undefined && Eczane_Adı_Normal.find('option:selected').attr('value') != "0" && Eczane_Adı_Normal.parent().children().find($("select option:first-child")).html() != "--&gt;&gt; Lütfen Eczane Adı Seçiniz &lt;&lt;--") {
                    window.location.href = '/Siparis-Olustur.aspx?Eczane_Id=' + Eczane_Adı_Normal.find('option:selected').attr("value") + '';

                }

            });


            $("select[name=Şehir_Adı_Select2]").select2({
                placeholder: "Şehir Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })

            $("select[name=Semt_Adı_Select2]").select2({
                placeholder: "Brick Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })

            $.ajax({
                url: 'Doktor-Listesi-Olustur.aspx/Geçmiş_Şehir',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Şehir_Adı_Select2 = $('select[id=Şehir_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Şehir_Adı_Select2.append('<option value="' + temp[i].Şehir_Adı + '">' + temp[i].Şehir_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            //Brick Brick
            $.ajax({
                url: 'Doktor-Listesi-Olustur.aspx/Geçmiş_Brick',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Semt_Adı_Select2 = $('select[id=Semt_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Semt_Adı_Select2.append('<option value="' + temp[i].Brick_Adı + '">' + temp[i].Brick_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            var Liste_ = []
            Listeyi_Doldur_Arama(Liste_);
            function Listeyi_Doldur_Arama(Liste_) {
                $('#Tablo_Arama_Div').empty();

                $('#Tablo_Arama_Div').append('<table id="Arama_Table" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +

                    '                                            <th>Ad</th>' +
                    '                                            <th>Eczacı Adı</th>' +
                    '                                            <th>İl</th>' +
                    '                                            <th>Brick</th>' +
                    '                                            <th>Git</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Arama_Body">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );




                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Arama_Body]')

                    for (var i = 0; i < Liste_.length; i++) {

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Doktor_Ad + '</td>' +
                            '<td>' + Liste_[i].Eczacı_Adı + '</td>' +
                            '<td>' + Liste_[i].CityName + '</td>' +
                            '<td>' + Liste_[i].TownName + '</td>' +
                            '<td>' + '<a value="' + Liste_[i].Doktor_Id + '" id="Doktoru_Ekle"><i class="fa fa fa-search"></i></a>' + '</td>' +

                            '</tr>'
                        )
                    }


                }



                $('#Arama_Table').dataTable({
                    "lengthMenu": [5, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    }
                });

                var Doktoru_Kaldır = $('a[id=Doktoru_Ekle]');
                Doktoru_Kaldır.click(function () {
                    
                    window.location.href = '/Siparis-Olustur.aspx?Eczane_Id=' + $(this).attr('value') + '';

                });
            }
            $('button[id=Ara_Btn]').click(function () {

                var Şehir_Adı_Select2 = $('select[id=Şehir_Adı_Select2]')
                var Semt_Adı_Select2 = $('select[id=Semt_Adı_Select2]')

                //#region Urun_Adı



                //#endregion

                //#region Şehir

                var Şehir_Liste = [];
                if (Şehir_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Şehir_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Urun_Adı: null
                        }
                        Urun_Adı_Class.Urun_Adı = Şehir_Adı_Select2.val()[i];
                        Şehir_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Urun_Adı: null
                    }
                    Urun_Adı_Class.Urun_Adı = null;
                    Şehir_Liste.push(Urun_Adı_Class)
                }


                //#endregion

                //#region Semt

                var Semt_Liste = [];
                if (Semt_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Semt_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Semt: null
                        }
                        Urun_Adı_Class.Semt = Semt_Adı_Select2.val()[i];
                        Semt_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Semt: null
                    }
                    Urun_Adı_Class.Semt = null;
                    Semt_Liste.push(Urun_Adı_Class)
                }
                //#endregion

                //#region Depo

                //#endregion

                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Doktor_Listele',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{" +
                        "'Şehir':'{Şehir_Liste:" + JSON.stringify(Şehir_Liste) + "}'," +
                        "'Semt':'{Semt_Liste:" + JSON.stringify(Semt_Liste) + "}'" +

                        "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste = [];
                        var temp = JSON.parse(data.d);

                        console.log(temp)
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                Doktor_Id: null,
                                Doktor_Ad: null,
                                Brans_Txt: null,
                                CityName: null,
                                TownName: null,
                                Unite_Txt: null,
                                Eczacı_Adı: null,
                            }
                            MyClass.Doktor_Id = temp[i].Doktor_Id;
                            MyClass.Doktor_Ad = temp[i].Doktor_Ad;

                            MyClass.CityName = temp[i].CityName;
                            MyClass.TownName = temp[i].TownName;
                            MyClass.Eczacı_Adı = temp[i].Eczacı_Adı;

                            Liste.push(MyClass);
                        }
                        Listeyi_Doldur_Arama(Liste);

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });








            })



        })


    </script>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-body">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label>Filtrele</label>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-6">
                                    <label>Şehir :</label>
                                </div>
                                <div class="col-xs-6">
                                    <label>Brick :</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <select name="Şehir_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Şehir_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-6">
                                    <select name="Semt_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Semt_Adı_Select2" multiple="multiple"></select>
                                </div>
                            </div>
                            <div class="row" style="">
                                <div class="col-xs-4 text-center">
                                    <label></label>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <button id="Ara_Btn" type="button" class="btn btn-block btn-info">Ara</button>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div id="Tablo_Arama_Div"></div>
                </div>
            </div>
        </div>
        
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label>Eczane Listesi</label>
                                <select id="Eczane_Listesi" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label>Şehir</label>
                                <select id="Şehir_Listesi" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label>Brick</label>
                                <select id="Brick_Listesi" class="form-control"></select>
                            </div>
                            <div class="form-group">
                                <label>Eczane Adı</label>
                                <select id="Eczane_Adı" class="form-control"></select>
                            </div>
                        </div>
                    </div>

                    <div class="box-footer">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <button id="Seçili_Eczaneye_Git" type="button" class="btn btn-block btn-info btn-lg">Seçili Eczaneye Git</button>
                                </div>
                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label>Şehir</label>
                                <select id="Şehir_Listesi_Normal" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label>Brick</label>
                                <select id="Brick_Listesi_Normal" class="form-control"></select>
                            </div>
                            <div class="form-group">
                                <label>Eczane Adı</label>
                                <select id="Eczane_Adı_Normal" class="form-control"></select>
                            </div>
                        </div>
                    </div>

                    <div class="box-footer">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <button id="Seçili_Eczaneye_Git_Normal" type="button" class="btn btn-block btn-info btn-lg">Seçili Eczaneye Git</button>
                                </div>
                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>
    </div>
</asp:Content>
