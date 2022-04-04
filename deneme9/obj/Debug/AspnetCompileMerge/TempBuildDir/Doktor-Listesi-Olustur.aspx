<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Doktor-Listesi-Olustur.aspx.cs" Inherits="deneme9.Doktor_Ekle_Cıkar1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {

            
            var Doktor_Yeni_Liste_Olustur_Modal_btn = $('button[id=Doktor_Yeni_Liste_Olustur_Modal_btn]'); //doktorları listelerken tersten listele 
            var Doktor_Liste_Olustur_Liste = $('select[id=Doktor_Liste_Olustur_Liste]');
            var Doktor_Yeni_Liste_Input = $('input[id=Doktor_Yeni_Liste_Input]');
            var Doktor_Listesi_Tablosu = $('table[id=Doktor_Listesi_Tablosu]');
            var Doktor_Liste_Ekle_btn = $('a[id=Doktor_Liste_Ekle_btn]') //doktorları listelerken tersten listele 
            var Doktor_Liste_Il = $('select[id=Doktor_Liste_Il]');
            Doktor_Liste_Il.append("<option>Lütfen İl Seçiniz</option>");
            var Doktor_Liste_Brick = $('select[id=Doktor_Liste_Brick]');
            var Doktor_Liste_Untie = $('select[id=Doktor_Liste_Untie]');
            var Doktor_Liste_Brans = $('select[id=Doktor_Liste_Brans]');
            var Doktor_Liste_Doktor_Ad = $('select[id=Doktor_Liste_Doktor_Ad]');
            var Doktor_Liste_Frekans = $('select[id=Doktor_Liste_Frekans]');
            var tablo_kontrol = true;



            //doktorları listelerken tersten listele 
            Doktor_Liste_Olustur_Liste.empty()




            $.ajax({
                url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var b = 0;
                    while (data.d.split('!')[b] != null) {
                        Doktor_Liste_Olustur_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;
                    }

                    $.ajax({
                        url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler_Tablo',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + Doktor_Liste_Olustur_Liste.find('option:selected').attr('value') + "-" + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            if (data.d == "Lütfen - Listeye -  Doktor - Ekleyiniz-0-0") {
                                tablo_kontrol = false;
                            }
                            //<td> <a style="font-size: 20px;" value='data.d.split('!')[b].split('-')[6]'><i class="fa fa-trash-o"></i></a>  </td >



                            var b = 0;
                            while (data.d.split('!')[b] != null) {

                                Doktor_Listesi_Tablosu.children().append("<tr><td></td><td>" + data.d.split('!')[b].split('-')[0] + "</td><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td>" + data.d.split('!')[b].split('-')[3] + "</td><td>" + data.d.split('!')[b].split('-')[5] + "</td>/<td> <a style='font-size: 20px; ' id='Doktoru_Kaldır' value='" + data.d.split('!')[b].split('-')[6] + "'><i class='fa fa-trash-o'></i></a>  </td></tr>")
                                b++;
                            } //doktorları listelerken tersten listele 

                            var Doktoru_Kaldır = Doktor_Listesi_Tablosu.children().find($('a[id=Doktoru_Kaldır]'));

                            Doktoru_Kaldır.click(function () {
                                $.ajax({
                                    url: 'Doktor-Listesi-Olustur.aspx/Doktoru_Listeden_Kaldır',
                                    dataType: 'json',
                                    type: 'POST',
                                    data: "{'parametre': '" + $(this).attr('value') + "'}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var Doktoru_Kaldır = Doktor_Listesi_Tablosu.children().find($('a[value=' + data.d + ']'))
                                      
                                        if (data.d == "0") {
                                            alert("İşlem Başarısız Lütfen Daha Sonra Tekrar Deneyiniz");
                                        }
                                        else {
                                            Doktoru_Kaldır.parent().parent().empty();
                                        }

                                    }
                                });



                            });


                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            //doktorları listelerken tersten listele 

            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {


                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Doktor_Liste_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Doktor_Liste_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Liste_Brick.empty();
                        Doktor_Liste_Brick.append("<option>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Doktor_Liste_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Doktor_Liste_Il.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Doktor_Liste_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Doktor_Liste_Brick.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '2-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Liste_Untie.empty();
                        Doktor_Liste_Untie.append("<option>Lütfen Ünite Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Doktor_Liste_Untie.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Liste_Brick.parent().children().find($("select option:first-child")).html() == "Lütfen Brick Seçiniz") {
                            Doktor_Liste_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });//Doktor_Liste_Brans
            Doktor_Liste_Untie.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '3-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Liste_Brans.empty();
                        Doktor_Liste_Brans.append("<option>Lütfen Branş Seçiniz</option>");

                        var b = 0;
                        while (data.d.split('!')[b] != null) {


                            Doktor_Liste_Brans.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;

                        }


                        if (Doktor_Liste_Untie.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Doktor_Liste_Untie.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        if (Doktor_Liste_Untie.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Doktor_Liste_Untie.parent().children().find($("select option:first-child")).remove();
                        }

                    }
                });

            });

            Doktor_Liste_Brans.change(function () {

                $.ajax({
                    url: 'Doktor-Ekle-Cikar.aspx/Doktoru_Brans',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '4-" + $(this).val() + "-" + Doktor_Liste_Untie.val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {


                        Doktor_Liste_Doktor_Ad.empty();
                        Doktor_Liste_Doktor_Ad.append(" <option>Lütfen Doktor Adı Seçiniz</option>");

                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Doktor_Liste_Doktor_Ad.append("<option Doktor_Id=" + data.d.split('!')[b].split("-")[2] + " value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Liste_Brans.parent().children().find($("select option:first-child")).html() == "Lütfen Branş Seçiniz") {
                            Doktor_Liste_Brans.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });// sadece 1 kere silecek şekilde ayarla sikim

            });//Doktor_Liste_Frekans 
            Doktor_Liste_Doktor_Ad.change(function () {
                Doktor_Liste_Frekans.empty();
                Doktor_Liste_Frekans.append(" <option>Lütfen Frekans Seçiniz</option>");
                Doktor_Liste_Frekans.append(" <option value='2'>A  (Ayda 2 Kere Ziyaret)</option>");
                Doktor_Liste_Frekans.append(" <option value='4'>B  (Ayda 4 Kere Ziyaret)</option>");
            });

            Doktor_Liste_Ekle_btn.click(function () {
                $.ajax({
                    url: 'Doktor-Listesi-Olustur.aspx/Doktor_Liste_Ekle_btn',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Doktor_Liste_Doktor_Ad.find('option:selected').attr('Doktor_Id') + "-" + Doktor_Liste_Frekans.find('option:selected').attr('value') + "-" + Doktor_Liste_Olustur_Liste.find('option:selected').attr('value') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {


                        if (data.d == "0") {
                            alert("Doktor Daha Önceden Bu listeye eklenmiş")
                        }
                        else {
                           
                            if (tablo_kontrol == false) {
                                Doktor_Listesi_Tablosu.children().empty();
                                Doktor_Listesi_Tablosu.children().append("<tr><th>#</th><th>Doktor Adı</th><th>Branş</th><th>Unite</th><th>Brick</th><th>Frekans</th><th>Kaldır</th></tr>")
                                Doktor_Listesi_Tablosu.children().append("<tr><td></td><td>" + Doktor_Liste_Doktor_Ad.find('option:selected').text() + "</td><td>" + Doktor_Liste_Brans.find('option:selected').text() + "</td><td>" + Doktor_Liste_Untie.find('option:selected').text() + "</td><td>" + Doktor_Liste_Brick.find('option:selected').text() + "</td><td>" + Doktor_Liste_Frekans.find('option:selected').attr('value') + "</td>/<td> <a style='font-size: 20px; ' id='Doktoru_Kaldır' value='" + data.d.split('-')[0] + "'><i class='fa fa-trash-o'></i></a></td></tr>")

                                
                            }
                            else {
                                tablo_kontrol = true;
                                Doktor_Listesi_Tablosu.children().append("<tr><td></td><td>" + Doktor_Liste_Doktor_Ad.find('option:selected').text() + "</td><td>" + Doktor_Liste_Brans.find('option:selected').text() + "</td><td>" + Doktor_Liste_Untie.find('option:selected').text() + "</td><td>" + Doktor_Liste_Brick.find('option:selected').text() + "</td><td>" + Doktor_Liste_Frekans.find('option:selected').attr('value') + "</td>/<td> <a style='font-size: 20px; ' id='Doktoru_Kaldır' value='" + data.d.split('-')[0] + "'><i class='fa fa-trash-o'></i></a></td></tr>")
                            }

                        }
                        var Doktoru_Kaldır = Doktor_Listesi_Tablosu.children().find($('a[id=Doktoru_Kaldır]'));

                        Doktoru_Kaldır.click(function () {
                            $.ajax({
                                url: 'Doktor-Listesi-Olustur.aspx/Doktoru_Listeden_Kaldır',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + $(this).attr('value') + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {
                                    var Doktoru_Kaldır = Doktor_Listesi_Tablosu.children().find($('a[value=' + data.d + ']'))

                                    if (data.d == "0") {
                                        alert("İşlem Başarısız Lütfen Daha Sonra Tekrar Deneyiniz");
                                    }
                                    else {
                                        Doktoru_Kaldır.parent().parent().empty();
                                    }

                                }
                            });



                        });
                          

                        



                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });



            });


            Doktor_Yeni_Liste_Olustur_Modal_btn.click(function () {


                //Doktor_Yeni_Liste_Input.val() //doktorları listelerken tersten listele 

                $.ajax({
                    url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Liste_Ekle',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Doktor_Yeni_Liste_Input.val() + "-" +  "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Liste_Olustur_Liste.append("<option id='" + data.d + "'>" + Doktor_Yeni_Liste_Input.val() + "</option>")

                        Doktor_Liste_Olustur_Liste.find($('option[id=' + data.d + ']')).attr('selected', 'selected');


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        //doktorları listelerken tersten listele 
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            });



        });
         //doktorları listelerken tersten listele
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Modal -->
    <div id="Doktor_Yeni_Liste_Ekle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lütfen Liste Adı Giriniz</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Liste Adı</label>
                        <input id="Doktor_Yeni_Liste_Input" type="text" class="form-control" placeholder="4 Frekans Doktorlar . . .">
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="Doktor_Yeni_Liste_Olustur_Modal_btn" type="button" class="btn btn-default" data-dismiss="modal">Ekle</button>
                </div>
            </div>

        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="box box-info box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">Doktor Listesi Oluştur</h3>
                    <div class="box-tools pull-right">
                    </div>
                    <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Liste Belirleyiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-9">
                            <div class="form-group">

                                <select id="Doktor_Liste_Olustur_Liste" class="form-control"></select>
                            </div>
                        </div>

                        <div class="col-xs-3">
                            <div class="form-group">
                                <button id="Doktor_Yeni_Liste_Olustur" type="button" class="btn btn-info pull-right" data-toggle="modal" data-target="#Doktor_Yeni_Liste_Ekle_Modal">Yeni Liste Oluştur</button>

                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen İL Seçiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <select id="Doktor_Liste_Il" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Brick Seçiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <select id="Doktor_Liste_Brick" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Ünite Seçiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <select id="Doktor_Liste_Untie" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Branş Seçiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <select id="Doktor_Liste_Brans" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Doktor Seçiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <select id="Doktor_Liste_Doktor_Ad" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Frekans Seçiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <select id="Doktor_Liste_Frekans" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <a id="Doktor_Liste_Ekle_btn" class="btn btn-info pull-right">Seçilen Doktoru Listeye Ekle</a>
                            </div>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="box">
                            <div class="box-body table-responsive no-padding">
                                <table id="Doktor_Listesi_Tablosu" class="table table-hover">
                                    <tbody>
                                        <tr>
                                            <th>#</th>
                                            <th>Doktor Adı</th>
                                            <th>Branş</th>
                                            <th>Unite</th>
                                            <th>Brick</th>
                                            <th>Frekans</th>
                                            <th>Kaldır</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>

                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>




</asp:Content>
